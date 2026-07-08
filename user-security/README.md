# User Security — Wekelijkse controle van systeem users

**Vak:** Linux & Windows Server [OBI40a] · Odisee · 2024–2025
**Docent:** Maarten Troost

## Opgave

Elke maandag om 11u15 automatisch controleren of:
1. De lijst van systeem users (UID < 1000) veranderd is
2. Het paswoord van een bestaande systeem user gewijzigd is

Bij verschil: user waarschuwen. Bij geen verschil: geen actie.

## Aanpak

- Bash-script (`check_users.sh`) + cronjob als root
- Vergelijking met `diff` op snapshots van `/etc/shadow` regels
- Broadcast via `wall` naar alle terminals + append naar `alerts.log`
- Baseline-mechanisme: eerste run maakt `oud.txt`, volgende runs vergelijken hiermee

## Cronjob

```
15 11 * * 1 /home/salaheddine-sennouni/check_users.sh
```

Root crontab (`sudo crontab -e`) omdat `/etc/shadow` alleen leesbaar is als root.

## Testscenario's

| Test | Verwacht | Resultaat |
|------|----------|-----------|
| Eerste run | Baseline aangemaakt, geen waarschuwing | ✅ 47 users in baseline |
| Tweede run zonder wijziging | Geen output, geen wall, geen log-update | ✅ Exit code 0 |
| `useradd -r testsys` | Diff `47a48`, wall broadcast, log-entry | ✅ UID 997 gedetecteerd |
| `chpasswd` op testsys | Diff `48c48`, wall broadcast, log-entry | ✅ Hash-wijziging gedetecteerd |

## Omgeving

- Ubuntu 24.04 in VMware VM
- Gebruiker: `salaheddine-sennouni`

## Volledig verslag

Zie [`verslag_check_users.pdf`](verslag_check_users.pdf) voor screenshots en volledige test-output.
