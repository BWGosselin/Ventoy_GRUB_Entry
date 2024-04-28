# Ventoy_GRUB_Entry

**Attention: Please ensure that Ventoy is already installed on your USB drive and inserted before proceeding.**

This script simplifies the process of adding Ventoy to your GRUB menu, making it easier to boot from Ventoy on your system.

How it works:

1. Detection of Ventoy Label: The script automatically identifies Ventoy drives by searching for the label "VTOYEFI" on connected USB devices. To ensure successful detection, make sure your Ventoy USB drive is connected before running the script.

2. Extraction of UUID: Once Ventoy is detected, the script extracts the Universally Unique Identifier (UUID) associated with it. This UUID is crucial for configuring the GRUB entry and is saved to a temporary file for reference (/tmp/vtouuid.txt).

3. Integration into GRUB: The script seamlessly integrates Ventoy into your GRUB menu by adding a custom entry. This entry includes instructions for GRUB to locate and boot Ventoy using its UUID.

4. Easy Uninstallation: For your convenience, an uninstallation script (uninstall.sh) is generated alongside the main script. This script allows you to revert any changes made by removing the Ventoy entry from the GRUB configuration file and deleting temporary files.

Usage:

Simply execute run.sh and follow the prompts. This will initiate the integration process and add Ventoy to your GRUB menu.

Uninstallation:

If you ever wish to remove Ventoy from your GRUB menu and undo all changes made by the script, execute uninstall.sh and follow the prompts. This will restore your GRUB configuration to its original state.

Note:

This script has been thoroughly tested on Debian 12 Bookworm. While it's designed to work smoothly on Debian systems, compatibility with other distributions may vary.
