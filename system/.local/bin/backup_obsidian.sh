#!/usr/bin/env bash
set -euo pipefail

VAULT="$HOME/vault"
DEST="/run/media/joshua/jspir"
GPG_KEY="44CB980DF60F1B8DA83BCEE950C74ED9F4D1B458"
FILENAME="vault-$(date +%Y-%m-%d).tar.gz.gpg"
OUTFILE="$DEST/$FILENAME"

if [[ ! -d "$DEST" ]]; then
    echo "Error: $DEST not mounted" >&2
    exit 1
fi

echo "Creating encrypted backup -> $OUTFILE"

tar -czf - \
    -C "$(dirname "$VAULT")" "$(basename "$VAULT")" \
    | gpg --encrypt --recipient "$GPG_KEY" --output "$OUTFILE"

echo "Done: $(du -h "$OUTFILE" | cut -f1)"
