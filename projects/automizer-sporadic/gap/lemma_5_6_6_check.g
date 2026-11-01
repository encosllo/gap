# Lemma 5.6.6 (the possible quasisimple L3(4) cores)
#
# Independent check of the class-fusion exclusions for the eight covers of
# L3(4) with 2-part in the centre.
#
# Expected: the output ends with ALL CO1 QUASISIMPLE COVER-FUSION CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_6_check.g
LoadPackage("ctbllib");;
co1Table:=CharacterTable("Co1");;
coverNames:=["2.L3(4)","2^2.L3(4)","4_1.L3(4)","4_2.L3(4)","6.L3(4)","(2^2x3).L3(4)","12_1.L3(4)","12_2.L3(4)"];;
for nm in coverNames do
 ct:=CharacterTable(nm);;Assert(0,ct<>fail);
 fus:=PossibleClassFusions(ct,co1Table,rec(decompose:=false));;
 Assert(0,Length(fus)=0);Print(nm," no possible embedding fusion\n");
od;
tripleTable:=CharacterTable("3.L3(4)");;
tripleFusions:=PossibleClassFusions(tripleTable,co1Table,rec(decompose:=false));;
Assert(0,Length(tripleFusions)=3);
central3:=Filtered(ClassPositionsOfCentre(tripleTable),i->OrdersClassRepresentatives(tripleTable)[i]=3);;
co1central3:=First([1..NrConjugacyClasses(co1Table)],i->OrdersClassRepresentatives(co1Table)[i]=3 and SizesCentralizers(co1Table)[i]=3*448345497600);;
Assert(0,co1central3<>fail and Length(central3)=2);
Assert(0,ForAll(tripleFusions,f->ForAll(central3,i->f[i]=co1central3)));
Print("3.L3(4): all surviving central classes go to Co1 class3A\n");
Print("ALL CO1 QUASISIMPLE COVER-FUSION CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
