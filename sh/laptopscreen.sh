#!/bin/bash

TouchscreenDevice='Wacom ISDv4 5002 Finger'
TouchpadDevice='SynPS/2 Synaptics TouchPad'
LaptopScreenName='eDP1'
ExternalScreenName='DP1-1'

WacomDevice="Wacom ISDv4 5002"
WacomStylus="$WacomDevice Pen stylus"
WacomEraser="$WacomDevice Pen eraser"

touchpadEnabled=$(xinput --list-props "$TouchpadDevice" | awk '/Device Enabled/{print $NF}')
screenMatrix=$(xinput --list-props "$TouchscreenDevice" | awk '/Coordinate Transformation Matrix/{print $5$6$7$8$9$10$11$12$NF}')

# Matrix for rotation
# ⎡ 1 0 0 ⎤
# ⎜ 0 1 0 ⎥
# ⎣ 0 0 1 ⎦
normal='1 0 0 0 1 0 0 0 1'
normal_float='1.000000,0.000000,0.000000,0.000000,1.000000,0.000000,0.000000,0.000000,1.000000'

#⎡ -1  0 1 ⎤
#⎜  0 -1 1 ⎥
#⎣  0  0 1 ⎦
inverted='-1 0 1 0 -1 1 0 0 1'
inverted_float='-1.000000,0.000000,1.000000,0.000000,-1.000000,1.000000,0.000000,0.000000,1.000000'

# 90° to the left 
# ⎡ 0 -1 1 ⎤
# ⎜ 1  0 0 ⎥
# ⎣ 0  0 1 ⎦
left='0 -1 1 1 0 0 0 0 1'
left_float='0.000000,-1.000000,1.000000,1.000000,0.000000,0.000000,0.000000,0.000000,1.000000'

# 90° to the right
#⎡  0 1 0 ⎤
#⎜ -1 0 1 ⎥
#⎣  0 0 1 ⎦
right='0 1 0 -1 0 1 0 0 1'

# restrict to 4:3 (instead of 16:9)
#⎡ 4/3 0 -1/6 ⎤
#⎜  0  1   0 ⎥
#⎣  0  0   1 ⎦
presentation='1.3333 0 -0.16666 0 1 0 0 0 1'

xinput --map-to-output "$WacomStylus" eDP1
xinput --map-to-output "$WacomEraser" eDP1
xinput --map-to-output "$TouchscreenDevice" eDP1

case $1 in 
    off)
            echo "Laptop display off"
            xrandr --output "$LaptopScreenName" --off --output "$ExternalScreenName" --auto
            ;;

    on)
            echo "Normal orientation"
            xrandr --output "$LaptopScreenName" --mode 1920x1080 --rotate normal 
            ;;
    external)
            echo "Normal orientation"
            xrandr --output "$LaptopScreenName" --off --output "$ExternalScreenName" --auto --primary
            ;;
    normal)
            echo "Normal orientation"
            xrandr --output "$LaptopScreenName" --mode 1920x1080 --rotate normal 
            ;;
    inverted)
            echo "Upside down orientation"
            xrandr --output "$LaptopScreenName" --mode 1920x1080 --rotate inverted
            ;;
    dual)   
            echo "Dual head setting"
            xrandr --output "$LaptopScreenName" --mode 1920x1080 --rotate inverted --output "$ExternalScreenName" --auto --right-of eDP1
            ;;
    clone)   
            echo "Clone screens"
            xrandr --output "$LaptopScreenName" --mode 2560x1440 --rotate normal --output "$ExternalScreenName" --auto --same-as eDP1
            ;;
    dual-portrait)   
            echo "Dual head setting"
            xrandr --output "$LaptopScreenName" --mode 1920x1080 --rotate right --output "$ExternalScreenName" --auto --right-of eDP1
            ;;
    portrait)   
            echo "Portrait mode"
            xrandr --output "$LaptopScreenName" --mode 1920x1080 --rotate left
            ;;
    presentation)
            echo "Presentation mode (1280x960)"
            ctmatrix=$presentation
            xrandr --output "$LaptopScreenName" --mode 1024x768
            xinput set-prop "$WacomStylus" --type=float 'Coordinate Transformation Matrix' $ctmatrix
            xinput set-prop "$WacomEraser" --type=float 'Coordinate Transformation Matrix' $ctmatrix
            xinput set-prop "$TouchscreenDevice" --type=float 'Coordinate Transformation Matrix' $ctmatrix
            ;;
    *)
            echo 'Unrecognized option'
            exit 1
            ;;
esac

