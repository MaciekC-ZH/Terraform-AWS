#!/bin/bash
set -euo pipefail

# 1. Sprawdzenie, czy podano argument ($1)
# -z oznacza "czy ciąg znaków jest pusty"
if [ -z "${1:-}" ]; then
  echo "Błąd: Nie podano ścieżki do katalogu!"
  echo "Użycie: $0 <sciezka_do_katalogu>"
  exit 1
fi

LOG_DIR="$1"

# 2. Sprawdzenie, czy podany katalog fizycznie istnieje
# ! -d oznacza "jeśli NIE jest katalogiem"
if [ ! -d "$LOG_DIR" ]; then
  echo "Błąd: Katalog '$LOG_DIR' nie istnieje!"
  exit 2
fi

# 3. Zliczanie błędów (szukamy frazy 'error' bez względu na wielkość liter)
# $(...) wykonuje polecenie w podpowłoce i przypisuje wynik do zmiennej
# Flaga -r szuka rekursywnie, -i ignoruje wielkość liter, -h nie wypisuje nazw plików
ERROR_COUNT=$(grep -rih "error" "$LOG_DIR"/*.log 2>/dev/null | wc -l || true)

echo "Liczba bledow ERROR: $ERROR_COUNT"

# 4. Warunek i archiwizacja
if [ "$ERROR_COUNT" -gt 0 ]; then
  DATA=$(date +%F)
  ARCHIWUM="logs_backup_${DATA}.tar.gz"

  # Tworzymy archiwum ze znalezionych plików .log
  tar -czf "$ARCHIWUM" -C "$LOG_DIR" $(cd "$LOG_DIR" && ls *.log)

  echo "Kopia zapasowa zostala utworzona: $ARCHIWUM"
else
  echo "Brak bledow, pomijam tworzenie kopii."
fi