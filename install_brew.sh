#!/bin/bash

# Run non-interactively: Homebrew 6.0+ asks for confirmation before installing
# ("ask mode") by default. HOMEBREW_NO_ASK disables that prompt.
export HOMEBREW_NO_ASK=1

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
)

# Add Proton suite if requested
case "$install_proton" in
    [yY][eE][sS]|[yY])
        echo "Including Proton suite in installation..."
        packages+=(
            protonpass/tap/pass-cli
        )
        casks+=(
            proton-pass
            proton-mail
            proton-mail-bridge
            proton-drive
            dunnkers/pinned/protonvpn-6-5-1
        )
        ;;
    *)
        echo "Skipping Proton suite."
        ;;
esac

# Add third-party taps
brew tap hashicorp/tap
brew tap anomalyco/tap
if [[ "$install_proton" =~ ^[yY] ]]; then
    brew tap protonpass/tap
    # Proton VPN is pinned to 6.5.1: 6.5.2 fails to enable its system extension
    # on macOS 27 ("Cannot enable System Extension" / "VPN Protocol Not Supported").
    # Remove the pin (and casks/protonvpn-6-5-1.rb) once a fixed release ships.
    brew tap-new --no-git dunnkers/pinned >/dev/null 2>&1 || true
    mkdir -p "$(brew --repository dunnkers/pinned)/Casks"
    cp "${SCRIPT_DIR}/casks/protonvpn-6-5-1.rb" "$(brew --repository dunnkers/pinned)/Casks/"
fi

# Install all packages in one command
echo "Installing Homebrew packages..."
brew install "${packages[@]}"
echo "✓ Homebrew package installation complete."

# Install all casks in one command
echo "Installing Homebrew cask applications..."
brew install $(printf -- '--cask %s ' "${casks[@]}")
echo "✓ Homebrew cask installation complete."