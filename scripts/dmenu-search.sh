#!/usr/bin/env bash

browser="google-chrome-stable --new-window"
engine="https://duckduckgo.com/?q=%s"
bookmarks_json="$HOME/.config/google-chrome/Default/Bookmarks"

# Use a recursive jq query to find all bookmarks, including those in nested folders
mapfile -t bookmarks < <(jq -r '
  .. | objects | select(.type? == "url") | "\(.name) \t\(.url)"
' "$bookmarks_json")

names=("${bookmarks[@]%%$'\t'*}")
selected_input=$(printf "%s\n" "${names[@]}" | dmenu -i -g 1 -p "Go:")

if [[ -z "$selected_input" ]]; then
  exit 0
fi

url_found=false
for entry in "${bookmarks[@]}"; do
  name="${entry%%$'\t'*}"
  url="${entry#*$'\t'}"
  if [[ "$name" == "$selected_input" ]]; then
    $browser "$url"
    url_found=true
    break
  fi
done

if [[ "$url_found" == false ]]; then
  query=$(printf "$engine" "$selected_input")
  $browser "$query"
fi
