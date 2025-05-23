📊 Secure VPN Project – Sample Logs

This document provides example log outputs for each major service to assist with debugging and verification.

---

## 📄 OpenVPN Logs (VM1)

```bash
sudo journalctl -u openvpn@server

Example:

Initialization Sequence Completed
Peer Connection Initiated with [AF_INET]203.0.113.10:1194

📄 WireGuard Logs (VM1 & VM2)

sudo wg show

Example:

peer: abcdef1234567890...
  endpoint: 10.9.0.2:51820
  latest handshake: 1 minute ago
  transfer: 1.5 MiB received, 2.1 MiB sent

📄 dnsmasq Logs (VM1)

sudo journalctl -u dnsmasq

Example:

dnsmasq[1234]: query[A] example.local from 10.8.0.10
dnsmasq[1234]: forwarded example.local to 127.0.0.1

📄 Nginx Logs (VM2)

sudo tail -f /var/log/nginx/access.log

Example:

10.9.0.1 - - [22/May/2025:10:30:21 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.68.0"

📄 MySQL Logs (VM2)

sudo tail -f /var/log/mysql/error.log

Example:

[Note] A temporary password is generated for root@localhost: xxxxxx
[Note] mysqld: ready for connections.

🔥 IPTables Logs (Both VMs, if logging is enabled)

Ensure logging chain exists in iptables:

iptables -A INPUT -j LOG --log-prefix "IPTables-Dropped: "

Then view logs:

sudo dmesg | grep IPTables


