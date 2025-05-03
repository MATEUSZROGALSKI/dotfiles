#!/bin/bash
# Outputs current network status with an icon

status=$(nmcli -t -f WIFI g 2>/dev/null)
if [ "$status" = "enabled" ]; then
  wifi=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
  if [ -n "$wifi" ]; then
    icon="" # FontAwesome WiFi
    echo "$icon $wifi"
  else
    icon="" # FontAwesome warning
    echo "$icon Disconnected"
  fi
else
  eth=$(nmcli -t -f DEVICE,STATE dev | grep ':connected' | grep -v '^lo:' | cut -d: -f1)
  if [ -n "$eth" ]; then
    icon="" # FontAwesome ethernet
    echo "$icon $eth"
  else
    icon=""
    echo "$icon Disconnected"
  fi
fi