
echo "Setting up Screenshots..."

# Save screenshots to ~/Pictures/Screenshots instead of the Desktop
SCREENSHOT_DIR="${HOME}/Pictures/Screenshots"
mkdir -p "${SCREENSHOT_DIR}"
defaults write com.apple.screencapture location "${SCREENSHOT_DIR}"
echo "✓ Screenshots will be saved to ${SCREENSHOT_DIR}."

# Restart SystemUIServer to apply changes
killall SystemUIServer
echo "✓ Screenshots setup complete."
