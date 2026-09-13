#!/bin/bash
set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Brak argumentu !"
  exit 1
fi

if [ ! -d "$1" ]; then
  echo "Katalog nie istnieje"
  exit 2
fi
DIR_ARG="$1"
WARNING_COUNT=$(grep -rih "warning" "$DIR_ARG"/*.conf 2>/dev/null | wc -l || true)

echo "Znaleziono ostrzezen: $WARNING_COUNT"

if [ $WARNING_COUNT -gt 0 ]; then
  echo "Uwaga! Wymagany przegląd konfiguracji"
else
  echo "Wszystkie konfiguracje są czyste"
fi