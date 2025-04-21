#!/usr/bin/env bash

# notification ID
NOTIF_ID=12345

# icon path
ICON_PATH=~/.local/bin/scripts/icons/inc_bright.png
# ICON_PATH=~/Github/.dotfiles/scripts/icons/dec_bright.png # local testing

connected_displays=$(xrandr --listmonitors | grep -oP '^\s*[0-9]+:\s+\+[*]?\K[^ ]+')

# Loop through the list of connected displays and echo each one
for display in $connected_displays; do
    # increment amount +
    STEP=-0.1

    # Get current brightness
    CURRENT_BRIGHTNESS=$(xrandr --verbose | grep -i brightness | awk '{print $2}' | head -n 1)

    # calculate new brightness (clamp between 0 and 1)
    NEW_BRIGHTNESS=$(echo "$CURRENT_BRIGHTNESS + $STEP" | bc)
    NEW_BRIGHTNESS=$(awk -v new="$NEW_BRIGHTNESS" 'BEGIN {if (new > 1) new = 1; if (new < 0) new = 0; print new}')

    # get percentage
    NEW_BRIGHTNESS_PERCENT=$(printf "%.0f" "$(echo "$NEW_BRIGHTNESS * 100" | bc)")

    # apply new brightness
    xrandr --output $display --brightness $NEW_BRIGHTNESS

    # notify-send new brightness with icon
    notify-send -u normal "Brightness $NEW_BRIGHTNESS_PERCENT%" -i $ICON_PATH -r $NOTIF_ID
done
