# Lemma 5.6.8 (the unitary L3(4) subgroups lie in a Siegel parabolic)
#
# Orders the four complements by their local normalizer orders (index 1: a
# nonzero class, index 2: the Levi class), independently of the order
# returned by ComplementClassesRepresentatives.
#
# Input: work/co1_u6_p_complements.ws (see run_checks.sh for the script that writes it).
# Writes: work/co1_u6_selected_complements.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   INTRINSIC U6 COMPLEMENT SELECTION PASSED
# Original file: co1_u6_select_intrinsic.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_u6_p_complements.ws gap/lib.g gap/lemma_5_6_8_select.g
# The zero cocycle is selected by its intrinsic local normalizer order,
# not by the order in which ComplementClassesRepresentatives returns it.
ulorders:=List(ulcomp,t->Size(Normalizer(ug,t)));;
leviIndex:=Filtered([1..Length(ulcomp)],i->ulorders[i]=241920);;
nonzeroIndices:=Filtered([1..Length(ulcomp)],i->ulorders[i]=40320);;
if Length(leviIndex)<>1 or Length(nonzeroIndices)<>3 then Error("wrongcomplementtypes");fi;
ulcomp:=ulcomp{Concatenation([nonzeroIndices[1],leviIndex[1]],nonzeroIndices{[2,3]})};;
Print("intrinsic selected localorders=",List(ulcomp,t->Size(Normalizer(ug,t))),"\n");
SaveWorkspace("work/co1_u6_selected_complements.ws");;
Print("INTRINSIC U6 COMPLEMENT SELECTION PASSED\n");
Print("FINAL\n");
QUIT;
