#!/bin/bash

configs=(
    'nvim' 'sxhkd' 'swhkd' 'bspwm' 'alacritty' 'ranger' 'rofi' 
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
    "swhkd") alacritty -e sudo nvim /etc/swhkd/swhkdrc
    ;;
    "") exit
    ;;
    *) alacritty --working-directory ~/.config/"$file"/ -e nvim .
    ;;
esac
