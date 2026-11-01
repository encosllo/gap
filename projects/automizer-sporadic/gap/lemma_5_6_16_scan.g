# Lemma 5.6.16 (the two triple-core sources)
#
# Source maximal 9 of Suz.2: C(L) = C3 x A4, |N(L)| = 2903040; the 10 abelian
# central factors give automizers of orders 80640 (8) and 241920 (2).
#
# Input: work/co1_3suz2_local.ws (see run_checks.sh for the script that writes it).
# Writes: work/co1_3l34_local_normalizer.ws, work/co1_3l34_central_product_candidate.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   H central product [ 12, 241920, 2903040, 12, 241920 ] 3L34 CENTRAL PR...
# Original file: co1_3l34_central_products_scan.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_3suz2_local.ws gap/lib.g gap/lemma_5_6_16_scan.g
pp9:=AtlasProgram("Suz.2",1,"maxes",9);;
zzcc:=Centre(DerivedSubgroup(ccas));;
g9:=ResultOfStraightLineProgram(pp9.program,GeneratorsOfGroup(ccas));;
mm9:=Group(Concatenation(g9,GeneratorsOfGroup(zzcc)));;
Print("max9 order ",Size(mm9)," centre3 ",Size(zzcc),"\n");
ll9:=mm9;;
while true do
 dd9:=DerivedSubgroup(ll9);;
 if Size(dd9)=Size(ll9) then break;fi;
 ll9:=dd9;;
od;
Print("perfect L order ",Size(ll9)," centre ",Size(Centre(ll9)),"\n");
cc9:=Centralizer(ccas,ll9);;
Print("L centralizer ",Size(cc9)," ",StructureDescription(cc9),"\n");
SaveWorkspace("work/co1_3l34_local_normalizer.ws");
subsC:=ConjugacyClassesSubgroups(cc9);;
Print("centralizer subgroup classes ",Length(subsC),"\n");
scanidx:=[];;
for cl in subsC do
 b9:=Representative(cl);;
 if IsAbelian(b9) then
  h9:=ClosureGroup(ll9,b9);;
  n9:=Normalizer(mm9,h9);;c9:=Centralizer(n9,h9);;
  Add(scanidx,Index(n9,c9));
  Print("H central product ",[Size(b9),Size(h9),Size(n9),Size(c9),Index(n9,c9)],"\n");
  if Index(n9,c9)=40320 then
   Print("POSSIBLE BASE K via3L34centralproduct\n");
   a9:=FactorGroup(n9,c9);;
   for typ in ["L3(4).2_1","L3(4).2_2","L3(4).2_3"] do
    Print(typ," character matching ",TransformingPermutationsCharacterTables(CharacterTable(a9),CharacterTable(typ))<>fail,"\n");
   od;
   SaveWorkspace("work/co1_3l34_central_product_candidate.ws");
  fi;
 fi;
od;
Print("3L34 CENTRAL PRODUCTS SCAN FINISHED\n");
Assert(0,Size(mm9)=2903040 and Size(ll9)=60480 and Size(Centre(ll9))=3);
Assert(0,Size(cc9)=36 and IdGroup(cc9)=IdGroup(DirectProduct(CyclicGroup(3),AlternatingGroup(4))));
Assert(0,Collected(scanidx)=[[80640,8],[241920,2]]);
Print("ALL TRIPLE-CORE SCAN CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
