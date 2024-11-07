#!/usr/bin/env bash

active_monitors=$(xrandr | grep " connected" | awk '{print $1}')

if [[ "$active_monitors" == *"DisplayPort-5"* && "$active_monitors" == *"DisplayPort-4"* ]]; then
    autorandr --load home-two2
elif [[ "$active_monitors" == *"DisplayPort-7"* && "$active_monitors" == *"DisplayPort-6"* ]]; then
    autorandr --load home-two
elif [[ "$active_monitors" == *"eDP"* ]]; then
    autorandr --load laptop
fi
