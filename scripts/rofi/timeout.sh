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

options=("5 Minutes" "15 Minutes" "30 Minutes" "60 Minutes" "Never")
choice=$(printf "%s\n" "${options[@]}" | $ROFI_LAUNCHER "Set:")

if [[ -z "$choice" ]]; then
    exit 0
fi

if [[ "$choice" == "Never" ]]; then
    pkill hypridle
    notify-send -t 4000 -u critical -i "$ICON_PATH" "Hypridle Timeout" "$choice"
else
    minutes=$(echo "$choice" | awk '{print $1}')
    ln -sfn "$DOT_DIR/timeout$minutes.conf" $CONFIG_DIR
    sleep 1
    restart_hypridle 
    notify-send -t 3000 -u normal -i "$ICON_PATH" "Hypridle Timeout" "$choice"
fi
