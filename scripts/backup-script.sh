#!/usr/bin/env bash

CURRENT_DATE_TIME=$(date "+%Y-%m-%d_%H-%M-%S")
LOG_FILE="$HOME/backup_logs/${CURRENT_DATE_TIME}-backup.log"
# old way
# SOURCE="$HOME/{Videos,gimp,.zshrc,github,.config,.ssh,backup_logs,github,personal,Pictures,work}"
SOURCE=(
  "$HOME/Videos"
  "$HOME/gimp"
  "$HOME/.zshrc"
  "$HOME/github"
  "$HOME/.config"
  "$HOME/.ssh"
  "$HOME/backup_logs"
  "$HOME/personal"
  "$HOME/Pictures"
  "$HOME/work"
)
EXPANDED_SOURCE=$(eval echo "$SOURCE")
DESTINATION="nas:/volume1/NetBackup/nixos_${USER}_backup"
RSYNC_LOCATION=$(which rsync)

# parameterized script
rsync -avuz --rsync-path="$RSYNC_LOCATION" --delete --log-file="$LOG_FILE" -e ssh "$EXPANDED_SOURCE" "$DESTINATION"
