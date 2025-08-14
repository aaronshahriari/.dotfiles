#!/usr/bin/env bash
URL="$1"

# Remove query params before extension check
BASE_URL="${URL%%\?*}"

if [[ "$BASE_URL" =~ \.(png|jpg|jpeg|gif|webp)$ ]]; then
    echo "[smart-open] Image detected → opening in feh..."
    feh --scale-down --geometry 80%x80% "$URL"
else
    echo "[smart-open] Not an image → opening in w3m..."
    brave "$URL"
fi
