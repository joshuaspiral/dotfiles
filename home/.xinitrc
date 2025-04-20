picom --vsync --backend=glx &
sxhkd &
dwmblocks &
./.fehbg
setxkbmap -option compose:ralt
setxkbmap -option caps:escape 
syndaemon -K -i 0.01 -R -d
export _JAVA_AWT_WM_NONREPARENTING=1
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
fcitx5 -d &
syncthing &
exec dwm
