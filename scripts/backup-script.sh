#!/usr/bin/env bash

CURRENT_DATE_TIME=$(date "+%Y-%m-%d_%H-%M-%S")
LOG_FILE="$HOME/backup_logs/${CURRENT_DATE_TIME}-backup.log"
ICON_PATH="$(nix path-info nixpkgs#material-black-colors)/share/icons/Material-Black-Plum-Numix-FLAT/32"
STARTING="$ICON_PATH/actions/alarm.svg"
COMPLETE="$ICON_PATH/status/stock_check-filled.svg"
ERROR="$ICON_PATH/status/dialog-error.svg"

SOURCE=(
  "$HOME/Videos"
  "$HOME/gimp"
  "$HOME/.zshrc"
  "$HOME/github"
  "$HOME/.ssh"
  "$HOME/backup_logs"
  "$HOME/personal"
  "$HOME/Pictures"
  "$HOME/work"
)

DESTINATION="nas_personal:/volume1/Backups/NixOS-Laptop"

notify-send -t 3000 -u normal -i "$STARTING" "Starting Rsync Backup"
if ! rsync -avuz --delete --log-file="$LOG_FILE" -e ssh "${SOURCE[@]}" "$DESTINATION"; then
    notify-send -t 4000 -u critical -i "$ERROR" "Backup Failed" "rsync backup to NAS failed. Check $LOG_FILE for details."
    exit 1
else
    notify-send -t 3000 -u normal -i "$COMPLETE" "Backup Complete" "rsync backup to NAS completed successfully."
fi
