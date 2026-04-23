#!/bin/bash

SAVE_DIR="$HOME/Pictures/screenshots"
API_KEY=$(cat "$HOME/.screenshot_api_key")
UPLOAD_URL="https://cdn.cuzimstupi4.eu/upload.php"

mkdir -p "$SAVE_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
FILE_PATH="$SAVE_DIR/$TIMESTAMP.png"

#spectacle -rbno "$FILE_PATH"

grim -g "$(slurp)" "$FILE_PATH"

if [ -f "$FILE_PATH" ]; then

    RESPONSE=$(curl -s -X POST \
      -F "api_key=$API_KEY" \
      -F "image=@$FILE_PATH" \
      -A "Mozilla/5.0 (X11; Linux x86_64; rv:148.0) Gecko/20100101 Firefox/148.0" \
      "$UPLOAD_URL")

    UPLOADED_URL=$(echo "$RESPONSE" | grep -o '"url":"[^"]*"' | cut -d'"' -f4 | sed 's/\\//g')

    if [ -n "$UPLOADED_URL" ]; then
        echo -n "$UPLOADED_URL" | wl-copy
        notify-send "uploaded and copied"
    else
        echo "Upload failed! Server responded: $RESPONSE"
        wl-copy --type image/png < "$FILE_PATH"
        notify-send "upload failed???"
    fi
else
    echo "capture failed?!?!?!?!?!?!?!?"
fi
