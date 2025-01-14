#!/usr/bin/env bash

CURENT_DATE_TIME=$(date "+%Y-%m-%d_%H-%M-%S")
LOG_FILE="$HOME/backup_logs/${CURENT_DATE_TIME}-backup.log"
SOURCE="$HOME/{.config,.ssh,backup_logs,github,nixos-config,personal,Pictures,work}"
EXPANDED_SOURCE=$(eval echo "$SOURCE")
DESTINATION="aaronshahriari@192.168.5.48:/volume1/NetBackup/${USER}_backup"

# full script
# rsync -avuz --delete --log-file=$HOME/backup_logs/${CURENT_DATE_TIME}-backup.log -e ssh ~/personal/streams/ aaronshahriari@192.168.5.48:/volume1/NetBackup/{$USER}_backup

# parameterized script
rsync -avuz --delete --log-file=$LOG_FILE -e ssh $EXPANDED_SOURCE $DESTINATION
