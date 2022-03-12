#!/bin/sh

echo "Enter the user you are installing for"
read -e user
home_dir="/home/$user"
echo $home_dir

pacman -S artix-archlinux-support
pacman -Syyu
# Copying doas.conf
cp doas.conf /etc/doas.conf

# Copying pacman.conf
cp pacman.conf /etc/pacman.conf

# Copying bashrc
cp .bashrc $home_dir/

set -e
# Installing X and X apps
pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xsetroot libxinerama libx11 libxft

# Installing other programs
pacman -S feh mpv sxiv qbittorrent zathura zathura-pdf-mupdf pulseaudio pulseaudio-alsa clang cronie-runit net-tools lxappearance picom playerctl dunst xbindkeys zsh alacritty python-pynvim fzf exa nodejs github-cli ranger thunar xclip maim

# Installing doas
pacman -S doas
# Symlinking doas to sudo
ln -sf /bin/doas /bin/sudo

# Install theme.sh
curl -Lo /usr/bin/theme.sh 'https://git.io/JM70M' && chmod +x /usr/bin/theme.sh

# Copying dotfiles
cp -R .config $home_dir/
chown joshua $home_dir/.config
rm -rf $home_dir/.src/
cp -R src $home_dir/.src/
chown joshua $home_dir/.src
cp .zshrc .xinitrc .xbindkeysrc .fehbg $home_dir/
cp -R scripts $home_dir/.scripts/

# Installing dmenu, dwm, dwmblocks
cd $home_dir/.src/dwm
chown joshua $home_dir/.src/dwm
make clean install

cd $home_dir/.src/dwmblocks
chown joshua $home_dir/.src/dwmblocks
make clean install

cd $home_dir/.src/dmenu
chown joshua $home_dir/.src/dmenu
make clean install


echo "Run paru.sh as user"
cd $home_dir
