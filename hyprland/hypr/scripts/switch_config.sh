#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/hypr/workspaces"
TARGET="$1"

ln -sf "$CONFIG_DIR/$TARGET.conf" "$CONFIG_DIR/current.conf"
hyprctl reload
