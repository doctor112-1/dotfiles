#!/bin/bash

sudo pacman -S curl wget git vim base-devel

cd ~ && sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

sudo pacman -S sddm stow hyprland hyprlock hyprpaper hypridle xdg-desktop-portal-hyprland hyprshot waybar rofi kitty keychain pipewire wireplumber pipewire-pulse brightnessctl playerctl swaync

yay -S zen-browser-bin

cd ~/dotfiles

stow ./hypridle ./hyprland ./backgrounds ./hyprlock ./hyprmocha ./hyprpaper ./kitty ./nvim ./rofi ./starship ./waybar

echo 'eval "$(starship init bash)"' >>~/.bashrc
echo 'eval $(keychain --eval --quiet)' >>~/.bashrc

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24

curl -fsSL https://get.pnpm.io/install.sh | sh -

sudo systemctl enable sddm.service
