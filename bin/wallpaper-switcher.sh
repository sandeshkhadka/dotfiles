#!/bin/bash

wallpaper=$(find ~/.config/feh/wallpapers -type f | rofi -dmenu)
feh --bg-fill $wallpaper
