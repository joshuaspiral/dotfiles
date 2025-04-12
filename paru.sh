#!/bin/sh

# Installing paru
mkdir ~/aux
cd ~/aux
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si

paru -S zoom anki-bin spotify-tui mullvad-vpn-runit mullvad-vpn
