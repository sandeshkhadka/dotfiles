#!/bin/bash

configs=(
    'nvim' 'sxhkd' 'bspwm' 'alacritty' 'ranger' 'rofi' 
    'polybar' 'tmux' 'zathura' 'picom' 'starship'
)

file=$(for config in ${configs[@]}
do
    echo "$config"
done | rofi -dmenu)
case "$file" in
    "picom") alacritty -e nvim ~/.config/picom.conf
    ;;
    "starship") alacritty -e nvim ~/.config/starship.toml
    ;;
    "") exit
    ;;
    *) alacritty -e nvim ~/.config/"$file"/
    ;;
esac
