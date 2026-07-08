# Linux & Windows Server — OBI40a

> **Schoolopdrachten** — Odisee Campus Brussel · Toegepaste Informatica · Cybersecurity & Network Specialist · 2024–2025
> **Docent:** Maarten Troost

Praktische opdrachten uit het vak **Linux & Windows Server**, uitgevoerd op Ubuntu 24.04 Server in VMware. Elke map bevat het script/de configuratie én het bijhorende PDF-verslag met screenshots en testresultaten.

---

## Inhoud

| Map | Opdracht | Skills |
|-----|----------|--------|
| [`user-security/`](user-security/) | Wekelijkse controle van systeem users (UID < 1000) via cronjob + `diff` + `wall` | bash, cron, awk, /etc/shadow monitoring |
| [`scripting/`](scripting/) | Huistaakscripting: 10 requirements — args check, dir-validatie, tar/gzip, unieke subdirs | bash, argumentparsing, tar, grep -E regex, ShellCheck |
| [`ssh/`](ssh/) | SSH op Ubuntu Server: install, service, PuTTY-verbinding, UFW netwerkrestrictie | OpenSSH, systemd, sshd_config drop-in, UFW |

---

## Highlights per opdracht

### `user-security/` — check_users.sh
Baseline-mechanisme: eerste run maakt `oud.txt`, volgende runs vergelijken via `diff`. Bij wijzigingen wordt de user gewaarschuwd via `wall` broadcast + logged in `alerts.log`. Getest met `useradd -r testsys` en `chpasswd` — beide correct gedetecteerd. Cronjob: `15 11 * * 1` in root's crontab.

### `scripting/` — huistaakscripting.sh
10 requirements geïmplementeerd in één script. Highlights: brede `grep -E` regex om varianten van `clear_history()` te vangen, `tar --exclude` tegen "file changed" warnings, `$$` (PID) voor uniekheid van submap-naam. ShellCheck: **0 errors**.

### `ssh/` — SSH + UFW
Troubleshooting-highlight: OpenSSH 9.x heeft `PasswordAuthentication no` als default, waardoor login met wachtwoord standaard geweigerd wordt. Opgelost via drop-in config in `/etc/ssh/sshd_config.d/`. UFW-restrictie getest met een subnet dat niet overeenkomt met de host — verbinding faalt correct, na `ufw reset` opnieuw werkend.

---

## Omgeving

- **VM OS:** Ubuntu 24.04.2 LTS (Noble)
- **Virtualisatie:** VMware Workstation
- **Host OS:** Windows 11
- **SSH-client op host:** PuTTY + OpenSSH for Windows 9.5p2

---

![Ubuntu](https://img.shields.io/badge/OS-Ubuntu%2024.04-E95420?logo=ubuntu&logoColor=white)
![Bash](https://img.shields.io/badge/Scripting-Bash-4EAA25?logo=gnubash&logoColor=white)
![OpenSSH](https://img.shields.io/badge/Service-OpenSSH-informational)
![UFW](https://img.shields.io/badge/Firewall-UFW-critical)
![systemd](https://img.shields.io/badge/Services-systemd-blue)
