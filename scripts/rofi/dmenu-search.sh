#!/usr/bin/env bash

icon_for_name() {
    case "$1" in
        *Twitch*) echo "" ;;
        *YouTube*) echo "" ;;
        *Twitter*) echo "" ;;
        *Hulu*) echo "󰠩" ;;
        *Gmail*) echo "󰊫" ;;
        *Netflix*) echo "󰝆" ;;
        *GitHub*) echo "" ;;
        *Leetcode*) echo "" ;;
        *Synology*) echo "󰣳" ;;
        *Fidelity*) echo "" ;;
        *Amazon*) echo "" ;;
        *ChatGPT*) echo "" ;;
        *OneDrive*) echo "󰏊" ;;
    esac
}

browser="google-chrome-stable"
engine="https://duckduckgo.com/?q=%s"
bookmarks_json="$HOME/.config/google-chrome/Default/Bookmarks"

# Use a recursive jq query to find all bookmarks, including those in nested folders
mapfile -t bookmarks < <(jq -r '
  .. | objects | select(.type? == "url") | "\(.name) \t\(.url)"
' "$bookmarks_json")

# names=("${bookmarks[@]%%$'\t'*}")
# selected_input=$(printf "%s\n" "${names[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh -i -g 1 -p "Go")

entries=()
declare -A url_map

for entry in "${bookmarks[@]}"; do
  name="${entry%%$'\t'*}"
  url="${entry#*$'\t'}"
  icon=$(icon_for_name "$name")
  display="$icon $name"
  entries+=("$display")
  url_map["$display"]="$url"
done

selected_input=$(printf "%s\n" "${entries[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh -i -g 1 -p "Go")

if [[ -z "$selected_input" ]]; then
  exit 0
fi

# Function to check if the currently focused window is a Chrome window
# is_chrome_focused() {
#   focused_class=$(xprop -id "$(xdotool getwindowfocus)" WM_CLASS 2>/dev/null)
#   [[ "$focused_class" == *"google-chrome"* ]]
# }
is_chrome_focused() {
  [[ $(hyprctl activewindow -j | jq -r ".class") == "google-chrome" ]]
}

# Determine browser command based on focus
if is_chrome_focused; then
  chrome_command="$browser"
else
  chrome_command="$browser --new-window"
fi

url="${url_map["$selected_input"]}"
if [[ -n "$url" ]]; then
  $chrome_command "$url"
else
  query=$(printf "$engine" "$selected_input")
  $chrome_command "$query"
fi

# url_found=false
# for entry in "${bookmarks[@]}"; do
#   name="${entry%%$'\t'*}"
#   url="${entry#*$'\t'}"
#   if [[ "$name" == "$selected_input" ]]; then
#     $chrome_command "$url"
#     url_found=true
#     break
#   fi
# done

if [[ "$url_found" == false ]]; then
  query=$(printf "$engine" "$selected_input")
  $chrome_command "$query"
fi
