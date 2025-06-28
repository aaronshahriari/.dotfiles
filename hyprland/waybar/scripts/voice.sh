#!/usr/bin/env bash

    device=$(wpctl inspect @DEFAULT_AUDIO_SOURCE@ | grep 'node.description' | cut -d '"' -f2)
if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q '\[MUTED\]'; then
    echo " "
else
    echo ""
fi
echo "$device"
