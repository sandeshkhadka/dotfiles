#!/bin/bash
dotconfigDirs=(
  'alacritty' 'feh' 'pulseaudio-ctl'
  'nvim' 'ranger' 'sxhkd' 'rofi' 'tmux'
  'bspwm' 'polybar' 'zathura'
)

for config in ${dotconfigDirs[@]}; do
  ln -srf "$config" ~/.config/
done

ln -srf ./bin ~/
ln -f ./.tmux-cht-command ~/
ln -f ./.tmux-cht-languages ~/

ln -f picom.conf ~/.config/picom.conf
ln -f ./zsh/custom_prompt.zsh-theme ~/.oh-my-zsh/themes/custom_prompt.zsh-theme
ln -f starship.toml ~/.config/starship.toml
ln -f .gitconfig ~/.gitconfig
ln -f betterlockscreenrc ~/.config/betterlockscreenrc
