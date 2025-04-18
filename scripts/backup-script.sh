#!/usr/bin/env bash

CURRENT_DATE_TIME=$(date "+%Y-%m-%d_%H-%M-%S")
LOG_FILE="$HOME/backup_logs/${CURRENT_DATE_TIME}-backup.log"

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

DESTINATION="nas_personal:/volume1/NetBackup/nixos_${USER}_backup"

rsync -avuz --delete --log-file="$LOG_FILE" -e ssh "${SOURCE[@]}" "$DESTINATION"
