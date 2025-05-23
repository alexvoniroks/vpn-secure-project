# 🛡️ Secure VPN Infrastructure Project

This project demonstrates a secure and isolated network infrastructure using:

- 🔐 **OpenVPN** and **WireGuard** for secure remote access (VM1)
- 🌐 **Nginx** and **MySQL** for web and database services (VM2)
- 📡 **dnsmasq** for internal DNS resolution
- 🔥 Strict **IPTables** firewall rules
- 🛠️ Configured for client access only through VPN and tunnels

## 🗂️ Project Structure

```
vpn-secure-project/
├── vm1-openvpn-wireguard/
│   ├── openvpn/
│   ├── wireguard/
│   ├── iptables/
│   └── dnsmasq/
├── vm2-web-db/
│   ├── nginx/
│   ├── mysql/
│   └── iptables/
├── diagrams/
├── docs/
└── README.md
```

## 🚀 Key Features

- **Zero Trust**: No public services — VPN is required to access any internal resource.
- **Layered VPN**: OpenVPN for remote access, WireGuard tunnel for VM-to-VM communication.
- **Custom DNS**: DNS traffic is strictly internal and encrypted.
- **Hard Firewalls**: IPTables allows only essential traffic between interfaces.
- **Self-Contained**: Easy to replicate in lab or homelab via Proxmox VMs.

## 📖 Documentation

- 📘 [Setup Guide](docs/setup.md)
- ✅ [Verification Steps](docs/verification.md)
- 📊 [Sample Logs](docs/logs.md)

## 🧪 Technologies Used

- Ubuntu Server
- OpenVPN
- WireGuard
- IPTables
- dnsmasq
- Nginx
- MySQL

## 📝 License

This project is licensed under the MIT License.
