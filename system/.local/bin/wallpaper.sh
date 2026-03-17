#!/bin/sh
WALL="${1:-$HOME/.walls/current.jpg}"
swww query || swww init
swww img "$WALL" \
    --transition-type crossfade \
    --transition-duration 0.3 \
    --transition-fps 120
