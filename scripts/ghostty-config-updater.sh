#!/usr/bin/env bash

FONT_SIZE="$1"
CONFIG="$HOME/github/.dotfiles/ghostty/config"

if [[ -z "$FONT_SIZE" ]]; then
  echo "Usage: $0 <font-size>"
  exit 1
fi

sed -i "s/^font-size = .*/font-size = $FONT_SIZE/" "$CONFIG"
