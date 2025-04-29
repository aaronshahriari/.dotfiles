#!/usr/bin/env bash

case "$(printf "Lock\nSleep\nReboot\nShutdown\n" | ~/.config/rofi/launchers/scripts/launcher.sh -g 1 -i -l 10 -p "System")" in
    "Lock")
        i3lock -n -i "$HOME"/Pictures/Wallpapers/lockscreen.png
        ;;
    "Sleep")
        systemctl suspend
        ;;
    "Reboot")
        case "$(printf "Yes\nNo" | ~/.config/rofi/launchers/scripts/launcher.sh -g 1 -i -l 10 -p "Are You Sure")" in
            "Yes") reboot ;;
            *) exit 1 ;;
        esac ;;
    "Shutdown")
        case "$(printf "Yes\nNo" | ~/.config/rofi/launchers/scripts/launcher.sh -g 1 -i -l 10 -p "Are You Sure")" in
            "Yes") shutdown -h now ;;
            *) exit 1 ;;
        esac ;;
    *) exit 1 ;;
esac
