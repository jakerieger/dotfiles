#!/bin/bash

GPU_USAGE="$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)"
GPU_TEMP="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)"
GPU_MEM="$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)"
GPU_MEM_TOTAL="$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits)"

# Color based on temperature
if [ "$GPU_TEMP" -gt 80 ]; then
    TEMP_COLOR="#f7768e"
elif [ "$GPU_TEMP" -gt 70 ]; then
    TEMP_COLOR=""
else
    TEMP_COLOR="#73daca"
fi

# Color based on usage
if [ "$GPU_USAGE" -gt 80 ]; then
    USAGE_COLOR="#f7768e"
elif [ "$GPU_USAGE" -gt 50 ]; then
    USAGE_COLOR="#e0af68"
else
    USAGE_COLOR="#73daca"
fi

TEXT="󰾲 <span foreground='$USAGE_COLOR' weight='bold'>${GPU_USAGE}%</span> 󰔏 <span foreground='$TEMP_COLOR'>${GPU_TEMP}°C</span>"

TOOLTIP="<b>GPU Statistics</b>\nUsage: ${GPU_USAGE}%\nTemperature: ${GPU_TEMP}°C\nMemory: ${GPU_MEM}MB / ${GPU_MEM_TOTAL}MB"

echo "{\"text\":\"$TEXT\", \"tooltip\":\"$TOOLTIP\"}"
