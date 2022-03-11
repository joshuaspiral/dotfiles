#!/bin/sh

# Installing paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

paru -S nerd-fonts-complete zoom discord
