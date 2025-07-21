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

# Function to process fields from a section
process_fields() {
    local fields_json="$1"
    local section_name="$2"
    local field_count=$(echo "$fields_json" | jq 'length')
    
    for i in $(seq 0 $((field_count - 1))); do
        field=$(echo "$fields_json" | jq -c ".[$i]")
        purpose=$(echo "$field" | jq -r '.purpose // empty')
        label=$(echo "$field" | jq -r '.label // empty')
        value=$(echo "$field" | jq -r '.value // empty')
        field_type=$(echo "$field" | jq -r '.type // empty')
        
        [[ -z "$value" ]] && continue
        
        # Create display name with section prefix if applicable
        display_prefix=""
        [[ -n "$section_name" ]] && display_prefix="[$section_name] "
        
        # Handle passwords
        if [[ "$purpose" == "PASSWORD" || "$field_type" == "CONCEALED" ]]; then
            if [[ -n "$section_name" ]]; then
                password_entry="🔑 $section_name - Password"
                [[ -n "$label" ]] && password_entry="🔑 $section_name - Password ($label)"
            else
                password_entry="🔑 Main - Password"
                [[ -n "$label" ]] && password_entry="🔑 Main - Password ($label)"
            fi
            options+=("$password_entry")
            password_map["$password_entry"]="$value"
        fi
        
        # Handle usernames/emails
        if [[ "$purpose" == "USERNAME" ]]; then
            if [[ "$value" == *"@"* ]]; then
                if [[ -n "$section_name" ]]; then
                    username_entry="📧 $section_name - Email"
                else
                    username_entry="📧 Main - Email"
                fi
            else
                if [[ -n "$section_name" ]]; then
                    username_entry="👤 $section_name - Username"
                else
                    username_entry="👤 Main - Username"
                fi
            fi
            [[ -n "$label" ]] && username_entry="$username_entry ($label)"
            options+=("$username_entry")
            username_map["$username_entry"]="$value"
        fi
        
        # Handle TOTP codes
        if [[ "$field_type" == "OTP" ]]; then
            if [[ -n "$section_name" ]]; then
                totp_entry="🔐 $section_name - TOTP"
            else
                totp_entry="🔐 Main - TOTP"
            fi
            [[ -n "$label" ]] && totp_entry="$totp_entry ($label)"
            options+=("$totp_entry")
            totp_map["$totp_entry"]="$value"
        fi
    done
}

# Process main fields (no section)
main_fields=$(echo "$item_json" | jq '.fields // []')
process_fields "$main_fields" ""

# Process sections
sections_count=$(echo "$item_json" | jq '.sections | length // 0')
for s in $(seq 0 $((sections_count - 1))); do
    section=$(echo "$item_json" | jq -c ".sections[$s]")
    section_label=$(echo "$section" | jq -r '.label // empty')
    section_fields=$(echo "$section" | jq '.fields // []')
    
    # Skip if no fields in section
    [[ $(echo "$section_fields" | jq 'length') -eq 0 ]] && continue
    
    process_fields "$section_fields" "$section_label"
done

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
