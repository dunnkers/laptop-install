
echo "Installing Homebrew packages..."
brew install gifski \
    docker \
    gemini-cli \
    node
echo "✓ Homebrew package installation complete."

echo "Installing Homebrew cask applications..."
brew install --cask gcloud-cli \
    --cask anki \
    --cask visual-studio-code \
    --cask maccy \
    --cask spotify \
    --cask whatsapp \
    --cask github \
    --cask drawio \
    --cask claude-code \
    --cask claude \
    --cask dbeaver-community \
    --cask db-browser-for-sqlite \
    --cask logi-options+ \
    --cask netnewswire
    # --cask rectangle \
echo "✓ Homebrew cask installation complete."