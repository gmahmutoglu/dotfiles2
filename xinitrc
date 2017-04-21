#/bin/bash/
# xmodmap ~/.Xmodmap
xrdb -merge ~/.Xresources
syndaemon -t -k -i 1
while true; do ~/bin/dunst-battery.sh ; sleep 300; done & 
exec i3
