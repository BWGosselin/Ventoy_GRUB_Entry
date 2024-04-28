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

# Define the file path
FILE="/etc/grub.d/40_custom"
UUID_FILE="/tmp/vtouuid.txt"

# Check if the UUID file exists and is not empty
if [ ! -f "$UUID_FILE" ] || [ -z "$(cat $UUID_FILE)" ]; then
    echo_color "Error: UUID file missing or empty." red
    exit 1
fi

# Read UUID from file
UUID=$(cat $UUID_FILE)

# Check if the GRUB file exists
if [ -f "$FILE" ]; then
    # Backup the original file before modifying
    cp "$FILE" "$FILE.bak"

    # Prepare the entry to add, including a newline before it
    ENTRY="\nmenuentry \"Ventoy\" {\n    search --fs-uuid --no-floppy --set=root $UUID\n    chainloader (\${root})/EFI/BOOT/BOOTx64.EFI\n}"

    # Append the entry at the end of the file
    echo -e "$ENTRY" | sudo tee -a "$FILE" > /dev/null

    echo_color "GRUB entry for Ventoy added successfully." green
else
    echo_color "Error: GRUB file does not exist." red
fi

