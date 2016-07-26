#!/bin/bash
if [ $1 = "external" ]; then
  rm .Xresources;
  rm .i3;
  rm .config/dunst/dunstrc;
  ln -s ~/dotfiles/externalMonitor/Xresources .Xresources;
  ln -s ~/dotfiles/externalMonitor/i3 .i3
  ln -s ~/dotfiles/externalMonitor/dunstrc ~/.config/dunst/dunstrc
elif [ $1 = "laptop" ]; then
  rm .Xresources;
  rm .i3;
  rm .config/dunst/dunstrc;
  ln -s ~/dotfiles/Xresources .Xresources;
  ln -s ~/dotfiles/i3 .i3
  ln -s ~/dotfiles/dunstrc ~/.config/dunst/dunstrc
else
    echo "unknown monitor option"
fi
