#!/bin/bash

# Get battery percentage
battery=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "N/A")
status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

# Choose icon based on battery level and charging status
if [[ "$status" == "Charging" ]]; then
    icon="󰂄"
else
    if [ "$battery" -ge 90 ]; then
        icon="󰁹"
    elif [ "$battery" -ge 80 ]; then
        icon="󰂂"
    elif [ "$battery" -ge 70 ]; then
        icon="󰂁"
    elif [ "$battery" -ge 60 ]; then
        icon="󰂀"
    elif [ "$battery" -ge 50 ]; then
        icon="󰁿"
    elif [ "$battery" -ge 40 ]; then
        icon="󰁾"
    elif [ "$battery" -ge 30 ]; then
        icon="󰁽"
    elif [ "$battery" -ge 20 ]; then
        icon="󰁼"
    else
        icon="󰁻"
    fi
fi

# Output the result
echo "$icon $battery%"
