# 📊 Secure VPN Project – Sample Logs

This document provides example log outputs for each major service to assist with debugging and verification.

---

## 📄 OpenVPN Logs (VM1)

```bash
sudo journalctl -u openvpn@server
```

Example:
```
Initialization Sequence Completed
Peer Connection Initiated with [AF_INET]203.x.x.x:1194
```

---

## 📄 WireGuard Logs (VM1 & VM2)

```bash
sudo wg show
```

Example:
```
peer: abcdef1234567890...
  endpoint: 10.10.0.2:51820
  latest handshake: 1 minute ago
  transfer: 1.5 MiB received, 2.1 MiB sent
```

---

## 📄 dnsmasq Logs (VM1)

```bash
sudo journalctl -u dnsmasq
```

Example:
```
dnsmasq[1234]: query[A] web.mynetwork.local from 10.10.0.2
dnsmasq[1234]: forwarded web.mynetwork.local to 127.0.0.1
```

---

## 📄 Nginx Logs (VM2)

```bash
sudo tail -f /var/log/nginx/access.log
```

Example:
```
10.10.0.1 - - [22/May/2025:10:30:21 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.68.0"
```

---

## 📄 MySQL Logs (VM2)

```bash
sudo tail -f /var/log/mysql/error.log
```

Example:
```
[Note] A temporary password is generated for root@localhost: xxxxxx
[Note] mysqld: ready for connections.
```

---

## 🔥 IPTables Logs (Both VMs, if logging is enabled)

Ensure logging chain exists in iptables:
```bash
iptables -A INPUT -j LOG --log-prefix "IPTables-Dropped: "
```

View logs:
```bash
sudo dmesg | grep IPTables
```

---

Use these logs to validate functionality and troubleshoot issues.
