#!/bin/sh

# Get the ID of the current default output device
DEVICE=$(pamixer --get-default-sink | awk 'NR==2 {print $1}')

# Get volume and mute status for that specific device
vol=$(pamixer --sink "$DEVICE" --get-volume)
mute=$(pamixer --sink "$DEVICE" --get-mute)

# Check if muted
if [ "$mute" = "true" ]; then
    echo "󰝟 Muted"
else
    # Show volume percentage
    echo "󰕾 $vol%"
fi
