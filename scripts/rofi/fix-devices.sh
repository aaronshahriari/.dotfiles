#!/usr/bin/env bash

ROFI_LAUNCHER="$HOME/.config/rofi/launchers/scripts/launcher.sh"
SCRIPT_DIR="$HOME/.local/bin/scripts"

reset_cam() {
    cam_id=$(lsusb | grep 'C920 PRO HD Webcam' | cut -d' ' -f6)
    if [ -n "$cam_id" ]; then
        sudo usbreset "$cam_id"
    else
        echo "Webcam could not be found" >&2
        return 1
    fi

}

options="Wallpaper\nBackup\nLogitech Camera"

choice=$(printf "$options" | $ROFI_LAUNCHER "Run:")

case "$choice" in
    "Wallpaper")
        "$HOME/.config/hypr/modules/wallpaper.sh"
        ;;
    "Backup")
        "$SCRIPT_DIR/backup-script.sh"
        ;;
    "Logitech Camera")
        reset_cam
        ;;
    *)
        exit 0
        ;;
esac
