#!/usr/bin/env bash

DIR="$HOME/personal/books/"
book_list=$(ls "$DIR" | ~/.config/rofi/launchers/scripts/launcher.sh -i -g 1 -p)

# close if no selection
[ -z "$book_list" ] && exit

zathura "$DIR/$book_list" &
