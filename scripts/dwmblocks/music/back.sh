#!/usr/bin/env bash

case $BLOCK_BUTTON in
    1) playerctl previous;
        kill -43 $(pidof dwmblocks) ;; 
	6) setsid -f "alacritty" -e "nvim" "$0" ;;
esac

# check if playerctl is on
# if YES show <<
# if NO show nothing

player_status="$(playerctl metadata 2>&1)"

if [ "$player_status" = "No players found" ]; then
    printf ""
else
    back_button=""
    printf " ^c#6e8387^%s ^d^" "$back_button"
fi
