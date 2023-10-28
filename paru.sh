#!/bin/sh

# Installing paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

paru -S zoom discord anki
