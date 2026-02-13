apps=(
    "1559269364 Notion Web Clipper"
    "1481853033 Strongbox Pro"
    "1609960918 Jomo - Screen Time Blocker"
    "408981434 iMovie"
    "1365531024 1Blocker - Ad Blocker"
    "1351639930 Gifski"
    "6502835663 Proton Pass for Safari"
)

ids=()

for app in "${apps[@]}"; do
    id="${app%% *}"
    name="${app#* }"
    ids+=("$id")
done

echo "Installing apps…"
mas install "${ids[@]}"

echo "Updating all Mac App Store apps..."
mas upgrade
