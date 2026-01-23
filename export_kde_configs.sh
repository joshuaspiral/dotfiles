#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
KDE_CONFIG_DIR="$DOTFILES_DIR/config/kde"

echo "Exporting KDE configurations to dotfiles..."

mkdir -p "$KDE_CONFIG_DIR"

KDE_CONFIGS=(
    "kglobalshortcutsrc"
    "khotkeysrc"
    "plasma-org.kde.plasma.desktop-appletsrc"
    "plasmashellrc"
    "kwinrc"
    "kwinrulesrc"
    "kdeglobals"

    "plasmarc"
    "kcminputrc"
    
    # Dolphin file manager
    "dolphinrc"
    
    # Konsole (if you use it)
    "konsolerc"
    
    # Task switcher
    "krunnerrc"
    
    # Notifications
    "plasmanotifyrc"
)

# Copy each config file if it exists
for config in "${KDE_CONFIGS[@]}"; do
    if [ -f "$HOME/.config/$config" ]; then
        echo "Copying $config"
        cp "$HOME/.config/$config" "$KDE_CONFIG_DIR/"
    else
        echo "Skipping $config (not found)"
    fi
done

echo ""
echo "KDE configs exported to $KDE_CONFIG_DIR"
echo "Review and commit these files to your dotfiles repo."
