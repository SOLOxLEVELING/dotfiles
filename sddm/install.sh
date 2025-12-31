#!/bin/bash

echo "📦 Installing Addy's Custom SDDM Theme..."

# 1. Install Dependencies (Arch Linux)
if ! pacman -Qs qt5-graphicaleffects > /dev/null; then
    echo "⬇️ Installing QT5 dependencies..."
    sudo pacman -S --noconfirm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg
fi

# 2. Copy the Theme
echo "🎨 Copying Theme to /usr/share/sddm/themes/..."
sudo cp -r ~/dotfiles/sddm/themes/catppuccin /usr/share/sddm/themes/

# 3. Create the Config Folder & Copy Config
echo "⚙️ Setting up Configuration..."
sudo mkdir -p /etc/sddm.conf.d
sudo cp ~/dotfiles/sddm/config/sddm.conf /etc/sddm.conf.d/theme.conf

# 4. Handle Profile Picture (Optional: Looks for your face.icon)
if [ -f ~/.face.icon ]; then
    echo "👤 Setting up Profile Picture..."
    sudo mkdir -p /usr/share/sddm/faces
    # Copy user's icon to the system faces folder using their username
    sudo cp ~/.face.icon "/usr/share/sddm/faces/$USER.face.icon"
    sudo chmod 644 "/usr/share/sddm/faces/$USER.face.icon"
fi

echo "✅ Done! You can test it with: sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/catppuccin"
