# 🌐 Linux Web Apps (Site Specific Browsers)

This guide documents how to turn any website (Udemy, YouTube Music, ChatGPT) into a "Native" Linux application. These apps run in their own window, have their own icon, and show up in Rofi/Wofi.

---

## Method 1: The "Chromium" Way (Easiest)

_Best for: Chrome, Brave, Chromium users who want auto-updates._

1.  Open the website in your browser (e.g., `https://www.udemy.com`).
2.  Click the **Three Dots Menu (⋮)** in the top right.
3.  Go to **More Tools** (or _Cast, Save and Share_) → **Create Shortcut...**
4.  **Name it:** "Udemy".
5.  **✅ CHECK THE BOX:** "Open as window".
6.  Click **Create**.

**Result:** It creates a `.desktop` file automatically and appears in your launcher.

---

## Method 2: The "Manual" Way (Custom & Clean)

_Best for: Total control over the icon, name, and window class (for Hyprland rules)._

### 1. Get an Icon

Find a transparent PNG logo and save it.

```bash
# Example: Save to your local icons folder
cp ~/Downloads/udemy-logo.png ~/.local/share/icons/udemy.png

2. Create the Launcher

Create a new file in your system applications folder.
Bash

nano ~/.local/share/applications/udemy.desktop

3. Paste Configuration

Copy this block. The secret sauce is the --app flag which hides the address bar.
Ini, TOML

[Desktop Entry]
Version=1.0
Type=Application
Name=Udemy
Comment=Online Courses
# ---------------------------------------------------------
# COMMAND FLAGS:
# --app=URL          : Opens as a standalone app (no URL bar)
# --class=NAME       : Crucial for Hyprland window rules
# --user-data-dir=...: (Optional) Keeps cookies separate from main browser
# ---------------------------------------------------------
Exec=google-chrome-stable --app=[https://www.udemy.com](https://www.udemy.com) --class=udemy
Icon=/home/addy/.local/share/icons/udemy.png
Terminal=false
StartupWMClass=udemy
Categories=Education;Network;WebBrowser;

(Note: If you use Brave, replace google-chrome-stable with brave-browser).
💎 Hyprland Polish (Window Rules)

To make your Web App feel like a real tool, add these rules to your windowrules.conf.

This allows the app to float nicely or have specific transparency settings.
Ini, TOML

# -----------------------------------------------------
# Web App Rules (Targeting class 'udemy')
# -----------------------------------------------------

# Option A: Float and Center (Like a tool)
windowrulev2 = float, class:^(udemy)$
windowrulev2 = size 1100 800, class:^(udemy)$
windowrulev2 = center, class:^(udemy)$

# Option B: Tile but keep opaque (Reading focus)
# windowrulev2 = tile, class:^(udemy)$
windowrulev2 = opaque, class:^(udemy)$
windowrulev2 = noblur, class:^(udemy)$

🗑️ How to Delete

If you messed up or want to remove an app:
Bash

# List your custom apps
ls ~/.local/share/applications/

# Delete one
rm ~/.local/share/applications/udemy.desktop
```
