# ✅ Secure VPN Project – Verification Guide

This guide outlines how to verify the correct operation of your Secure VPN Infrastructure across both VMs.

---

## 🔌 1. Verify OpenVPN Client Connection (VM1)

### On the client:
- Import and connect using your `.ovpn` file.
- Check connection status:
```bash
ifconfig
ping 10.8.0.1  # Replace with VPN server IP
```

### On VM1:
- Verify connection logs:
```bash
sudo journalctl -u openvpn@server
```
- Confirm tunnel is active:
```bash
ip a show tun0
```

---

## 🔐 2. Verify WireGuard Tunnel Between VM1 and VM2

### On VM1:
```bash
sudo wg show
ping 10.10.0.2  # Replace with VM2 WireGuard IP
```

### On VM2:
```bash
sudo wg show
ping 10.10.0.1  # Replace with VM1 WireGuard IP
```

---

## 🌐 3. Verify Web Server Access (via VPN tunnel)

### From client Mobile Phone(via OpenVPN):
```bash
curl http://10.10.0.2  # Replace with VM2 internal IP
```

You should see the default Nginx welcome page or your hosted site.

---

## 🧬 4. Verify MySQL Access (via VPN tunnel)

### From VM1 (or a tunneled client):
```bash
mysql -h 10.10.0.2 -u root -p
```

Check database and user tables.

---

## 📡 5. Verify DNS Resolution (dnsmasq)

### On client or VM1:
```bash
dig @10.10.0.2 web.mynetwork.local
```

Should return internal IPs defined in `dnsmasq.conf`.

---

## 🔥 6. Verify IPTables Rules

On both VMs:
```bash
sudo iptables -L -v -n
```

Ensure:
- Only expected ports are open.
- VPN interfaces have appropriate ACCEPT rules.
- No public access to VM2 services.

---

## 📦 Additional Checks

- Confirm `iptables-persistent` service is enabled:
```bash
sudo systemctl status netfilter-persistent
```

- Confirm services start on boot:
```bash
sudo systemctl is-enabled openvpn@server
sudo systemctl is-enabled wg-quick@wg0
```

✅ If all above pass, your secure VPN infrastructure is fully operational!
