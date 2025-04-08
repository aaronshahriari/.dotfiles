#!/usr/bin/env bash

picom -b &
feh --bg-fill /home/$USER/Pictures/Wallpapers/dark_stream.jpg --bg-fill /home/$USER/Pictures/Wallpapers/dark_stream.jpg
xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8
xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 0
xinput set-prop "pointer:PIXA3854:00 093A:0274 Touchpad" "libinput Scrolling Pixel Distance" 50
xsetroot -cursor_name left_ptr
xss-lock -- i3lock -n -i /home/aaronshahriari/Pictures/Wallpapers/resize_lock.png
xset s 900 900
