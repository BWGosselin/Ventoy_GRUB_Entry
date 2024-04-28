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

echo_color "Script Initialization..." yellow
sleep 1  # Short pause for user to read the message

# Confirm start
echo -n "This script will modify system configurations. Continue? (y/n): "
read -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo_color "Operation cancelled by the user." red
    exit 1
fi
echo_color "Proceeding with script execution..." green
sleep 1

# Main script logic
UNINSTALL_SCRIPT="./uninstall.sh"

if [ -f "$UNINSTALL_SCRIPT" ]; then
    echo_color "Error: uninstall.sh already exists. Reset with uninstall.sh if this is an error." red
    exit 1
fi

cat > "$UNINSTALL_SCRIPT" << 'EOF'
#!/bin/bash

# Enhanced echo with background colors
echo_color() {
    local msg=$1
    local color=$2
    case "$color" in
        green) color_code="42;30" ;;
        red) color_code="41;37" ;;
        yellow) color_code="43;30" ;;
        *) color_code="0" ;;
    esac
    echo -e "\\033[${color_code}m${msg}\\033[0m"
}

echo_color "Uninstall process initiated..." yellow

LOCK_FILE="./uninstall.sh"  # Using uninstall.sh as the lock file
FILE="/etc/grub.d/40_custom"
UPDATE_SCRIPT="./update_grub.sh"

# Restore original GRUB configuration if backup exists
if [ -f "$FILE.bak" ]; then
    if mv "$FILE.bak" "$FILE"; then
        echo_color "GRUB configuration restored to original." green
    else
        echo_color "Failed to restore GRUB configuration." red
    fi
else
    echo_color "No backup found. No changes made." red
fi

# Remove the lock file
if [ -f "$LOCK_FILE" ]; then
    rm "$LOCK_FILE" && echo_color "Lock file removed. Script is ready to execute again." green
else
    echo_color "No lock file found. Nothing to reset." red
fi

# Execute update_grub.sh if it exists and ensure executable permissions
if [ -f "$UPDATE_SCRIPT" ]; then
    chmod +x "$UPDATE_SCRIPT"
    echo_color "Executing update_grub.sh..." yellow
    if ! bash "$UPDATE_SCRIPT"; then
        echo_color "Failed to execute update_grub.sh." red
        exit 1
    fi
else
    echo_color "update_grub.sh not found." red
    exit 1
fi

echo_color "Uninstall process completed successfully." green
EOF

chmod +x "$UNINSTALL_SCRIPT"
echo_color "Uninstall script is prepared and executable." green

# Processing additional scripts
scripts=("find_uuid.sh" "add_grub_entry.sh" "update_grub.sh")
chmod +x "${scripts[@]}"

for script in "${scripts[@]}"; do
    echo_color "Processing $script..." yellow
    if ! ./"$script"; then
        echo_color "Execution failed: $script." red
    fi
done

echo_color "All scripts executed successfully." green

