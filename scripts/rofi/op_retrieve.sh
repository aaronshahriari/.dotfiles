#!/usr/bin/env bash

# 1Password Manager with Rofi - Enhanced version
set -euo pipefail

# Check dependencies
for dep in op jq rofi wl-copy notify-send; do
    if ! command -v "$dep" &> /dev/null; then
        echo "Error: Required dependency '$dep' not found" >&2
        exit 1
    fi
done

# Check if signed in to 1Password and handle authentication
check_and_signin() {
    # Check if we can access 1Password
    if op account list &> /dev/null; then
        return 0
    fi
    
    # Try to sign in with biometric unlock if available
    if op account list --format=json 2>/dev/null | jq -r '.[0].user_uuid' &> /dev/null; then
        echo "Attempting biometric unlock..." >&2
        if op signin --raw &> /dev/null; then
            return 0
        fi
    fi
    
    # Try interactive signin
    echo "1Password session expired. Signing in..." >&2
    if op signin; then
        return 0
    else
        echo "Error: Failed to sign in to 1Password" >&2
        exit 1
    fi
}

check_and_signin

# Get all items and extract title + id
if ! mapfile -t entries < <(op item list --format=json 2>/dev/null | jq -r '.[] | "\(.title)\t\(.id)"'); then
    echo "Error: Failed to fetch 1Password items" >&2
    exit 1
fi

# Exit if no items found
if [[ ${#entries[@]} -eq 0 ]]; then
    echo "Error: No items found in 1Password" >&2
    exit 1
fi

# Create associative array mapping title -> id
declare -A id_map
titles=()

for entry in "${entries[@]}"; do
    title="${entry%%$'\t'*}"
    id="${entry#*$'\t'}"
    titles+=("$title")
    id_map["$title"]="$id"
done

# Show rofi to select title
selected_title=$(printf "%s\n" "${titles[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh "1Password Items")

# Exit if nothing selected
[[ -z "$selected_title" ]] && exit 0

# Get full item JSON
item_id="${id_map["$selected_title"]}"
if ! item_json=$(op item get "$item_id" --reveal --format=json 2>/dev/null); then
    echo "Error: Failed to retrieve item details" >&2
    exit 1
fi

# Parse and organize credentials
declare -A password_map
declare -A username_map
declare -A totp_map
options=()

# Find the main password first
main_password=""
field_count=$(echo "$item_json" | jq '.fields | length')
for i in $(seq 0 $((field_count - 1))); do
    field=$(echo "$item_json" | jq -c ".fields[$i]")
    purpose=$(echo "$field" | jq -r '.purpose // empty')
    field_type=$(echo "$field" | jq -r '.type // empty')
    value=$(echo "$field" | jq -r '.value // empty')

    if [[ "$purpose" == "PASSWORD" || "$field_type" == "CONCEALED" ]] && [[ -n "$value" ]]; then
        main_password="$value"
        break
    fi
done

# Now collect all credentials
for i in $(seq 0 $((field_count - 1))); do
    field=$(echo "$item_json" | jq -c ".fields[$i]")
    purpose=$(echo "$field" | jq -r '.purpose // empty')
    label=$(echo "$field" | jq -r '.label // empty')
    value=$(echo "$field" | jq -r '.value // empty')
    field_type=$(echo "$field" | jq -r '.type // empty')

    # Handle usernames/emails
    if [[ "$purpose" == "USERNAME" && -n "$value" ]]; then
        if [[ "$value" == *"@"* ]]; then
            entry="📧 Copy Email: $value"
        else
            entry="👤 Copy Username: $value"
        fi
        options+=("$entry")
        username_map["$entry"]="$value"
    fi

    # Handle TOTP codes
    if [[ "$field_type" == "OTP" && -n "$value" ]]; then
        totp_entry="🔐 Copy TOTP Code"
        [[ -n "$label" ]] && totp_entry="🔐 Copy TOTP: $label"
        options+=("$totp_entry")
        totp_map["$totp_entry"]="$value"
    fi
done

# Always add password option at the top if we found one
if [[ -n "$main_password" ]]; then
    options=("🔑 Copy Password" "${options[@]}")
    password_map["🔑 Copy Password"]="$main_password"
fi

# Exit if no options found
if [[ ${#options[@]} -eq 0 ]]; then
    echo "Error: No credentials found for this item" >&2
    exit 1
fi

# Show rofi to select credential
selected=$(printf "%s\n" "${options[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh "Select credential to copy")
[[ -z "$selected" ]] && exit 0

# Copy the selected credential
if [[ -n "${password_map[$selected]:-}" ]]; then
    printf "%s" "${password_map[$selected]}" | wl-copy
    notify-send "1Password" "Password copied to clipboard"
elif [[ -n "${username_map[$selected]:-}" ]]; then
    printf "%s" "${username_map[$selected]}" | wl-copy
    notify-send "1Password" "Username/Email copied to clipboard"
elif [[ -n "${totp_map[$selected]:-}" ]]; then
    printf "%s" "${totp_map[$selected]}" | wl-copy
    notify-send "1Password" "TOTP code copied to clipboard"
else
    echo "Error: No value found for selection: $selected" >&2
    exit 1
fi
