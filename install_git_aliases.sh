#!/bin/bash

OLD_MARKER="# laptop-install: git aliases"
START_MARKER="# laptop-install: git aliases (start)"
END_MARKER="# laptop-install: git aliases (end)"

# Remove old block (no end marker — goes to EOF)
if grep -q "$OLD_MARKER" ~/.zshrc 2>/dev/null && ! grep -q "$START_MARKER" ~/.zshrc 2>/dev/null; then
    echo "Removing old git aliases block from ~/.zshrc..."
    sed -i '' "/$OLD_MARKER/,\$d" ~/.zshrc
fi

# Remove current block if re-running
if grep -q "$START_MARKER" ~/.zshrc 2>/dev/null; then
    echo "Updating git aliases in ~/.zshrc..."
    sed -i '' "/$START_MARKER/,/$END_MARKER/d" ~/.zshrc
fi

echo "Installing git aliases to ~/.zshrc..."

cat >> ~/.zshrc << 'EOF'

# laptop-install: git aliases (start)
gopn() {
    local input="${1%/}"
    local owner repo clone_cmd
    if [[ "$input" =~ "://|^git@" ]]; then
        if [[ "$input" =~ github\.com[:/]([^/]+)/([^/.]+)(\.git)?$ ]]; then
            owner="${match[1]}"
            repo="${match[2]}"
        else
            echo "Could not parse owner/repo from URL: $input"
            return 1
        fi
        clone_cmd=(git clone "$input")
    elif [[ "$input" =~ ^([^/]+)/([^/]+)$ ]]; then
        owner="${match[1]}"
        repo="${match[2]}"
        clone_cmd=(gh repo clone "$input")
    else
        echo "Usage: gopn <github-url or owner/repo>"
        return 1
    fi
    local dest="$HOME/git/$owner/$repo"
    if [ -d "$dest" ]; then
        echo "Opening $owner/$repo ... ✨"
        cd "$dest"
        return
    fi
    mkdir -p "$HOME/git/$owner"
    "${clone_cmd[@]}" "$dest" && cd "$dest"
}

_gopn() {
    _path_files -W "$HOME/git" -/
}
compdef _gopn gopn
# laptop-install: git aliases (end)
EOF

echo "✓ Git aliases installed. Run 'source ~/.zshrc' to activate."
