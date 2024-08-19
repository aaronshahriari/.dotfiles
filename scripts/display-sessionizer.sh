#!/usr/bin/env bash

source ~/.local/bin/scripts/themes.sh

case "$(printf "Home\n" | dmenu -l 10 -nb $BLACK -sf $BLACK -sb $MAIN -nf $MAIN -fn $FONT -p "Display Setup:")" in
    "Home")
        case "$(printf "Laptop\nSingle\nDouble\n" | dmenu -l 10 -nb $BLACK -sf $BLACK -sb $MAIN -nf $MAIN -fn $FONT -p "Display Setup:")" in
            # "Laptop")
            #     autorandr --load laptop
            #     xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8 ;;
            "Single")
                # set auto setup
                autorandr --load home-single
                # set dpi for home setup
                xrandr --dpi 95
                # set xinput for home mouse
                xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8
                # restart i3 to setup wallpaper/polybar/workspaces
                i3-msg restart ;;
            "Double")
                autorandr --load home-two
                xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8
                i3-msg restart ;;
        esac
    # "Laptop")
    #     autorandr --load laptop ;;
    # "Single-Display")
    #     autorandr --load single ;;
esac
