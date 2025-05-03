#!/bin/bash
# Outputs current keyboard layout with an icon

layout=$(setxkbmap -query | awk '/layout:/ {print $2}' 2>/dev/null)
if [ -z "$layout" ]; then
  layout=$(localectl status 2>/dev/null | awk -F: '/X11 Layout/ {gsub(/^[ \t]+/, "", $2); print $2}')
fi

case "$layout" in
  pl) label="PL" ;;
  us) label="EN" ;;
  de) label="DE" ;;
  fr) label="FR" ;;
  *) label="${layout^^}" ;;
esac

icon="" # FontAwesome keyboard
echo "$icon $label"