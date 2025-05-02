#!/usr/bin/env bash

CACHE_FILE="$HOME/.cache/hy3-group-mode"

if [[ -f "$CACHE_FILE" ]]; then
    MODE=$(<"$CACHE_FILE")
else
    MODE="v"
fi

case "$MODE" in
    h)
        ICON="󰯍" ;;
    v)
        ICON="󰯎" ;;
    *)
        ICON="?" ;;
esac

echo "{\"text\": \"$ICON\", \"tooltip\": \"Group Mode: $MODE\"}"
