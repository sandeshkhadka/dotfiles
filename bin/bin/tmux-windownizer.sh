#!/bin/sh
#
directory=$(find ~/ ~/vaults ~/explore/ ~/projects ~/playground ~/dotfiles ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)
window_name=$(basename "$directory" | tr . _)
if [ -z "$window_name" ]
then
      exit
else
      tmux new-window -S -c "$directory" -n "$window_name"
fi
