#!/bin/bash
# Reproduces logs/search_section_5_*: all orders 201-1000 (Section 5), in 4 parallel processes. Orders with many groups are split by group id (part, nparts) and the others by order (orderpart, norderparts). Order 768 (1,090,235 groups) takes about 4-5 hours per part. Usage: ./run_search_section_5.sh
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
SKIP='skip:=[384,576,640,768,864,896,960];;'
xargs -P 4 -I{} bash -c 'run_job "$@"' _ {} <<JOBS
nmin:=768;; nmax:=768;; part:=1;; nparts:=4;;|search_section_5|search_section_5_768_part1of4
nmin:=768;; nmax:=768;; part:=2;; nparts:=4;;|search_section_5|search_section_5_768_part2of4
nmin:=768;; nmax:=768;; part:=3;; nparts:=4;;|search_section_5|search_section_5_768_part3of4
nmin:=768;; nmax:=768;; part:=4;; nparts:=4;;|search_section_5|search_section_5_768_part4of4
nmin:=201;; nmax:=1000;; orderpart:=1;; norderparts:=4;; $SKIP|search_section_5|search_section_5_201-1000_part1of4
nmin:=201;; nmax:=1000;; orderpart:=2;; norderparts:=4;; $SKIP|search_section_5|search_section_5_201-1000_part2of4
nmin:=201;; nmax:=1000;; orderpart:=3;; norderparts:=4;; $SKIP|search_section_5|search_section_5_201-1000_part3of4
nmin:=201;; nmax:=1000;; orderpart:=4;; norderparts:=4;; $SKIP|search_section_5|search_section_5_201-1000_part4of4
nmin:=384;; nmax:=384;; part:=1;; nparts:=4;;|search_section_5|search_section_5_384_part1of4
nmin:=384;; nmax:=384;; part:=2;; nparts:=4;;|search_section_5|search_section_5_384_part2of4
nmin:=384;; nmax:=384;; part:=3;; nparts:=4;;|search_section_5|search_section_5_384_part3of4
nmin:=384;; nmax:=384;; part:=4;; nparts:=4;;|search_section_5|search_section_5_384_part4of4
nmin:=640;; nmax:=640;; part:=1;; nparts:=4;;|search_section_5|search_section_5_640_part1of4
nmin:=640;; nmax:=640;; part:=2;; nparts:=4;;|search_section_5|search_section_5_640_part2of4
nmin:=640;; nmax:=640;; part:=3;; nparts:=4;;|search_section_5|search_section_5_640_part3of4
nmin:=640;; nmax:=640;; part:=4;; nparts:=4;;|search_section_5|search_section_5_640_part4of4
nmin:=576;; nmax:=576;; part:=1;; nparts:=2;;|search_section_5|search_section_5_576_part1of2
nmin:=576;; nmax:=576;; part:=2;; nparts:=2;;|search_section_5|search_section_5_576_part2of2
nmin:=864;; nmax:=864;; part:=1;; nparts:=2;;|search_section_5|search_section_5_864_part1of2
nmin:=864;; nmax:=864;; part:=2;; nparts:=2;;|search_section_5|search_section_5_864_part2of2
nmin:=960;; nmax:=960;; part:=1;; nparts:=2;;|search_section_5|search_section_5_960_part1of2
nmin:=960;; nmax:=960;; part:=2;; nparts:=2;;|search_section_5|search_section_5_960_part2of2
nmin:=896;; nmax:=896;;|search_section_5|search_section_5_896
JOBS
echo "Finished $(date '+%F %T %Z'), total $(( ($(date +%s) - start) / 60 )) min" >> "$INFO"
