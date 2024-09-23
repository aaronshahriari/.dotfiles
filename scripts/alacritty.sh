#!/usr/bin/env bash

curr_setup="$(autorandr --current)"
detect_setup="$(autorandr --detected)"

if [ "$curr_setup" = "home-two" ] || [ "$detect_setup" = "home-two" ]; then
    alacritty --config-file $HOME/.config/alacritty/home-two.toml
else if [ "$curr_setup" = "laptop" ] || [ "$detect_setup" = "laptop" ]; then
    alacritty --config-file $HOME/.config/alacritty/laptop.toml
else
    alacritty --config-file $HOME/.config/alacritty/alacritty.toml
fi
