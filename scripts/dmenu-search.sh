#!/usr/bin/env bash

#!/bin/bash

# Prompt the user with dmenu to enter a search query
query=$(echo "" | dmenu  -l 0 -g 1 -p "Search:")

# If a query was entered, open Firefox with the search query
if [ -n "$query" ]; then
    firefox "https://www.google.com/search?q=$query"
fi
