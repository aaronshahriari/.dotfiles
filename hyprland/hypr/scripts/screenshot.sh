#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILENAME="$DIR/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

capture() {
    pkill slurp || hyprshot -m ${1:-region} --raw |
        satty --filename - \
        --output-filename "$FILENAME" \
        --early-exit \
        --actions-on-enter save-to-clipboard \
        --save-after-copy \
        --copy-command 'wl-copy'
}

options="Select\nWindow\nOutput"
screenshot_type=$(printf "$options" | ~/.config/rofi/launchers/scripts/launcher.sh "Type:")

# close if no selection
[ -z "$screenshot_type" ] && exit

case "$screenshot_type" in
    "Select")
        capture region
        ;;
    "Window")
        capture window
        ;;
    "Output")
        capture output
        ;;
    *)
        exit 0
        ;;
esac
