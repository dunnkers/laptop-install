echo "Configuring Maccy..."

# Disable automatic update checks (will update with brew)
# Maccy is sandboxed; the write fails unless the terminal may access its container
# (System Settings > Privacy & Security > App Management / Full Disk Access).
if ! defaults write org.p0deje.Maccy SUEnableAutomaticChecks -bool false; then
    echo "✗ Could not write Maccy preferences; grant your terminal App Management or Full Disk Access and re-run." >&2
    exit 1
fi

# Launch at login
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Maccy.app", hidden:false, name:"Maccy"}' 2>/dev/null || true

# Restart Maccy to apply changes
killall Maccy 2>/dev/null || true
open -a Maccy 2>/dev/null || true

echo "✓ Maccy has been configured."
