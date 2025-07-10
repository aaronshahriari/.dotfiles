#!/usr/bin/env bash

bt_status=$(bluetoothctl show 2>/dev/null)
bt_powered=$(echo "$bt_status" | grep "Powered:" | awk '{print $2}')

if [[ "$bt_powered" == "yes" ]]; then
    device=$(bluetoothctl devices Connected | cut -d ' ' -f3- | head -n 1)
    icon="󰂯"
    tooltip=${device:-"No device connected"}
elif [[ "$bt_powered" == "no" ]]; then
    icon=""
    tooltip="Bluetooth off"
else
    icon="󰂜"
    tooltip="Bluetooth unavailable"
fi

echo "$icon"
echo "$tooltip"
