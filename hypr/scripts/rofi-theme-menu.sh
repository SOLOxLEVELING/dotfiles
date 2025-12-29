#!/bin/bash

# Rofi Theme Menu Launcher
# Displays available themes in a Rofi menu and applies the selected one

THEME_DIR="$HOME/.config/hypr/themes"
SCRIPT_DIR="$HOME/.config/hypr/scripts"
ROFI_THEME="$HOME/.config/rofi/themes/selector.rasi"

# Get list of available themes (exclude helper files)
EXCLUDE_FILES="current.conf|common.conf|base.conf"
THEMES=$(ls -1 "$THEME_DIR"/*.conf 2>/dev/null | grep -vE "$EXCLUDE_FILES" | xargs -n1 basename | sed 's/.conf$//')

if [ -z "$THEMES" ]; then
    notify-send "Theme Switcher" "No themes found in $THEME_DIR" -u critical
    exit 1
fi

# Get currently active theme
CURRENT_THEME=""
if [ -L "$THEME_DIR/current.conf" ]; then
    CURRENT_THEME=$(basename "$(readlink "$THEME_DIR/current.conf")" .conf)
fi

# Build Rofi menu with current theme marked
MENU_ITEMS=""
while IFS= read -r theme; do
    if [ "$theme" = "$CURRENT_THEME" ]; then
        MENU_ITEMS="${MENU_ITEMS}✓ ${theme}\n"
    else
    MENU_ITEMS="${MENU_ITEMS}  ${theme}\n"
    fi
done <<< "$THEMES"

# Show Rofi menu
SELECTED=$(echo -e "$MENU_ITEMS" | rofi -dmenu \
    -theme "$ROFI_THEME" \
    -p "Select Theme" \
    -mesg "Current: ${CURRENT_THEME:-None}" \
    -no-custom \
    -format "s")

# Exit if user cancelled
if [ -z "$SELECTED" ]; then
    exit 0
fi

# Remove the checkmark and leading spaces
SELECTED=$(echo "$SELECTED" | sed 's/^[✓ ]*//')

# Apply the selected theme
"$SCRIPT_DIR/theme-switcher.sh" "$SELECTED"
