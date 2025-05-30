#!/usr/bin/env bash

case $BLOCK_BUTTON in
    1) playerctl previous;
        kill -42 $(pidof dwmblocks) ;; 
    2) playerctl play-pause;
        kill -42 $(pidof dwmblocks) ;; 
    3) playerctl next;
        kill -42 $(pidof dwmblocks) ;; 
	6) setsid -f "ghostty" -e "nvim" "$0" ;;
esac

# check if playerctl is on
# if YES show on menu bar the artist - song << play/pause >>
# if NO show nothing

player_status="$(playerctl metadata 2>&1)"

if [ "$player_status" = "No players found" ]; then
    printf ""
else
    curr_song="$(playerctl metadata --format '{{ artist }} - {{ title }}' | tr -d '\r' | sed 's/[^[:print:]]//g' | awk '{$1=$1; print}')"
    printf "^c#6e8387^%s^d^\n" "$curr_song"
fi
