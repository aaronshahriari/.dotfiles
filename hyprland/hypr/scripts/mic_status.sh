#!/usr/bin/env bash
ICON_PATH="$(nix path-info nixpkgs#material-black-colors)/share/icons/Material-Black-Plum-Numix-FLAT/32/devices/audio-input-microphone.svg"

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

get_status=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{gsub(/\[|\]/,"",$3); print $3}')
if [[ "$get_status" == "MUTED" ]]; then
    notify-send -t 2000 -u normal -i "$ICON_PATH" "Muted"
else
    notify-send -t 2000 -u critical -i "$ICON_PATH" "Unmuted"
fi
