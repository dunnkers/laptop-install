#!/bin/bash

MARKER="# laptop-install: git aliases"

# Skip if already installed
if grep -q "$MARKER" ~/.zshrc 2>/dev/null; then
    echo "Git aliases already installed in ~/.zshrc, skipping."
    exit 0
fi

echo "Installing git clone aliases to ~/.zshrc..."

cat >> ~/.zshrc << 'EOF'

# laptop-install: git aliases
gitopen() {
    local url="$1"
    local owner repo
    if [[ "$url" =~ github\.com[:/]([^/]+)/([^/.]+)(\.git)?$ ]]; then
        owner="${match[1]}"
        repo="${match[2]}"
    else
        echo "Usage: gitopen <github-url>"
        return 1
    fi
    local dest="$HOME/git/$owner/$repo"
    if [ -d "$dest" ]; then
        echo "$owner/$repo already exists, opening."
        cd "$dest"
        return
    fi
    mkdir -p "$HOME/git/$owner"
    git clone "$url" "$dest" && cd "$dest"
}

ghopen() {
    local slug="$1"
    local owner repo
    if [[ "$slug" =~ ^([^/]+)/([^/]+)$ ]]; then
        owner="${match[1]}"
        repo="${match[2]}"
    else
        echo "Usage: ghopen <owner/repo>"
        return 1
    fi
    local dest="$HOME/git/$owner/$repo"
    if [ -d "$dest" ]; then
        echo "$owner/$repo already exists, opening."
        cd "$dest"
        return
    fi
    mkdir -p "$HOME/git/$owner"
    gh repo clone "$slug" "$dest" && cd "$dest"
}
EOF

echo "✓ Git aliases installed. Run 'source ~/.zshrc' to activate."
