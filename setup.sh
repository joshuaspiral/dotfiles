#!/bin/bash

# run from home
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
    link_config "$app_name"
done

# Link home/ dotfiles directly into ~/ (e.g. .xinitrc, .Xresources)
if [ -d "$DOTFILES_DIR/home" ]; then
    echo "Setting up home directory dotfiles..."
    for file in "$DOTFILES_DIR/home/"* "$DOTFILES_DIR/home/".* ; do
        [ -e "$file" ] || continue
        filename=$(basename "$file")
        [ "$filename" = "." ] || [ "$filename" = ".." ] && continue
        target="$HOME/$filename"
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            echo "  -> Backing up $target"
            mkdir -p "$BACKUP_DIR"
            mv "$target" "$BACKUP_DIR/"
        fi
        if [ -L "$target" ] && [ "$(readlink -f "$target")" = "$file" ]; then
            echo "  -> $filename already linked."
        else
            echo "  -> Symlinking $filename"
            ln -sf "$file" "$target"
        fi
    done
fi

# Link scripts/ to ~/.scripts
if [ -d "$DOTFILES_DIR/scripts" ]; then
    echo "Setting up scripts..."
    target="$HOME/.scripts"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    fi
    ln -sf "$DOTFILES_DIR/scripts" "$target"
fi

link_system_config() {
    local rel_path=$1
    local source_path="$DOTFILES_DIR/etc/$rel_path"
    local target_path="/etc/$rel_path"

    echo "Processing system config $rel_path..."

    if [ -L "$target_path" ]; then
        local current_link=$(readlink -f "$target_path")
        if [ "$current_link" == "$source_path" ]; then
            echo "  -> Already linked correctly."
            return
        fi
    fi

    echo "  -> Symlinking $source_path to $target_path (requires sudo)"

    sudo mkdir -p "$(dirname "$target_path")"

    if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
        echo "  -> Backing up existing $target_path to $BACKUP_DIR/"
        sudo mkdir -p "$BACKUP_DIR"
        sudo mv "$target_path" "$BACKUP_DIR/"
    fi

    sudo ln -sf "$source_path" "$target_path"
}

# Recursively link all files under etc/ (handles nested dirs like systemd/system/)
if [ -d "$DOTFILES_DIR/etc" ]; then
    echo "Setting up system configurations..."
    while IFS= read -r -d '' file; do
        rel_path="${file#$DOTFILES_DIR/etc/}"
        link_system_config "$rel_path"
    done < <(find "$DOTFILES_DIR/etc" -type f -print0)
fi

# Enable powertop service
echo "Enabling powertop auto-tune service..."
sudo systemctl enable powertop.service

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
echo "Next steps:"
echo "  1. Install packages:   yay -S --needed - < pkglist.txt"
echo "  2. Build dwm:          cd ~/dwm && sudo make clean install"
echo "  3. Build dwmblocks:    cd ~/dwmblocks && sudo make clean install"
echo "  4. Enable dunst:       systemctl --user enable --now dunst"
echo "  5. Start X:            startx (add 'exec dwm' to ~/.xinitrc)"
