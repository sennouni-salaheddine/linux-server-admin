#!/bin/bash
# Automatische back-up via cron
# Gebruik: crontab -e  →  0 2 * * * /opt/scripts/backup-cron.sh

DATUM=$(date +%Y-%m-%d)
BRON="/var/www /etc"
DOEL="/mnt/backup"
LOGBESTAND="/var/log/backup.log"

mkdir -p "$DOEL"

echo "[$DATUM] Back-up gestart..." >> "$LOGBESTAND"

for MAP in $BRON; do
  tar -czf "$DOEL/backup_$(basename $MAP)_$DATUM.tar.gz" "$MAP" 2>> "$LOGBESTAND"
  echo "[$DATUM] ✓ $MAP gearchiveerd" >> "$LOGBESTAND"
done

# Oude back-ups verwijderen (ouder dan 7 dagen)
find "$DOEL" -name "*.tar.gz" -mtime +7 -delete
echo "[$DATUM] Oude back-ups opgeruimd (>7 dagen)" >> "$LOGBESTAND"

echo "[$DATUM] Back-up voltooid." >> "$LOGBESTAND"

