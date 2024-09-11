#!/usr/bin/env bash

# set the directory to save the screenshot
SCREENSHOT_DIR="/home/aaronshahriari/Pictures/Screenshots/"

# take a screenshot without notifications and save it in the directory
flameshot gui -c -p $SCREENSHOT_DIR

# find the most recently created file in the screenshot directory that was modified within the last 5 seconds
LATEST_SCREENSHOT=$(find $SCREENSHOT_DIR -type f -mmin -0.0333 -print | sort -r | head -n 1)

# check if a screenshot file was found and its timestamp
if [[ -n $LATEST_SCREENSHOT ]]; then
    # Check if the file exists and is not empty
    if [[ -f $LATEST_SCREENSHOT && -s $LATEST_SCREENSHOT ]]; then
        notify-send -u low "Screenshot Taken" -i "$LATEST_SCREENSHOT"
    else
        notify-send -u low "Screenshot Error" "The screenshot file is empty or couldn't be saved."
    fi
else
    notify-send -u low "Screenshot Cancelled"
fi
