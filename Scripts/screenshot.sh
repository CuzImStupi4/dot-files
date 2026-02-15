#!/bin/bash

SAVE_DIR="$HOME/Pictures/screenshots"
mkdir -p "$SAVE_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FILE_PATH="$SAVE_DIR/$TIMESTAMP.png"

spectacle -rbno "$FILE_PATH"

if [ -f "$FILE_PATH" ]; then
    wl-copy --type image/png < "$FILE_PATH"
else
    echo "copying screenshot failed"
fi
