#!/usr/bin/env bash

reset_cam() {
    cam_id=$(lsusb | grep 'C920 PRO HD Webcam' | cut -d' ' -f6)
    if [ -n "$cam_id" ]; then
        sudo usbreset "$cam_id"
    else
        echo "Webcam could not be found" >&2
        return 1
    fi

}

case "$(printf "Red Light Off\nWallpaper\nLogitech Mouse\nWireplumber\n" | ~/.config/rofi/launchers/scripts/launcher.sh -g 1 -m 0 -i -l 10 -p "Run")" in
    "Red Light Off")
        hyprctl hyprsunset identity
        ;;

    "Wallpaper")
        "$HOME"/.config/hypr/modules/wallpaper.sh
        ;;

    "Logitech Camera")
        reset_cam
        ;;

    "Wireplumber")
        systemctl --user restart wireplumber.service
        systemctl --user restart pipewire.service
        ;;
esac
