#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Github ~/ ~/work ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    # exit 0
    return 0
fi

hostname=$(hostname)
full_selected="file:/$hostname$selected"
current_dir=$(pwd)

# matches CWD exact
wezterm_running=$(wezterm cli list | grep -w $full_selected)
if [[ -z $wezterm_running ]]; then
    if [[ "$current_dir" == "$HOME" ]]; then
        cd "$selected" || exit 1
        clear
    else
        wezterm cli spawn --cwd $selected
    fi
else
    tabid=$(echo "$wezterm_running" | awk '{print $2}')
    wezterm cli activate-tab --tab-id $tabid
fi
