picom --vsync --backend=glx &
xbindkeys &
setxkbmap -option compose:ralt
./.fehbg
/usr/bin/emacs --daemon &
dwmblocks &
sxhkd &
syndaemon -K -i 0.01 -R -d
exec dwm
