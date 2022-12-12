#!/bin/sh
echo "[universe]\nServer = https://universe.artixlinux.org/$arch" >> /etc/pacman.conf
pacman -S artix-archlinux-support
echo "# Arch
[extra]
Include = /etc/pacman.d/mirrorlist-arch

[community]
Include = /etc/pacman.d/mirrorlist-arch

[multilib]
Include = /etc/pacman.d/mirrorlist-arch
" >> /etc/pacman.conf
pacman -Syyu
# Copying doas.conf
cp doas.conf /etc/doas.conf

set -e
# Installing X and X apps
pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxinerama libx11 libxft

# Installing other programs
pacman -S feh mpv sxiv qbittorrent zathura zathura-pdf-mupdf pulseaudio pulseaudio-alsa clang cronie-runit net-tools lxappearance picom playerctl dunst xbindkeys zsh alacritty python-pynvim fzf exa nodejs github-cli ranger thunar xclip maim sxhkd adobe-source-code-pro-fonts

# Installing doas
pacman -S doas
# Symlinking doas to sudo
ln -sf /bin/doas /bin/sudo

# Install theme.sh
curl -Lo /usr/bin/theme.sh 'https://git.io/JM70M' && chmod +x /usr/bin/theme.sh

echo "Run paru.sh as user"
