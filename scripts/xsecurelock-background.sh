#!/usr/bin/env bash

window_id=$XSCREENSAVER_WINDOW

if [ "$XSCREENSAVER_SAVER_INDEX" = "1" ]; then
  IMAGE_PATH="/usr/share/backgrounds/lockscreen.jpg"
else
  IMAGE_PATH="/usr/share/backgrounds/lockscreen.jpg"
fi

echo "TESTING THIS WORKS"

# feh \
#   --window-id="$window_id" \
#   --xinerama-index="$XSCREENSAVER_SAVER_INDEX" \
#   --zoom=fill \
#   -F "$IMAGE_PATH" 
