echo "Configuring Hyperkey..."

# Remap physical key to hyper key: caps lock
defaults write com.knollsoft.Hyperkey keyRemap -int 1

# Set caps lock as the remapped key (2 = caps lock)
defaults write com.knollsoft.Hyperkey capsLockRemapped -int 2

# Apply hyper key modifiers to Click
defaults write com.knollsoft.Hyperkey hyperFlags -int 1835008

# Quick press caps lock to execute caps lock
defaults write com.knollsoft.Hyperkey executeQuickHyperKey -int 1
defaults write com.knollsoft.Hyperkey quickHyperKeycode -int 0

# Open on login
defaults write com.knollsoft.Hyperkey launchOnLogin -bool true

# Hide menu bar icon
defaults write com.knollsoft.Hyperkey hideMenuBarIcon -bool true

# Disable automatic update checks (will update with brew)
defaults write com.knollsoft.Hyperkey SUEnableAutomaticChecks -int 0

# Restart Hyperkey to apply changes
killall Hyperkey 2>/dev/null || true
open -a Hyperkey

echo "✓ Hyperkey has been configured."