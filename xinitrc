#/bin/bash/
# xmodmap ~/.Xmodmap
xrdb -merge ~/.Xresources
exec i3
syndaemon -t -k -i 1
xrandr --output DP1 --primary
