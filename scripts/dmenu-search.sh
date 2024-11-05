#!/usr/bin/env bash

choice=$(echo -e "New Window\nNew Tab" | dmenu -m 0 -l 2 -p "Open in:")

if [ -n "$choice" ]; then
    query=$(echo "" | dmenu -m 0 -l 0 -g 0 -p "Search:")
    if [ -n "$query" ]; then
        case "$choice" in
            "New Window")
                google-chrome-stable --new-window "https://duckduckgo.com/?q=$query"
                ;;
            "New Tab")
                google-chrome-stable --new-tab "https://duckduckgo.com/?q=$query"
                ;;
            *)
                echo "Invalid choice, exiting." >&2
                exit 1
                ;;
        esac
    fi
else
    echo "No choice made, exiting." >&2
    exit 1
fi
