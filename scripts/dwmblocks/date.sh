#!/usr/bin/env bash

case $BLOCK_BUTTON in
	6) setsid -f "wezterm" -e "nvim" "$0" ;;
esac

date_str=$(date "+%D %I:%M%p")
printf "^c#ffffff^%s ^d^" "$date_str"
