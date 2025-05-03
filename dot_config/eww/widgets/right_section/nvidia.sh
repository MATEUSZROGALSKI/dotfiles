#!/bin/bash
# Outputs Nvidia GPU status with an icon

if ! command -v nvidia-smi &>/dev/null; then
  echo " N/A"
  exit 0
fi

gpu_name=$(nvidia-smi --query-gpu=name --format=csv,noheader,nounits 2>/dev/null | head -n1)
gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)

icon="" # Nerd Font Nvidia icon, fallback to chip if unavailable
if [ -n "$gpu_temp" ]; then
  echo "$icon $gpu_temp°C"
elif [ -n "$gpu_name" ]; then
  echo "$icon $gpu_name"
else
  echo "$icon N/A"
fi