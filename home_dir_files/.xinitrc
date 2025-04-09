picom --vsync --backend=glx &
sxhkd &
dwmblocks &
./.fehbg
setxkbmap -option compose:ralt
setxkbmap -option ctrl:nocaps
syndaemon -K -i 0.01 -R -d
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx -d &
syncthing &
exec dwm
