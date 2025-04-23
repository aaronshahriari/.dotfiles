#!/usr/bin/env bash

player_status="$(playerctl metadata 2>&1)"

if [ "$player_status" = "No players found" ]; then
    printf ""
else
    curr_song="$(playerctl metadata --format '{{ artist }} - {{ title }}' | tr -d '\r' | sed 's/[^[:print:]]//g' | awk '{$1=$1; print}')"
    curr_song_escaped=$(echo "$curr_song" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&apos;/g')
    printf "%s\n" "$curr_song_escaped"
fi
