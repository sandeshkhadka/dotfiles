#!/bin/bash
dotconfigsDir=(
  'alacritty' 'feh' 'pulseaudio-ctl'
  'nvim' 'ranger' 'sxhkd' 'rofi' 'tmux'
  'bspwm' 'polybar' 'zathura'
)

for config in ${dotconfigsDir[@]}; do
  ln -s "$config" ~/.config/"$config"
done

ln ./zsh/zsh_profile ~/.zsh_profile
ln -s ./bin ~/bin
ln ./starship.toml ~/.config/starship.toml
ln ./picom.conf ~/.config/picom.conf
