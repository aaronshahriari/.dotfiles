#!/usr/bin/env bash

case $BLOCK_BUTTON in
	6) setsid -f "alacritty" -e "nvim" "$0" ;;
esac

# wait until exactly a minute
while [ $(date +%S) -ne 00 ]; do
    sleep 0.1
done

date_str=$(date "+%D %I:%M%p")

printf "^c#ffffff^%s ^d^" "$date_str"
