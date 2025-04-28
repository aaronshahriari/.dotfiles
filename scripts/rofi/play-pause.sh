#!/usr/bin/env bash

all_players=$(playerctl -l)

if [ -z "$all_players" ]; then
    exit 1
elif [ "$(echo "$all_players" | wc -w)" -eq 1 ]; then
    playerctl -p "$all_players" play-pause
else
    adjusted_chrome=$(echo "$all_players" | sed 's/\<chromium[^ ]*/Chrome/g')
    adjusted_spotify=$(echo "$adjusted_chrome" | sed 's/\<spotify[^ ]*/Spotify/g')

    IFS=$'\n' read -rd '' -a player_clean_list <<< "$adjusted_spotify"
    IFS=$'\n' read -rd '' -a player_dirty_list <<< "$all_players"

    selection=$(printf '%s\n' "${adjusted_spotify[@]}" | tac | ~/.config/rofi/launchers/scripts/launcher.sh -i -l 10 -p "Player")
    case "$selection" in
        "${player_clean_list[0]}")
            if ! playerctl -p "${player_dirty_list[0]}" play-pause; then
                notify-send -u critical "Error" "Failed to play/pause ${player_clean_list[0]}"
            fi
            ;;
        "${player_clean_list[1]}") 
            if ! playerctl -p "${player_dirty_list[1]}" play-pause; then
                notify-send -u critical "Error" "Failed to play/pause ${player_clean_list[1]}"
            fi
            ;;
        *) exit 1 ;;
    esac
fi
