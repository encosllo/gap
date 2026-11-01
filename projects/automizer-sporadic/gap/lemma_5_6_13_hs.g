# Lemma 5.6.13 (the Co2 sources)
#
# Co2 source HS.2 (TOM class 580): full Co1 centralizer 1 and normalizer 241920.
#
# Input: work/co1_co2_standard.ws (see run_checks.sh for the script that writes it).
# Writes: work/co1_co2_hs_l34_actual.ws, work/co1_co2_hs_l34_centralized.ws, work/co1_co2_hs_l34_done.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL CO2 HS-SOURCE CO1 CHECKS PASSED
# Original file: co1_co2_hs_l34_actual.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_co2_standard.ws gap/lib.g gap/lemma_5_6_13_hs.g
LoadPackage("atlasrep");;
LoadPackage("tomlib");;
pr:=AtlasProgram("Co2",1,"maxes",5);;
if pr=fail then Error("missing Co2 HS.2 max program");fi;
hsgens:=ResultOfStraightLineProgram(pr.program,co2StdGens);;
hsExt:=Group(hsgens);;
if Size(hsExt)<>88704000 then Error("wrong HS.2 source");fi;
hsActual:=DerivedSubgroup(hsExt);;
if Size(hsActual)<>44352000 then Error("wrong HS socle");fi;
Print("actual Co2 HS.2/HS orders ",[Size(hsExt),Size(hsActual)],"\n");
hsStd:=StandardGeneratorsData(hsActual,"HS");;
if hsStd=fail then Error("HS standard generators failed");fi;
tomHS:=TableOfMarks("HS");;
if Length(OrdersTom(tomHS))<>589 or StandardGeneratorsInfo(tomHS)[1].ATLAS<>true then Error("HS TOM model");fi;
hsSource:=UnderlyingGroup(tomHS);;
hsMap:=GroupHomomorphismByImages(hsSource,hsActual,GeneratorsOfGroup(hsSource),hsStd.stdgens);;
if hsMap=fail or Size(Image(hsMap))<>44352000 then Error("HS TOM transport");fi;
allT:=Filtered([1..Length(OrdersTom(tomHS))],i->OrdersTom(tomHS)[i]=20160 and IsomorphismGroups(RepresentativeTom(tomHS,i),PSL(3,4))<>fail);;
if allT<>[580] then Error("HS complete T class list");fi;
hsT:=Image(hsMap,RepresentativeTom(tomHS,580));;
if Size(hsT)<>20160 then Error("wrong transported T");fi;
hsLocalN:=Normalizer(hsExt,hsT);;hsLocalC:=Centralizer(hsLocalN,hsT);;
Print("HS.2 T local [N,C,A] ",[Size(hsLocalN),Size(hsLocalC),Size(hsLocalN)/Size(hsLocalC)],"\n");
SaveWorkspace("work/co1_co2_hs_l34_actual.ws");;
hsGlobalC:=Centralizer(co1G,hsT);;
Print("actual Co2 HS-source T global centralizer ",Size(hsGlobalC),"\n");
if Size(hsGlobalC)<>1 then Error("global centralizer not trivial");fi;
SaveWorkspace("work/co1_co2_hs_l34_centralized.ws");;
hsGlobalN:=Normalizer(co1G,hsT);;
Print("actual Co2 HS-source T global normalizer ",Size(hsGlobalN),"\n");
if Size(hsGlobalN)<>241920 then Error("global automizer not full Aut(T)");fi;
SaveWorkspace("work/co1_co2_hs_l34_done.ws");;
Print("ALL CO2 HS-SOURCE CO1 CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
