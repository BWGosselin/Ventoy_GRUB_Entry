#!/bin/bash

# Enhanced echo with background colors for clear visual differentiation
echo_color() {
    local msg=$1
    local color=$2
    case "$color" in
        red) color_code="41;37" ;;     # White text on red background
        green) color_code="42;30" ;;   # Black text on green background
        yellow) color_code="43;30" ;;  # Black text on yellow background
        *) color_code="0" ;;           # Default to no color if not specified
    esac
    echo -e "\033[${color_code}m${msg}\033[0m"
}

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NO_COLOR='\033[0m'

echo_color "Updating GRUB configuration..." yellow

# Update GRUB configuration quietly
sudo update-grub > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo_color "GRUB configuration updated successfully." green
else
    echo_color "Failed to update GRUB configuration." red
fi

