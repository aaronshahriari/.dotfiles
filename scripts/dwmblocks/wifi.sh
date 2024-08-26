#!/usr/bin/env bash

case $BLOCK_BUTTON in
    1) alacritty -e nmtui ;;
	6) setsid -f "alacritty" -e "nvim" "$0" ;;
esac

# wifi
if [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'up' ] ; then
	wifisignal="$(awk '/^\s*w/ { print int($3 * 100 / 70) }' /proc/net/wireless)"
    if [ "$wifisignal" -ge 90 ]; then
        iconstrength="^c#8BC34A^󰤨 ^d^"
    elif [ "$wifisignal" -ge 80 ]; then
        iconstrength="^c#FFEB3B^󰤥 ^d^"
    elif [ "$wifisignal" -ge 60 ]; then
        iconstrength="^c#FFC107^󰤢 ^d^"
    elif [ "$wifisignal" -ge 40 ]; then
        iconstrength="^c#FF9800^󰤟 ^d^"
    elif [ "$wifisignal" -ge 20 ]; then
        iconstrength="^c#FF5722^󰤯 ^d^"
    fi
elif [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'down' ] ; then
	[ "$(cat /sys/class/net/w*/flags 2>/dev/null)" = '0x1003' ] && iconstrength="^c#2196F3^󰤫 ^d^" || iconstrength="^c#2196F3^󰤭 ^d^"
fi

# ethernet
# if [ "$(cat /sys/class/net/e*/operstate 2>/dev/null)" = 'up' ]
#     ethericon=""
# fi

printf "%s^c#ffffff^%s^d^" "$iconstrength" "$wifisignal"
