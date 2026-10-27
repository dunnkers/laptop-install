#!/bin/bash

# Some casks (visual-studio-code, docker-desktop, …) run sudo partway through
# their install. Authorise once up front so the rest of the run is unattended.
echo "Some installers need administrator rights — asking for your password once:"
if sudo -v; then
    # Refresh the sudo timestamp every 60s until this script exits.
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" 2>/dev/null || exit
    done &
    sudo_keepalive_pid=$!
    trap 'kill "${sudo_keepalive_pid}" 2>/dev/null' EXIT
else
    echo "⚠ Could not authenticate — installers may prompt for a password later."
fi

sh install_brew.sh
sh install_cf.sh
sh install_container.sh
sh install_mas.sh
sh install_talat.sh
sh install_dock.sh
sh install_hotcorners.sh
sh install_quickactions.sh
sh install_hyperkey.sh
sh install_maccy.sh
sh install_rectangle.sh
sh install_linearmouse.sh
sh install_spotify.sh
sh install_mos.sh
sh install_ohmyzsh.sh
sh install_git_aliases.sh