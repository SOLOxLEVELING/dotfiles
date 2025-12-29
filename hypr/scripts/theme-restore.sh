#!/bin/bash

# Theme Restore Script - Run on login to restore last theme
# Add to ~/.config/hypr/autostart.conf:
# exec-once = ~/.config/hypr/scripts/theme-restore.sh

THEME_STATE_FILE="$HOME/.config/hypr/.current-theme"
THEME_SCRIPT="$HOME/.config/hypr/scripts/theme-switcher.sh"

# Check if saved theme exists
if [ -f "$THEME_STATE_FILE" ]; then
    SAVED_THEME=$(cat "$THEME_STATE_FILE")
    if [ -n "$SAVED_THEME" ]; then
        echo "Restoring theme: $SAVED_THEME"
        # Wait a moment for system to initialize
        sleep 2
        "$THEME_SCRIPT" "$SAVED_THEME"
    fi
else
    echo "No saved theme found, using default"
fi
