#!/usr/bin/env bash

ROFI_LAUNCHER="$HOME/.config/rofi/launchers/scripts/launcher.sh"
SCRIPT_DIR="$HOME/.local/bin/scripts"

options="Wallpaper\nBackup"

choice=$(printf "$options" | $ROFI_LAUNCHER -g 1 -m 0 -i -l 10 -p "Run")

case "$choice" in
    "Wallpaper")
        "$HOME/.config/hypr/modules/wallpaper.sh"
        ;;
    "Backup")
        "$SCRIPT_DIR/backup-script.sh"
        ;;
    *)
        exit 0
        ;;
esac
