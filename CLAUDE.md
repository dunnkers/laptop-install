# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS laptop setup automation repository that installs and configures applications and system settings. The installation process is orchestrated through a main script that sequentially executes modular installation scripts.

## Architecture

### Installation Flow

The main entry point is [install.sh](install.sh), which executes scripts in this order:

1. [install_brew.sh](install_brew.sh) - Installs all Homebrew packages and cask applications in one consolidated command. Includes optional Proton suite (asks user once, saves preference).
2. [install_mas.sh](install_mas.sh) - Installs Mac App Store applications
3. Configuration scripts for specific applications:
   - [install_hotcorners.sh](install_hotcorners.sh)
   - [install_hyperkey.sh](install_hyperkey.sh)
   - [install_rectangle.sh](install_rectangle.sh)
   - [install_linearmouse.sh](install_linearmouse.sh)

Note: [install_dock.sh](install_dock.sh) exists but is not currently invoked by the main script.

### Script Types

1. **Package Installation Scripts**: Use `brew install` or `mas install` to install applications
2. **Configuration Scripts**: Use `defaults write` to configure application preferences via macOS defaults system
3. **Application Control**: Scripts use `killall` and `open -a` to restart applications after configuration

### Configuration Pattern

Application configuration scripts follow this pattern:
- Write preferences using `defaults write com.app.bundle preference -type value`
- Restart the application to apply changes: `killall AppName && open -a AppName`
- Key modifier flag `1835008` represents the Hyperkey (Caps Lock remapped via Hyperkey app)
- Key modifier flag `1966080` represents Hyperkey + Shift

### Special Configuration Files

- [linearmouse.json](linearmouse.json): JSON configuration for LinearMouse that maps mouse buttons to macOS gestures. Copied to `~/.config/linearmouse/` during installation.

### User Preferences System

The repository includes a preferences management system ([lib/preferences.sh](lib/preferences.sh)) that stores user choices persistently in `~/.config/laptop-install/preferences`. This allows scripts to ask questions once and remember the answers for future runs.

**Key functions:**
- `get_preference "key" "default"` - Retrieves a stored preference value
- `set_preference "key" "value"` - Stores a preference value
- `has_preference "key"` - Checks if a preference exists
- `ask_preference "key" "prompt" "default"` - Asks user for input only if preference not already set

**Usage example:**
```bash
source "${SCRIPT_DIR}/lib/preferences.sh"
install_proton=$(ask_preference "install_proton" "Install Proton suite? [y/N]:" "n")
```

To reset preferences and be prompted again, delete the preferences file:
```bash
rm ~/.config/laptop-install/preferences
```

## Running the Installation

Execute the main installation script:
```bash
sh install.sh
```

Run individual installation scripts:
```bash
sh install_brew.sh
sh install_rectangle.sh
# etc.
```

## Adding New Applications

1. **Homebrew packages**: Add to the `packages` array in [install_brew.sh](install_brew.sh)
2. **Homebrew casks**: Add to the `casks` array in [install_brew.sh](install_brew.sh)
3. **Mac App Store apps**: Add to the `apps` array in [install_mas.sh](install_mas.sh) with format `"<app_id> <app_name>"`

All Homebrew packages and casks are installed in a single consolidated command for efficiency.

## Adding New Configuration Scripts

1. Create a new `install_<appname>.sh` script following the existing pattern
2. Add it to [install.sh](install.sh) in the appropriate sequence
3. Use `defaults write` for preference configuration
4. Restart the app with `killall <AppName> && open -a <AppName>`

## macOS Defaults System

Configuration uses macOS `defaults` command to write preferences:
- Bundle identifiers follow pattern `com.vendor.AppName` (e.g., `com.knollsoft.Rectangle`, `com.apple.dock`)
- Use `defaults read <bundle>` to view current settings
- Use `defaults write <bundle> <key> -<type> <value>` to modify settings
- Common types: `-bool`, `-int`, `-string`, `-dict`
- Changes typically require app restart via `killall` and `open`

## Key Codes and Modifier Flags

When configuring keyboard shortcuts:
- Arrow keys: left=123, right=124, up=126, down=125
- Letters: Use keycodes (e.g., U=32, I=34, J=38, K=40)
- Modifier `1835008`: Hyperkey (all modifiers via Caps Lock)
- Modifier `1966080`: Hyperkey + Shift
