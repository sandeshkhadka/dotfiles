if [[ -z $DISPLAY ]] && (( $EUID != 0 )) && [[ $(tty) = /dev/tty1 ]]; then
    startx 1>~/.log/xsession-errors 2>&1 &
fi

