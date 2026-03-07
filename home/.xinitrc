#!/bin/sh

# Dark mode for GTK/Qt apps
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
export QT_QPA_PLATFORMTHEME=qt5ct

# Wallpaper
feh --bg-fill ~/.walls/94b53061-ecde-4315-a36a-7ef4845f9dcb.JPEG &

# Load X resources (DPI, fonts, etc.)
xrdb -merge ~/.Xresources &

# Display resolution & refresh rate (edit to match your screen)
xrandr --output eDP-1 --mode 2880x1800 --rate 120 &
# Uncomment for external monitor:
# xrandr --output DP-2 --right-of eDP-1 --mode 2560x1440 --rate 100 &

# Keyboard settings
setxkbmap -option compose:ralt &

# Compositor
picom &

# Notifications
dunst &

# Status bar
dwmblocks &

# Screen locker (locks after 2 minutes of inactivity)
xset s 120 120
xss-lock -- slock &

# Input method (Japanese/CJK)
fcitx5 -d &

# Start DWM
exec dwm
