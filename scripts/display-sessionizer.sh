#!/usr/bin/env bash

# get the current set autorandr setups
autorandr_profiles=$(autorandr | tr ' ' '\n')

case "$(printf "$autorandr_profiles" | dmenu -g 1 -i -l 10 -p "Display Setup:")" in
    "default")
        autorandr --load default
        ;;
    "home-two")
        autorandr --load home-two
        ;;
esac
