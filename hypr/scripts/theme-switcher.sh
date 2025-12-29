#!/bin/bash

# Hyprland Theme Switcher - FAST VERSION
# Switches: Hyprland, Wallpaper, Rofi, Waybar, Kitty, Starship, Wlogout, Swaync
# Usage: theme-switcher.sh <theme-name>

# Configuration paths
THEME_DIR="$HOME/.config/hypr/themes"
WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
CURRENT_THEME_LINK="$THEME_DIR/current.conf"
THEME_STATE_FILE="$HOME/.config/hypr/.current-theme"
EXCLUDE_FILES="current.conf|common.conf|base.conf"

# Check if theme name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <theme-name>"
    echo "Available themes:"
    ls -1 "$THEME_DIR"/*.conf 2>/dev/null | grep -vE "$EXCLUDE_FILES" | xargs -n1 basename | sed 's/.conf$//' || echo "No themes found"
    exit 1
fi

THEME_NAME="$1"
THEME_FILE="$THEME_DIR/${THEME_NAME}.conf"

# Validate theme exists
if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme '$THEME_NAME' not found"
    exit 1
fi

echo "🎨 Switching to: $THEME_NAME"

# ═══════════════════════════════════════════
# FAST PARALLEL EXECUTION
# ═══════════════════════════════════════════

# 1. Hyprland theme
ln -sf "$THEME_FILE" "$CURRENT_THEME_LINK"

# 2. Rofi theme
ROFI_THEME="$HOME/.config/rofi/themes/${THEME_NAME}.rasi"
[ -f "$ROFI_THEME" ] && cp "$ROFI_THEME" "$HOME/.config/rofi/themes/current.rasi"

# 3. Waybar theme
WAYBAR_THEME="$HOME/.config/waybar/themes/${THEME_NAME}.css"
if [ -f "$WAYBAR_THEME" ]; then
    ln -sf "$WAYBAR_THEME" "$HOME/.config/waybar/theme.css"
    (killall -q waybar; waybar &) &>/dev/null &
fi

# 4. Kitty theme
KITTY_THEME="$HOME/.config/kitty/themes/${THEME_NAME}.conf"
if [ -f "$KITTY_THEME" ]; then
    ln -sf "$KITTY_THEME" "$HOME/.config/kitty/theme.conf"
    kitty @ set-colors --all "$KITTY_THEME" 2>/dev/null &
fi

# 5. Starship theme
STARSHIP_THEME="$HOME/.config/starship/themes/${THEME_NAME}.toml"
[ -f "$STARSHIP_THEME" ] && ln -sf "$STARSHIP_THEME" "$HOME/.config/starship.toml"

# 6. Wlogout theme
WLOGOUT_THEME="$HOME/.config/wlogout/themes/${THEME_NAME}.css"
if [ -f "$WLOGOUT_THEME" ]; then
    ln -sf "$WLOGOUT_THEME" "$HOME/.config/wlogout/style.css"
fi

# 7. Swaync (Notification Center) - Update theme and reload
SWAYNC_THEME="$HOME/.config/swaync/themes/${THEME_NAME}.css"
if [ -f "$SWAYNC_THEME" ]; then
    ln -sf "$SWAYNC_THEME" "$HOME/.config/swaync/themes/current.css"
    swaync-client -rs &>/dev/null &
    swaync-client -R &>/dev/null &
fi

# 8. Wallpaper (smooth wipe transition)
WALLPAPER="$WALLPAPER_DIR/${THEME_NAME}.jpg"
[ ! -f "$WALLPAPER" ] && WALLPAPER="$WALLPAPER_DIR/${THEME_NAME}.png"

if [ -f "$WALLPAPER" ]; then
    pgrep -x swww-daemon > /dev/null || swww-daemon &
    swww img "$WALLPAPER" \
        --transition-type wipe \
        --transition-angle 30 \
        --transition-duration 1 \
        --transition-fps 60 &
fi

# 9. Reload Hyprland
hyprctl reload &>/dev/null &

# 10. Save theme state
echo "$THEME_NAME" > "$THEME_STATE_FILE"

echo "✓ Done!"

# Notification
notify-send "Theme" "$THEME_NAME" -t 2000 2>/dev/null &
