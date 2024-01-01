picom --vsync --backend=glx &
sxhkd &
dwmblocks &
./.fehbg
setxkbmap -option compose:ralt
setxkbmap -option ctrl:nocaps
syndaemon -K -i 0.01 -R -d
export _JAVA_AWT_WM_NONREPARENTING=1
exec dwm
