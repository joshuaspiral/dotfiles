#!/bin/bash

set -e
# Installing X
pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxinerama libx11 libxft 

# Installing other programs
pacman -S feh mpv sxiv qbittorrent zathura zathura-pdf-mupdf pulseaudio pulseaudio-alsa clang cronie-runit net-tools lxappearance picom playerctl dunst xbindkeys zsh alacritty

curl -Lo /usr/bin/theme.sh 'https://git.io/JM70M' && chmod +x /usr/bin/theme.sh

paru -S nerd-fonts-complete zoom opendoas-sudo
