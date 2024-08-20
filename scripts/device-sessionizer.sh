#!/usr/bin/env bash

source ~/.local/bin/scripts/themes.sh

case "$(printf "Shutdown\nReboot\nLock\n" | dmenu -i -l 10 -p "System:")" in
    "Shutdown") sudo poweroff ;;
    "Reboot") reboot ;;
    "Lock") ~/.local/bin/scripts/i3lock.sh ;;
    *) exit 1 ;;
esac
