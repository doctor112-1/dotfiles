#!/bin/bash

theme=$(cat theme)

if [[ "$theme" = dark ]]; then
  stow -D waybar-light
  stow -D hyprpaper-light
  stow waybar-dark hyprpaper-dark
  echo "light" >theme
fi

if [[ "$theme" = light ]]; then
  stow -D waybar-dark
  stow -D hyprpaper-dark
  stow waybar-light hyprpaper-light
  echo "dark" >theme
fi

killall waybar
killall hyprpaper
setsid waybar 1>/dev/null 2>/dev/null &
setsid hyprpaper 1>/dev/null 2>/dev/null &
