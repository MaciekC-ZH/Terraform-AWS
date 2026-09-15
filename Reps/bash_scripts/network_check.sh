#!/bin/bash
set -euo pipefail

# Jeśli $1 nie jest podany, ustaw domyślnie 80
PORT="${1:-80}"

# Sposób 1: Sprawdzenie portu - grep -q zwraca 0 (sukces), gdy znajdzie dopasowanie
if ss -tulpn | grep -q ":$PORT "; then
    echo "[OK] Port $PORT jest otwarty i nasłuchuje"
else
    echo "[WARN] Port $PORT jest zamknięty!"
fi

# Krok 2: Pobranie kodu HTTP
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://google.com || true)

if [ "$HTTP_CODE" -eq 200 ]; then
    echo "[OK] Połączenie działa, status 200"
else
    echo "[FAIL] Problem z połączeniem. Status: $HTTP_CODE"
fi