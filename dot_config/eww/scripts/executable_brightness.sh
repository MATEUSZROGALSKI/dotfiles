#!/bin/bash

# Get brightness percentage (using brightnessctl)
max_brightness=$(brightnessctl max)
current_brightness=$(brightnessctl get)
brightness=$((current_brightness * 100 / max_brightness))

# Choose icon based on brightness level
if [ "$brightness" -ge 75 ]; then
    icon="󰃠"
elif [ "$brightness" -ge 50 ]; then
    icon="󰃝"
elif [ "$brightness" -ge 25 ]; then
    icon="󰃟"
else
    icon="󰃞"
fi

# Output the result
echo "$icon $brightness%"
