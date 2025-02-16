#!/usr/bin/env bash

get_streams() {
    wpctl status | awk '
        /Audio/{audio=1} /Video/{audio=0} /Settings/{audio=0} 
        audio && /Streams:/ {flag=1; next} 
        audio && flag && /^[ │]+[0-9]+\./ && !/>/ && $2 !~ /Audio\/Sink|Audio\/Source/ {
        gsub(/^[ │]+/, ""); print
    }'
}

# get available streams
streams=$(get_streams)

if [ -z "$streams" ]; then
    notify-send "No Streams Found"
    exit 1
fi

# select stream using dmenu
selected_stream=$(echo "$streams" | dmenu -i -g 1 -p "Select Stream:")

# set the selected sink as default if a valid sink is selected
if [ -n "$selected_stream" ]; then
    stream_id=$(echo "$selected_stream" | awk '{print $1}' | sed 's/\.$//')
    wpctl set-mute "$stream_id" toggle
    notify-send "Toggle Mute $(echo "$selected_stream" | cut -d' ' -f2- | tr -d '\n' | xargs | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')"
else
    notify-send "No Stream Selected"
    exit 1
fi
