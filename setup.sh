#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Starting dotfiles setup..."

mkdir -p "$CONFIG_DIR"

link_config() {
    local app_name=$1
    local source_path="$DOTFILES_DIR/config/$app_name"
    local target_path="$CONFIG_DIR/$app_name"

    echo "Processing $app_name..."

    if [ -e "$target_path" ]; then
        if [ -L "$target_path" ]; then
            local current_link=$(readlink -f "$target_path")
            if [ "$current_link" == "$source_path" ]; then
                echo "  -> Already linked correctly."
                return
            fi
        fi
        
        echo "  -> Backing up existing config to $BACKUP_DIR/$app_name"
        mkdir -p "$BACKUP_DIR"
        mv "$target_path" "$BACKUP_DIR/"
    fi

    echo "  -> Symlinking $source_path to $target_path"
    ln -s "$source_path" "$target_path"
}


# Link all directories in config/
for config in "$DOTFILES_DIR/config/"*; do
    app_name=$(basename "$config")
    
    # Skip kde directory - handle it separately
    if [ "$app_name" = "kde" ]; then
        continue
    fi
    
    link_config "$app_name"
done

# Restore KDE configs if they exist
if [ -d "$DOTFILES_DIR/config/kde" ]; then
    echo "Restoring KDE configurations..."
    for kde_config in "$DOTFILES_DIR/config/kde/"*; do
        config_file=$(basename "$kde_config")
        target="$HOME/.config/$config_file"
        
        if [ -f "$target" ]; then
            echo "  → Backing up existing $config_file"
            mkdir -p "$BACKUP_DIR"
            cp "$target" "$BACKUP_DIR/"
        fi
        
        echo "  → Copying $config_file"
        cp "$kde_config" "$target"
    done
fi

# Install yay if not present
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    if ! command -v git &> /dev/null; then
        sudo pacman -S --noconfirm git base-devel
    fi
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
fi

echo ""
echo "Setup complete!"
if [ -d "$BACKUP_DIR" ]; then
    echo "Backups were created in $BACKUP_DIR"
fi

echo ""
echo "To install packages from pkglist.txt, run:"
echo "yay -S --needed --noconfirm - < pkglist.txt"

