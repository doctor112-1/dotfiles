#!/bin/bash

set -euxo pipefail

# general stuff
sudo pacman -S curl wget git vim base-devel

# install yay
cd ~ && sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

# install a bunch of stuff
sudo pacman -S sddm stow hyprland hyprlock hyprpaper hypridle xdg-desktop-portal-hyprland hyprshot waybar rofi kitty keychain pipewire wireplumber pipewire-pulse brightnessctl playerctl swaync wl-clipboard ripgrep btop
yay -S zen-browser-bin

# make folder to store screenshots
mkdir ~/screenshots

# make folder to store videos
mkdir ~/Videos

# btop
cd ~
wget https://github.com/catppuccin/btop/releases/download/1.0.0/themes.tar.gz
tar xf ~/themes.tar.gz
mkdir ~/.config/btop
mv ~/themes ~/.config/btop

# fonts
sudo pacman -S noto-fonts ttf-jetbrains-mono-nerd ttf-jetbrains-mono

# build and install neovim
cd ~
sudo pacman -S base-devel cmake unzip ninja curl
git clone --depth 1 https://github.com/neovim/neovim
cd ~/neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# stow dotfiles
cd ~/dotfiles
stow hypridle hyprland backgrounds hyprlock hyprmocha hyprpaper kitty nvim rofi starship waybar openssh

# setup .bashrc
echo 'eval "$(starship init bash)"' >>~/.bashrc
echo 'eval $(keychain --eval --quiet)' >>~/.bashrc

# install nvm, node, and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24

# install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# cleanup
rm -rf ~/neovim ~/yay ~/themes.tar.gz

# enable sddm
sudo systemctl enable sddm.service
