#!/bin/bash
dotconfigDirs=(
  'alacritty' 'nvim' 'ranger' 'rofi' 'tmux'
  'zathura'
)

for config in ${dotconfigDirs[@]}; do
  ln -srf "$config" ~/.config/
done

ln -srf ./bin ~/
ln -f ./.tmux-cht-command ~/
ln -f ./.tmux-cht-languages ~/

ln -f .gitconfig ~/.gitconfig
