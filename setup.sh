#!/bin/bash
dotconfigDirs=(
  'alacritty' 'feh' 'pulseaudio-ctl'
  'nvim' 'ranger' 'sxhkd' 'rofi' 'tmux'
  'bspwm' 'polybar' 'zathura'
)

for config in ${dotconfigDirs[@]}; do
  ln -srf "$config" ~/.config/"$config"
done

ln -srf ./bin ~/bin

ln -f picom.conf ~/.config/picom.conf
ln -f starship.toml ~/.config/starship.toml
ln -f .gitconfig ~/.gitconfig
ln -f betterlockscreenrc ~/.config/betterlockscreenrc
