#!/usr/bin/env bash

case "$(printf "Lock\nSleep\nSwitch User\nReboot\nShutdown\n" | dmenu -g 1 -i -l 10 -p "System:")" in
    "Lock")
        i3lock -i /usr/share/backgrounds/locker-background.png
        ;;
    "Sleep")
        i3lock -i /usr/share/backgrounds/locker-background.png && systemctl suspend
        ;;
    "Switch User")
        case "$(printf "Yes\nNo" | dmenu -g 1 -i -l 10 -p "Are You Sure:")" in
            "Yes") dm-tool switch-to-greeter ;;
            *) exit 1 ;;
        esac ;;
    "Reboot")
        case "$(printf "Yes\nNo" | dmenu -g 1 -i -l 10 -p "Are You Sure:")" in
            "Yes") reboot ;;
            *) exit 1 ;;
        esac ;;
    "Shutdown")
        case "$(printf "Yes\nNo" | dmenu -g 1 -i -l 10 -p "Are You Sure:")" in
            "Yes") shutdown -h now ;;
            *) exit 1 ;;
        esac ;;
    *) exit 1 ;;
esac
