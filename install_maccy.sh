echo "Configuring Maccy..."

# Disable automatic update checks (will update with brew)
defaults write org.p0deje.Maccy SUEnableAutomaticChecks -bool false

# Launch at login
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Maccy.app", hidden:false, name:"Maccy"}' 2>/dev/null || true

# Restart Maccy to apply changes
killall Maccy 2>/dev/null || true
open -a Maccy

echo "✓ Maccy has been configured."
