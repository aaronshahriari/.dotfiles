#!/usr/bin/env bash

case $BLOCK_BUTTON in
	6) setsid -f "alacritty" -e "nvim" "$0" ;;
esac

battery=/sys/class/power_supply/BAT0
capacity="$(cat "$battery/capacity" 2>&1)"
case "$(cat "$battery/status" 2>&1)" in
    "Full") status="^c#4CAF50^󰁹 ^d^" ;;
    "Discharging")
        if [ "$capacity" -ge 90 ]; then
            status="^c#8BC34A^󰂂 ^d^"
        elif [ "$capacity" -ge 80 ]; then
            status="^c#8BC34A^󰂁 ^d^"
        elif [ "$capacity" -ge 70 ]; then
            status="^c#FFEB3B^󰂀 ^d^"
        elif [ "$capacity" -ge 60 ]; then
            status="^c#FFEB3B^󰁿 ^d^"
        elif [ "$capacity" -ge 50 ]; then
            status="^c#FFC107^󰁾 ^d^"
        elif [ "$capacity" -ge 40 ]; then
            status="^c#FFC107^󰁽 ^d^"
        elif [ "$capacity" -ge 30 ]; then
            status="^c#FF9800^󰁼 ^d^"
        elif [ "$capacity" -ge 20 ]; then
            status="^c#FF9800^󰁻 ^d^"
        elif [ "$capacity" -ge 10 ]; then
            status="^c#FF5722^󰁺 ^d^"
        fi
        ;;
    "Charging")
        if [ "$capacity" -ge 90 ]; then
            status="^c#8BC34A^󰂋 ^d^"
        elif [ "$capacity" -ge 80 ]; then
            status="^c#8BC34A^󰂊 ^d^"
        elif [ "$capacity" -ge 70 ]; then
            status="^c#FFEB3B^󰢞 ^d^"
        elif [ "$capacity" -ge 60 ]; then
            status="^c#FFEB3B^󰂉 ^d^"
        elif [ "$capacity" -ge 50 ]; then
            status="^c#FFC107^󰢝 ^d^"
        elif [ "$capacity" -ge 40 ]; then
            status="^c#FFC107^󰂈 ^d^"
        elif [ "$capacity" -ge 30 ]; then
            status="^c#FF9800^󰂇 ^d^"
        elif [ "$capacity" -ge 20 ]; then
            status="^c#FF9800^󰂆 ^d^"
        elif [ "$capacity" -ge 10 ]; then
            status="^c#FF5722^󰢜 ^d^"
        fi
        ;;
    "Not charging") status="^c#2196F3^󱉝 ^d^" ;;
    "Unknown") status="^c#2196F3^󰂑 ^d^" ;;
    *) exit 1 ;;
esac

printf "%s^c#ffffff^%s%%^d^" "$status" "$capacity"
