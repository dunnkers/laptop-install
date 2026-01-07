echo "Configuring LinearMouse..."

# Create the configuration directory if it doesn't exist
mkdir -p ~/.config/linearmouse

# Copy the configuration file to the LinearMouse config directory
cp linearmouse.json ~/.config/linearmouse/linearmouse.json

# Configure general settings
defaults write com.lujjjh.LinearMouse showInMenuBar -bool false
defaults write com.lujjjh.LinearMouse showInDock -bool true

# Add LinearMouse to login items
osascript -e 'tell application "System Events" to delete login item "LinearMouse"' 2>/dev/null || true
osascript -e 'tell application "System Events" to make login item at end with properties {name:"LinearMouse", path:"/Applications/LinearMouse.app", hidden:false}' 2>/dev/null

# Restart LinearMouse to apply the configuration
killall LinearMouse 2>/dev/null || true
open -a LinearMouse

echo "✓ LinearMouse configuration complete."
