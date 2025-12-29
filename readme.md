# My Arch Linux Dotfiles

![GitHub stars](https://img.shields.io/github/stars/SOLOxLEVELING/dotfiles?style=social)
![GitHub forks](https://img.shields.io/github/forks/SOLOxLEVELING/dotfiles?style=social)

A dynamic, multi-theme, and performance-oriented Hyprland setup for Arch Linux, designed for developers and aesthetics enthusiasts. Switch between your favorite color schemes on the fly.

---

## Gallery

| Catppuccin | Dracula | Gruvbox |
| :---: | :---: | :---: |
| ![Catppuccin](hypr/wallpapers/catppuccin.jpg) | ![Dracula](hypr/wallpapers/dracula.png) | ![Gruvbox](hypr/wallpapers/gruvbox.png) |

| Nord | OLED |
| :---: | :---: |
| ![Nord](hypr/wallpapers/nord.png) | ![OLED](hypr/wallpapers/oled.png) |

---

## Key Features

- **Dynamic Theming**: Switch between multiple themes (`Catppuccin`, `Dracula`, `Gruvbox`, `Nord`, `OLED`) instantly using a Rofi menu. The script updates colors for Hyprland, Waybar, Kitty, Rofi, and Dunst.
- **Modular Architecture**: Configurations are neatly organized into separate files for easy management of `settings`, `keybindings`, `autostart`, and more.
- **Developer-Focused**: Pre-configured for web development with specific workspace assignments and generous terminal scrollback.
- **Floating Aesthetics**: A modern desktop experience with a floating Waybar and notifications.
- **Performance-Tuned**: Optimized for a smooth and responsive experience on Wayland.

---

## Tech Stack

| Component | Tool | Description |
| --- | --- | --- |
| **OS** | Arch Linux | The foundational operating system. |
| **WM** | Hyprland | A dynamic tiling Wayland compositor. |
| **Bar** | Waybar | A highly customizable Wayland bar. |
| **Terminal** | Kitty | A fast, feature-rich, GPU-based terminal. |
| **Shell** | Bash + Starship | A minimal, fast, and infinitely customizable prompt. |
| **Launcher** | Rofi | A versatile application launcher and window switcher. |
| **Notifications** | Dunst | A lightweight and customizable notification daemon. |
| **Lock Screen** | Hyprlock | A sleek and fast screen locker for Wayland. |
| **Idle Daemon** | Hypridle | For screen locking and idle management. |

---

## Installation

### 1. Install Dependencies

```bash
# Core components
sudo pacman -S hyprland waybar dunst rofi-wayland kitty starship hyprpaper

# Utilities
sudo pacman -S grim slurp swappy cliphist wl-clipboard

# Fonts (for icons)
sudo pacman -S ttf-jetbrains-mono-nerd noto-fonts-emoji

# Extras
sudo pacman -S hyprlock hypridle playerctl brightnessctl
```

### 2. Deploy Dotfiles

```bash
# Backup your existing config (optional, but recommended)
mv ~/.config ~/.config.bak

# Clone the repository
git clone https://github.com/SOLOxLEVELING/dotfiles.git ~/.config

# Make scripts executable
chmod +x ~/.config/hypr/scripts/*.sh
chmod +x ~/.config/waybar/launch.sh
```

### 3. Finalize

Reboot or log out and log back in, selecting Hyprland from your display manager.

---

## Usage

### Theme Switching

Press `Super + T` to open the theme selection menu. Choose your desired theme, and the entire desktop environment will update to the new color scheme.

### Keybindings

**Modifier Key**: `SUPER` (Windows Key)

| Key | Action |
| --- | --- |
| `Super + Return` | Open Terminal (Kitty) |
| `Super + Q` | Close Active Window |
| `Super + M` | Exit Hyprland Session |
| `Super + E` | Open File Manager |
| `Super + T` or `Super + K` | **Open Theme Switcher** |
| `Super + Alt + Space`| App Launcher (Rofi) |
| `Super + V` | Clipboard History (Cliphist) |
| `Super + S` | Screenshot (Select Area) |
| `Super + Shift + S` | Screenshot (Full Screen) |
| `Super + L` | Lock Screen |
| `Super + F` | Open Browser |
| `Super + Z` | Open IDE |
| `Super + Shift + B` | Reload Waybar |
| `Super + [0-9]` | Switch to Workspace [0-9] |
| `Super + Shift + [0-9]`| Move Window to Workspace [0-9] |
| `Super + Arrows` | Move Focus |

---

## Directory Structure

```
~/.config/
├── hypr/
│   ├── hyprland.conf       # Main configuration entry point
│   ├── animations.conf     # Animation settings
│   ├── autostart.conf      # Autostart applications
│   ├── keybinds.conf       # Keybindings
│   ├── rules.conf          # Window and workspace rules
│   ├── scripts/            # Theme switching and utility scripts
│   └── themes/             # Theme color definitions
├── waybar/
│   ├── config.jsonc        # Bar layout and modules
│   ├── style.css           # Bar styling
│   └── themes/             # Theme-specific CSS
├── kitty/
│   ├── kitty.conf          # Terminal configuration
│   └── themes/             # Terminal color themes
├── rofi/
│   ├── config.rasi         # Rofi configuration
│   └── themes/             # Rofi color themes
└── dunst/
    └── dunstrc             # Dunst configuration
```

---

## Credits

- The Hyprland community for their work on the compositor.
- The creators of the color schemes: Catppuccin, Dracula, Gruvbox, and Nord.
- Adnan (Addy) - Creator