#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Github ~/ ~/work ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

hostname=$(wezterm cli list-clients | awk 'NR==2 {print $2}')
full_selected="file://$hostname$selected"

# matches CWD exact
wezterm_running=$(wezterm cli list | grep -w $full_selected)
if [[ -z $wezterm_running ]]; then
    wezterm cli spawn --cwd $selected
else
    tabid=$(echo "$wezterm_running" | awk '{print $2}')
    wezterm cli activate-tab --tab-id $tabid
fi
