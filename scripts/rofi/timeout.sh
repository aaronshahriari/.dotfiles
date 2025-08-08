#!/usr/bin/env bash
ROFI_LAUNCHER="$HOME/.config/rofi/launchers/scripts/launcher.sh"
DOT_DIR="/home/aaronshahriari/github/.dotfiles/hyprland/hypr/timeout"
CONFIG_DIR="/home/aaronshahriari/.config/hypr/hypridle.conf"
ICON_PATH="$(nix path-info nixpkgs#material-black-colors)/share/icons/Material-Black-Plum-Numix-FLAT/32/actions/alarm.svg"

restart_hypridle() {
    if pgrep -x "hypridle" > /dev/null; then
        pkill hypridle
        hypridle &
    else
        hypridle &
    fi
}

# intervals = [5, 15, 30, 60, Never]
options=("5 Minutes" "15 Minutes" "30 Minutes" "60 Minutes" "Never")
choice=$(printf "%s\n" "${options[@]}" | $ROFI_LAUNCHER "Set:")

if [[ -z "$choice" ]]; then
    exit 0
fi

if [[ "$choice" == "Never" ]]; then
    # pkill hypridle
    notify-send -u critical -i "$ICON_PATH" "Hypridle Timeout" "$choice"
else
    minutes=$(echo "$choice" | awk '{print $1}')
    # echo "ln -sfn "$DOT_DIR/timeout"$minutes".conf" $CONFIG_DIR"
    # sleep 1
    # restart_hypridle 
    notify-send -u low -i "$ICON_PATH" "Hypridle Timeout" "$choice"
fi
