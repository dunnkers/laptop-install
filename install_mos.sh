#!/bin/bash

# Configure Mos scroll settings
defaults write com.caldis.Mos reverse -bool true
defaults write com.caldis.Mos duration -float 2.00

# Restart Mos to apply changes
killall Mos 2>/dev/null
open -a Mos
