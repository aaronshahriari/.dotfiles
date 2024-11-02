#!/usr/bin/env bash

# Source any environment settings, like your zsh profile
source ~/.config/zsh/.zsh_profile

# Set all xsecurelock environment variables
export XSECURELOCK_PASSWORD_PROMPT="asterisks"
export XSECURELOCK_AUTH_CURSOR_BLINK=0
export XSECURELOCK_SAVER=~/.local/bin/scripts/xsecurelock-background.sh
export XSECURELOCK_AUTH_BACKGROUND_COLOR="#337690"
export XSECURELOCK_SINGLE_AUTH_WINDOW=0
export XSECURELOCK_AUTH_FOREGROUND_COLOR="#000000"
export XSECURELOCK_SHOW_DATETIME=1
export XSECURELOCK_FONT="CaskaydiaCove Nerd Font"
export XSECURELOCK_DATETIME_FORMAT="%D %I:%M%p"
export XSECURELOCK_SHOW_KEYBOARD_LAYOUT=0
export XSECURELOCK_DEBUG_WINDOW_INFO=1

# Start xsecurelock with the configured environment
exec xsecurelock
