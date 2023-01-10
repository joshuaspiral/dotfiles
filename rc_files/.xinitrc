picom --vsync --backend=glx &
xbindkeys
setxkbmap -option compose:ralt
/* doas brightnessctl s 30% */
./.fehbg
dwmblocks &
sxhkd &
exec dwm
