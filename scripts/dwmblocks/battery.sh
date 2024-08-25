#!/usr/bin/env bash

battery=/sys/class/power_supply/BAT0
case "$(cat "$battery/status" 2>&1)" in
    "Full") status="󰁹" ;;
    "Discharging")
        if [ "$capacity" -ge 90 ]; then
            status="󰂂"
        elif [ "$capacity" -ge 80 ]; then
            status="󰂁"
        elif [ "$capacity" -ge 70 ]; then
            status="󰂀"
        elif [ "$capacity" -ge 60 ]; then
            status="󰁿"
        elif [ "$capacity" -ge 50 ]; then
            status="󰁾"
        elif [ "$capacity" -ge 40 ]; then
            status="󰁽"
        elif [ "$capacity" -ge 30 ]; then
            status="󰁼"
        elif [ "$capacity" -ge 20 ]; then
            status="󰁻"
        elif [ "$capacity" -ge 10 ]; then
            status="󰁺"
        fi
        ;;
    "Charging")
        if [ "$capacity" -ge 90 ]; then
            status="󰂋"
        elif [ "$capacity" -ge 80 ]; then
            status="󰂊"
        elif [ "$capacity" -ge 70 ]; then
            status="󰢞"
        elif [ "$capacity" -ge 60 ]; then
            status="󰂉"
        elif [ "$capacity" -ge 50 ]; then
            status="󰢝"
        elif [ "$capacity" -ge 40 ]; then
            status="󰂈"
        elif [ "$capacity" -ge 30 ]; then
            status="󰂇"
        elif [ "$capacity" -ge 20 ]; then
            status="󰂆"
        elif [ "$capacity" -ge 10 ]; then
            status="󰢜"
        fi
        ;;
    "Not charging") status="󱉞" ;;
    "Unknown") status="󰂑" ;;
    *) exit 1 ;;
esac
capacity="$(cat "$battery/capacity" 2>&1)"
# Will make a warn variable if discharging and low
# Prints the info
printf "%s %s%%" "$status" "$capacity"
