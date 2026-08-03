#!/bin/bash
set -ouex pipefail

rm /opt && mkdir /opt # PATCH: Recreate /opt as a real directory to allow Helium to install properly.

dnf5 copr enable -y imput/helium
dnf5 remove -y firefox
dnf5 install -y \
	distrobox \
	helium-bin \
	nix \
	nix-daemon \
	podman
dnf5 copr disable -y imput/helium

# Add /nix -> /var/nix mounts.
#
cat <<EOF >/usr/lib/systemd/system/nix.mount
[Unit]
Description=Bind mount /var/nix to /nix

[Mount]
What=/var/nix
Where=/nix
Type=none
Options=bind

[Install]
WantedBy=local-fs.target
EOF

# Add default /nix bindings for new Distrobox containers.
#
mkdir -p /usr/share/distrobox
cat <<EOF >/usr/share/distrobox/distrobox.conf
container_manager="podman"
container_additional_volumes="/nix:/nix:ro"
EOF

systemctl enable nix.mount
systemctl enable nix-daemon.service
