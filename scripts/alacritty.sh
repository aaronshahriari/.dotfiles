#!/usr/bin/env bash

alacritty_status=/tmp/alacritty
curr_setup="$(cat "$alacritty_status")"

if [ "$curr_setup" = "home-two" ]; then
    alacritty --config-file $HOME/.config/alacritty/home-two.toml
elif [ "$curr_setup" = "laptop" ]; then
    alacritty --config-file $HOME/.config/alacritty/laptop.toml
else
    alacritty --config-file $HOME/.config/alacritty/alacritty.toml
fi
