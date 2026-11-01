# Lemma 5.6.2 (location of an abelian realizer)
#
# Order filters on the maximal subgroups for automizer order 40320,
# including the 2-adic bounds used in the abelian branch.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   A8.2 order=40320 v2=7
# Original file: co1_l34outer_filters.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_2_filters.g
LoadPackage("ctbllib");;
ko:=40320;;
for nm in ["Co1","Co2","O8+(2)","U6(2)","M24","M23","M22.2","M22","S6(2)"] do
 tt:=CharacterTable(nm);;
 Print("GROUP ",nm,"\n");
 if HasMaxes(tt) then
  for sn in Maxes(tt) do
   ss:=CharacterTable(sn);;
   if ss<>fail and Size(ss) mod ko=0 then
    Print(sn," order=",Size(ss)," v2=",Number(FactorsInt(Size(ss)),x->x=2),"\n");
   fi;
  od;
 else Print("NO MAXES\n");fi;
od;
expected:=[
["Co1",[["Co2",42305421312000],["3.Suz.2",2690072985600],["2^11:M24",501397585920],["Co3",495766656000],["2^(1+8)+.O8+(2)",89181388800],["U6(2).3.2",55180984320],["(A4xG2(4)):2",6038323200],["2^(2+12):(A8xS3)",1981808640],["3^2.U4(3).D8",235146240],["(A5xJ2):2",72576000],["(A6xU3(3)):2",4354560],["A9xS3",1088640],["(A7xL2(7)):2",846720]]],
["Co2",[["U6(2).2",18393661440],["2^10:m22:2",908328960],["McL",898128000],["2^1+8:s6f2",743178240],["HS.2",88704000],["2^1+4+6.a8",41287680],["U4(3).D8",26127360],["M23",10200960]]],
["O8+(2)",[["S6(2)",1451520],["O8+(2)M2",1451520],["O8+(2)M3",1451520],["2^6:A8",1290240],["O8+(2)M5",1290240],["O8+(2)M6",1290240]]],
["U6(2)",[["2^9.L3(4)",10321920],["U4(3).2_2",6531840],["U6(2)M5",6531840],["U6(2)M6",6531840],["S6(2)",1451520],["U6(2)M9",1451520],["U6(2)M10",1451520],["M22",443520],["U6(2)M12",443520],["U6(2)M13",443520],["L3(4).2_1",40320]]],
["M24",[["M23",10200960],["M22.2",887040],["2^4:a8",322560],["L3(4).3.2_2",120960]]],
["M23",[["M22",443520],["L3(4).2_2",40320],["2^4:a7",40320]]],
["M22.2",[["M22",443520],["L3(4).2_2",40320]]],
["M22",[]],
["S6(2)",[["A8.2",40320]]]];;
Assert(0,List(expected,r->[r[1],Filtered(List(Maxes(CharacterTable(r[1])),sn->[sn,Size(CharacterTable(sn))]),x->x[2] mod ko=0)])=expected);
Print("ALL ORDER FILTERS AGREE WITH THE RECORDED LISTS\n");
Print("FINAL\n");
QUIT;
