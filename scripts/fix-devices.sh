#!/usr/bin/env bash

case "$(printf "Wallpaper\nLogitech Mouse\nTouchpad\nDWMBlocks\n" | dmenu -m 0 -i -l 10 -p "Restart:")" in
    "Wallpaper")
        feh --bg-fill /usr/share/backgrounds/desktop_wall.jpg --bg-fill /usr/share/backgrounds/desktop_wall.jpg
        ;;
    "Logitech Mouse")
        xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8
        ;;
    "Touchpad")
        xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Scrolling Pixel Distance" 50
        xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0
        ;;
    "Restart DWMBlocks")
        pkill dwmblocks
        dwmblocks &
        ;;
esac
