#!/usr/bin/env bash

case $BLOCK_BUTTON in
    1) setsid -w -f "alacritty" -e alsamixer; pkill -RTMIN+1 dwmblocks ;;
    2) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; pkill -RTMIN+1 dwmblocks ;;
    4) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+; pkill -RTMIN+1 dwmblocks ;;
    5) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; pkill -RTMIN+1 dwmblocks ;;
esac

# Get the volume and mute status
vol="$(amixer get Master | grep -oP '[0-9]+(?=%)' | head -1)"
mute_status="$(amixer get Master | grep -oP '\[(on|off)\]' | head -1)"

[ "$mute_status" == "[off]" ] && echo "  " && exit

case 1 in
	$((vol >= 70)) ) icon="  " ;;
	$((vol >= 30)) ) icon=" " ;;
	$((vol >= 1)) ) icon=" " ;;
	* ) echo "  " ;;
esac

printf "%s %s" "$icon" "$vol"
