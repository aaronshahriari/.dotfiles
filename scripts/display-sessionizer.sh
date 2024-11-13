#!/usr/bin/env bash

case "$(printf "Home\n" | dmenu -i -l 10 -p "Display:")" in
    "Home")
        case "$(printf "Laptop\nSingle\nDouble\n" | dmenu -i -l 10 -p "Display Setup:")" in
            "Laptop")
                autorandr --load laptop
                feh --bg-fill /usr/share/backgrounds/desktop_wall.jpg --bg-fill /usr/share/backgrounds/desktop_wall.jpg
                xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Scrolling Pixel Distance" 50
                xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0
                xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8 ;;
            # "Single")
            #     # set auto setup
            #     autorandr --load home-single
            #     feh --bg-fill /usr/share/backgrounds/desktop_wall.jpg --bg-fill /usr/share/backgrounds/desktop_wall.jpg
            #     # set dpi for home setup
            #     xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Scrolling Pixel Distance" 50
            #     xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0
            #     xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8 ;;
            "Double")
                # active_monitors=$(xrandr --listmonitors | awk '{print $4}' | tail -n +2)
                active_monitors=$(xrandr | grep " connected" | awk '{print $1}')

                if [[ "$active_monitors" == *"DisplayPort-5"* && "$active_monitors" == *"DisplayPort-4"* ]]; then
                    autorandr --load home-two2
                elif [[ "$active_monitors" == *"DisplayPort-7"* && "$active_monitors" == *"DisplayPort-6"* ]]; then
                    autorandr --load home-two
                fi
                feh --bg-fill /usr/share/backgrounds/desktop_wall.jpg --bg-fill /usr/share/backgrounds/desktop_wall.jpg
                xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Scrolling Pixel Distance" 50
                xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8 ;;
        esac
esac
