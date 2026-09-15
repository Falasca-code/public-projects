#!/usr/bin/env bash
set -euo pipefail
fail=0
check(){ if "$@" >/dev/null 2>&1; then printf '%-24s OK\n' "$1"; else printf '%-24s FAIL\n' "$1"; fail=1; fi; }
check uname -s
check nproc
check free -m
check df -P .
check docker --version
check docker compose version
[[ -f .env ]] && printf '%-24s OK\n' Environment || { printf '%-24s FAIL (.env missing)\n' Environment; fail=1; }
for name in ZABBIX_URL ZABBIX_TOKEN POSTGRES_PASSWORD FAROL_ADMIN_PASSWORD FAROL_SESSION_SECRET; do
  grep -Eq "^${name}=.+" .env 2>/dev/null || { printf '%-24s FAIL (%s)\n' Secrets "$name"; fail=1; }
done
(( fail == 0 )) || exit 1
printf '\nPREFLIGHT: READY\n'
