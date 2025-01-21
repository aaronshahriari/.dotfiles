#!/usr/bin/env bash

# get the current set autorandr setups
autorandr_profiles=$(autorandr | tr ' ' '\n')

move_workspaces() {
    local primary=$1
    local secondary=$2
    for i in {1..5}; do
        i3-msg "workspace $i; move workspace to output $primary" > /dev/null 2>&1
    done
    for i in {6..10}; do
        i3-msg "workspace $i; move workspace to output $secondary" > /dev/null 2>&1
    done
}

case "$(printf "$autorandr_profiles" | dmenu -g 1 -i -l 10 -p "Display Setup:")" in
    "laptop")
        autorandr --load laptop
        xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0 ;;
    "home-two")
        autorandr --load home-two
        move_workspaces "DisplayPort-5" "DisplayPort-4"
        ;;
    "home-two-swap")
        autorandr --load home-two-swap
        move_workspaces "DisplayPort-4" "DisplayPort-5"
        ;;
esac

feh --bg-fill /usr/share/backgrounds/desktop_wall.jpg --bg-fill /usr/share/backgrounds/desktop_wall.jpg
xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Scrolling Pixel Distance" 50
xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8
