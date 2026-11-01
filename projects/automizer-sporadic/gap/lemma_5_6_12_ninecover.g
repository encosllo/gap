# Lemma 5.6.12 (maximal overgroups of a simple L3(4))
#
# The perfect residual of the maximal 3^2.U4(3).D8 has order 29393280 = 9|U4(3)|.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   CO1 U43 MAX PERFECT CORE IS FULL 3^2-COVER CERTIFIED
# Original file: co1_u43_ninecover_identity.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_12_ninecover.g
LoadPackage("ctbllib");;
tm:=CharacterTable("3^2.U4(3).D8");;
if tm=fail then Error("missingCo1max");fi;
pos:=ClassPositionsOfSolvableResiduum(tm);;
ss:=Sum(SizesConjugacyClasses(tm){pos});;
Print("Co1 3^2.U43.D8 perfectresidualorder=",ss," quotientU43ratio=",ss/Size(CharacterTable("U4(3)")),"\n");
if ss<>29393280 then Error("notfullninecover");fi;
Print("CO1 U43 MAX PERFECT CORE IS FULL 3^2-COVER CERTIFIED\n");
Print("FINAL\n");
QUIT;
