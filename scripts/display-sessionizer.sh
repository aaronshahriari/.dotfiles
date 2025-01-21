#!/usr/bin/env bash

# get the current set autorandr setups
autorandr_profiles=$(autorandr | tr ' ' '\n')

case "$(printf "$autorandr_profiles" | dmenu -g 1 -i -l 10 -p "Display Setup:")" in
    "laptop")
        autorandr --load laptop
        xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0 ;;
    "home-two")
        autorandr --load home-two
        ;;
    "home-two-swap")
        autorandr --load home-two-swap
        ;;
esac

feh --bg-fill /usr/share/backgrounds/desktop_wall.jpg --bg-fill /usr/share/backgrounds/desktop_wall.jpg
xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Scrolling Pixel Distance" 50
xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8
