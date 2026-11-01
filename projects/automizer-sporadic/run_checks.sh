#!/bin/bash
# Reproduces all the files in logs/, in 4 parallel processes (about 20 minutes with 2).
# Usage: ./run_checks.sh
# Each job is "<GAP assignments>|<script>|<log name>|<input workspace>": gap/<script>.g writes
# logs/<log name>.log; if <input workspace> is given, GAP starts from work/<input workspace>.ws.
# The jobs run in stages: a stage starts when the previous one has finished, since its jobs
# load workspaces written by earlier stages. Workspaces are written to work/ (not committed).
# NJOBS=<k> ./run_checks.sh runs k jobs in parallel instead of 4 (less memory).
# A job fails if GAP exits with nonzero status (every script asserts its decisive values),
# if its log does not end with FINAL, or if the log has a GAP error; the run then stops
# after the current stage and run_checks.sh exits with status 1.
cd "$(dirname "$0")"
mkdir -p work logs
NJOBS="${NJOBS:-4}"
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
  gap -q -c 'SetPrintFormattingStatus("*stdout*", false); Print("Software: GAP ", GAPInfo.Version, ", SmallGrp ", InstalledPackageVersion("smallgrp"), ", AtlasRep ", InstalledPackageVersion("atlasrep"), ", CTblLib ", InstalledPackageVersion("ctbllib"), ", TomLib ", InstalledPackageVersion("tomlib"), "\n"); QUIT;' < /dev/null | tr -d '\r'
}
{ echo "Run of $(basename "$0"), $NJOBS jobs in parallel, started $(date '+%F %T %Z')"; machine_info; echo; } > "$INFO"
start=$(date +%s)
run_job() {
  IFS='|' read -r args script name input <<< "$1"
  echo "$(date '+%F %T') start $name"
  s=$(date +%s)
  if [ -n "$input" ] && [ ! -f "work/$input.ws" ]; then
    echo "FAILED $name: missing workspace work/$input.ws" | tee -a "$INFO" >&2
    return 1
  fi
  # --quitonbreak: an Error or a failed Assert ends GAP with a nonzero status.
  gap -q --quitonbreak ${input:+-L "work/$input.ws"} -c "$args" gap/lib.g "gap/$script.g" < /dev/null 2>&1 | tr -d '\r' > "logs/$name.log"
  status=${PIPESTATUS[0]}
  echo "$(date '+%F %T') end   $name"
  printf '%-40s %4d min %2d s\n' "$name.log" $(( ($(date +%s) - s) / 60 )) $(( ($(date +%s) - s) % 60 )) >> "$INFO"
  if [ "$status" -ne 0 ] || [ "$(tail -n 1 "logs/$name.log")" != FINAL ] || grep -q '^Error' "logs/$name.log"; then
    echo "FAILED $name: exit status $status, see logs/$name.log" | tee -a "$INFO" >&2
    return 1
  fi
}
export -f run_job
# A stage fails if any of its jobs fails; the run then stops, so that no later
# job loads a workspace written by a failed producer.
run_stage() {
  echo "Stage $1" >> "$INFO"
  if ! xargs -P "$NJOBS" -I{} bash -c 'run_job "$@"' _ {}; then
    echo "Stopped after a failure in stage $1, $(date '+%F %T %Z')" | tee -a "$INFO" >&2
    exit 1
  fi
}
run_stage 1 <<JOBS
|lemma_3_6_2|lemma_3_6_2|
|proposition_3_7_5|proposition_3_7_5|
|theorem_3_8_4|theorem_3_8_4|
|theorem_3_9_3|theorem_3_9_3|
|lemma_4_3_3|lemma_4_3_3|
|proposition_4_8_2|proposition_4_8_2|
|proposition_4_8_3|proposition_4_8_3|
|theorem_4_9_2|theorem_4_9_2|
|section_4_10|section_4_10|
|theorem_5_1_3|theorem_5_1_3|
|theorem_5_1_4|theorem_5_1_4|
|theorem_5_1_5|theorem_5_1_5|
|theorem_5_1_7|theorem_5_1_7|
|theorem_5_2_1|theorem_5_2_1|
|theorem_5_3_3|theorem_5_3_3|
|theorem_5_4_4|theorem_5_4_4|
|theorem_5_4_8|theorem_5_4_8|
|proposition_5_5_1_l43_h1|proposition_5_5_1_l43_h1|
|proposition_5_5_1_o7_h1|proposition_5_5_1_o7_h1|
|proposition_5_5_1_o7_orbits|proposition_5_5_1_o7_orbits|
|theorem_5_5_9|theorem_5_5_9|
|lemma_5_6_1|lemma_5_6_1|
|lemma_5_6_1_check|lemma_5_6_1_check|
|lemma_5_6_2_filters|lemma_5_6_2_filters|
|lemma_5_6_2_modules|lemma_5_6_2_modules|
|lemma_5_6_2_u6_embedding|lemma_5_6_2_u6_embedding|
|lemma_5_6_3|lemma_5_6_3|
|lemma_5_6_4|lemma_5_6_4|
|lemma_5_6_6_centre_bound|lemma_5_6_6_centre_bound|
|lemma_5_6_6_check|lemma_5_6_6_check|
|lemma_5_6_6_class_fusions|lemma_5_6_6_class_fusions|
|lemma_5_6_7|lemma_5_6_7|
|lemma_5_6_8_complements|lemma_5_6_8_complements|
|lemma_5_6_8_f4_modules|lemma_5_6_8_f4_modules|
|lemma_5_6_8_h1|lemma_5_6_8_h1|
|lemma_5_6_9|lemma_5_6_9|
|lemma_5_6_9_incidence|lemma_5_6_9_incidence|
|corollary_5_6_10|corollary_5_6_10|
|lemma_5_6_11|lemma_5_6_11|
|lemma_5_6_12|lemma_5_6_12|
|lemma_5_6_12_ninecover|lemma_5_6_12_ninecover|
|lemma_5_6_13|lemma_5_6_13|
|lemma_5_6_13_golay|lemma_5_6_13_golay|
|lemma_5_6_13_m23|lemma_5_6_13_m23|
|proposition_5_6_14_golay|proposition_5_6_14_golay|
|lemma_5_6_15_suz|lemma_5_6_15_suz|
|lemma_5_6_15_u43|lemma_5_6_15_u43|
|proposition_5_7_1|proposition_5_7_1|
|proposition_5_7_1_target|proposition_5_7_1_target|
|proposition_5_7_3_sylow|proposition_5_7_3_sylow|
|lemma_5_7_5|lemma_5_7_5|
|proposition_5_7_11|proposition_5_7_11|
JOBS
run_stage 2 <<JOBS
|lemma_5_6_8_select|lemma_5_6_8_select|co1_u6_p_complements
|lemma_5_6_13_hs|lemma_5_6_13_hs|co1_co2_standard
|lemma_5_6_13_mcl|lemma_5_6_13_mcl|co1_co2_standard
|lemma_5_6_13_u43|lemma_5_6_13_u43|co1_co2_standard
|proposition_5_6_14_golay_centralizer|proposition_5_6_14_golay_centralizer|co1_l34_22_before_normalizer
|lemma_5_6_15_scan|lemma_5_6_15_scan|co1_3suz2_local
|proposition_5_7_3_automizers|proposition_5_7_3_automizers|fi22_f1296_base_bootstrap
|proposition_5_7_6_lattice|proposition_5_7_6_lattice|fi22_f1296_base_bootstrap
JOBS
run_stage 3 <<JOBS
|lemma_5_6_8_fusion|lemma_5_6_8_fusion|co1_u6_selected_complements
|lemma_5_6_8_outer_type|lemma_5_6_8_outer_type|co1_u6_selected_complements
|proposition_5_6_14_u6_levi|proposition_5_6_14_u6_levi|co1_u6_selected_complements
|proposition_5_6_14_u6_nonzero|proposition_5_6_14_u6_nonzero|co1_u6_selected_complements
|lemma_5_6_15_outer|lemma_5_6_15_outer|co1_3l34_local_normalizer
|proposition_5_7_3|proposition_5_7_3|fi22_base_allabelian3
|proposition_5_7_3_types|proposition_5_7_3_types|fi22_base_allabelian3
|proposition_5_7_6|proposition_5_7_6|fi22_class2_candidate_lattice
|proposition_5_7_7|proposition_5_7_7|fi22_base_allabelian3
|proposition_5_7_9_types|proposition_5_7_9_types|fi22_class2_candidate_lattice
JOBS
run_stage 4 <<JOBS
|proposition_5_7_7_invariants|proposition_5_7_7_invariants|fi22_abelian_parent_twoextensions
|proposition_5_7_7_omitted|proposition_5_7_7_omitted|fi22_abelian_parent_twoextensions
|proposition_5_7_7_omitted_check|proposition_5_7_7_omitted_check|fi22_abelian_parent_twoextensions
|proposition_5_7_9_auts|proposition_5_7_9_auts|fi22_mixed_p3_abstract_types
JOBS
run_stage 5 <<JOBS
|proposition_5_7_9|proposition_5_7_9|fi22_mixed_p3_type_auts
JOBS
run_stage 6 <<JOBS
|proposition_5_7_9_coverage|proposition_5_7_9_coverage|fi22_mixed_nonabel_allparents
|proposition_5_7_9_invariants|proposition_5_7_9_invariants|fi22_mixed_nonabel_allparents
JOBS
echo "Finished $(date '+%F %T %Z'), total $(( ($(date +%s) - start) / 60 )) min; all jobs passed" | tee -a "$INFO"
