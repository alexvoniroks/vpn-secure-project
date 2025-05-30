#!/bin/bash

set -e

echo "=== [1/5] Updating system ==="
apt update && apt upgrade -y

echo "=== [2/5] Installing OpenVPN ==="
apt install -y openvpn easy-rsa

echo "=== [3/5] Installing WireGuard ==="
apt install -y wireguard

echo "=== [4/5] Installing iptables-persistent ==="
DEBIAN_FRONTEND=noninteractive apt install -y iptables-persistent

echo "=== [5/5] Applying configurations ==="

# Paths
BASE_DIR="/home/vpn/vpn-secure-project/vm1-openvpn-wireguard"
OPENVPN_CONF="${BASE_DIR}/openvpn/server.conf"
WG_CONF="${BASE_DIR}/wireguard/wg0.conf"
IPTABLES_RULES="${BASE_DIR}/iptables/rules.v4"

# Apply OpenVPN config
echo "[*] Copying OpenVPN config..."
mkdir -p /etc/openvpn
cp "$OPENVPN_CONF" /etc/openvpn/server.conf

# Apply WireGuard config
echo "[*] Copying WireGuard config..."
mkdir -p /etc/wireguard
cp "$WG_CONF" /etc/wireguard/wg0.conf
chmod 600 /etc/wireguard/wg0.conf

# Apply iptables rules
echo "[*] Restoring iptables rules..."
iptables-restore < "$IPTABLES_RULES"
netfilter-persistent save

# Enable and start services
echo "[*] Enabling and starting OpenVPN..."
systemctl enable openvpn@server
systemctl start openvpn@server

echo "[*] Enabling and starting WireGuard..."
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0

echo "✅ VM1 setup complete!"
