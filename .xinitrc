dwmblocks &
picom --vsync --backend=glx &
xbindkeys
setxkbmap -option compose:ralt
doas brightnessctl s 30%
./.fehbg
exec dwm
