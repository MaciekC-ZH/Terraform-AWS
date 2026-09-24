#!/bin/bash
set -euo pipefail

docker run -d --name powtorka-web -p 8085:80 nginx:alpine

sleep 2

HTTP_STAUTS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8085)

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "[OK] Kontener działa i zwraca 200"
else
    echo "[BŁĄD]Kod odpowiedzi: $HTTP_STATUS"
    exit 1
fi