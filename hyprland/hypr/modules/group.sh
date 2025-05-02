#!/usr/bin/env bash

CACHE_FILE="$HOME/.cache/hy3-group-mode"
DEFAULT_MODE="v"

# Read current mode from cache or fallback to default
if [[ -f "$CACHE_FILE" ]]; then
    CURRENT_MODE=$(<"$CACHE_FILE")
else
    CURRENT_MODE="$DEFAULT_MODE"
fi

# Get argument
MODE="$1"

# Handle 'swap' argument
if [[ "$MODE" == "swap" ]]; then
    if [[ "$CURRENT_MODE" == "v" ]]; then
        MODE="h"
    else
        MODE="v"
    fi
fi

# Fallback to default if mode is invalid
if [[ "$MODE" != "v" && "$MODE" != "h" ]]; then
    MODE="$DEFAULT_MODE"
fi

# Write new mode to cache and dispatch command
echo "$MODE" > "$CACHE_FILE"
hyprctl dispatch hy3:makegroup "$MODE"
kill -45 "$(pgrep waybar)"
