apps=(
    "1559269364 Notion Web Clipper"
    # "1481853033 Strongbox Pro"
    "1609960918 Jomo - Screen Time Blocker"
    "408981434 iMovie"
    "1365531024 1Blocker - Ad Blocker"
    "1351639930 Gifski"
    "6502835663 Proton Pass for Safari"
)

installed=$(mas list 2>/dev/null)

echo "Installing apps…"
for app in "${apps[@]}"; do
    id="${app%% *}"
    name="${app#* }"
    if echo "$installed" | grep -q "^$id "; then
        echo "  ✓ $name already installed"
    else
        echo "  Installing $name ($id)…"
        mas install "$id"
    fi
done

# check which apps are outdated
echo "Checking for outdated apps…"
outdated=$(mas outdated 2>/dev/null)

# check for running apps
running_apps=$(osascript -e 'tell application "System Events" to get name of every application process' 2>/dev/null)

echo "Upgrading apps…"
for app in "${apps[@]}"; do
    id="${app%% *}"
    name="${app#* }"
    if ! echo "$outdated" | grep -q "^$id "; then
        echo "  ✓ $name is up to date"
        continue
    fi
    # strip suffixes like " - Ad Blocker" or " for Safari" to match process names
    short_name="${name%% - *}"
    short_name="${short_name%% for *}"
    if echo "$running_apps" | grep -qi "$short_name"; then
        echo "  ⚠ Skipping $name — currently running"
    else
        echo "  Upgrading $name ($id)…"
        mas upgrade --verbose "$id" &
        pid=$!
        ( sleep 30 && kill $pid 2>/dev/null ) &
        timer=$!
        if wait $pid 2>/dev/null; then
            kill $timer 2>/dev/null
            echo "  ✓ $name done"
        else
            kill $timer 2>/dev/null
            echo "  ✗ $name failed or timed out"
        fi
    fi
done
