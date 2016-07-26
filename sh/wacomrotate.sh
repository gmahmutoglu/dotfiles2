#!/bin/bash
device="Wacom ISDv4 5002"
stylus="$device Pen stylus"
eraser="$device Pen eraser"
touch="$device Finger"
pad="$device Finger pad"

xsetwacom --set "$stylus" Rotate $1
xsetwacom --set "$eraser" Rotate $1
xsetwacom --set "$touch"  Rotate $1
#xsetwacom --set "$pad"    Rotate $1
