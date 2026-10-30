#!/bin/bash
# Reproduces logs/theorems_*, logs/question_5_3_* and logs/example_* (orders up to 200 and Examples 5.1 and 5.2), in 4 parallel processes (about 70 minutes on a MacBook Air M2). Usage: ./run_checks.sh
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
  gap -q -c "$args" gap/lib.g "gap/$script.g" < /dev/null 2>&1 | tr -d '\r' > "logs/$name.log"
  echo "$(date '+%F %T') end   $name"
  printf '%-40s %4d min %2d s\n' "$name.log" $(( ($(date +%s) - s) / 60 )) $(( ($(date +%s) - s) % 60 )) >> "$INFO"
}
export -f run_job
xargs -P 4 -I{} bash -c 'run_job "$@"' _ {} <<JOBS
nmin:=192;; nmax:=192;; part:=1;; nparts:=2;;|question_5_3|question_5_3_192_part1of2
nmin:=192;; nmax:=192;; part:=2;; nparts:=2;;|question_5_3|question_5_3_192_part2of2
nmin:=192;; nmax:=192;; part:=1;; nparts:=2;;|theorems|theorems_192_part1of2
nmin:=192;; nmax:=192;; part:=2;; nparts:=2;;|theorems|theorems_192_part2of2
nmin:=1;; nmax:=191;;|theorems|theorems_1-191
nmin:=193;; nmax:=200;;|theorems|theorems_193-200
nmin:=1;; nmax:=191;;|question_5_3|question_5_3_1-191
nmin:=193;; nmax:=200;;|question_5_3|question_5_3_193-200
|example_5_1|example_5_1
|example_5_2|example_5_2
|example_5_2_check|example_5_2_check
JOBS
echo "Finished $(date '+%F %T %Z'), total $(( ($(date +%s) - start) / 60 )) min" >> "$INFO"
