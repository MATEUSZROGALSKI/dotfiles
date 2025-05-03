#!/bin/bash

# Check if connected to WiFi
wifi_status=$(nmcli -t -f SIGNAL,ACTIVE dev wifi | grep yes | cut -d':' -f1)
ethernet_status=$(nmcli -t -f STATE dev | grep connected | grep ethernet)

if [[ -n "$wifi_status" ]]; then
    # WiFi connected, determine signal strength
    if [[ "$wifi_status" -ge 75 ]]; then
        icon="󰤨"
    elif [[ "$wifi_status" -ge 50 ]]; then
        icon="󰤥"
    elif [[ "$wifi_status" -ge 25 ]]; then
        icon="󰤢"
    else
        icon="󰤟"
    fi
    
    # Get SSID
    ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep yes | cut -d':' -f2)
    echo "$icon $ssid"
elif [[ -n "$ethernet_status" ]]; then
    # Ethernet connected
    echo "󰈀 Ethernet"
else
    # No connection
    echo "󰤮 Offline"
fi
