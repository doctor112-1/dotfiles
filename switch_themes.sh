#!/bin/bash

theme=$(cat theme)

if [[ "$theme" = dark ]]; then
  stow -D waybar-light
  stow -D hyprpaper-light
  stow -D hyprlock-light
  stow waybar-dark hyprpaper-dark hyprlock-dark
  echo "light" >theme
fi

if [[ "$theme" = light ]]; then
  stow -D waybar-dark
  stow -D hyprpaper-dark
  stow -D hyprlock-dark
  stow waybar-light hyprpaper-light hyprlock-light
  echo "dark" >theme
fi

killall waybar
killall hyprpaper
setsid waybar 1>/dev/null 2>/dev/null &
setsid hyprpaper 1>/dev/null 2>/dev/null &
