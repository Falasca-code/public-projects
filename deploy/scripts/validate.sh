#!/usr/bin/env bash
set -euo pipefail
base="${APP_URL:-http://127.0.0.1}"
check(){ curl -fsS --max-time 10 "$1" >/dev/null && printf '%-24s OK\n' "$2"; }
check "$base" Frontend
check "$base/api/health" Backend
printf '%-24s INFO\n' 'Database/Zabbix'
printf '\nSTATUS: HEALTHY\n'
