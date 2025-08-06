#!/usr/bin/env bash
case "$(printf "Lock\nSuspend\nLogout\nReboot\nShutdown\n" | ~/.config/rofi/launchers/scripts/launcher.sh "System:")" in
    "Lock")
        hyprlock
        ;;
    "Suspend")
        case "$(printf "Yes\nNo" | ~/.config/rofi/launchers/scripts/launcher.sh "Are You Sure:")" in
            "Yes") 
                mpc -q pause
                amixer set Master mute
                hyprlock &
                systemctl suspend
                ;;
            *) exit 1 ;;
        esac ;;
    "Logout")
        case "$(printf "Yes\nNo" | ~/.config/rofi/launchers/scripts/launcher.sh "Are You Sure:")" in
            "Yes") 
                if [[ "$DESKTOP_SESSION" == 'i3' ]]; then
                    i3-msg exit
                elif [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
                    bspc quit
                elif [[ "$DESKTOP_SESSION" == 'openbox' ]]; then
                    openbox --exit
                elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
                    qdbus org.kde.ksmserver /KSMServer logout 0 0 0
                else
                    # Fallback for other desktop environments
                    pkill -KILL -u "$USER"
                fi
                ;;
            *) exit 1 ;;
        esac ;;
    "Reboot")
        case "$(printf "Yes\nNo" | ~/.config/rofi/launchers/scripts/launcher.sh "Are You Sure:")" in
            "Yes") systemctl reboot ;;
            *) exit 1 ;;
        esac ;;
    "Shutdown")
        case "$(printf "Yes\nNo" | ~/.config/rofi/launchers/scripts/launcher.sh "Are You Sure:")" in
            "Yes") systemctl poweroff ;;
            *) exit 1 ;;
        esac ;;
    *) exit 1 ;;
esac
