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

bluelight_on() {
    hyprsunset=$(pgrep hyprsunset)
    if [ -z "$hyprsunset" ]; then
        hyprsunset &
        hyprctl hyprsunset temperature 2500
    else
        hyprctl hyprsunset temperature 2500
    fi
}

bluelight_off() {
    hyprsunset=$(pgrep hyprsunset)
    if [ -z "$hyprsunset" ]; then
        hyprsunset &
        hyprctl hyprsunset identity
    else
        hyprctl hyprsunset identity
    fi
}

case "$(printf "Hyprsunset\nWallpaper\nLogitech Mouse\nWireplumber\n" | ~/.config/rofi/launchers/scripts/launcher.sh -g 1 -m 0 -i -l 10 -p "Run")" in
    "Hyprsunset")
        case "$(printf "On\nOff\n" | ~/.config/rofi/launchers/scripts/launcher.sh -g 1 -m 0 -i -l 10)" in
            "On")
                bluelight_on
                ;;
            "Off")
                bluelight_off
                ;;
        esac
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
