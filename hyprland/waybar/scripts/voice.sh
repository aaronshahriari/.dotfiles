#!/usr/bin/env bash

inspect_output=$(wpctl inspect @DEFAULT_AUDIO_SOURCE@)
volume_output=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
device=$(echo "$inspect_output" | grep 'node.description' | cut -d '"' -f2)

if echo "$volume_output" | grep -q '\[MUTED\]'; then
    echo '{"text": "", "tooltip": "'"$device"'", "class": "muted"}'
else
    volume_amount=$(echo "$volume_output" | awk '{printf "%.0f%%", $2 * 100}')
    echo '{"text": " '"$volume_amount"'", "tooltip": "'"$device"'", "class": "unmuted"}'
fi
