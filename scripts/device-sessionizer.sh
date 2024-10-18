#!/usr/bin/env bash

export XSECURELOCK_PASSWORD_PROMPT="asterisks"
export XSECURELOCK_AUTH_CURSOR_BLINK=0
export XSECURELOCK_SAVER=~/.local/bin/scripts/xsecurelock-background.sh
export XSECURELOCK_AUTH_BACKGROUND_COLOR="#337690"
export XSECURELOCK_AUTH_FOREGROUND_COLOR="#000000"
export XSECURELOCK_SHOW_DATETIME=1
export XSECURELOCK_FONT="CaskaydiaCove Nerd Font"
export XSECURELOCK_DATETIME_FORMAT="%D %I:%M%p"
export XSECURELOCK_SHOW_KEYBOARD_LAYOUT=0
export XSECURELOCK_SINGLE_AUTH_WINDOW=1
export XSECURELOCK_DEBUG_WINDOW_INFO=1

case "$(printf "Lock\nSleep\nReboot\nShutdown\n" | dmenu -m 0 -i -l 10 -p "System:")" in
    "Lock") xsecurelock ;;
    "Sleep")
        systemctl suspend
        xsecurelock
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
