#!/usr/bin/env bash

case "$(printf "Shutdown\nReboot\nLock\n" | dmenu -i -l 10 -p "System:")" in
    "Shutdown")
        case "$(printf "Yes\nNo" | dmenu -i -l 10 -p "Are You Sure:")" in
            "Yes") sudo shutdown -h now ;;
            *) exit 1 ;;
        esac
    "Reboot")
        case "$(printf "Yes\nNo" | dmenu -i -l 10 -p "Are You Sure:")" in
            "Yes") reboot ;;
            *) exit 1 ;;
        esac
    "Lock")
        case "$(printf "Yes\nNo" | dmenu -i -l 10 -p "Are You Sure:")" in
            "Yes") slock ;;
            *) exit 1 ;;
        esac
    *) exit 1 ;;
esac
