#!/usr/bin/env bash

case "$(printf "Lock\nSleep\nReboot\nShutdown\n" | dmenu -m 0 -i -l 10 -p "System:")" in
    "Lock") slock ;;
    "Sleep")
        systemctl suspend
        slock
        ;;
    "Reboot")
        case "$(printf "Yes\nNo" | dmenu -m 0 -i -l 10 -p "Are You Sure:")" in
            "Yes") reboot ;;
            *) exit 1 ;;
        esac ;;
    "Shutdown")
        case "$(printf "Yes\nNo" | dmenu -m 0 -i -l 10 -p "Are You Sure:")" in
            "Yes") sudo shutdown -h now ;;
            *) exit 1 ;;
        esac ;;
    *) exit 1 ;;
esac
