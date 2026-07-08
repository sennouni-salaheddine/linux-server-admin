# Linux Server Administration

> **Schoolproject** — Odisee Campus Brussel · Toegepaste Informatica · Cybersecurity & Network Specialist · 2024–2025

Opzetten en beheren van een Linux-serveromgeving met focus op beveiliging, automatisering en systeembeheer.

---

## Technologieën

| Domein | Technologie |
|--------|-------------|
| OS | Ubuntu Server (LTS) |
| Beheer op afstand | SSH v2 + hardening |
| Servicebeheer | systemd (units, targets, timers) |
| Automatisering | cron jobs |
| Beveiliging | UFW firewall, fail2ban, SSH key-based auth |
| Gebruikersbeheer | Linux users, groups, sudo-rechten |

---

## Behandelde onderwerpen

- **SSH hardening**: uitschakelen van root login, password auth uitschakelen, key-only toegang, custom poort
- **systemd**: schrijven van custom service units en timers als alternatief voor cron
- **cron**: automatisering van back-ups en onderhoudsscripts
- **Firewall**: UFW regelset voor minimale aanvalsoppervlak
- **Logging**: systeemlogboeken lezen en monitoren via `journalctl`

---

## Omgeving

- Gevirtualiseerd via VMware ESXi / lokale VM
- Netwerkconfiguratie: statisch IP, DNS, gateway

---

## Badges

![Ubuntu](https://img.shields.io/badge/OS-Ubuntu%20Server-E95420?logo=ubuntu&logoColor=white)
![SSH](https://img.shields.io/badge/Beheer-SSH%20Hardening-informational)
![systemd](https://img.shields.io/badge/Services-systemd-blue)
![Cron](https://img.shields.io/badge/Automatisering-Cron-success)
![UFW](https://img.shields.io/badge/Firewall-UFW-critical)

