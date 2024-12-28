#!/usr/bin/env bash

case $BLOCK_BUTTON in
	6) setsid -f "ghostty" -e "nvim" "$0" ;;
esac

# Get total and available memory
total_mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
available_mem=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

# Calculate memory usage as a percentage and round up
usage=$(awk "BEGIN {usage=($total_mem-$available_mem)/$total_mem*100; print (usage == int(usage)) ? usage : int(usage+1)}")

if [ "$usage" -ge 90 ]; then
    icon="^c#FF5722^ ^d^"
elif [ "$usage" -ge 70 ]; then
    icon="^c#FF9800^ ^d^"
elif [ "$usage" -ge 50 ]; then
    icon="^c#FFC107^ ^d^"
elif [ "$usage" -ge 30 ]; then
    icon="^c#FFEB3B^ ^d^"
elif [ "$usage" -ge 10 ]; then
    icon="^c#8BC34A^ ^d^"
elif [ "$usage" -ge 0 ]; then
    icon="^c#8BC34A^ ^d^"
fi

# Display memory usage percentage
printf "%s ^c#ffffff^%s%%^d^" "$icon" "$usage"
