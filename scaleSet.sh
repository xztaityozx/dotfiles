
[ "$1" = "HDMI" ] && gsettings set org.gnome.desktop.interface scaling-factor 2 &&
xrandr --output HDMI-1 --scale 1x1 &&
xrandr --output HDMI-1 --scale 1.2x1.2 &&
xrandr --output HDMI-1 --panning 2304x1440 && exit

gsettings set org.gnome.desktop.interface scaling-factor 2
xrandr --output DSI-1 --scale 1x1
xrandr --output DSI-1 --scale 1.2x1.2
xrandr --output DSI-1 --panning 2304x1536

