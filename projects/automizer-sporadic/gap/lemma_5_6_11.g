# Lemma 5.6.11 (Suzuki sources)
#
# Maximal-subgroup filter of Suz for order 20160: four sources, and no
# simple L3(4) in G2(4) or J2.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL SUZ T-SOURCE MAXIMAL FILTER CHECKS PASSED
# Original file: suz_l34_complete_maxfilter.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_11.g
LoadPackage("ctbllib");;
t:=CharacterTable("Suz");;
if not HasMaxes(t) then Error("missing complete maximal list");fi;
rows:=[];;
for name in Maxes(t) do
 tt:=CharacterTable(name);
 if Size(tt) mod 20160=0 then Add(rows,[name,Size(tt)]);fi;
od;
if Set(rows)<>Set([
 ["G2(4)",251596800],["3_2.U4(3).2_3'",19595520],
 ["J2.2",1209600],["(a4xpsl(3,4)):2",483840]]) then
 Error("unexpected maximal order filter");fi;
Print("Suz full maximal order filter ",rows,"\n");
for name in ["G2(4)","U5(2)","J2"] do
 fs:=PossibleClassFusions(CharacterTable("L3(4)"),CharacterTable(name),rec(decompose:=false));
 if Length(fs)<>0 then Error("unexpected simple T fusion");fi;
 Print("no simple T in ",name,"\n");
od;
Print("ALL SUZ T-SOURCE MAXIMAL FILTER CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
