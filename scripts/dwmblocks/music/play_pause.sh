#!/usr/bin/env bash

case $BLOCK_BUTTON in
    1) playerctl play-pause;
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
    play_pause="$(playerctl status 2>&1)"
    if [ "$play_pause" = "Playing" ]; then
        play_pause_button=""
    elif [ "$play_pause" = "Paused" ]; then
        play_pause_button=""
    else
        play_pause_button=""
    fi
    printf " ^c#6e8387^%s ^d^" "$play_pause_button"
fi
