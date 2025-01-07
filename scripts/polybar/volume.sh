#!/usr/bin/env bash

case $BLOCK_BUTTON in
    1) setsid -w -f "ghostty" -e alsamixer; kill -35 $(pidof dwmblocks) ;; 
    3) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; kill -35 $(pidof dwmblocks) ;;
    4)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0;
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+;
        kill -35 $(pidof dwmblocks) ;; 
    5)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0;
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-;
        kill -35 $(pidof dwmblocks) ;; 
	6) setsid -f "ghostty" -e "nvim" "$0" ;;
esac

# Get the volume and mute status
vol="$(amixer get Master | grep -oP '[0-9]+(?=%)' | head -1)"
mute_status="$(amixer get Master | grep -oP '\[(on|off)\]' | head -1)"

[ "$mute_status" == "[off]" ] && echo "^c#B71C1C^ ^d^" && exit

case 1 in
	$((vol >= 70)) ) icon=" " ;;
	$((vol >= 30)) ) icon="" ;;
	$((vol >= 1)) ) icon="" ;;
	* ) echo "^c#B71C1C^ ^d^" ;;
esac

printf "^c#ffffff^%s %s^d^" "$icon" "$vol"
