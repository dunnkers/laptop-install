
read -r -p "Install Proton suite (Pass, Mail, Drive, VPN)? [y/N]: " response

case "$response" in
    [yY][eE][sS]|[yY])
        echo "Installing Proton apps..."
        brew install --cask proton-pass
        brew install --cask proton-mail
        brew install --cask proton-drive
        brew install --cask protonvpn
        echo "Proton suite installation complete."
        ;;
    *)
        echo "Skipping Proton suite installation."
        ;;
esac
