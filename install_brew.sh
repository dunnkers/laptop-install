#!/bin/bash

# Run non-interactively: Homebrew 6.0+ asks for confirmation before installing
# ("ask mode") by default. HOMEBREW_NO_ASK disables that prompt.
export HOMEBREW_NO_ASK=1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Build list of packages to install
packages=(
    gifski
    gemini-cli
    node
    uv
    gh
    mas
    glab
    hashicorp/tap/terraform
    tflint
    pre-commit
    git-filter-repo
    ffmpeg
    colima
    tree
    llmfit
    anomalyco/tap/opencode
    himalaya
    cloudflare-wrangler
    rust
    rust-analyzer
    cmake
    pkgconf
    protonpass/tap/pass-cli
)

casks=(
    gcloud-cli
    anki
    openmtp
    visual-studio-code
    maccy
    # spotify  # Removed: "Apple cannot verify that spotify is free of malware that may harm your Mac" - install manually from https://www.spotify.com/download/mac/
    whatsapp
    github
    google-chrome
    hyperkey
    rectangle
    drawio
    claude-code
    claude
    craft
    dbeaver-community
    db-browser-for-sqlite
    netnewswire
    linear-linear
    linearmouse
    mos
    obsidian
    ollama-app
    docker-desktop
    screen-studio
    proton-pass
    dunnkers/pinned/protonvpn-6-5-1
)

# Add third-party taps
brew tap hashicorp/tap
brew tap anomalyco/tap
brew tap protonpass/tap
# Proton VPN is pinned to 6.5.1: 6.5.2 fails to enable its system extension
# on macOS 27 ("Cannot enable System Extension" / "VPN Protocol Not Supported").
# Remove the pin (and casks/protonvpn-6-5-1.rb) once a fixed release ships.
brew tap-new --no-git dunnkers/pinned >/dev/null 2>&1 || true
mkdir -p "$(brew --repository dunnkers/pinned)/Casks"
cp "${SCRIPT_DIR}/casks/protonvpn-6-5-1.rb" "$(brew --repository dunnkers/pinned)/Casks/"

# Install all packages in one command
echo "Installing Homebrew packages..."
brew install "${packages[@]}"
echo "✓ Homebrew package installation complete."

# Install all casks in one command
echo "Installing Homebrew cask applications..."
brew install $(printf -- '--cask %s ' "${casks[@]}")
echo "✓ Homebrew cask installation complete."