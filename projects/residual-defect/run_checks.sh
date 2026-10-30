#!/bin/bash
# Reproduces all the files in logs/, in 4 parallel processes (about 35 minutes on a MacBook Air M2, mostly Case B of theorem_5_10). Usage: ./run_checks.sh
# Each job is "<GAP assignments>|<script>|<log name>": gap/<script>.g writes logs/<log name>.log.
cd "$(dirname "$0")"
# logs/<this script>.txt records the machine, the software and the duration of each job.
export INFO="logs/$(basename "$0" .sh).txt"
machine_info() {
  if [ "$(uname)" = Darwin ]; then
    echo "Machine: $(system_profiler SPHardwareDataType 2>/dev/null | awk -F': ' '/Model Name/ {m=$2} /Chip|Processor Name/ {c=$2} END {print m ", " c}'), $(sysctl -n hw.ncpu) cores, $(( $(sysctl -n hw.memsize) / 1073741824 )) GB RAM"
    echo "System: macOS $(sw_vers -productVersion) ($(uname -m))"
  else
    echo "Machine: $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | sed 's/^ //'), $(nproc) cores, $(awk '/MemTotal/ {printf "%d", $2/1048576}' /proc/meminfo) GB RAM"
    echo "System: $(uname -sr) ($(uname -m))"
  fi
  gap -q -c 'Print("Software: GAP ", GAPInfo.Version, ", SmallGrp ", InstalledPackageVersion("smallgrp"), "\n"); QUIT;' < /dev/null | tr -d '\r'
}
{ echo "Run of $(basename "$0"), 4 jobs in parallel, started $(date '+%F %T %Z')"; machine_info; echo; } > "$INFO"
start=$(date +%s)
run_job() {
  args="${1%%|*}"; rest="${1#*|}"; script="${rest%%|*}"; name="${rest##*|}"
  echo "$(date '+%F %T') start $name"
  s=$(date +%s)
  gap -q -o 6g -c "$args" gap/lib.g "gap/$script.g" < /dev/null 2>&1 | tr -d '\r' > "logs/$name.log"
  echo "$(date '+%F %T') end   $name"
  printf '%-40s %4d min %2d s\n' "$name.log" $(( ($(date +%s) - s) / 60 )) $(( ($(date +%s) - s) % 60 )) >> "$INFO"
}
export -f run_job
xargs -P 4 -I{} bash -c 'run_job "$@"' _ {} <<JOBS
long:=true;;|theorem_5_10|theorem_5_10
|example_3_11|example_3_11
|section_3|section_3
|sections_4-5|sections_4-5
|theorem_6_1|theorem_6_1
|theorem_7_10|theorem_7_10
|theorem_3_10|theorem_3_10
JOBS
echo "Finished $(date '+%F %T %Z'), total $(( ($(date +%s) - start) / 60 )) min" >> "$INFO"
