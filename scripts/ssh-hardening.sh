#!/bin/bash
# SSH Hardening Script — Ubuntu Server
# Pas de SSH-daemon config aan voor verhoogde beveiliging

set -e

SSH_CONFIG="/etc/ssh/sshd_config"
BACKUP="/etc/ssh/sshd_config.bak"

echo "[*] Backup maken van huidige config..."
cp "$SSH_CONFIG" "$BACKUP"

echo "[*] SSH hardening toepassen..."

# Schakel root login uit
sed -i "s/^#*PermitRootLogin.*/PermitRootLogin no/" "$SSH_CONFIG"

# Alleen SSH protocol 2
sed -i "s/^#*Protocol.*/Protocol 2/" "$SSH_CONFIG"

# Wachtwoord-authenticatie uitschakelen (key-only)
sed -i "s/^#*PasswordAuthentication.*/PasswordAuthentication no/" "$SSH_CONFIG"

# Lege wachtwoorden verboden
sed -i "s/^#*PermitEmptyPasswords.*/PermitEmptyPasswords no/" "$SSH_CONFIG"

# X11 forwarding uitschakelen
sed -i "s/^#*X11Forwarding.*/X11Forwarding no/" "$SSH_CONFIG"

# Maximaal aantal login-pogingen
sed -i "s/^#*MaxAuthTries.*/MaxAuthTries 3/" "$SSH_CONFIG"

# Idle timeout: 10 minuten
sed -i "s/^#*ClientAliveInterval.*/ClientAliveInterval 600/" "$SSH_CONFIG"
sed -i "s/^#*ClientAliveCountMax.*/ClientAliveCountMax 0/" "$SSH_CONFIG"

# Alleen specifieke gebruiker toelaten (aanpassen indien nodig)
# echo "AllowUsers salah" >> "$SSH_CONFIG"

echo "[*] SSH-service herstarten..."
systemctl restart sshd

echo "[✓] SSH hardening voltooid. Backup opgeslagen als: $BACKUP"
echo "[!] Zorg dat je SSH-key werkt voordat je je sessie sluit!"

