#!/bin/bash
# Make sure Apple's `container` (formula) and Orchard (cask GUI) are running and
# start at login. Both are installed by install_brew.sh.

echo "Configuring container and Orchard..."

# container: run as a launchd service via brew services (starts at login)
if brew services list | grep -E '^container\s+started' >/dev/null 2>&1; then
    echo "container service already running."
else
    brew services start container
fi

# brew services doesn't install a kernel automatically
container system kernel set --recommended 2>/dev/null || true

# Orchard: launch at login (skip if already a login item), and start it now
if ! osascript -e 'tell application "System Events" to get the name of every login item' 2>/dev/null | grep -q "Orchard"; then
    osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Orchard.app", hidden:false, name:"Orchard"}' 2>/dev/null || true
fi
pgrep -x Orchard >/dev/null 2>&1 || open -a Orchard 2>/dev/null || true

echo "✓ container and Orchard are configured."
