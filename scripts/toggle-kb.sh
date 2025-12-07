#!/usr/bin/env bash

# Switch to next keyboard layout for all devices
niri msg action switch-layout next

# Get current layout from the main keyboard
current_layout=$(niri msg -j keyboard-layouts | jq -r '.names[.current_idx]')

# Send notification
notify-send -a "Keyboard Layout" -t 800 "Switched to: $current_layout"
