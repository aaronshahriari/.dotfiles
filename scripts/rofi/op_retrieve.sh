#!/usr/bin/env bash

# get all items and extract title + id
mapfile -t entries < <(op item list --format=json | jq -r '.[] | "\(.title)\t\(.id)"')

# create associative array mapping title -> id
declare -A id_map
titles=()

for entry in "${entries[@]}"; do
    title="${entry%%$'\t'*}"
    id="${entry#*$'\t'}"
    titles+=("$title")
    id_map["$title"]="$id"
done

# show rofi to select title
selected_title=$(printf "%s\n" "${titles[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh "1Password Items")

# exit if nothing selected
[[ -z "$selected_title" ]] && exit 1

# output corresponding id
# echo "${id_map["$selected_title"]}"

#!/usr/bin/env bash

# Get full item JSON
item_id="${id_map["$selected_title"]}"
item_json=$(op item get "$item_id" --reveal --format=json)

# Parse and pair usernames and passwords properly
declare -A password_map
options=()

# Loop over fields with index
field_count=$(echo "$item_json" | jq '.fields | length')
for i in $(seq 0 $((field_count - 1))); do
  field=$(echo "$item_json" | jq -c ".fields[$i]")
  purpose=$(echo "$field" | jq -r '.purpose // empty')
  label=$(echo "$field" | jq -r '.label // empty')
  section_id=$(echo "$field" | jq -r '.section.id // "root"')
  value=$(echo "$field" | jq -r '.value // empty')

  # Is it a username?
  if [[ "$purpose" == "USERNAME" || "${label,,}" == "username" ]]; then
    # Search forward for a CONCEALED (password) field in the same section
    password=""
    for j in $(seq $((i + 1)) $((field_count - 1))); do
      next_field=$(echo "$item_json" | jq -c ".fields[$j]")
      next_type=$(echo "$next_field" | jq -r '.type // empty')
      next_section=$(echo "$next_field" | jq -r '.section.id // "root"')
      next_value=$(echo "$next_field" | jq -r '.value // empty')

      if [[ "$next_type" == "CONCEALED" && "$next_section" == "$section_id" ]]; then
        password="$next_value"
        break
      fi
    done

    if [[ -n "$value" && -n "$password" ]]; then
      entry="$value"
      options+=("$entry")
      password_map["$entry"]="$password"
    fi
  fi
done

# Show rofi to select username
selected=$(printf "%s\n" "${options[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh "Select Username")
[[ -z "$selected" ]] && exit 1

# Echo matching password
# echo "${password_map["$selected"]}"
printf "%s" "${password_map["$selected"]}" | wl-copy
notify-send "Password copied to clipboard"
