#!/bin/sh
set -e
# Installing X and X apps
pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxinerama libx11 libxft

# Installing other programs
pacman -S feh mpv sxiv qbittorrent zathura zathura-pdf-mupdf pulseaudio pulseaudio-alsa clang cronie-runit net-tools lxappearance picom playerctl dunst xbindkeys zsh alacritty python-pynvim fzf exa nodejs github-cli ranger thunar xclip maim sxhkd adobe-source-code-pro-fonts ttc-iosevka ttf-cascadia-code acpi pamixer yarn noto-fonts-cjk arc-gtk-theme


# Install theme.sh
curl -Lo /usr/bin/theme.sh 'https://git.io/JM70M' && chmod +x /usr/bin/theme.sh

echo "Run paru.sh as user"
