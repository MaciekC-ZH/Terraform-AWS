#!/bin/bash
set -euo pipefail

OUTPUT_FILE="disc_summary.txt"
date > "$OUTPUT_FILE"

df -h | tail -n +2 | awk '{print $6, $5, $1}' | while read -r mountpoint usage device; do
    echo "Punkt: $mountpoint | Zuzycie: $usage | Dysk: $device" >> "$OUTPUT_FILE"
done
