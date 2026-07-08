#!/bin/bash
# UFW Firewall Setup — Ubuntu Server
# Minimale regelset: alleen SSH en optioneel HTTP/HTTPS

set -e

echo "[*] UFW resetten naar defaults..."
ufw --force reset

echo "[*] Default policies instellen..."
ufw default deny incoming
ufw default allow outgoing

echo "[*] SSH toestaan (poort 22)..."
ufw allow ssh

# Uncomment voor webserver:
# ufw allow http
# ufw allow https

echo "[*] UFW inschakelen..."
ufw --force enable

echo "[✓] Firewallstatus:"
ufw status verbose

