#!/usr/bin/env bash

case $BLOCK_BUTTON in
	1) setsid -f "ghostty" -e top ;;
	6) setsid -f "ghostty" -e "nvim" "$0" ;;
esac

usage="$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print int(100 - $1)}')"
if [ "$usage" -ge 90 ]; then
    icon="^c#FF5722^ ^d^"
elif [ "$usage" -ge 70 ]; then
    icon="^c#FF9800^ ^d^"
elif [ "$usage" -ge 50 ]; then
    icon="^c#FFC107^ ^d^"
elif [ "$usage" -ge 30 ]; then
    icon="^c#FFEB3B^ ^d^"
elif [ "$usage" -ge 10 ]; then
    icon="^c#8BC34A^ ^d^"
elif [ "$usage" -ge 0 ]; then
    icon="^c#8BC34A^ ^d^"
fi

printf "%s ^c#ffffff^%s%%^d^" "$icon" "$usage"
