#!/usr/bin/env bash

# prompt the user with dmenu to enter a search query
query=$(echo "" | dmenu -m 0 -l 0 -g 0 -p "Search:")

# if a query was entered, open firefox with the search query
if [ -n "$query" ]; then
    # firefox "https://duckduckgo.com/?q=$query"
    firefox --search "$query"
fi
