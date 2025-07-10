#!/usr/bin/env bash

# Cache wpctl output once to avoid race conditions across monitors
inspect_output=$(wpctl inspect @DEFAULT_AUDIO_SOURCE@)
volume_output=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)

# Extract description once
device=$(echo "$inspect_output" | grep 'node.description' | cut -d '"' -f2)

# Check mute state
if echo "$volume_output" | grep -q '\[MUTED\]'; then
    echo ""
else
    echo ""
fi

echo "$device"
