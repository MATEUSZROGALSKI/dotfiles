#!/usr/bin/env bash

# Exit immediately if any non-Xorg block is found
if nvidia-smi -q -d PIDS \
     | awk '
         BEGIN { RS="GPU instance ID" }              # split on GPU blocks :contentReference[oaicite:4]{index=4}
         /Process ID/ && $0 !~ /\/usr\/lib\/Xorg/ {    # find blocks with Process ID not Xorg :contentReference[oaicite:5]{index=5}
           exit 1                                     # non-zero exit triggers "ON"
         }
       '; then
  echo "OFF"
else
  echo "ON"
fi

