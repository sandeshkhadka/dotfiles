#!/bin/bash
voltage=$(cat /sys/class/power_supply/BAT1/voltage_now)
current=$(cat /sys/class/power_supply/BAT1/current_now)

# Convert voltage to volts and current to amperes
voltage_in_volts=$(echo "scale=2; $voltage / 1000000" | bc)
current_in_amperes=$(echo "scale=2; $current / 1000000" | bc)

# Calculate power in watts (P = V * I)
power_in_watts=$(echo "scale=2; $voltage_in_volts * $current_in_amperes" | bc)

if [ -f /sys/class/power_supply/BAT*/voltage_now ]; then
  powerDraw="󰠰 $power_in_watts W"
fi


cat << EOF
{ "text":"$powerDraw", "tooltip":"power Draw $powerDraw"}  
EOF
