# Linux Server Administration

> **Schoolproject** — Odisee Campus Brussel · Toegepaste Informatica · Cybersecurity & Network Specialist · 2024–2025

Opzetten en beheren van een Ubuntu Server met focus op beveiliging, automatisering en systeembeheer.

---

## Technologieën

| Domein | Technologie |
|--------|-------------|
| OS | Ubuntu Server (LTS) |
| Beheer op afstand | SSH v2 + hardening |
| Servicebeheer | systemd (units, timers) |
| Automatisering | cron jobs |
| Beveiliging | UFW firewall, SSH key-based auth |
| Gebruikersbeheer | Linux users, groups, sudo |

---

## Inhoud van deze repo

```
scripts/
├── ssh-hardening.sh       # SSH daemon configuratie verharden
├── ufw-setup.sh           # UFW firewall basisregelset
└── backup-cron.sh         # Automatische back-up via cron

configs/
├── sshd_config_hardened   # Voorbeeld van een geharde SSH config
└── systemd/
    ├── backup.service     # systemd service unit voor back-up
    ├── backup.timer       # systemd timer (vervangt cron)
    └── example-monitor.service
```

---

## Scripts

### `ssh-hardening.sh`
Past de SSH daemon config aan: root login uitschakelen, wachtwoordauth uitschakelen (key-only), max 3 loginpogingen, idle timeout na 10 minuten.

### `ufw-setup.sh`
Zet UFW in met een minimale regelset: default deny incoming, default allow outgoing, SSH toegestaan.

### `backup-cron.sh`
Archiveert `/var/www` en `/etc` dagelijks naar `/mnt/backup`, logt de uitvoer en verwijdert back-ups ouder dan 7 dagen. Integreerbaar als cron job of systemd timer.

---

## Badges

![Ubuntu](https://img.shields.io/badge/OS-Ubuntu%20Server-E95420?logo=ubuntu&logoColor=white)
![SSH](https://img.shields.io/badge/Beheer-SSH%20Hardening-informational)
![systemd](https://img.shields.io/badge/Services-systemd-blue)
![UFW](https://img.shields.io/badge/Firewall-UFW-critical)

