echo "Configuring Rectangle shortcuts..."

# Enable launch on login
defaults write com.knollsoft.Rectangle launchOnLogin -bool true

# Basic Halves (Arrows)
defaults write com.knollsoft.Rectangle leftHalf -dict keyCode 123 modifierFlags 1835008
defaults write com.knollsoft.Rectangle rightHalf -dict keyCode 124 modifierFlags 1835008
defaults write com.knollsoft.Rectangle topHalf -dict keyCode 126 modifierFlags 1835008
defaults write com.knollsoft.Rectangle bottomHalf -dict keyCode 125 modifierFlags 1835008

# Corners (U, I, J, K keys)
defaults write com.knollsoft.Rectangle topLeft -dict keyCode 32 modifierFlags 1835008
defaults write com.knollsoft.Rectangle topRight -dict keyCode 34 modifierFlags 1835008
defaults write com.knollsoft.Rectangle bottomLeft -dict keyCode 38 modifierFlags 1835008
defaults write com.knollsoft.Rectangle bottomRight -dict keyCode 40 modifierFlags 1835008

# Utilities (Maximize, Center, Resize)
defaults write com.knollsoft.Rectangle maximize -dict keyCode 3 modifierFlags 1835008 # F key
defaults write com.knollsoft.Rectangle center -dict keyCode 8 modifierFlags 1835008   # C key
defaults write com.knollsoft.Rectangle larger -dict keyCode 24 modifierFlags 1835008  # + key
defaults write com.knollsoft.Rectangle smaller -dict keyCode 27 modifierFlags 1835008 # - key

# Restore & Maximize Height
defaults write com.knollsoft.Rectangle restore -dict keyCode 15 modifierFlags 1835008
defaults write com.knollsoft.Rectangle maximizeHeight -dict keyCode 4 modifierFlags 1835008

# Thirds (Hyper + Q, W, E)
defaults write com.knollsoft.Rectangle firstThird -dict keyCode 12 modifierFlags 1835008
defaults write com.knollsoft.Rectangle centerThird -dict keyCode 13 modifierFlags 1835008
defaults write com.knollsoft.Rectangle lastThird -dict keyCode 14 modifierFlags 1835008

# Two Thirds (Hyper + A, S, D)
defaults write com.knollsoft.Rectangle firstTwoThirds -dict keyCode 0 modifierFlags 1835008
defaults write com.knollsoft.Rectangle centerTwoThirds -dict keyCode 1 modifierFlags 1835008
defaults write com.knollsoft.Rectangle lastTwoThirds -dict keyCode 2 modifierFlags 1835008

# Next/Previous Display (Hyper + Shift + Arrows)
defaults write com.knollsoft.Rectangle nextDisplay -dict keyCode 124 modifierFlags 1966080
defaults write com.knollsoft.Rectangle previousDisplay -dict keyCode 123 modifierFlags 1966080

# Stage Manager settings
defaults write com.knollsoft.Rectangle stageSize -int 5

# Restart Rectangle to apply changes
killall Rectangle && open -a Rectangle

echo "Rectangle has been configured."