#!/usr/bin/env bash

ROFI_LAUNCHER="$HOME/.config/rofi/launchers/scripts/launcher.sh"
SCRIPT_DIR="$HOME/.local/bin/scripts"

reset_cam() {
    cam_id=$(lsusb | grep 'C920 PRO HD Webcam' | cut -d' ' -f6)
    if [ -n "$cam_id" ]; then
        sudo usbreset "$cam_id"
    else
        notify-send -u critical "Utilities" "Webcam Could Not Be Found"
        return 1
    fi

}

options=("Timeout" "Wallpaper" "Backup" "Logitech Camera")
choice=$(printf "%s\n" "${options[@]}" | $ROFI_LAUNCHER "Run:")

case "$choice" in
    "Timeout")
        "$SCRIPT_DIR/rofi/timeout.sh"
        ;;
    "Wallpaper")
        "$HOME/.config/hypr/scripts/wallpaper.sh"
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
