picom --vsync --backend=glx &
sxhkd &
dwmblocks &
./.fehbg
setxkbmap -option compose:ralt
setxkbmap -option ctrl:nocaps
syndaemon -K -i 0.01 -R -d
<<<<<<< HEAD
export _JAVA_AWT_WM_NONREPARENTING=1
=======
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx -d &
syncthing &
>>>>>>> d31aece (09.04)
exec dwm
