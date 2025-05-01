#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILENAME="$DIR/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

grim -g "$(slurp)" "$FILENAME" || exit 1

gimp "$FILENAME" &
