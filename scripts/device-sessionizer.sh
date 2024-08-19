#!/usr/bin/env bash

source ~/.local/bin/scripts/themes.sh

case "$(printf "Shutdown\nReboot\nLock\nExit i3\n" | dmenu -l 10 -nb $BLACK -sf $BLACK -sb $MAIN -nf $MAIN -fn $FONT -p "System:")" in
    "Shutdown") sudo poweroff ;;
    "Reboot") reboot ;;
    "Lock") ~/.local/bin/scripts/i3lock.sh ;;
    "Exit i3") sudo pkill i3 ;;
    *) exit 1 ;;
esac
