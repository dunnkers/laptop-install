echo "Setting up Mission Control desktop shortcuts..."

# Control + 1..9: jump directly to Desktop 1..9
# (System Settings > Keyboard > Keyboard Shortcuts > Mission Control).
# Symbolic hotkey IDs 118..126 are "Switch to Desktop 1..9".
# parameters = ASCII code, virtual keycode, modifier mask (262144 = Control).
ascii=(49 50 51 52 53 54 55 56 57)
keycodes=(18 19 20 21 23 22 26 28 25)

for i in 0 1 2 3 4 5 6 7 8; do
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$((118 + i))" \
        "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>${ascii[$i]}</integer><integer>${keycodes[$i]}</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>"
done

# Apply without logging out
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
echo "✓ Control + 1-9 now switch to Desktop 1-9."
