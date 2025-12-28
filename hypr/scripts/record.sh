#!/bin/bash

if pgrep -x wf-recorder >/dev/null; then
    notify-send "Recording" "Already recording!"
    exit 1
fi

mkdir -p ~/Videos/Recordings
FILENAME=~/Videos/Recordings/recording-$(date +%Y%m%d-%H%M%S).mp4

case "$1" in
monitor)
    GEOMETRY=$(slurp -o)
    ;;
region)
    GEOMETRY=$(slurp)
    ;;
active)
    GEOMETRY=""
    ;;
*)
    GEOMETRY=$(slurp -o)
    ;;
esac

if [ -z "$GEOMETRY" ] && [ "$1" != "active" ]; then
    notify-send "Recording Cancelled" "No selection made"
    exit 1
fi

notify-send "Recording Started" "Press SUPER+SHIFT+CTRL+R to stop"

if [ -n "$GEOMETRY" ]; then
    wf-recorder -g "$GEOMETRY" -f "$FILENAME"
else
    wf-recorder -f "$FILENAME"
fi

notify-send "Recording Stopped" "Saved to $FILENAME"
