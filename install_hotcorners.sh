
echo "Setting up Hot Corners..."

# Top Left: Launchpad (Apps)
defaults write com.apple.dock wvous-tl-corner -int 11
defaults write com.apple.dock wvous-tl-modifier -int 0
echo "✓ Top Left Hot Corner set to Launchpad."

# Bottom Left: Put Display to Sleep
defaults write com.apple.dock wvous-bl-corner -int 10
defaults write com.apple.dock wvous-bl-modifier -int 0
echo "✓ Bottom Left Hot Corner set to Put Display to Sleep."

# Top Right: Notification Centre
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-tr-modifier -int 0
echo "✓ Top Right Hot Corner set to Notification Centre."

# Bottom Right: Mission Control
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0
echo "✓ Bottom Right Hot Corner set to Mission Control."

# Restart the Dock to apply changes
killall Dock
echo "✓ Hot Corners setup complete."