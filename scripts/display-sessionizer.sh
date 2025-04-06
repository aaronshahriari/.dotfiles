#!/usr/bin/env bash

# get the current set autorandr setups
autorandr_profiles=$(autorandr | awk '{print $1}')

# use dmenu to select one
selected_display=$(printf "%s\n" "$autorandr_profiles" | dmenu -g 1 -i -l 10 -p "Display Setup:")

# if a selection was made, load it
if [ -n "$selected_display" ]; then
    autorandr --load "$selected_display"
fi
