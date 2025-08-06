#!/usr/bin/env bash

BAT="/sys/class/power_supply/BAT1"
CHARGE=$(cat "$BAT/capacity")
STATUS=$(cat "$BAT/status")

# Icon levels: 0-10, 11-30, 31-50, 51-70, 71-90, 91-100
get_icon() {
    if [ "$CHARGE" -le 10 ]; then
        echo "󰂎"
    elif [ "$CHARGE" -le 30 ]; then
        echo "󰁻"
    elif [ "$CHARGE" -le 50 ]; then
        echo "󰁽"
    elif [ "$CHARGE" -le 70 ]; then
        echo "󰁿"
    elif [ "$CHARGE" -le 90 ]; then
        echo "󰂁"
    else
        echo "󰁹"
    fi
}

ICON=$(get_icon)

# Format based on status
case "$STATUS" in
    "Charging")
        echo "󰚥 $CHARGE%"
        ;;
    "Not charging")
        echo "󰚦 $CHARGE%"
        ;;
    *)
        echo "$ICON $CHARGE%"
        ;;
esac
