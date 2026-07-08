#!/bin/bash
# Huistaakscripting — Linux & Windows Server [OBI40a]
# Salaheddine Sennouni
#
# Gebruik: ./huistaakscripting.sh <werkdirectory> <aantal>
#
# Requirements:
#   1-2. Exact 2 argumenten, anders syntax error + exit 1
#   3-4. Werkdirectory moet bestaan + rwx-rechten hebben, anders exit 1
#   5.   Kopieert ~/.bashrc naar werkdir als copy_bashrc
#   6.   Voegt clear_history() toe (slechts 1 keer, ook bij herhaalde uitvoering)
#   7-8. Zipt alle bestanden in werkdir naar bestanden.tar.gz (excl. het archief zelf)
#   9-10. Maakt unieke submap (datum+tijd+PID) en pakt archief daarin uit

# Req 1+2: controleer of er precies 2 argumenten zijn
if [ "$#" -ne 2 ]; then
    echo "syntax error: huistaakscripting.sh werkdirectory aantal" >&2
    exit 1
fi

WERKDIR="$1"
# $2 (aantal) wordt als argument vereist maar verder niet gebruikt in dit script

# Req 3+4: alle werkdir-checks gecombineerd in 1 conditie
if [ ! -d "$WERKDIR" ] || [ ! -r "$WERKDIR" ] || [ ! -w "$WERKDIR" ] || [ ! -x "$WERKDIR" ]; then
    exit 1
fi

# Req 5: kopieer ~/.bashrc naar werkdir als copy_bashrc
cp "$HOME/.bashrc" "$WERKDIR/copy_bashrc"

# Req 6: voeg functie ALLEEN toe als ze nog niet bestaat
# Brede regex: vangt ook 'function clear_history' en 'clear_history ()' varianten op
if ! grep -Eq '^[[:space:]]*(function[[:space:]]+)?clear_history[[:space:]]*(\(\))?[[:space:]]*\{' "$WERKDIR/copy_bashrc"; then
    cat >> "$WERKDIR/copy_bashrc" << 'EOF'

clear_history() {
    history -c
    history -w
}
EOF
fi

# Req 7+8: zip alle bestanden in werkdir naar bestanden.tar.gz
# --exclude voorkomt dat tar zichzelf mee-inpakt (anders 'file changed' warning)
tar --exclude='./bestanden.tar.gz' -czf "$WERKDIR/bestanden.tar.gz" -C "$WERKDIR" .

# Req 9+10: maak unieke subdir op basis van datum+tijd+PID en pak uit
# $$ (PID van huidig script) zorgt voor extra uniekheid bij snelle herhaling
SUBDIR="$WERKDIR/extracted_$(date +%Y%m%d_%H%M%S)_$$"
mkdir "$SUBDIR"
tar -xzf "$WERKDIR/bestanden.tar.gz" -C "$SUBDIR"
