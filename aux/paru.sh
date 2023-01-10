#!/bin/sh

# Installing vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Installing paru
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

paru -S nerd-fonts-complete zoom discord
