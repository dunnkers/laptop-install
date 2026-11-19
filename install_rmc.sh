#!/bin/bash
# Install rmc, a converter for reMarkable v6 (.rm) pages (to SVG/Markdown/PDF),
# via uv (installed by install_brew.sh). Lands in ~/.local/bin/rmc.
# Note: `rmc -t pdf` shells out to Inkscape; `rmc -t svg` has no extra dependency.

echo "Installing rmc..."

if [ -x "$HOME/.local/bin/rmc" ]; then
    echo "rmc already installed."
else
    uv tool install rmc && echo "✓ rmc installation complete."
fi
