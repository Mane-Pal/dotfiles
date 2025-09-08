#!/bin/bash

# Scratchpad toggle script for Ghostty
# This script toggles the visibility of the scratchpad terminal

SCRATCHPAD_CLASS="scratchpad"

# Check if scratchpad is already running and visible
if hyprctl clients | grep -q "class: $SCRATCHPAD_CLASS"; then
    # If scratchpad exists, toggle its visibility
    if hyprctl clients | grep -A 20 "class: $SCRATCHPAD_CLASS" | grep -q "mapped: 1"; then
        # Hide scratchpad
        hyprctl dispatch movetoworkspace special:scratchpad,class:$SCRATCHPAD_CLASS
    else
        # Show scratchpad
        hyprctl dispatch togglespecialworkspace scratchpad
        hyprctl dispatch focuswindow class:$SCRATCHPAD_CLASS
    fi
else
    # If scratchpad doesn't exist, launch it
    ghostty --class $SCRATCHPAD_CLASS &
fi 