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
    echo -e "\\033[${color_code}m${msg}\\033[0m"
}

echo_color "Finding UUID for VTOYEFI..." yellow

# Path to the device with label 'VTOYEFI'
DEVICE_PATH=$(readlink -f /dev/disk/by-label/VTOYEFI 2>/dev/null)

if [ -z "$DEVICE_PATH" ]; then
    echo_color "No partition with label 'VTOYEFI' found." red
    exit 1
fi

# Extract the UUID from the device path
UUID=$(ls -l /dev/disk/by-uuid/ | grep "$(basename $DEVICE_PATH)" | awk '{print $9}')

if [ -n "$UUID" ]; then
    echo_color "UUID of VTOYEFI: $UUID" green
    # Write the UUID to a text file in the /tmp directory
    echo $UUID > /tmp/vtouuid.txt
else
    echo_color "Could not retrieve UUID." red
    exit 1
fi
