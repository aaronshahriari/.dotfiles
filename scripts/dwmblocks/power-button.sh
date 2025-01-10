#!/usr/bin/env bash

case $BLOCK_BUTTON in
    1) ~/.local/bin/scripts/fix-devices.sh ;;
	6) setsid -f "ghostty" -e "nvim" "$0" ;;
esac

power_icon="⏻"

printf "^c#ffffff^%s^d^" "$power_icon"
