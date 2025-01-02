#!/usr/bin/env bash

case $BLOCK_BUTTON in
	6) setsid -f "ghostty" -e "nvim" "$0" ;;
esac

# home for now
usage=$(df -h /home | awk ' /[0-9]/ {print $3 "/" $2}')
icon="󰠦"

printf " ^c#ffffff^%s %s^d^" "$icon" "$usage"
