#!/bin/bash
#
cd ~/.guilty/
todo=$(find . -type f | fzf)
tmux neww nvim $todo
