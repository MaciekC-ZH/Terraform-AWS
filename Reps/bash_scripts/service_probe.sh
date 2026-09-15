#!/bin/bash
set -euo pipefail

PORT="${1:-22}"

if ss -tulpn | grep -q ":$PORT "; then
    echo "[OK] PORT $PORT nasłuchuje"
else
    echo "[BRAK] Nic nie nasłuchuje na porcie $PORT"
fi

STATUS=$(curl -s -L -o /dev/null -w "%{http_code}" https://api.github.com || true)

if [ "$STATUS" -eq 200 ]; then
    echo "[OK] GitHub API odpowiada"
else
    echo "[FAIL] Błąd połączenia, kod: $STATUS"
fi