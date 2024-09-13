#!/usr/bin/env bash

case "$(printf "Home\n" | dmenu -m 0 -i -l 10 -p "Display Setup:")" in
    "Home")
        case "$(printf "Laptop\nSingle\nDouble\n" | dmenu -m 0 -i -l 10 -p "Display Setup:")" in
            "Laptop")
                autorandr --load laptop
                xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0
                xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8 ;;
            "Single")
                # set auto setup
                autorandr --load home-single
                # set dpi for home setup
                xrandr --dpi 95
                # set xinput for home mouse
                xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0
                xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8 ;;
            "Double")
                autorandr --load home-two
                xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0
                xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8 ;;
        esac
esac
