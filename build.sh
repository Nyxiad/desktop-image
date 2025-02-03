#!/bin/bash

set -ouex pipefail

source /etc/os-release

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Third-party repositories
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/network:/im:/signal/Fedora_$VERSION_ID/network:im:signal.repo

# Packages
dnf install -y chromium tailscale libavcodec-freeworld signal-desktop
dnf remove -y firefox

# Flatpaks
flatpak install -y com.bitwarden.desktop org.gnome.World.PikaBackup io.github.dvlv.boxbuddyrs org.mozilla.firefox

# System services
systemctl enable tailscaled
