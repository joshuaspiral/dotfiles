# dotfiles
Personal dotfiles 

# Description
For Artix Linux but everything but the scripts should work for Arch Linux too.

# Usage
```sh
sudo pacman -S artix-archlinux-support
echo -e "\n# Arch\n[extra]\nInclude = /etc/pacman.d/mirrorlist-arch\n\n[multilib]\nInclude = /etc/pacman.d/mirrorlist-arch" | sudo tee -a /etc/pacman.conf
sudo pacman -Syyu
sudo pacman -S stow
make
```
