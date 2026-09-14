#!/bin/bash
set -euo pipefail

REPORT_FILE="memory_raport.txt"

date > "$REPORT_FILE"
echo "----" >> "$REPORT_FILE"


ps aux --sort=-%mem | tail -n +2 | head -n 3 | awk '{print $2, $4, $11}' | while read -r pid mem cmd; do
    echo "Proces: $cmd | PID: $pid | Zuzycie RAM: $mem%" | tee -a "$REPORT_FILE"
done