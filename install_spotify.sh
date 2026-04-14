#!/bin/sh
# Configure Spotify preferences

PREFS_FILE="$HOME/Library/Application Support/Spotify/prefs"

# Ensure the directory exists
mkdir -p "$(dirname "$PREFS_FILE")"

# Helper: set a key in the prefs file (add if missing, replace if present)
set_pref() {
    key="$1"
    value="$2"
    if grep -q "^${key}=" "$PREFS_FILE" 2>/dev/null; then
        sed -i '' "s|^${key}=.*|${key}=${value}|" "$PREFS_FILE"
    else
        echo "${key}=${value}" >> "$PREFS_FILE"
    fi
}

# Disable auto-start on login
set_pref "app.autostart-mode" '"off"'
set_pref "app.autostart-configured" "true"

echo "Spotify: disabled auto-start on login."
