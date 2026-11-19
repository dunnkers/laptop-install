apps=(
    # "1481853033 Strongbox Pro"
    "1609960918 Jomo - Screen Time Blocker"
    "408981434 iMovie"
    "1365531024 1Blocker - Ad Blocker"
    "1351639930 Gifski"
    "6502835663 Proton Pass for Safari"
    "937984704 Amphetamine"
    "6471380298 StopTheMadness Pro"
    "302584613 Amazon Kindle"
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

# An app is "running" if its main binary is; Safari extension helpers (.appex) don't count
is_running() {
    local path
    path=$(mdfind "kMDItemAppStoreAdamID == $1" | head -1)
    [ -n "$path" ] && pgrep -f "^$path/Contents/MacOS/" >/dev/null
}

echo "Upgrading apps…"
for app in "${apps[@]}"; do
    id="${app%% *}"
    name="${app#* }"
    if ! echo "$outdated" | grep -q "^$id "; then
        echo "  ✓ $name is up to date"
        continue
    fi
    if is_running "$id"; then
        echo "  ⚠ Skipping $name — currently running"
    else
        echo "  Upgrading $name ($id)…"
        mas upgrade --verbose "$id" &
        pid=$!
        ( sleep 30 && kill $pid 2>/dev/null ) &
        timer=$!
        if wait $pid 2>/dev/null; then
            { kill $timer; wait $timer; } 2>/dev/null
            echo "  ✓ $name done"
        else
            { kill $timer; wait $timer; } 2>/dev/null
            echo "  ✗ $name failed or timed out"
        fi
    fi
done
