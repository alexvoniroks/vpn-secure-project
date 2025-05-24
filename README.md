# 🛡️ Secure VPN Infrastructure Project

This project demonstrates a secure and isolated network infrastructure using:

- 🔐 **OpenVPN** and **WireGuard** for secure remote access (VM1)
- 🌐 **Nginx** and **MySQL** for web and database services (VM2)
- 📡 **dnsmasq** for internal DNS resolution
- 🔥 Strict **IPTables** firewall rules (exported as `rules.v4`)
- 🛠️ Configured for client access only through VPN and tunnels

---

## 🗂️ Project Structure

```
vpn-secure-project/
├── README.md
├── LICENSE
├── .gitignore

├── vm1-openvpn-wireguard/
│   ├── openvpn/                  # OpenVPN server config (VM1)
│   │   └── server.conf
│   ├── wireguard/                # WireGuard server config (VM1)
│   │   └── wg0.conf
│   ├── iptables/                 # IPTables rules export (VM1)
│       └── rules.v4

├── vm2-web-db/
│   ├── nginx/                    # Nginx web server config (VM2)
│   │   └── default.conf
│   ├── mysql/                    # MySQL init or setup script (VM2)
│   │   └── init.sql
│   ├── wireguard/                # WireGuard client config (VM2)
│   │   └── wg0.conf
│   └── iptables/                 # IPTables rules export (VM2)
│   |   └── rules.v4
|   └── dnsmasq/                  # Internal DNS config (VM2)
│       └── dnsmasq.conf

├── diagrams/
│   └── network-diagram.png       # Optional network diagram

└── docs/
    ├── setup.md                  # Full setup instructions
    ├── verification.md           # Verification and testing
    └── logs.md                   # Sample service logs
```

---

## 🚀 Key Features

- **Zero Trust**: No public services — VPN is required to access internal resources.
- **Layered VPN**: OpenVPN for remote clients, WireGuard tunnel between VMs.
- **Custom DNS**: Internal DNS with `dnsmasq` over VPN only.
- **Firewall Hardened**: Strict `iptables` rules with exports included for VM1 and VM2.

---

## 🧪 Technologies Used

- Ubuntu Server 24.04
- OpenVPN
- WireGuard
- IPTables (`rules.v4`)
- dnsmasq
- Nginx
- MySQL

---

## 📝 License

This project is licensed under the MIT License.
