#!/usr/bin/env bash

case $BLOCK_BUTTON in
    1) ~/.local/bin/scripts/device-sessionizer.sh ;;
    2) ~/.local/bin/scripts/display-sessionizer.sh ;;
    3) ~/.local/bin/scripts/fix-devices.sh ;;
	6) setsid -f "ghostty" -e "nvim" "$0" ;;
esac

power_icon="⏻"

printf "^c#6e8387^%s  ^d^" "$power_icon"
