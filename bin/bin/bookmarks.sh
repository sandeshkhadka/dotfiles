#!/bin/zsh
url=$(cat ~/.bookmarks | dmenu -p "url: ")

if [ -z $url ]
then
  exit 
fi

if [ $url = "addnew" ]
then 
  clipboard=$(xclip -o)

  if [ -z "$clipboard" ]
  then
    exit
  fi
  newurl=$(echo "$clipboard" | dmenu -p "New url: ")
  if [ -z "$newurl" ]
  then
    exit
  fi
  echo "$newurl" >> ~/.bookmarks
  exit
fi

if [ $url = "delete" ]
then 
  url=$(tail -n +2 ~/.bookmarks | dmenu -p "delete: ")
  index=$(grep $url ~/.bookmarks -n| cut -d : -f 1)
  sed -i $index'd' ~/.bookmarks
  exit
fi

# microsoft-edge-dev $url >> /dev/null
# brave $url >> /dev/null
firefox $url >> /dev/null

