#!/bin/bash

# Slack status checker for waybar
# Checks if Slack is running and looks for unread message indicators

# Check if Slack is running
if ! pgrep -x "slack" >/dev/null; then
  echo '{"text": "󰒱", "class": "offline", "tooltip": "Slack is not running"}'
  exit 0
fi

# Get Slack window title to check for unread messages
SLACK_TITLE=$(hyprctl clients -j | jq -r '.[] | select(.class=="Slack") | .title' 2>/dev/null)

if [[ -z "$SLACK_TITLE" ]]; then
  echo '{"text": "󰒱", "class": "offline", "tooltip": "Slack window not found"}'
  exit 0
fi

# Check for unread indicators in the title
# Slack usually shows unread count like "• Slack" or "• (2) Slack" or specific indicators
if [[ "$SLACK_TITLE" =~ .*•.* ]] || [[ "$SLACK_TITLE" =~ .*\(.+\).* ]]; then
  echo '{"text": "󰒱", "class": "unread", "tooltip": "You have unread messages in Slack"}'
else
  echo '{"text": "󰒱", "class": "read", "tooltip": "No unread messages"}'
fi

