# Lemma 5.6.16 (the two triple-core sources)
#
# The centre-fixed quotient has order 40320 and is L3(4).2_1, not L3(4).2_2.
#
# Input: work/co1_3l34_local_normalizer.ws (see run_checks.sh for the script that writes it).
# Expected: the recorded output (GAP 4.12.1) ends with
#   L3(4).2_3 false
# Original file: co1_3l34_centre_fixed_outer.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_3l34_local_normalizer.ws gap/lib.g gap/lemma_5_6_16_outer.g
cz3:=Centralizer(mm9,Centre(ll9));;
aq3:=FactorGroup(cz3,cc9);;
Print("centre-fixed normalizer autoL order ",Size(aq3),"\n");
for typ in ["L3(4).2_1","L3(4).2_2","L3(4).2_3"] do
 Print(typ," ",TransformingPermutationsCharacterTables(CharacterTable(aq3),CharacterTable(typ))<>fail,"\n");
od;
Assert(0,Size(aq3)=40320);
Assert(0,List(["L3(4).2_1","L3(4).2_2","L3(4).2_3"],typ->TransformingPermutationsCharacterTables(CharacterTable(aq3),CharacterTable(typ))<>fail)=[true,false,false]);
Print("OUTER TYPE L3(4).2_1 ASSERTED\n");
Print("FINAL\n");
QUIT;
