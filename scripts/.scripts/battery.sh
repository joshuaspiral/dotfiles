#!/bin/bash

battery_info=$(acpi -b)
battery_status=$(echo "$battery_info" | awk '{print $3}')
battery_percentage=$(echo "$battery_info" | grep -oE '[0-9]+%')

echo "$battery_status $battery_percentage"
