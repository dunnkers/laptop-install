#!/bin/bash

# Source preferences library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/preferences.sh"

echo "Configuring automated folder cleanup..."
echo ""

# Ask user if they want automated cleanup
enable_cleanup=$(ask_preference "enable_cleanup" "Enable automated cleanup of Downloads and Desktop folders? [y/N]:" "n")

if [[ ! "$enable_cleanup" =~ ^[yY]([eE][sS])?$ ]]; then
    echo "Skipping automated cleanup setup."
    exit 0
fi

echo ""

# Ask for age threshold
cleanup_age=$(ask_preference "cleanup_age_hours" "Move files older than how many hours to Trash? [default: 24]:" "24")

# Validate numeric input
if ! [[ "$cleanup_age" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Using default: 24 hours"
    cleanup_age=24
    set_preference "cleanup_age_hours" "24"
fi

# Ask which folders to clean
cleanup_downloads=$(ask_preference "cleanup_downloads" "Clean Downloads folder? [Y/n]:" "y")
cleanup_desktop=$(ask_preference "cleanup_desktop" "Clean Desktop folder? [Y/n]:" "y")

# Convert yes/no to true/false for environment variables
if [[ "$cleanup_downloads" =~ ^[yY]([eE][sS])?$ ]]; then
    cleanup_downloads_bool="true"
else
    cleanup_downloads_bool="false"
fi

if [[ "$cleanup_desktop" =~ ^[yY]([eE][sS])?$ ]]; then
    cleanup_desktop_bool="true"
else
    cleanup_desktop_bool="false"
fi

echo ""
echo "Configuration:"
echo "  - Age threshold: ${cleanup_age} hours"
echo "  - Downloads: ${cleanup_downloads_bool}"
echo "  - Desktop: ${cleanup_desktop_bool}"
echo "  - Schedule: Daily at 2:00 AM"
echo ""

# Create config directory
mkdir -p "${HOME}/.config/laptop-install"

# Make cleanup script executable
chmod +x "${SCRIPT_DIR}/lib/cleanup_folders.sh"

# Create LaunchAgent plist from template
PLIST_NAME="com.laptop-install.cleanup.plist"
PLIST_DEST="${HOME}/Library/LaunchAgents/${PLIST_NAME}"

# Copy and customize plist with sed
sed -e "s|INSTALL_DIR|${SCRIPT_DIR}|g" \
    -e "s|HOME|${HOME}|g" \
    -e "s|CLEANUP_AGE_HOURS_VALUE|${cleanup_age}|g" \
    -e "s|CLEANUP_DOWNLOADS_VALUE|${cleanup_downloads_bool}|g" \
    -e "s|CLEANUP_DESKTOP_VALUE|${cleanup_desktop_bool}|g" \
    "${SCRIPT_DIR}/${PLIST_NAME}" > "${PLIST_DEST}"

# Unload existing LaunchAgent if present
launchctl unload "${PLIST_DEST}" 2>/dev/null || true

# Load the LaunchAgent
if launchctl load "${PLIST_DEST}"; then
    echo "✓ Automated cleanup configured successfully."
else
    echo "⚠ Warning: Failed to load LaunchAgent. You may need to load it manually:"
    echo "  launchctl load ${PLIST_DEST}"
fi

echo ""
echo "Verification commands:"
echo ""
echo "  # Test cleanup manually:"
echo "  bash ${SCRIPT_DIR}/lib/cleanup_folders.sh"
echo ""
echo "  # View cleanup logs:"
echo "  cat ${HOME}/.config/laptop-install/cleanup.log"
echo ""
echo "  # Check LaunchAgent status:"
echo "  launchctl list | grep com.laptop-install.cleanup"
echo ""
echo "  # Trigger immediate cleanup (for testing):"
echo "  launchctl start com.laptop-install.cleanup"
echo ""
echo "  # Disable automated cleanup:"
echo "  launchctl unload ${PLIST_DEST}"
echo ""
