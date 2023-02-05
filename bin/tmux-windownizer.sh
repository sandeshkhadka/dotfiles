#!/bin/sh
#
directory=$(find ~/ ~/playground ~/.config -maxdepth 1 -mindepth 1 -type d | fzf)
window_name=$(basename "$directory" | tr . _)
if [ -z "$window_name" ]
then
      exit
else
      tmux new-window -S -c "$directory" -n "$window_name"
fi
