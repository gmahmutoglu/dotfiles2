!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/amahmutoglu/.Xauthority

if xrandr | grep "DP1-1 connected"; then
    xrandr --output DP1-1 --auto --primary --output eDP1 --off
else 
    xrandr --output DP1-1 --off --output eDP1 --auto --primary
fi   
#xrandr | grep "DP1-1 connected" &> /dev/null && connect || disconnect
