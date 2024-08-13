#!/usr/bin/env bash

case "$(printf "Home\nLaptop\nSingle-Display\n" | dmenu -l 10 -nb '#000000' -sf '#000000' -sb '#67A86C' -nf '#67A86C' -fn 'CaskaydiaCoveNerdFontMono-10' -p "Display Setup:")" in
    "Home")
        autorandr --load home
        xinput set-prop "pointer:Logitech G502" "libinput Accel Speed" -0.8 ;;
    # "Laptop")
    #     autorandr --load laptop ;;
    # "Single-Display")
    #     autorandr --load single ;;
esac
