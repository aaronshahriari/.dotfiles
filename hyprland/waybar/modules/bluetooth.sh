#!/usr/bin/env bash

bt_powered=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')

if [[ "$bt_powered" == "yes" ]]; then
    echo "󰂯"
elif [[ "$bt_powered" == "no" ]]; then
    echo ""
else
    echo "Bluetooth unavailable"
fi
