#!/usr/bin/env bash

autorandr --load home-two
feh --bg-fill /usr/share/backgrounds/desktop_wall.jpg --bg-fill /usr/share/backgrounds/desktop_wall.jpg
xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8
xsetroot -cursor_name left_ptr
