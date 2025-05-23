# 🛠️ Secure VPN Project – Setup Guide

This document outlines how to set up the Secure VPN Infrastructure using two VMs on Proxmox.

## 🖥️ VM Overview

- **VM1**: Handles OpenVPN, WireGuard, dnsmasq, and IPTables
- **VM2**: Hosts Nginx and MySQL, accessible only through VM1 via WireGuard

---

## 📍 Prerequisites

- Two Ubuntu Server VMs (20.04 or later)
- Proxmox environment
- SSH or console access
- Root or sudo privileges

---

## 🔧 VM1 – OpenVPN + WireGuard + DNS

### 1. Install OpenVPN

```bash
sudo apt update
sudo apt install openvpn easy-rsa -y
```

Initialize PKI and generate server/client certs using `easy-rsa`.

### 2. Install WireGuard

```bash
sudo apt install wireguard -y
```

Create keys and config in `vm1-openvpn-wireguard/wireguard/wg0.conf`.

### 3. Configure dnsmasq

```bash
sudo apt install dnsmasq -y
```

Place your DNS config in `vm1-openvpn-wireguard/dnsmasq/dnsmasq.conf`.

Enable and restart:

```bash
sudo systemctl enable dnsmasq
sudo systemctl restart dnsmasq
```

### 4. IPTables Rules

Load rules from `vm1-openvpn-wireguard/iptables/rules.v4`:

```bash
sudo iptables-restore < rules.v4
```

Persist rules:

```bash
sudo apt install iptables-persistent
```

---

## 🌐 VM2 – Web + DB + Tunnel

### 1. Install Nginx

```bash
sudo apt install nginx -y
```

Use config in `vm2-web-db/nginx/default.conf`.

### 2. Install MySQL

```bash
sudo apt install mysql-server -y
```

Load any custom schema from `vm2-web-db/mysql/init.sql`.

### 3. Apply IPTables

```bash
sudo iptables-restore < vm2-web-db/iptables/rules.v4
sudo netfilter-persistent save
```

---

## 🔗 WireGuard Tunnel

- Configure `wg0.conf` on both VMs.
- Start and enable the interface:

```bash
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
```

---

## ✅ Next Steps

- Connect from a client using OpenVPN.
- Ensure internal DNS and access to web and database through WireGuard.

📘 Continue to [Verification Guide](verification.md)
