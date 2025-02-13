#!/usr/bin/env bash

output_profile=$(autorandr --detected)

if [[ -z "$output_profile" ]]; then
    echo "default"
else
    echo "$output_profile"
fi
