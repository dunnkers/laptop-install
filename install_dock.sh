echo "Configuring macOS Dock..."

# Enable auto-hide
defaults write com.apple.dock autohide -bool true

# Restart Dock to apply changes
killall Dock

echo "Dock has been configured."
