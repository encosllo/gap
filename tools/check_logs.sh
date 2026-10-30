#!/bin/bash
# Checks the logs of the projects given as arguments (all of them by default): every log must end
# with a line FINAL and contain no GAP error. Usage: tools/check_logs.sh [project ...]
cd "$(dirname "$0")/../projects"
[ $# -eq 0 ] && set -- */
status=0
for p in "$@"; do
  p="${p%/}"
  for f in "$p"/logs/*.log; do
    [ -e "$f" ] || { echo "$p: no logs"; status=1; continue; }
    if [ "$(tail -n 1 "$f")" != "FINAL" ]; then echo "$f: does not end with FINAL"; status=1; fi
    if grep -qE '^(Error|Syntax error|brk>)|^#I  .*exceeded' "$f"; then echo "$f: GAP error"; status=1; fi
  done
  echo "$p: $(ls "$p"/logs/*.log 2>/dev/null | wc -l | tr -d ' ') logs checked"
done
exit $status
