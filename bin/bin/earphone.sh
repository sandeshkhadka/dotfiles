#!/usr/bin/env bash

tlpConf="/etc/tlp.d/00-audio.conf"
powerSave="/sys/module/snd_hda_intel/parameters/power_save"
powerSaveController="/sys/module/snd_hda_intel/parameters/power_save_controller"

if [ "$1" == "on" ]; then
    sudo echo "Setting earphone mode"
    sudo echo "SOUND_POWER_SAVE_ON_AC=0" > $tlpConf
    sudo echo "SOUND_POWER_SAVE_ON_BAT=0" >> $tlpConf
    sudo echo "SOUND_POWER_SAVE_CONTROLLER=N" >> $tlpConf
    sudo echo "0" > $powerSave
    sudo echo "N" > $powerSaveController
    # ask to reboot now
    read -p "Reboot now? [y/n] " choice
    if [[ $choice =~ ^[Yy]$ ]]; then
        sudo reboot
    fi

elif [ "$1" == "off" ]; then
    sudo echo "Setting speaker mode"
    sudo echo "SOUND_POWER_SAVE_ON_AC=1" > $tlpConf
    sudo echo "SOUND_POWER_SAVE_ON_BAT=1" >> $tlpConf
    sudo echo "SOUND_POWER_SAVE_CONTROLLER=Y" >> $tlpConf
    sudo echo "1" > $powerSave
    sudo echo "Y" > $powerSaveController
    read -p "Reboot now? [y/n] " choice
    if [[ $choice =~ ^[Yy]$ ]]; then
        sudo reboot
    fi
#add status option
elif [ "$1" == "status" ]; then
  echo "Current status:"
  cat $tlpConf
  echo "---------------------"
  echo "power_save: $(cat $powerSave)"
  echo "power_save_controller: $(cat $powerSaveController)"

else
    echo "Usage: earphone.sh [on|off]"
fi
