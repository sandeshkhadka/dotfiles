#!/bin/bash
dotconfigDirs=(
  'alacritty' 'pulseaudio-ctl'
  'nvim' 'ranger' 'sxhkd' 'rofi' 'tmux'
  'bspwm' 'polybar' 'zathura' 'kitty'
)

for config in ${dotconfigDirs[@]}; do
  ln -srf "$config" ~/.config/
done

ln -srf ./bin ~/
ln -f ./.tmux-cht-command ~/
ln -f ./.tmux-cht-languages ~/

ln -f picom.conf ~/.config/picom.conf
ln -f ./zsh/custom_prompt.zsh-theme ~/.oh-my-zsh/themes/custom_prompt.zsh-theme
ln -f ./zsh/common.profile.sh ~/.common.profile.sh
ln -f ./zsh/zshenv ~/.zshenv
ln -f .gitconfig ~/.gitconfig
ln -f betterlockscreenrc ~/.config/betterlockscreenrc
