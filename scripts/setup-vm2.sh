#!/bin/bash

set -e

echo "=== [1/6] Updating system ==="
apt update && apt upgrade -y

echo "=== [2/6] Installing Nginx ==="
apt install -y nginx

echo "=== [3/6] Installing MySQL ==="
DEBIAN_FRONTEND=noninteractive apt install -y mysql-server

echo "=== [4/6] Installing WireGuard ==="
apt install -y wireguard

echo "=== [5/6] Installing iptables-persistent ==="
DEBIAN_FRONTEND=noninteractive apt install -y iptables-persistent

# Paths
BASE_DIR="/home/vpn/vpn-secure-project/vm2-web-db"
NGINX_CONF="${BASE_DIR}/nginx/default.conf"
WG_CONF="${BASE_DIR}/wireguard/wg0.conf"
IPTABLES_RULES="${BASE_DIR}/iptables/rules.v4"
INIT_SQL="${BASE_DIR}/mysql/init.sql"

echo "=== [6/6] Applying configurations ==="

# Nginx
echo "[*] Copying Nginx config..."
cp "$NGINX_CONF" /etc/nginx/sites-available/default
systemctl restart nginx
systemctl enable nginx

# WireGuard
echo "[*] Setting up WireGuard client..."
mkdir -p /etc/wireguard
cp "$WG_CONF" /etc/wireguard/wg0.conf
chmod 600 /etc/wireguard/wg0.conf
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0

# IPTables
echo "[*] Applying iptables rules..."
iptables-restore < "$IPTABLES_RULES"
netfilter-persistent save

# MySQL Init (optional)
if [ -f "$INIT_SQL" ]; then
    echo "[*] Running MySQL init script..."
    mysql -u root < "$INIT_SQL"
else
    echo "[*] No init.sql found, skipping MySQL schema setup."
fi

echo "✅ VM2 setup complete!"
