#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/standard/"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
hyprctl hyprpaper reload "$FOCUSED_MONITOR","$WALLPAPER"
