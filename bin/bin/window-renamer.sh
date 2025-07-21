#!/bin/bash

name=$(dmenu < /dev/null -p "rename:");
tmux rename-window "$name"
