#!/usr/bin/env bash

#!/bin/bash

# Prompt the user with dmenu to enter a search query
query=$(echo "" | dmenu  -l 0 -g 0 -p "Search:")

# If a query was entered, open Firefox with the search query
if [ -n "$query" ]; then
    firefox "https://duckduckgo.com/?q=$query"
fi
