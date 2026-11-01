# Lemma 5.6.8 (the unitary L3(4) subgroups lie in a Siegel parabolic)
#
# Identifies the outer type L3(4).2_2 of the complement normalizers.
#
# Input: work/co1_u6_selected_complements.ws (see run_checks.sh for the script that writes it).
# Expected: the recorded output (GAP 4.12.1) ends with
#   L3(4).2_3 tablematch=false
# Original file: co1_u6_complement_outertype.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_u6_selected_complements.ws gap/lib.g gap/lemma_5_6_8_outer_type.g
LoadPackage("ctbllib");;
un1:=Normalizer(ug,ulcomp[1]);;
Print("localnormalizerorder=",Size(un1),"\n");
uct:=CharacterTable(un1);;
for nm in ["L3(4).2_1","L3(4).2_2","L3(4).2_3"] do
 Print(nm," tablematch=",TransformingPermutationsCharacterTables(uct,CharacterTable(nm))<>fail,"\n");
od;
Assert(0,Size(un1)=40320);
Assert(0,List(["L3(4).2_1","L3(4).2_2","L3(4).2_3"],nm->TransformingPermutationsCharacterTables(uct,CharacterTable(nm))<>fail)=[false,true,false]);
Print("OUTER TYPE L3(4).2_2 ASSERTED\n");
Print("FINAL\n");
QUIT;
