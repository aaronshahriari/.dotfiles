#!/usr/bin/env bash

# Defaults
COMMAND="opencode ."
AI_WINDOW="ai-assistant"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--command)
            COMMAND="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [-c 'your_command']"
            exit 1
            ;;
    esac
done

CURRENT_WINDOW=$(tmux display-message -p '#W')

# If already in ai-assistant window, go back and kill it
if [[ "$CURRENT_WINDOW" == "$AI_WINDOW" ]]; then
    tmux last-window
    tmux kill-window -t "$AI_WINDOW"
    exit 0
fi

# If window exists, switch to it
if tmux list-windows -F '#W' | grep -Fxq "$AI_WINDOW"; then
    tmux select-window -t "$AI_WINDOW"
else
    # Otherwise create the window and run the command
    tmux new-window -n "$AI_WINDOW" "$COMMAND"
fi
