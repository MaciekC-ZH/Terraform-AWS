#!/bin/bash
set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Nie podano sciezki"
  exit 1
fi
if [ ! -d "$1" ]; then
  echo "Podana sciezka nie jest katalogiem"
  exit 2
fi
DIR_PATH=$1

LICZBA=$(find "$DIR_PATH" -type f | wc -l)
echo "Liczba znalezionych plików: $LICZBA"

if [ $LICZBA -gt 5 ];then
  echo "Wykryto za duzo plików. Usuwanie ..."
  find "$DIR_PATH" -type f -delete
  echo "Katalog został wyczyszczony"
else
  echo "Katalog miesci się w normie, brak akcji"
fi
