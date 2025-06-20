#!/usr/bin/env bash

bt_powered=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')

if [[ "$bt_powered" == "yes" ]]; then
    bluetoothctl power off && pkill -RTMIN+8 waybar
elif [[ "$bt_powered" == "no" ]]; then
    bluetoothctl power on && pkill -RTMIN+8 waybar
else
    echo "Bluetooth unavailable"
fi
