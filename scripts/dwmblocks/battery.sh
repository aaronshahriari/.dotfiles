#!/usr/bin/env bash

case $BLOCK_BUTTON in
	6) setsid -f "alacritty" -e "nvim" "$0" ;;
esac

notify_file=/tmp/battery-notify
battery=/sys/class/power_supply/BAT1
capacity="$(cat "$battery/capacity" 2>&1)"

case "$(cat "$battery/status" 2>&1)" in
    "Full")
        status="^c#4CAF50^󰁹 ^d^"
        if [ -f "$notify_file" ]; then
            content=$(cat "$notify_file")
            if  [ "$content" -ne 3 ]; then
                notify-send -u normal "Fully Charged "$capacity%"" -i ~/.local/bin//scripts/icons/full_battery.png
                echo 3 > "$notify_file"
            fi
        else
            notify-send -u critical ""$notify_file" DOESN'T EXIST"
        fi
        ;;
    "Discharging")
        if [ "$capacity" -ge 99 ]; then
            status="^c#8BC34A^󰁹 ^d^"
        elif [ "$capacity" -ge 90 ]; then
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
            if [ "$capacity" -eq 20 ]; then
                if [ -f "$notify_file" ]; then
                    content=$(cat "$notify_file")
                    if  [ "$content" -ne 2 ]; then
                        notify-send -u critical "Low Battery "$capacity%"" -i ~/.local/bin/scripts/icons/empty_battery.png
                        echo 2 > "$notify_file"
                    fi
                else
                    notify-send -u critical ""$notify_file" DOESN'T EXIST"
                fi
            fi
        elif [ "$capacity" -ge 10 ]; then
            status="^c#FF5722^󰁺 ^d^"
            if [ "$capacity" -eq 10 ]; then
                if [ -f "$notify_file" ]; then
                    content=$(cat "$notify_file")
                    if  [ "$content" -ne 1 ]; then
                        notify-send -u critical "Low Battery "$capacity%"" -i ~/.local/bin/scripts/icons/empty_battery.png
                        echo 1 > "$notify_file"
                    fi
                else
                    notify-send -u critical ""$notify_file" DOESN'T EXIST"
                fi
            fi
        elif [ "$capacity" -ge 0 ]; then
            status="^c#FF5722^󰂎 ^d^"
        fi
        ;;
    "Charging")
        if [ "$capacity" -ge 99 ]; then
            status="^c#8BC34A^󰂅 ^d^"
        elif [ "$capacity" -ge 90 ]; then
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
            if [ "$capacity" -eq 20 ]; then
                if [ -f "$notify_file" ]; then
                    content=$(cat "$notify_file")
                    if  [ "$content" -ne 2 ]; then
                        notify-send -u critical "Low Battery "$capacity%"" -i ~/.local/bin/scripts/icons/empty_battery.png
                        echo 2 > "$notify_file"
                    fi
                else
                    notify-send -u critical ""$notify_file" DOESN'T EXIST"
                fi
            fi
        elif [ "$capacity" -ge 10 ]; then
            status="^c#FF5722^󰢜 ^d^"
            if [ "$capacity" -eq 10 ]; then
                if [ -f "$notify_file" ]; then
                    content=$(cat "$notify_file")
                    if  [ "$content" -ne 1 ]; then
                        notify-send -u critical "Low Battery "$capacity%"" -i ~/.local/bin/scripts/icons/empty_battery.png
                        echo 1 > "$notify_file"
                    fi
                else
                    notify-send -u critical ""$notify_file" DOESN'T EXIST"
                fi
            fi
        elif [ "$capacity" -ge 0 ]; then
            status="^c#FF5722^󰢟 ^d^"
        fi
        ;;
    "Not charging") status="^c#2196F3^󱉝 ^d^" ;;
    "Unknown") status="^c#2196F3^󰂑 ^d^" ;;
    *) exit 1 ;;
esac

printf "%s^c#ffffff^%s%%^d^" "$status" "$capacity"
