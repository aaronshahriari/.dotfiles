#!/usr/bin/env bash

case "$(printf "Shutdown\nReboot\nLock\nExit i3\n" | dmenu -l 10 -nb '#000000' -sf '#000000' -sb '#67A86C' -nf '#67A86C' -fn 'JetbrainsMono-11' -p "System:")" in
    "Shutdown") sudo poweroff ;;
    "Reboot") sudo reboot ;;
    "Lock") i3lock -t -i ~/Downloads/i3lock.png ;;
    "Exit i3") sudo pkill i3 ;;
    *) exit 1 ;;
esac
