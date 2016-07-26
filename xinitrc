#/bin/bash/
# xmodmap ~/.Xmodmap
xrdb -merge ~/.Xresources
exec i3
syndaemon -t -k -i 1
while :; do ~/bin/dunst-battery.sh ; sleep 300; done & 
