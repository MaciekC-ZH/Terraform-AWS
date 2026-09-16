#!/bin/bash
set -euo pipefail

THRESHOLD="${1:-80}"

CURRENT_USAGE=$(df / | tail -n 1 | awk '{print $5}' | tr -d '%')
echo "Aktualne zużycie dysku: $CURRENT_USAGE% (Próg: $THRESHOLD%)"

if [ $CURRENT_USAGE -gt $THRESHOLD ]; then
    echo "[ALARM] Dysk jest zapełniony powyżej limitu!"
else
    echo "[Ok] Zuzycie dysku w normie."
fi