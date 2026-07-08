#!/bin/bash
# Wekelijkse controle van systeem users (UID < 1000)
# Salaheddine Sennouni - Linux & Windows Server [OBI40a]
#
# Doel: elke maandag om 11u15 detecteren of:
#   1) er systeem users zijn toegevoegd/verwijderd
#   2) het paswoord van een bestaande systeem user gewijzigd is
# Bij verschil: broadcast via wall + log naar alerts.log
# Bij geen verschil: geen output, geen actie
#
# Cronjob: 15 11 * * 1 /home/salaheddine-sennouni/check_users.sh

# 1) Maak lijst van alle systeem users en hun shadow regel
awk -F: '$3 < 1000 {print $1}' /etc/passwd > users.txt

> nieuw.txt
while read u; do
    grep "^$u:" /etc/shadow >> nieuw.txt
done < users.txt

# 2) Eerste keer? Maak baseline en stop
if [ ! -f oud.txt ]; then
    cp nieuw.txt oud.txt
    echo "Baseline aangemaakt op $(date)" > alerts.log
    exit 0
fi

# 3) Vergelijk oud met nieuw via diff
if diff oud.txt nieuw.txt > /dev/null; then
    # Geen verschil = geen waarschuwing
    exit 0
else
    # Wel verschil = waarschuw user
    echo "===============================================" >> alerts.log
    echo "WAARSCHUWING: systeem users gewijzigd!" >> alerts.log
    echo "Tijdstip: $(date)" >> alerts.log
    echo "Verschillen:" >> alerts.log
    diff oud.txt nieuw.txt >> alerts.log
    echo "===============================================" >> alerts.log

    wall < alerts.log

    # Update baseline
    cp nieuw.txt oud.txt
fi
