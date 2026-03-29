#!/bin/bash
TARGET="$HOME"
STOW_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if ! command -v stow &> /dev/null || ! command -v git &> /dev/null; then
    echo "Error: git and stow must be installed."
    exit 1
fi

if [[ "$1" == "--install-packages" ]]; then
    echo "Updating system and databases..."
    sudo pacman -Syu --noconfirm

    NATIVE_PKGS=$(comm -12 <(pacman -Slq | sort) <(sort "$STOW_DIR/pkglist.txt"))
    AUR_PKGS=$(comm -13 <(pacman -Slq | sort) <(sort "$STOW_DIR/pkglist.txt"))

    echo "Installing native packages..."
    sudo pacman -S --needed --noconfirm $NATIVE_PKGS

    if ! command -v yay &> /dev/null; then
        echo "Installing yay..."
        rm -rf /tmp/yay
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay && makepkg -si --noconfirm
        rm -rf /tmp/yay
    fi
    echo "Installing AUR packages..."
    yay -S --needed --noconfirm $AUR_PKGS

    echo "Enabling core system services..."
    sudo systemctl enable ly@tty2.service
    sudo systemctl disable getty@tty2.service
    sudo systemctl enable tlp.service throttled.service tailscaled.service
    sudo systemctl enable --now bluetooth.service

    echo "Installing pacman hook directory..."
    sudo mkdir -p /etc/pacman.d/hooks
fi

echo "Stowing system files (requires root)..."
sudo stow --adopt --target="/" --dir="$STOW_DIR" system
sudo git checkout -- "$STOW_DIR/system"

echo "Stowing user packages..."
cd "$STOW_DIR" || exit
for d in */; do
    pkg="${d%/}"
    if [[ "$pkg" != "system" && "$pkg" != "scripts" && "$pkg" != ".git" ]]; then
        stow --adopt --target="$TARGET" --dir="$STOW_DIR" "$pkg"

        # Only checkout if the path is tracked by git
        if git ls-files --error-unmatch "$STOW_DIR/$pkg" &>/dev/null; then
            git checkout -- "$STOW_DIR/$pkg"
        fi

        echo "Stowed $pkg"
    fi
done
