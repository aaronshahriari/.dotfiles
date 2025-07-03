#!/usr/bin/env bash

SESSION=$(tmux display-message -p '#S')
CURRENT_WINDOW=$(tmux display-message -p '#W')
AI_WINDOW="ai-assistant"

# Check if ai-assistant window exists
window_exists=$(tmux list-windows -F '#W' | grep -Fx "$AI_WINDOW")

# If currently in ai-assistant window, rejoin back to previous
if [[ "$CURRENT_WINDOW" == "$AI_WINDOW" ]]; then
    tmux last-window
    tmux join-pane -s "$SESSION:$AI_WINDOW".0 -h
    tmux kill-window -t "$AI_WINDOW"
    exit 0
fi

# If ai-assistant window exists (i.e. split was moved), bring it back
if [[ -n "$window_exists" ]]; then
    tmux join-pane -s "$SESSION:$AI_WINDOW".0 -h
    tmux kill-window -t "$AI_WINDOW"
    exit 0
fi

# If split not created yet, or already gone, create it now
pane_count=$(tmux list-panes | wc -l)
if [[ "$pane_count" -eq 1 ]]; then
    # Create vertical split (side by side) and run zsh or your AI tool
    tmux split-window -h -c "#{pane_current_path}" -d "opencode ."
    tmux select-pane -L  # Go back to original pane
else
    # Move the most recent (right-side) pane to ai-assistant window
    tmux break-pane -d -n "$AI_WINDOW"
    tmux select-window -t "$CURRENT_WINDOW"
    tmux select-pane -L
fi
