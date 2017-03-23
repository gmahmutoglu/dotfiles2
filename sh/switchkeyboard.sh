#!/bin/bash

#layout=$(setxkbmap -query | grep 'layout' | cut -d ' ' -f6-)
layout=$(setxkbmap -query | awk '/layout:\s+\w+/{ print $2 }')

if [ "$layout" = "us" ]; then
    setxkbmap tr
    xmodmap ~/.Xmodmaptr
elif [ "$layout" = "tr" ]; then
    setxkbmap us
    xmodmap ~/.Xmodmap
fi

