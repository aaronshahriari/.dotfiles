#!/usr/bin/env bash

# ICON_PATH="$(nix path-info nixpkgs#material-black-colors)/share/icons/Material-Black-Plum-Numix-FLAT/32/devices/computer.svg"
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/standard/"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
WALLPAPER_NAME=$(basename "$WALLPAPER" | sed 's/\.[^.]*$//')
notify-send -t 1500 -u low -i "$WALLPAPER" "New Wallpaper" "$WALLPAPER_NAME"
hyprctl hyprpaper reload "$FOCUSED_MONITOR","$WALLPAPER"
