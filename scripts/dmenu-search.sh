#!/usr/bin/env bash

# prompt the user with dmenu to enter a search query
case "$(printf "win\ntab\n" | dmenu -m 0 -i -l 10 -p "Window Type:")" in
    "win")
        query=$(echo "" | dmenu -m 0 -l 0 -g 0 -p "Search:")
        if [ -n "$query" ]; then
            firefox --search "$query"
        fi
        ;;
    "tab")
        query=$(echo "" | dmenu -m 0 -l 0 -g 0 -p "Search:")
        if [ -n "$query" ]; then
            firefox --new-tab "https://duckduckgo.com/?q=$query"
        fi
        ;;
esac
