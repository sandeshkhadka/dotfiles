#!/bin/bash

wallpaper=$(find ~/dotfiles/wallpapers -type f | rofi -dmenu)
feh --bg-fill $wallpaper
