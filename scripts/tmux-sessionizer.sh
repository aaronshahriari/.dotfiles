#!/usr/bin/env bash

switch_to() {
    if [[ -z $TMUX ]]; then
        tmux attach-session -t "$1"
    else
        tmux switch-client -t "$1"
    fi
}

has_session() {
    tmux list-sessions | grep -q "^$1:"
}

hydrate() {
    if [ -f "$2"/.tmux-sessionizer ]; then
        tmux send-keys -t "$1" "source $2/.tmux-sessionizer" c-M
    elif [ -f "$HOME"/.tmux-sessionizer ]; then
        tmux send-keys -t "$1" "source $HOME/.tmux-sessionizer" c-M
    fi
}

find_dirs() {
    # list TMUX sessions
    if [[ -n "${TMUX}" ]]; then
        current_session=$(tmux display-message -p '#S')
        tmux list-sessions -F "[TMUX] #{session_name}" 2>/dev/null | grep -vFx "[TMUX] $current_session"
    else
        tmux list-sessions -F "[TMUX] #{session_name}" 2>/dev/null
    fi

    # note: TS_SEARCH_PATHS is an array of paths to search for directories
    # if the path ends with :number, it will search for directories with a max depth of number ;)
    # if there is no number, it will search for directories with a max depth defined by TS_MAX_DEPTH or 1 if not set
    for entry in "${TS_SEARCH_PATHS[@]}"; do
        # Check if entry as :number as suffix then adapt the maxdepth parameter
        if [[ "$entry" =~ ^([^:]+):([0-9]+)$ ]]; then
            path="${BASH_REMATCH[1]}"
            depth="${BASH_REMATCH[2]}"
        else
            path="$entry"
        fi

        [[ -d "$path" ]] && find "$path" -mindepth 1 -maxdepth "${depth:-${TS_MAX_DEPTH:-1}}" -path '*/.git' -prune -o -type d -print
    done
}

if [[ $# -eq 1 ]]; then
    selected=$1
else
    if [[ $USER == "aaronshahriari" ]]; then
        selected=$(
        (
            find_dirs
            find ~/nixos-config ~/Downloads ~/.config ~/vault_personal -mindepth 0 -maxdepth 0 -type d
            find ~/github ~/work ~/personal ~/personal/projects/ ~/personal/learning/ -mindepth 1 -maxdepth 1 -type d
        ) | fzf)
    fi
fi

if [[ -z $selected ]]; then
    return 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    hydrate "$selected_name" "$selected"
    exit 0
fi

if ! has_session "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    hydrate "$selected_name" "$selected"
fi

switch_to "$selected_name"
