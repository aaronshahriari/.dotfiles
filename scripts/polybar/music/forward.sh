#!/usr/bin/env bash

case $BLOCK_BUTTON in
    1) playerctl next;
        kill -43 $(pidof dwmblocks) ;; 
	6) setsid -f "ghostty" -e "nvim" "$0" ;;
esac

# check if playerctl is on
# if YES show <<
# if NO show nothing

player_status="$(playerctl metadata 2>&1)"

if [ "$player_status" = "No players found" ]; then
    printf ""
else
    forward_button=""
    printf "^c#6e8387^%s ^d^" "$forward_button"
fi
