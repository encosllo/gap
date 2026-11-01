# Proposition 5.7.9 (mixed realizers with nonabelian normal Sylow 3-subgroup)
#
# Coverage audit: the processed indices are exactly the 6278 retained ones,
# 84 = 29 + 55 disjointly, and the totals 336 and 22.
#
# Input: work/fi22_mixed_nonabel_allparents.ws (see run_checks.sh for the script that writes it).
# Expected: the recorded output (GAP 4.12.1) ends with
#   STRICT NONABEL MIXED COVERAGE AUDIT PASSED
# Original file: fi22_nonabel_mixed_coverage_audit.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_mixed_nonabel_allparents.ws gap/lib.g gap/proposition_5_7_9_coverage.g
if hitMix or countParentsMix<>6278 or Length(allRowsMix)<>6278 then Error("incomplete or positive parent scan");fi;
if Set(List(allRowsMix,r->r[1]))<>Set(keptMix) then Error("eligible-index coverage mismatch");fi;
if Length(Set(List(allRowsMix,r->r[1])))<>Length(allRowsMix) then Error("duplicate processed indices");fi;
positiveIdx:=Set(List(Filtered(allRowsMix,r->r[8]),r->r[1]));;
repIdx:=Set(List(familiesMix,f->f.idx));;fusedIdx:=Set(List(fusionMix,f->f[1]));;
if Intersection(repIdx,fusedIdx)<>[] or Union(repIdx,fusedIdx)<>positiveIdx then Error("global family/fusion partition mismatch");fi;
if Length(fusedIdx)<>Length(fusionMix) then Error("duplicate fusion source");fi;
if not ForAll(fusionMix,f->f[2] in repIdx) then Error("fusion target not a representative");fi;
if not ForAll(familiesMix,f->IsBound(f.checks) and IsBound(f.hits) and IsBound(f.extrows)) then Error("unfinished global family");fi;
if Sum(List(familiesMix,f->f.checks))<>countExtMix or Sum(List(familiesMix,f->f.hits))<>countOrderMix then Error("extension totals mismatch");fi;
if not ForAll(familiesMix,f->Length(f.extrows)=f.hits) then Error("order-hit record mismatch");fi;
Print("parents ",Length(allRowsMix)," exactly cover eligible indices; Q8-positive ",Length(positiveIdx)," = family reps ",Length(repIdx)," + actual-conjugacy fusions ",Length(fusedIdx),"\n");
Print("all ",Length(familiesMix)," families complete; extension checks ",countExtMix,"; order1296 hits ",countOrderMix,"; target ",hitMix,"\n");
Print("STRICT NONABEL MIXED COVERAGE AUDIT PASSED\n");
Print("FINAL\n");
QUIT;
