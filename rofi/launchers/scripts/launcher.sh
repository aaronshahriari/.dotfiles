#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10

dir="$HOME/.config/rofi/launchers/scripts"
theme='style-2'

## Run
rofi \
    -dmenu -i -p "$1" \
    -kb-accept-custom "" \
    -kb-custom-1 "Control+Return" \
    -theme ${dir}/${theme}.rasi
