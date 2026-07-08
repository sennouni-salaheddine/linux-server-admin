# Scripting Assignment — huistaakscripting.sh

**Vak:** Linux & Windows Server [OBI40a] · Odisee · 2024–2025
**Docent:** Maarten Troost

## Opgave (10 requirements)

| Req | Wat | Implementatie |
|-----|-----|---------------|
| 1-2 | Exact 2 argumenten, anders `syntax error` + exit 1 | `[ "$#" -ne 2 ]` |
| 3-4 | Werkdirectory moet bestaan + rwx-rechten, anders exit 1 | Combined check met `\|\|` |
| 5 | Kopieer `~/.bashrc` naar werkdir als `copy_bashrc` | `cp "$HOME/.bashrc" ...` |
| 6 | Functie `clear_history()` toevoegen — slechts 1 keer | `grep -Eq` met brede regex |
| 7-8 | Alle bestanden in werkdir → `bestanden.tar.gz` | `tar --exclude=` |
| 9-10 | Unieke submap (datum+tijd+PID) met uitgepakt archief | `date +%Y%m%d_%H%M%S`_`$$` |

## Kernpunten

- **Geen foutmelding bij werkdir-fout** — enkel exit code 1 (zoals gevraagd)
- **Grep-regex vangt varianten op**: `function clear_history`, `clear_history ()`, met/zonder spaties
- **`--exclude` op tar** voorkomt "file changed as we read it" waarschuwing
- **`$$` (PID)** garandeert uniekheid van submap ook bij snelle herhaalde uitvoering

## Kwaliteit

- ShellCheck: **0 errors** (na fix van SC2034)
- Peer review: extra suggesties toegepast (bredere grep, --exclude, _$$)

## Volledig verslag

Zie [`scriptingverslag.pdf`](scriptingverslag.pdf) voor testresultaten per requirement met screenshots.
