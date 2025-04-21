#!/usr/bin/env bash

get_sinks() {
    wpctl status | awk '/Audio/{audio=1} /Video/{audio=0} audio && /Sinks:/ {flag=1; next} /Sources:/ {flag=0} flag && /^[ │*]/{if ($0 ~ /[0-9]+/) {gsub(/^[ │*]+/, ""); sub(/\s*\[.*$/, ""); split($0, arr, " "); print arr[1] " " arr[2] " " arr[3]}}'
}

get_sources() {
    wpctl status | awk '
        /Audio/ { audio=1 } 
        /Video/ { audio=0 } 
        audio && /Sources:/ { flag=1; next } 
        audio && (/Sink endpoints:/ || /Source endpoints:/) { flag=0 }
        flag && /^[ │*]/ {
            if ($0 ~ /[0-9]+/) { 
                gsub(/^[ │*]+/, ""); 
                sub(/\s*\[.*$/, ""); 
                split($0, arr, " "); 
                print arr[1], arr[2], arr[3];
            }
        }
    '
}

# Get available sinks
sinks=$(get_sinks)

if [ -z "$sinks" ]; then
    notify-send "No Sinks Found"
    exit 1
fi

# Select sink using rofi -dmenu
selected_sink=$(echo "$sinks" | cut -d' ' -f2- | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' | rofi -dmenu -m 0 -i -g 1 -p "Select Sink")

# Set the selected sink as default if a valid sink is selected
if [ -n "$selected_sink" ]; then
    sink_id=$(echo "$sinks" | grep -i "$selected_sink" | awk -F. '{print $1}')
    wpctl set-default "$sink_id"
    notify-send "Audio Sink Set To $(echo "$selected_sink" | cut -d' ' -f2-)"
else
    notify-send "No Sink Selected"
    exit 1
fi

# Get available sources
sources=$(get_sources)

if [ -z "$sources" ]; then
    notify-send "No Sources Found"
    exit 1
fi

# Select source using rofi -dmenu
selected_source=$(echo "$sources" | cut -d' ' -f2- | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' | rofi -dmenu -m 0 -i -g 1 -p "Select Source")

# Set the selected source as default if a valid source is selected
if [ -n "$selected_source" ]; then
    source_id=$(echo "$sources" | grep -i "$selected_source" | awk -F. '{print $1}')
    wpctl set-default "$source_id"
    notify-send "Audio Source Set To $(echo "$selected_source" | cut -d' ' -f2-)"
else
    notify-send "No Source Selected"
    exit 1
fi
