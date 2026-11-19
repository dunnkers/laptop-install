#!/bin/bash
# SwiftBar (cask, installed by install_brew.sh) shows script output in the menu bar.
# Plugins live in ~/.config/swiftbar; drop an executable `name.10s.sh` in there.

echo "Configuring SwiftBar..."

PLUGIN_DIR="$HOME/.config/swiftbar"
mkdir -p "$PLUGIN_DIR"

defaults write com.ameba.SwiftBar PluginDirectory -string "$PLUGIN_DIR"
# Updates come through brew
defaults write com.ameba.SwiftBar SUEnableAutomaticChecks -bool false

# Launch at login (skip if already a login item)
if ! osascript -e 'tell application "System Events" to get the name of every login item' 2>/dev/null | grep -q "SwiftBar"; then
    osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/SwiftBar.app", hidden:false, name:"SwiftBar"}' 2>/dev/null || true
fi

# Restart to pick up the plugin directory
killall SwiftBar 2>/dev/null || true
open -a SwiftBar 2>/dev/null || true

echo "✓ SwiftBar has been configured (plugins: $PLUGIN_DIR)."
