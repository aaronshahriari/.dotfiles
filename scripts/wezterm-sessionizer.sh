#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Github ~/ ~/work ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

full_selected="file://$HOST$selected"
home_dir="file://$HOST$HOME"

# matches CWD exact
wezterm_running=$(wezterm cli list | grep -w $full_selected)
if [[ -z $wezterm_running ]]; then
    if [[ "$full_selected" == "$home_dir" ]]; then
        echo "wezterm cli spawn current tab"
        cd $full_selected
        clear
    else
        echo "wezterm cli spawn --cwd $selected"
        # wezterm cli spawn --cwd $selected
    fi
else
    tabid=$(echo "$wezterm_running" | awk '{print $2}')
    wezterm cli activate-tab --tab-id $tabid
fi
