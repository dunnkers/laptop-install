#!/bin/bash
# Install talat (local meeting transcription) from the official DMG.
# Not available via Homebrew or the Mac App Store; https://talat.app/download/mac
# redirects to the latest release (Apple Silicon only).

APP="/Applications/talat.app"

if [ -d "$APP" ]; then
    echo "talat already installed."
    exit 0
fi

if [ "$(uname -m)" != "arm64" ]; then
    echo "⚠ talat only ships an Apple Silicon build; skipping."
    exit 0
fi

tmp_dir=$(mktemp -d)
mount_point="${tmp_dir}/mnt"
cleanup() {
    hdiutil detach "$mount_point" -quiet 2>/dev/null
    rm -rf "$tmp_dir"
}
trap cleanup EXIT

echo "Downloading talat..."
curl -fsSL -o "${tmp_dir}/talat.dmg" "https://talat.app/download/mac" || { echo "⚠ talat download failed."; exit 1; }

mkdir -p "$mount_point"
hdiutil attach "${tmp_dir}/talat.dmg" -nobrowse -readonly -mountpoint "$mount_point" -quiet || { echo "⚠ Could not mount talat DMG."; exit 1; }

app_src=$(find "$mount_point" -maxdepth 1 -name "*.app" | head -n 1)
if [ -z "$app_src" ]; then
    echo "⚠ No .app found in talat DMG."
    exit 1
fi

cp -R "$app_src" /Applications/ && echo "✓ talat installed."
