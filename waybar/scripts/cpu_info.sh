#!/bin/bash

CPU_USAGE="$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')"
CPU_TEMP="$(sensors | grep 'Tctl' | awk '{print $2}' | tr -d '+')"

# Color based on temperature
if [ "$CPU_TEMP" -gt 80 ]; then
    TEMP_COLOR="#f7768e"
elif [ "$CPU_TEMP" -gt 70 ]; then
    TEMP_COLOR=""
else
    TEMP_COLOR="#73daca"
fi

# Color based on usage
if [ "$CPU_USAGE" -gt 80 ]; then
    USAGE_COLOR="#f7768e"
elif [ "$CPU_USAGE" -gt 50 ]; then
    USAGE_COLOR="#e0af68"
else
    USAGE_COLOR="#73daca"
fi

TEXT="󰾲 <span foreground='$USAGE_COLOR' weight='bold'>${CPU_USAGE}%</span> 󰔏 <span foreground='$TEMP_COLOR'>${CPU_TEMP}</span>"

TOOLTIP="<b>CPU Statistics</b>\nUsage: ${CPU_USAGE}%\nTemperature: ${CPU_TEMP}"

echo "{\"text\":\"$TEXT\", \"tooltip\":\"$TOOLTIP\"}"
