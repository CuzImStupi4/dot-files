#!/usr/bin/env bash
# Usage: set-wallpaper.sh <path-to-image>
set -euo pipefail

IMG="${1:?usage: set-wallpaper.sh <path-to-image>}"
if [ ! -f "$IMG" ]; then
    echo "not found: $IMG" >&2
    exit 1
fi
IMG="$(realpath "$IMG")"

pgrep -x awww-daemon >/dev/null || { awww-daemon & disown; sleep 0.4; }
awww img "$IMG" \
    --transition-type grow \
    --transition-pos center \
    --transition-duration 0.8

hellwal -i "$IMG"

killall -SIGUSR2 waybar 2>/dev/null || true

hyprctl reload
