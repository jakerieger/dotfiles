#!/bin/bash

# Get current TLP mode
get_mode() {
    if systemctl is-active --quiet tlp.service; then
        # Check if AC is connected
        if [ -d /sys/class/power_supply/AC ] || [ -d /sys/class/power_supply/ACAD ]; then
            if cat /sys/class/power_supply/AC*/online 2>/dev/null | grep -q 1; then
                echo "AC"
            else
                echo "BAT"
            fi
        else
            echo "?"
        fi
    else
        echo "OFF"
    fi
}

# Show menu and switch
show_menu() {
    OPTIONS="Performance\nBalanced\nPower Saver"
    CHOICE=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Power Profile")

    case "$CHOICE" in
    "Performance")
        # Force AC profile
        sudo tlp ac
        notify-send "Power Profile" "Switched to Performance" -i battery-full
        ;;
    "Balanced")
        # Let TLP auto-decide
        sudo tlp start
        notify-send "Power Profile" "Switched to Balanced" -i battery-good
        ;;
    "Power Saver")
        # Force battery profile
        sudo tlp bat
        notify-send "Power Profile" "Switched to Power Saver" -i battery-low
        ;;
    esac
}

if [ "$1" = "menu" ]; then
    show_menu
else
    get_mode
fi
