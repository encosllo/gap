# Lemma 5.6.16 (the two triple-core sources)
#
# Aligned U4(3) source in 3.Suz.2: unique aligned centre, all abelian central
# factors, and the centre-fixed outer type (not L3(4).2_2). Also checks the
# unitary-source facts of Lemma 5.6.11.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL CO1 U43-SOURCE CENTRAL-CORE CHECKS PASSED
# Original file: co1_3cover_u43_completion_certificate.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_16_u43.g
# Complete U4(3)-source certificate for quasisimple L3(4) cores in Co1.
# Run with GAP 4.12.1, AtlasRep 2.1.8, CTblLib 1.3.7, TomLib 1.2.11.
LoadPackage("atlasrep");;
LoadPackage("ctbllib");;
LoadPackage("tomlib");;
PerfectCore:=function(g)
 local h,d;
 h:=g;
 while true do
  d:=DerivedSubgroup(h);
  if Size(d)=Size(h) then return h;fi;
  h:=d;
 od;
end;;
AssertCo1:=function(ok,msg)
 if not ok then Error(msg);fi;
end;;
Ccover:=AtlasGroup("3.Suz.2",IsPermGroup);;
AssertCo1(Ccover<>fail and Size(Ccover)=2690072985600,"3.Suz.2 model");;
Zglobal:=Centre(PerfectCore(Ccover));;
AssertCo1(Size(Zglobal)=3,"global central 3");;
program3:=AtlasProgram("Suz.2",1,"maxes",3);;
Msource:=Group(Concatenation(
 ResultOfStraightLineProgram(program3.program,GeneratorsOfGroup(Ccover)),
 GeneratorsOfGroup(Zglobal)));;
AssertCo1(Size(Msource)=117573120,"full maximal preimage order");;
Ucover:=PerfectCore(Msource);;
ZU:=Centre(Ucover);;
AssertCo1(Size(Ucover)=29393280 and Size(ZU)=9 and
 AbelianInvariants(ZU)=[3,3],"perfect U4(3) preimage");;
pointDomain:=[1..LargestMovedPoint(Ccover)];;
quotU:=ActionHomomorphism(Ucover,List(Orbits(ZU,pointDomain),Set),OnSets);;
Uquot:=Image(quotU);;
AssertCo1(Size(Uquot)=3265920 and Size(Kernel(quotU))=9,"U4(3) quotient");;
tomU:=TableOfMarks("U4(3)");;
AssertCo1(Length(OrdersTom(tomU))=381,"complete U4(3) table of marks");;
tomIso:=IsomorphismGroups(UnderlyingGroup(tomU),Uquot);;
AssertCo1(tomIso<>fail,"explicit table of marks isomorphism");;
Tmodel:=PSL(3,4);;
Tclasses:=Filtered([1..Length(OrdersTom(tomU))],i->
 OrdersTom(tomU)[i]=20160 and
 IsomorphismGroups(RepresentativeTom(tomU,i),Tmodel)<>fail);;
AssertCo1(Tclasses=[376,377],"all L3(4) subgroup classes in U4(3)");;
Print("complete U4(3) T classes ",Tclasses,"\n");
cores:=[];;
for index in Tclasses do
 Tsub:=Image(tomIso,RepresentativeTom(tomU,index));;
 fullT:=PreImage(quotU,Tsub);;
 Lcore:=PerfectCore(fullT);;
 AssertCo1(Size(fullT)=181440 and Size(Lcore)=60480 and
  Size(Centre(Lcore))=3,"perfect preimage of T");;
 aligned:=Centre(Lcore)=Zglobal;;
 Print("T class ",index,": preimage ",Size(fullT),
  ", perfect core ",Size(Lcore),", aligned centre=",aligned,"\n");
 Add(cores,[index,Lcore,aligned]);;
od;
AssertCo1(Number(cores,r->r[3])=1,"one aligned and one unaligned T class");;
Lcore:=First(cores,r->r[3])[2];;
Ccore:=Centralizer(Ccover,Lcore);;
Ncore:=Normalizer(Ccover,Lcore);;
AssertCo1(Size(Ccore)=36 and
 IsomorphismGroups(Ccore,DirectProduct(CyclicGroup(3),AlternatingGroup(4)))<>fail,
 "full core centralizer C3 x A4");;
AssertCo1(Size(Ncore)=2903040,"full core normalizer");;
Print("aligned core: N=",Size(Ncore),", C=",Size(Ccore),
 ", automizer=",Index(Ncore,Ccore),"\n");
centralClasses:=ConjugacyClassesSubgroups(Ccore);;
AssertCo1(Length(centralClasses)=14,"centralizer subgroup classes");;
ordersA:=[];;
for cl in centralClasses do
 B:=Representative(cl);;
 if IsAbelian(B) then
  H:=ClosureGroup(Lcore,B);;
  NH:=Normalizer(Ncore,H);;
  CH:=Centralizer(NH,H);;
  aorder:=Index(NH,CH);;
  AssertCo1(aorder in [80640,241920],"unexpected central product automizer");;
  Add(ordersA,aorder);;
  Print("central product ",[Size(B),Size(H),Size(NH),Size(CH),aorder],"\n");
 fi;
od;
AssertCo1(Collected(ordersA)=[[80640,8],[241920,2]],"all abelian central factors");;
Nfix:=Centralizer(Ncore,Centre(Lcore));;
Afix:=FactorGroup(Nfix,Ccore);;
AssertCo1(Size(Afix)=40320,"centre-fixed automizer order");;
tabFix:=CharacterTable(Afix);;
for typ in ["L3(4).2_1","L3(4).2_2","L3(4).2_3"] do
 match:=TransformingPermutationsCharacterTables(tabFix,CharacterTable(typ))<>fail;;
 Print("centre-fixed outer type ",typ,": ",match,"\n");
 AssertCo1(match=(typ="L3(4).2_1"),"centre-fixed outer type identification");;
od;
Print("ALL CO1 U43-SOURCE CENTRAL-CORE CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
