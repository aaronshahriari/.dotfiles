#!/usr/bin/env bash

nmtui="$(command -pv nmtui)" || exit 1
sleep 0.1; exec "$nmtui" "$@"
