picom --vsync --backend=glx &
setxkbmap -option compose:ralt
setxkbmap -option ctrl:nocaps
./.fehbg
dwmblocks &
sxhkd &
syndaemon -K -i 0.01 -R -d
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
exec dwm

