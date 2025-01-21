#!/usr/bin/env bash

# get the current set autorandr setups
autorandr_profiles=$(autorandr | tr ' ' '\n')

case "$(printf "$autorandr_profiles" | dmenu -g 1 -i -l 10 -p "Display Setup:")" in
    "laptop")
        autorandr --load laptop
        xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0 ;;
    "home-two")
        autorandr --load home-two
        primary="DisplayPort-5"
        secondary="DisplayPort-4"
        i3-msg "workspace 1; move workspace to output $primary"
        i3-msg "workspace 2; move workspace to output $primary"
        i3-msg "workspace 3; move workspace to output $primary"
        i3-msg "workspace 4; move workspace to output $primary"
        i3-msg "workspace 5; move workspace to output $primary"
        i3-msg "workspace 6; move workspace to output $secondary"
        i3-msg "workspace 7; move workspace to output $secondary"
        i3-msg "workspace 8; move workspace to output $secondary"
        i3-msg "workspace 9; move workspace to output $secondary"
        i3-msg "workspace 10; move workspace to output $secondary"
        ;;
    "home-two-swap")
        autorandr --load home-two-swap
        primary="DisplayPort-4"
        secondary="DisplayPort-5"
        i3-msg "workspace 1; move workspace to output $primary"
        i3-msg "workspace 2; move workspace to output $primary"
        i3-msg "workspace 3; move workspace to output $primary"
        i3-msg "workspace 4; move workspace to output $primary"
        i3-msg "workspace 5; move workspace to output $primary"
        i3-msg "workspace 6; move workspace to output $secondary"
        i3-msg "workspace 7; move workspace to output $secondary"
        i3-msg "workspace 8; move workspace to output $secondary"
        i3-msg "workspace 9; move workspace to output $secondary"
        i3-msg "workspace 10; move workspace to output $secondary"
        ;;
esac

feh --bg-fill /usr/share/backgrounds/desktop_wall.jpg --bg-fill /usr/share/backgrounds/desktop_wall.jpg
xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Scrolling Pixel Distance" 50
xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8
