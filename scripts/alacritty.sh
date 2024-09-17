#!/usr/bin/env bash

curr_setup="$(autorandr --current)"

if [ "$curr_setup" = "home-two" ]; then
    alacritty --config-file $HOME/.config/alacritty/home-two.toml
elif [ "$curr_setup" = "laptop" ]; then
    alacritty --config-file $HOME/.config/alacritty/laptop.toml
else
    alacritty --config-file $HOME/.config/alacritty/alacritty.toml
fi
