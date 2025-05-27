#!/bin/bash

echo "Installing dependencies..."
sudo apt install hyprland nautilus zsh xdg-desktop-portal-hyprland swaybg waybar wofi kitty blueman-applet fzf batcat mdcat -y

sudo snap install opera

curl -sS https://starship.rs/install.sh | sh