#!/usr/bin/env bash

# Usage:
#   ./minimized_windows.sh           # List minimized windows as JSON
#   ./minimized_windows.sh restore <window_id>  # Restore window

set -e

get_icon() {
  # Map window class/name to icon (Nerd Font/FontAwesome)
  case "$1" in
    firefox|Firefox) echo "" ;;   # Firefox
    Alacritty|alacritty|URxvt|XTerm) echo "" ;; # Terminal
    code|Code|code-oss) echo "" ;; # VSCode
    Thunar|thunar|Nautilus|nautilus) echo "" ;; # File Manager
    spotify|Spotify) echo "" ;; # Spotify
    *) echo "" ;; # Default window icon
  esac
}

if [[ "$1" == "restore" && -n "$2" ]]; then
  # Restore window: unminimize, float, center, focus
  win_id="$2"
  i3-msg "[id=$win_id]" scratchpad show > /dev/null

  exit 0
fi

# if [[ "$1" == "restore" && -n "$2" ]]; then
#   # Restore window: unminimize, float, center, focus
#   win_id="$2"
#   i3-msg "[id=$win_id]" floating enable > /dev/null
#   i3-msg "[id=$win_id]" move position center > /dev/null
#   i3-msg "[id=$win_id]" focus > /dev/null
#   i3-msg "[id=$win_id]" scratchpad show > /dev/null 2>&1 || true
#   exit 0
# fi

# List minimized windows
i3-msg -t get_tree \
  | jq -r '
      .nodes[] | .nodes[] | .nodes[] | select(.name=="__i3_scratch") 
      | .floating_nodes[] | .nodes[] 
      | {
          id: .window,
          name: .name[0:10],
          class: .window_properties.class,
          icon: (
            # Normalize class to lowercase for simpler matching
            ( .window_properties.class // "" | ascii_downcase ) as $cls
            | if    $cls == "firefox"                       then ""
              elif  ($cls == "alacritty" or
                     $cls == "urxvt"     or
                     $cls == "xterm")      then ""
              elif  ($cls == "code"      or
                     $cls == "code-oss")   then ""
              elif  ($cls == "thunar"    or
                     $cls == "nautilus")  then ""
              elif  $cls == "spotify"                      then ""
              else ""
              end
          )
        }
  ' | jq -s .
