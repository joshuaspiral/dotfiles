picom --vsync --backend=glx &
setxkbmap -option compose:ralt
./.fehbg
dwmblocks &
sxhkd &
syndaemon -K -i 0.01 -R -d
setxkbmap -option ctrl:nocaps
exec dwm

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
