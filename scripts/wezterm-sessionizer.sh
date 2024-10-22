#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Github ~/ ~/work ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi
# echo "$selected"

hostname=$(wezterm cli list-clients | awk 'NR==2 {print $2}')
# echo "$hostname"

wezterm_running=$(wezterm cli list | awk 'NR > 1 { print $NF }')
# echo "$wezterm_running"

full_wezterm_path="file://$hostname$selected"
# echo "$full_wezterm_path"

path_exsist=false

# fully empty create a window
if [[ -z $wezterm_running ]]; then
    echo "ALL EMPTY THEN CREATE WINDOW"
    echo ""
else
    echo "NOT EMPTY CHECK EACH WINDOW"
    echo ""
    while IFS= read -r line; do
        if [[ "$full_wezterm_path" == "$line" ]]; then
            echo "inside true"
            path_exists=true
            break
        fi
    done <<< "$wezterm_running"
fi

if $path_exists; then
    echo "PATH DOES NOT EXIST."
else
    echo "PATH EXISTS."
fi

# wezterm cli activate-pane --domain local --title "$selected_name"
