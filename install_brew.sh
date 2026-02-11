#!/bin/bash

# Source preferences library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/preferences.sh"

# Ask about Proton suite installation (only once)
install_proton=$(ask_preference "install_proton" "Install Proton suite (Pass, Mail, Drive, VPN)? [y/N]:" "n")

# Build list of packages to install
packages=(
    gifski
    gemini-cli
    node
    uv
    gh
    mas
    glab
)

casks=(
    gcloud-cli
    anki
    visual-studio-code
    maccy
    spotify
    whatsapp
    github
    google-chrome
    hyperkey
    fastrepl/hyprnote/hyprnote@nightly
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
    obsidian
    docker-desktop
)

# Add Proton suite if requested
case "$install_proton" in
    [yY][eE][sS]|[yY])
        echo "Including Proton suite in installation..."
        casks+=(
            proton-pass
            proton-mail
            proton-drive
            protonvpn
        )
        ;;
    *)
        echo "Skipping Proton suite."
        ;;
esac

# Install all packages in one command
echo "Installing Homebrew packages..."
brew install "${packages[@]}"
echo "✓ Homebrew package installation complete."

# Install all casks in one command
echo "Installing Homebrew cask applications..."
brew install $(printf -- '--cask %s ' "${casks[@]}")
echo "✓ Homebrew cask installation complete."