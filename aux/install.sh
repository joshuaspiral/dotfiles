#!/bin/sh
set -e
# Installing X and X apps
pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxinerama libx11 libxft

# Installing other programs
pacman -S neovim emacs feh mpv sxiv qbittorrent zathura zathura-pdf-mupdf pulseaudio pulseaudio-alsa net-tools lxappearance picom playerctl dunst xbindkeys zsh fish alacritty fzf exa bat nodejs github-cli ranger thunar xclip maim sxhkd wget zoxide starship acpi pamixer yarn

# Installing fonts and themes
pacman -S ttc-iosevka ttc-iosevka-ss14 ttc-iosevka-ss04 ttf-fira-sans ttf-joypixels noto-fonts-cjk arc-gtk-theme

echo "Run paru.sh as user"
