#!/usr/bin/env bash

# 1Password Section-based Selector
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

# Parse and organize sections with their credentials
declare -A section_creds
options=()

# Function to extract credentials from fields
extract_credentials() {
    local fields_json="$1"
    local section_name="$2"
    local field_count=$(echo "$fields_json" | jq 'length')
    local username=""
    local password=""
    
    # Extract username and password from this section
    for i in $(seq 0 $((field_count - 1))); do
        field=$(echo "$fields_json" | jq -c ".[$i]")
        purpose=$(echo "$field" | jq -r '.purpose // empty')
        label=$(echo "$field" | jq -r '.label // empty')
        value=$(echo "$field" | jq -r '.value // empty')
        field_type=$(echo "$field" | jq -r '.type // empty')
        
        [[ -z "$value" ]] && continue
        
        # Find username
        if [[ "$purpose" == "USERNAME" || "$label" == "username" ]]; then
            username="$value"
        fi
        
        # Find password
        if [[ "$purpose" == "PASSWORD" || "$label" == "password" || "$field_type" == "CONCEALED" ]]; then
            password="$value"
        fi
    done
    
    # Only add section if it has both username and password
    if [[ -n "$username" && -n "$password" ]]; then
        section_display="$section_name: $username"
        options+=("$section_display")
        section_creds["$section_display"]="$username|$password"
    fi
}

# Process main fields (no section)
main_fields=$(echo "$item_json" | jq '.fields | [.[] | select(has("section") | not)]')
extract_credentials "$main_fields" "Main"

# Process sections by filtering fields that belong to each section
sections_count=$(echo "$item_json" | jq '.sections | length // 0')
for s in $(seq 0 $((sections_count - 1))); do
    section=$(echo "$item_json" | jq -c ".sections[$s]")
    section_id=$(echo "$section" | jq -r '.id // empty')
    section_label=$(echo "$section" | jq -r '.label // empty')
    
    # Skip sections without labels or with empty labels
    [[ -z "$section_label" ]] && continue
    
    # Filter fields that belong to this section
    section_fields=$(echo "$item_json" | jq --arg section_id "$section_id" '.fields | [.[] | select(.section.id == $section_id)]')
    
    # Skip if no fields in section
    [[ $(echo "$section_fields" | jq 'length') -eq 0 ]] && continue
    
    extract_credentials "$section_fields" "$section_label"
done

# Exit if no sections with credentials found
if [[ ${#options[@]} -eq 0 ]]; then
    echo "Error: No sections with username/password pairs found" >&2
    exit 1
fi

# Show rofi to select section
selected_section=$(printf "%s\n" "${options[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh "Select section")
[[ -z "$selected_section" ]] && exit 0

# Extract username and password from selected section
creds="${section_creds["$selected_section"]}"
username="${creds%%|*}"
password="${creds#*|}"

# Show rofi to select what to copy
copy_options=("👤 Copy Username: $username" "🔑 Copy Password")
selected_copy=$(printf "%s\n" "${copy_options[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh "What to copy?")
[[ -z "$selected_copy" ]] && exit 0

# Copy the selected credential
if [[ "$selected_copy" == "👤 Copy Username: $username" ]]; then
    printf "%s" "$username" | wl-copy
    notify-send "1Password" "Username copied to clipboard"
elif [[ "$selected_copy" == "🔑 Copy Password" ]]; then
    printf "%s" "$password" | wl-copy
    notify-send "1Password" "Password copied to clipboard"
else
    echo "Error: Invalid selection" >&2
    exit 1
fi