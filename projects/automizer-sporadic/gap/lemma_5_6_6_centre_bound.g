# Lemma 5.6.6 (the possible quasisimple L3(4) cores)
#
# The order-7 centralizers 7 x A7 and 7 x L3(2); the largest abelian
# 2-subgroups of their other factors have order 4.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   QUASISIMPLE L34 CENTRAL 2-PART BOUND FOUR CERTIFIED
# Original file: co1_l34_centre_bound.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_6_centre_bound.g
LoadPackage("ctbllib");;
t1:=CharacterTable("Co1");;tm:=CharacterTable("(A7xL2(7)):2");;
fm:=GetFusionMap(tm,t1);;
if fm=fail then Error("missingmaxfusion");fi;
orders7:=Filtered([1..NrConjugacyClasses(t1)],i->OrdersClassRepresentatives(t1)[i]=7);;
Print("Co1order7 centralizers=",List(orders7,i->SizesCentralizers(t1)[i]),"\n");
source7:=Filtered([1..NrConjugacyClasses(tm)],i->OrdersClassRepresentatives(tm)[i]=7);;
for i in source7 do
 Print("max7class ",i," localC=",SizesCentralizers(tm)[i]," globalC=",SizesCentralizers(t1)[fm[i]],"\n");
od;
for sz in [17640,1176] do
 if not ForAny(source7,i->SizesCentralizers(tm)[i]=sz and SizesCentralizers(t1)[fm[i]]=sz) then Error("factorcentralizer notfull");fi;
od;
for small in [AlternatingGroup(7),PSL(3,2)] do
 pp:=SylowSubgroup(small,2);;
 ma:=Maximum(List(Filtered(ConjugacyClassesSubgroups(pp),c->IsAbelian(Representative(c))),c->Size(Representative(c))));;
 Print("factororder=",Size(small)," Sylow2=",StructureDescription(pp)," maxabelian2order=",ma,"\n");
 if ma<>4 then Error("abelianboundfailed");fi;
od;
Print("QUASISIMPLE L34 CENTRAL 2-PART BOUND FOUR CERTIFIED\n");
Print("FINAL\n");
QUIT;
