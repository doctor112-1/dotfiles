#!/bin/bash

set -euxo pipefail

# general stuff
sudo pacman -S curl wget git vim base-devel

# install yay
cd ~ && sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

# install a bunch of stuff
sudo pacman -S sddm stow hyprland hyprlock hyprpaper hypridle xdg-desktop-portal-hyprland hyprshot waybar rofi kitty starship keychain pipewire wireplumber pipewire-pulse brightnessctl playerctl swaync wl-clipboard ripgrep btop openssh less wf-recorder go qt6-svg qt6-declarative qt5-quickcontrols2 dns-over-https
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
stow hypridle hyprland backgrounds hyprlock hyprmocha kitty nvim rofi starship

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

# setup .bashrc
echo 'eval "$(starship init bash)"' >>~/.bashrc
echo 'eval $(keychain --eval --quiet)' >>~/.bashrc

# install nvm, node, and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24

# install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# man setup
sudo pacman -S man-db man-pages
sudo mandb

# sddm theme
wget https://github.com/catppuccin/sddm/releases/download/v1.1.2/catppuccin-mocha-flamingo-sddm.zip
unzip catppuccin-mocha-flamingo-sddm.zip
sudo mv -v catppuccin-mocha-flamingo /usr/share/sddm/themes
echo "[Theme]
Current=catppuccin-mocha-flamingo" | sudo tee /etc/sddm.conf

# install pragmasevka
wget https://github.com/shytikov/pragmasevka/releases/download/v1.7.0/Pragmasevka_NF.zip
unzip Pragmasevka_NF.zip
sudo mkdir -p /usr/local/share/fonts/ttf/Pragmasevka
sudo mv *.ttf /usr/local/share/fonts/ttf/Pragmasevka
fc-cache

# enable dns-over-https
sudo systemctl enable doh-client.service

# stop NetworkManager from updating resolv.conf
echo "[main]
dns=none" | sudo tee /etc/NetworkManager/conf.d/90-dns-none.conf
sudo systemctl reload NetworkManager

# update resolv.conf
sudo rm /etc/resolv.conf
echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf

# cleanup
rm -rf ~/neovim ~/yay-bin ~/themes.tar.gz ~/catppuccin-mocha-flamingo-sddm.zip ~/Pragmasevka_NF.zip

# enable sddm
sudo systemctl enable sddm.service
