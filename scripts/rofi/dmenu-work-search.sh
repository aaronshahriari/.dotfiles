#!/usr/bin/env bash

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

# Applications that should always open in app mode (match by name)
app_mode_names=("Teams" "Outlook")

# Work-specific apps and URLs - customize these for your work environment
work_entries=(
    "󰊻 Teams	https://teams.microsoft.com/v2/"
    "󰴢 Outlook	https://outlook.office.com/mail/"
    " Calendar	https://outlook.office.com/calendar/view/workweek"
    " PaceHR	https://pacehr.techmahindra.com/psp/PACEHR/?cmd=login&languageCd=ENG&"
    "󰧷 TimeSheet	https://timetracker.techmahindra.com/MyTime/Forms/InnerPage.aspx"
    "󱙕 Paychex	https://myapps.paychex.com/landing_remote/login.do?lang=en"
)

entries=()
declare -A url_map

for entry in "${work_entries[@]}"; do
    name="${entry%%$'\t'*}"
    url="${entry#*$'\t'}"
    entries+=("$name")
    url_map["$name"]="$url"
done

rofi_output=$(printf "%s\n" "${entries[@]}" | ~/.config/rofi/launchers/scripts/launcher.sh "Work:")
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

# Check if the selected entry name should open in app mode
should_use_app_mode=false
for app_name in "${app_mode_names[@]}"; do
    if [[ "$selected_input" == *"$app_name"* ]]; then
        should_use_app_mode=true
        break
    fi
done

if [[ $rofi_exit -eq 10 && -n "$url" ]]; then
    $browser_command --app="$url"
elif [[ -n "$url" && "$should_use_app_mode" == true ]]; then
    $browser_command --app="$url"
elif [[ -n "$url" ]]; then
    $browser_cmd "$url"
else
    query=$(printf "$engine" "$selected_input")
    $browser_cmd "$query"
fi
