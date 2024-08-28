#!/usr/bin/env bash

case $BLOCK_BUTTON in
	6) setsid -f "alacritty" -e "nvim" "$0" ;;
esac

notify_file=/tmp/battery-notify
# battery=/sys/class/power_supply/BAT0
# capacity="$(cat "$battery/capacity" 2>&1)"
capacity=100

# case "$(cat "$battery/status" 2>&1)" in
case "Full" in 
    "Full")
        status="󰁹 "
        if [ -f "$notify_file" ]; then
            content=$(cat "$notify_file")
            if  [ "$content" -ne 3 ]; then
                notify-send "Low Battery "$capacity%""
                echo 3 > "$notify_file"
            fi
        else
            echo "NOTIFY: "$notify_file" DOESN'T EXIST"
        fi
        ;;
    "Discharging")
        if [ "$capacity" -ge 90 ]; then
            status="󰂂 "
        elif [ "$capacity" -ge 80 ]; then
            status="󰂁 "
        elif [ "$capacity" -ge 70 ]; then
            status="󰂀 "
        elif [ "$capacity" -ge 60 ]; then
            status="󰁿 "
        elif [ "$capacity" -ge 50 ]; then
            status="󰁾 "
        elif [ "$capacity" -ge 40 ]; then
            status="󰁽 "
        elif [ "$capacity" -ge 30 ]; then
            status="󰁼 "
        elif [ "$capacity" -ge 20 ]; then
            echo "CAPACITY = $capacity%\n"
            status="󰁻 "
            if [ "$capacity" -eq 20 ]; then
                if [ -f "$notify_file" ]; then
                    content=$(cat "$notify_file")
                    if  [ "$content" -ne 2 ]; then
                        notify-send -u critial "Low Battery "$capacity%""
                        echo 2 > "$notify_file"
                    fi
                else
                    notify-send -u critial ""$notify_file" DOESN'T EXIST"
                fi
            fi
        elif [ "$capacity" -ge 10 ]; then
            status="󰁺 "
            if [ "$capacity" -eq 10 ]; then
                if [ -f "$notify_file" ]; then
                    content=$(cat "$notify_file")
                    if  [ "$content" -ne 1 ]; then
                        notify-send -u critial "Low Battery "$capacity%""
                        echo 1 > "$notify_file"
                    fi
                else
                    notify-send -u critial ""$notify_file" DOESN'T EXIST"
                fi
            fi
        elif [ "$capacity" -ge 0 ]; then
            status="󰂎 "
        fi
        ;;
    "Charging")
        if [ "$capacity" -ge 90 ]; then
            status="󰂋 "
        elif [ "$capacity" -ge 80 ]; then
            status="󰂊 "
        elif [ "$capacity" -ge 70 ]; then
            status="󰢞 "
        elif [ "$capacity" -ge 60 ]; then
            status="󰂉 "
        elif [ "$capacity" -ge 50 ]; then
            status="󰢝 "
        elif [ "$capacity" -ge 40 ]; then
            status="󰂈 "
        elif [ "$capacity" -ge 30 ]; then
            status="󰂇 "
        elif [ "$capacity" -ge 20 ]; then
            status="󰂆 "

            if [ "$capacity" -eq 20 ]; then
                if [ -f "$notify_file" ]; then
                    content=$(cat "$notify_file")
                    if  [ "$content" -ne 2 ]; then
                        notify-send -u critial "Low Battery "$capacity%""
                        echo 2 > "$notify_file"
                    fi
                else
                    notify-send -u critial ""$notify_file" DOESN'T EXIST"
                fi
            fi
        elif [ "$capacity" -ge 10 ]; then
            status="󰢜 "
            if [ "$capacity" -eq 10 ]; then
                if [ -f "$notify_file" ]; then
                    content=$(cat "$notify_file")
                    if  [ "$content" -ne 1 ]; then
                        notify-send -u critial "Low Battery "$capacity%""
                        echo 1 > "$notify_file"
                    fi
                else
                    notify-send -u critial ""$notify_file" DOESN'T EXIST"
                fi
            fi
        elif [ "$capacity" -ge 0 ]; then
            status="󰢟 "
        fi
        ;;
    "Not charging") status="󱉝 " ;;
    "Unknown") status="󰂑 " ;;
    *) exit 1 ;;
esac

printf "%s^c#ffffff^%s%%^d^" "$status" "$capacity"
