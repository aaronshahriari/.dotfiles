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

case "$(printf "Wallpaper\nLogitech Mouse\nDWMBlocks\nLogitech Camera\nTouchpad\nWireplumber\n" | dmenu -g 1 -m 0 -i -l 10 -p "Restart:")" in
    "Wallpaper")
        feh --bg-fill "$HOME"/Pictures/Wallpapers/wallpaper.jpg --bg-fill "$HOME"/Pictures/Wallpapers/wallpaper.jpg
        ;;
    "Logitech Mouse")
        xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.9
        ;;
    "DWMBlocks")
        pkill dwmblocks && dwmblocks &
        ;;
    "Logitech Camera")
        reset_cam
        ;;
    "Touchpad")
        xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Scrolling Pixel Distance" 50
        xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0
        ;;
    "Wireplumber")
        systemctl --user restart wireplumber.service
        systemctl --user restart pipewire.service
        ;;
esac
