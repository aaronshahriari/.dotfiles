#!/usr/bin/env bash

# Start hyprsunset if it's not running
if ! pgrep -x hyprsunset > /dev/null; then
    hyprsunset &
    sleep 0.3  # small delay to ensure it starts
fi

# Pass through hyprctl hyprsunset command
hyprctl hyprsunset "$@"
