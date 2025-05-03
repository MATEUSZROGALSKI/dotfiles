#!/bin/bash
# Outputs current volume percentage and mute status with an icon

volume=$(pamixer --get-volume 2>/dev/null)
mute=$(pamixer --get-mute 2>/dev/null)

if [ "$mute" = "true" ]; then
  icon="" # FontAwesome mute
  echo "$icon Mute"
else
  if [ "$volume" -ge 70 ]; then
    icon="" # FontAwesome high
  elif [ "$volume" -ge 30 ]; then
    icon="" # FontAwesome medium
  else
    icon="" # FontAwesome low
  fi
  echo "$icon $volume%"
fi