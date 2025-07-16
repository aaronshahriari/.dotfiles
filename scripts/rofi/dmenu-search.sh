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

# configuration - change this to switch browsers
browser="brave"  # Options: "brave", "chrome"

# browser-specific configuration - add new browsers here
case "$browser" in
    "brave")
        browser_command="brave"
        browser_class="brave-browser"
        bookmarks_json="$HOME/.config/BraveSoftware/Brave-Browser/Default/Bookmarks"
        focus_function="is_brave_focused"
        ;;
    "chrome")
        browser_command="google-chrome-stable"
        browser_class="google-chrome"
        bookmarks_json="$HOME/.config/google-chrome/Default/Bookmarks"
        focus_function="is_chrome_focused"
        ;;
esac

# Other configuration
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
rofi_output=$(printf "%s\n" "${entries[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh "Search:")
rofi_exit=$?
selected_input="$rofi_output"

if [[ -z "$selected_input" ]]; then
  exit 0
fi

is_chrome_focused() {
  [[ $(hyprctl activewindow -j | jq -r ".class") == "google-chrome" ]]
}

is_brave_focused() {
  [[ $(hyprctl activewindow -j | jq -r ".class") == "brave-browser" ]]
}

# Determine browser command based on focus
if $focus_function; then
    browser_cmd="$browser_command"
else
    browser_cmd="$browser_command --new-window"
fi

url="${url_map["$selected_input"]}"

if [[ $rofi_exit -eq 10 && -n "$url" ]]; then
  $browser_command --app="$url"
elif [[ -n "$url" ]]; then
  $browser_cmd "$url"
else
  query=$(printf "$engine" "$selected_input")
  $browser_cmd "$query"
fi
