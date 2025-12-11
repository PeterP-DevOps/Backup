#!/bin/bash

SRC="$HOME/"
DEST="/tmp/backup"
CLONE_USER="ppg"
CLONE_IP="192.168.31.212"
EXCLUDE='**/.*/'

LOCAL_LOG_DIR="/tmp/backup_logs"
mkdir -p "$LOCAL_LOG_DIR"
LOG_FILE="$LOCAL_LOG_DIR/rsync.log"

SYSTEM_LOG="/var/log/backup.log"
touch "$SYSTEM_LOG"

rsync -a --delete --checksum --verbose --progress --itemize-changes --exclude="$EXCLUDE" \
    "$SRC" "$CLONE_USER@$CLONE_IP:$DEST" &> "$LOG_FILE"

if [ $? -eq 0 ]; then
    echo "$(date): Backup completed successfully." >> "$SYSTEM_LOG"
else
    echo "$(date): Backup failed. See $LOG_FILE for details." >> "$SYSTEM_LOG"
fi

