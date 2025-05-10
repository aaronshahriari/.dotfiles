#!/usr/bin/env bash

# Get play status and track info
class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
info=$(playerctl metadata --player=spotify --format '{{artist}} - {{title}}')

# Truncate long titles
if [[ ${#info} -gt 40 ]]; then
    info="$(echo "$info" | cut -c1-40)..."
fi

# Get position and duration
position=$(playerctl --player=spotify position 2>/dev/null || echo 0)
length=$(playerctl --player=spotify metadata --format '{{mpris:length}}' 2>/dev/null || echo 0)
length_sec=$((length / 1000000))

# Calculate percentage as integer
progress=0
if [[ $length_sec -gt 0 ]]; then
    progress=$(awk -v p="$position" -v l="$length_sec" 'BEGIN { printf "%d", (p/l)*100 }')
fi

percent=$(( (progress / 10) * 10 ))
echo "{\"text\":\"$info\", \"class\":\"$class\", \"percentage\":$percent}"

# Output JSON
# echo "{\"text\":\"$info\", \"class\":\"$class\", \"percentage\":$progress}"
