#!/usr/bin/env bash

FONT_SIZE="$1"
CONFIG="$HOME/github/.dotfiles/i3/config"  # adjust if needed

if [[ -z "$FONT_SIZE" ]]; then
  echo "Usage: $0 <font-size>"
  echo "Example: $0 12"
  exit 1
fi

# Replace the number at the end of the "font pango:" line
sed -i -E "s|^(font pango:.* )([0-9]+)$|\1$FONT_SIZE|" "$CONFIG"
