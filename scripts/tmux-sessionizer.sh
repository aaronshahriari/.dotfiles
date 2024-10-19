#!/usr/bin/env bash

# Select a directory using fzf or pass it as an argument
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Github ~/ ~/work ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

# Get a session name from the directory name
selected_name=$(basename "$selected" | tr . _)

# Check if WezTerm is already running with this workspace
wezterm_running=$(wezterm cli list | grep $selected_name)

# Create a new WezTerm tab if not already running
if [[ -z $wezterm_running ]]; then
    wezterm cli spawn --cwd "$selected" --domain local --new-window --title "$selected_name"
    exit 0
fi

# Focus the existing WezTerm window if already running
wezterm cli activate-pane --domain local --title "$selected_name"
