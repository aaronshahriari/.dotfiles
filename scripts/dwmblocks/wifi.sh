#!/usr/bin/env bash

case $BLOCK_BUTTON in
    1) alacritty -e nmtui; pkill -RTMIN+3 dwmblocks ;;
esac

# wifi
if [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'up' ] ; then
	wifisignal="$(awk '/^\s*w/ { print int($3 * 100 / 70) }' /proc/net/wireless)"
    if [ "$wifisignal" -ge 90 ]; then
        iconstrength="󰤨"
    elif [ "$wifisignal" -ge 80 ]; then
        iconstrength="󰤥"
    elif [ "$wifisignal" -ge 60 ]; then
        iconstrength="󰤢"
    elif [ "$wifisignal" -ge 40 ]; then
        iconstrength="󰤟"
    elif [ "$wifisignal" -ge 20 ]; then
        iconstrength="󰤯"
    fi
elif [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'down' ] ; then
	[ "$(cat /sys/class/net/w*/flags 2>/dev/null)" = '0x1003' ] && iconstrength="󰤫" || iconstrength="󰤭"
fi

# ethernet
# if [ "$(cat /sys/class/net/e*/operstate 2>/dev/null)" = 'up' ]
#     ethericon=""
# fi

printf "%s %s" "$iconstrength" "$wifisignal"
