# SSH op Ubuntu Server — System Security

**Vak:** Linux & Windows Server [OBI40a] · Odisee · 2024–2025
**Onderwerp:** System Security

## Opgave

| Deel | Wat |
|------|-----|
| a | OpenSSH-server installeren via APT |
| b | Service controleren + poort verifiëren |
| c | SSH-client verifiëren op host (Windows 11) |
| d | SSH-verbinding opzetten via PuTTY |
| e | Netwerkrestrictie via firewall (UFW) — toepassen en verwijderen |

## Omgeving

| Onderdeel | Waarde |
|-----------|--------|
| VM OS | Ubuntu 24.04.2 LTS (Noble) |
| Virtualisatie | VMware Workstation |
| VM IP | 192.168.200.129/24 |
| Host OS | Windows 11 |
| SSH-client | PuTTY + OpenSSH for Windows 9.5p2 |

## Interessant troubleshooting-probleem

**Probleem:** na installatie werkte SSH-login niet met wachtwoord (Access denied).

**Oorzaak:** in OpenSSH 9.x is de standaardwaarde van `PasswordAuthentication` gewijzigd naar `no`. De regel in `/etc/ssh/sshd_config` was uitgecommentarieerd (`#PasswordAuthentication yes`), waardoor de default van kracht was.

**Oplossing:** drop-in configuratiebestand aangemaakt in `/etc/ssh/sshd_config.d/50-password-auth.conf` met expliciete waarde `yes`. Zie [`50-password-auth.conf`](50-password-auth.conf).

```bash
echo 'PasswordAuthentication yes' | sudo tee \
    /etc/ssh/sshd_config.d/50-password-auth.conf
sudo systemctl restart ssh
sudo sshd -T | grep -i passwordauthentication
```

## UFW netwerkrestrictie (deel e)

```bash
# Alleen SSH toestaan vanaf 192.167.0.0/16 (host zit in 192.168.200.0/24 → moet dus falen)
sudo ufw allow from 192.167.0.0/16 to any port 22
sudo ufw deny 22
sudo ufw enable
sudo ufw status numbered

# Verwacht: connection timed out vanaf host

# Restrictie opheffen
sudo ufw disable
sudo ufw reset
```

## Volledig verslag

Zie [`ssh_verslag.pdf`](ssh_verslag.pdf) voor screenshots en volledige uitvoer.
