  #!/bin/bash
TARGET="$HOME"
STOW_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ensure Stow and Git are installed
if ! command -v stow &> /dev/null || ! command -v git &> /dev/null; then
    echo "Error: git and stow must be installed."
    exit 1
fi

if [[ "$1" == "--install-packages" ]]; then
    if ! command -v yay &> /dev/null; then
        echo "Installing yay..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay && makepkg -si --noconfirm
        rm -rf /tmp/yay
    fi
    yay -S --needed - < "$STOW_DIR/pkglist.txt"

    echo "Enabling core system services..."
    sudo systemctl enable ly.service
    sudo systemctl enable tlp.service
    echo "Enabling keyring services..."
    sudo systemctl enable --now bluetooth.service
fi

# Packages to stow
PACKAGES="sway waybar nvim fish kitty tofi dunst system yazi gtk calcurse zathura"

echo "Stowing packages..."
for pkg in $PACKAGES; do
    if [ -d "$STOW_DIR/$pkg" ]; then
        stow --restow --target="$TARGET" --dir="$STOW_DIR" "$pkg"
        echo "Stowed $pkg"
    else
        echo "Warning: Directory $pkg not found."
    fi
done 
