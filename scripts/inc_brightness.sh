#!/usr/bin/env bash

# notification ID
NOTIF_ID=12345

# icon path
# ICON_PATH=~/.local/bin/scripts/icons/inc_bright.png
ICON_PATH=~/Github/.dotfiles/scripts/icons/inc_bright.png

# find connected displays
DISPLAY_NAME="DisplayPort-6"

# increment amount +
STEP=0.1

# Get current brightness
CURRENT_BRIGHTNESS=$(xrandr --verbose | grep -i brightness | awk '{print $2}' | head -n 1)

# calculate new brightness (clamp between 0 and 1)
NEW_BRIGHTNESS=$(echo "$CURRENT_BRIGHTNESS + $STEP" | bc)
NEW_BRIGHTNESS=$(awk -v new="$NEW_BRIGHTNESS" 'BEGIN {if (new > 1) new = 1; if (new < 0) new = 0; print new}')

# get percentage
NEW_BRIGHTNESS_PERCENT=$(printf "%.0f" "$(echo "$NEW_BRIGHTNESS * 100" | bc)")

# apply new brightness
xrandr --output $DISPLAY_NAME --brightness $NEW_BRIGHTNESS

# notify-send new brightness with icon
notify-send -u normal "Brightness $NEW_BRIGHTNESS_PERCENT%" -i $ICON_PATH -r $NOTIF_ID
