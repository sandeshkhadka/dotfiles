#!/bin/sh

VIM="nvim"
export EDITOR=$VIM
export GIT_EDITOR=$VIM
alias vim=nvim
#alias ls=eza
alias clipit="xclip -sel clip"

bindkey -s ^f "tmux-sessionizer.sh\n"

# source /usr/share/autojump/autojump.zsh
