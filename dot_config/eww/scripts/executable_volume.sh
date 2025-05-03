#!/bin/bash

# Get volume percentage
volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

# Choose icon based on volume level and mute status
if [[ "$mute" == "true" ]]; then
    icon="󰝟"
else
    if [ "$volume" -ge 70 ]; then
        icon="󰕾"
    elif [ "$volume" -ge 30 ]; then
        icon="󰖀"
    elif [ "$volume" -ge 1 ]; then
        icon="󰕿"
    else
        icon="󰝟"
    fi
fi

# Output the result
echo "$icon $volume%"
