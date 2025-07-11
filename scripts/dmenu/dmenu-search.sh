#!/usr/bin/env bash

# Configuration - Change this to switch browsers
browser="brave"  # Options: "brave", "chrome"

# Auto-configure based on browser choice
case "$browser" in
    "brave")
        browser_command="brave"
        browser_class="brave"
        bookmarks_json="$HOME/.config/BraveSoftware/Brave-Browser/Default/Bookmarks"
        ;;
    "chrome")
        browser_command="google-chrome-stable"
        browser_class="google-chrome"
        bookmarks_json="$HOME/.config/google-chrome/Default/Bookmarks"
        ;;
esac

# Other configuration
engine="https://duckduckgo.com/?q=%s"
dmenu_prompt="Go:"
dmenu_args="-m 0 -i -g 1"

# Icon configuration - add icons for specific bookmark names
get_icon() {
    case "$1" in
        "GitHub")           echo "🐙" ;;
        "Gmail")            echo "📧" ;;
        "YouTube")          echo "📺" ;;
        "ChatGPT")          echo "🤖" ;;
        "Reddit")           echo "🔴" ;;
        "Stack Overflow")   echo "📚" ;;
        "Discord")          echo "💬" ;;
        "Twitter")          echo "🐦" ;;
        "Netflix")          echo "🎬" ;;
        "Spotify")          echo "🎵" ;;
        *)                  echo "" ;;
    esac
}

# Use a recursive jq query to find all bookmarks, including those in nested folders
mapfile -t bookmarks < <(jq -r '
  .. | objects | select(.type? == "url") | "\(.name) \t\(.url)"
' "$bookmarks_json")

# Format names with icons for display
display_names=()
for entry in "${bookmarks[@]}"; do
    name="${entry%%$'\t'*}"
    icon=$(get_icon "$name")
    if [[ -n "$icon" ]]; then
        display_names+=("$icon $name")
    else
        display_names+=("$name")
    fi
done

# Show dmenu and get selection
selected_display=$(printf "%s\n" "${display_names[@]}" | dmenu $dmenu_args -p "$dmenu_prompt")

# Extract the actual name from the selection (remove icon if present)
if [[ "$selected_display" =~ ^[[:space:]]*[[:emoji:][:punct:]]*[[:space:]]*(.+)$ ]]; then
    selected_input="${BASH_REMATCH[1]}"
else
    selected_input="$selected_display"
fi

if [[ -z "$selected_display" ]]; then
  exit 0
fi

# Browser focus detection functions
is_chrome_focused() {
  [[ $(hyprctl activewindow -j | jq -r ".class") == "google-chrome" ]]
}

is_brave_focused() {
  [[ $(hyprctl activewindow -j | jq -r ".class") == "brave-browser" ]]
}

# Determine browser command based on focus and browser choice
case "$browser" in
    "brave")
        if is_brave_focused; then
            browser_cmd="$browser_command"
        else
            browser_cmd="$browser_command --new-window"
        fi
        ;;
    "chrome")
        if is_chrome_focused; then
            browser_cmd="$browser_command"
        else
            browser_cmd="$browser_command --new-window"
        fi
        ;;
esac

url_found=false
for entry in "${bookmarks[@]}"; do
  name="${entry%%$'\t'*}"
  url="${entry#*$'\t'}"
  if [[ "$name" == "$selected_input" ]]; then
    $browser_cmd "$url"
    url_found=true
    break
  fi
done

if [[ "$url_found" == false ]]; then
  query=$(printf "$engine" "$selected_input")
  $browser_cmd "$query"
fi
