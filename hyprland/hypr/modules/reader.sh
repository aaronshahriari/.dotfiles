#!/usr/bin/env bash

DIR="$HOME/personal/books/"
book_list=$(find "$DIR" -maxdepth 1 -mindepth 1 -printf "%f\n" | ~/.config/rofi/launchers/scripts/launcher.sh -i -g 1 -p)

# close if no selection
[ -z "$book_list" ] && exit

FULL_PATH="$DIR/$book_list"

if [[ "$book_list" == *.pdf ]]; then
    zathura "$FULL_PATH" &
elif [[ -d "$FULL_PATH" ]]; then
    if [[ -f "$FULL_PATH/index.html" ]]; then
        xdg-open "$FULL_PATH/index.html" &
    else
        notify-send "No index.html In Directory: $book_list"
    fi
else
    notify-send "No Configuration For Book: $book_list"
fi
