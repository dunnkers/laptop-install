#!/bin/bash
# Install the Cloudflare CLI (cf, beta) via npm, the official method per
# https://developers.cloudflare.com/cf/. Not the Homebrew "cf" formula (Cloud Foundry).
# Requires node, which install_brew.sh installs.

if ! command -v npm >/dev/null 2>&1; then
    echo "⚠ npm not found (run install_brew.sh first); skipping Cloudflare CLI."
    exit 1
fi

echo "Installing Cloudflare CLI (cf)..."
npm install --global cf && echo "✓ Cloudflare CLI installation complete."
