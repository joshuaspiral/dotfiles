# dotfiles

my dotfiles for artix + kde plasma

## what's in here
- alacritty, fish, nvim (lazy.nvim setup)
- kde settings (shortcuts, themes, etc)
- git config
- zathura

## setup
```sh
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles
./setup.sh
```

the script symlinks everything to `~/.config` and installs yay if you don't have it

## packages
```sh
yay -S --needed - < pkglist.txt
```

## kde configs
save your current kde settings:
```sh
./export_kde_configs.sh
```
