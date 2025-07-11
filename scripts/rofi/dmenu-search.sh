#!/usr/bin/env bash

icon_for_name() {
    case "$1" in
        *Twitch*) echo "" ;;
        *YouTube*) echo "" ;;
        *Twitter*) echo "" ;;
        *ESPN*) echo "󰫲" ;;
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

# browser="google-chrome-stable"
# bookmarks_json="$HOME/.config/google-chrome/Default/Bookmarks"
browser="brave"
bookmarks_json="$HOME/.config/BraveSoftware/Brave-Browser/Default/Bookmarks"
engine="https://duckduckgo.com/?q=%s"

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
  display="$icon  $name"
  entries+=("$display")
  url_map["$display"]="$url"
done

# selected_input=$(printf "%s\n" "${entries[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh -i -g 1 -p "Go")
rofi_output=$(printf "%s\n" "${entries[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh -i -g 1 -p "Go")
rofi_exit=$?
selected_input="$rofi_output"

if [[ -z "$selected_input" ]]; then
  exit 0
fi

# Function to check if the currently focused window is a Chrome window
# is_chrome_focused() {
#   focused_class=$(xprop -id "$(xdotool getwindowfocus)" WM_CLASS 2>/dev/null)
#   [[ "$focused_class" == *"google-chrome"* ]]
# }
# is_chrome_focused() {
#   [[ $(hyprctl activewindow -j | jq -r ".class") == "google-chrome" ]]
# }
is_brave_focused() {
  [[ $(hyprctl activewindow -j | jq -r ".class") == "brave-browser" ]]
}

# Determine browser command based on focus
if is_brave_focused; then
  brave_command="$browser"
else
  brave_command="$browser --new-window"
fi

url="${url_map["$selected_input"]}"

if [[ $rofi_exit -eq 10 && -n "$url" ]]; then
  $browser --app="$url"
elif [[ -n "$url" ]]; then
  $brave_command "$url"
else
  query=$(printf "$engine" "$selected_input")
  $brave_command "$query"
fi

if [[ "$url_found" == false ]]; then
  query=$(printf "$engine" "$selected_input")
  $brave_command "$query"
fi
