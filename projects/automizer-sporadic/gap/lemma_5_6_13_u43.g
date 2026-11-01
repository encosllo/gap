# Lemma 5.6.13 (the Co2 sources)
#
# Co2 source U4(3).D8 (TOM classes 376, 377, fused by the D8): full Co1
# centralizer 1 and normalizer 241920.
#
# Input: work/co1_co2_standard.ws (see run_checks.sh for the script that writes it).
# Writes: work/co1_co2_u43_socle.ws, work/co1_co2_u43_t_before_global.ws, work/co1_co2_u43_t_after_centralizer.ws, work/co1_co2_u43_t_global.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL ACTUAL CO2 U43-SOURCE L34 CHECKS PASSED
# Original file: co1_co2_u43_l34_actual.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_co2_standard.ws gap/lib.g gap/lemma_5_6_13_u43.g
LoadPackage("atlasrep");;LoadPackage("tomlib");;
pU:=AtlasProgram("Co2","maxes",7);;
uMax:=Group(ResultOfStraightLineProgram(pU.program,co2StdGens));;
Print("actualCo2 U43.D8 maxorder=",Size(uMax),"\n");
if Size(uMax)<>26127360 then Error("wrongU43max");fi;
uSoc:=uMax;;
while true do
 ud:=DerivedSubgroup(uSoc);;
 if Size(ud)=Size(uSoc) then break;fi;
 uSoc:=ud;;
od;
Print("actualU43 socleorder=",Size(uSoc),"\n");
if Size(uSoc)<>3265920 then Error("wrongU43socle");fi;
SaveWorkspace("work/co1_co2_u43_socle.ws");;
# No U43 black-box finder is shipped by this AtlasRep version.
# Use exactly the checked ATLAS standard-generator definition.
repeat
 uRand:=Random(uSoc);;
until Order(uRand) mod 2=0;
uA0:=uRand^(Order(uRand)/2);;
repeat
 uB0:=Random(uSoc);;
 if Order(uB0)=6 then
  uBcen:=Size(Centralizer(uSoc,uB0));;
 else uBcen:=0;fi;
until uBcen=72;
Print("manualU43 b6 centralizer=",uBcen,"\n");
repeat
 uaa:=uA0^Random(uSoc);;ubb:=uB0^Random(uSoc);;
until Order(uaa*ubb)=7 and Order((uaa*ubb)^3*(ubb*uaa)^2*ubb^2)=5;
uStd:=rec(stdgens:=[uaa,ubb]);;
Print("manualU43 checkedstandard orders=",[Order(uaa),Order(ubb),Order(uaa*ubb),Order((uaa*ubb)^3*(ubb*uaa)^2*ubb^2)],"\n");
uTom:=TableOfMarks("U4(3)");;uTomGroup:=UnderlyingGroup(uTom);;
if not StandardGeneratorsInfo(uTom)[1].ATLAS then Error("nonstandardTom");fi;
uMap:=GroupHomomorphismByImages(uTomGroup,uSoc,GeneratorsOfGroup(uTomGroup),uStd.stdgens);;
if uMap=fail or Size(Image(uMap))<>3265920 then Error("U43TOMtransportfailed");fi;
uTindices:=Filtered([1..Length(OrdersTom(uTom))],i->OrdersTom(uTom)[i]=20160 and IsSimpleGroup(RepresentativeTom(uTom,i)) and IsomorphismGroups(RepresentativeTom(uTom,i),PSL(3,4))<>fail);;
Print("allU43 Tclasses=",uTindices,"\n");
if Length(uTindices)<>2 then Error("wrongTclasscount");fi;
uT:=Image(uMap,RepresentativeTom(uTom,uTindices[1]));;
nuLocal:=Normalizer(uMax,uT);;cuLocal:=Centralizer(uMax,uT);;
Print("local max N,C=",[Size(nuLocal),Size(cuLocal)]," U43conjugacy-class orbit=",Index(uMax,uSoc)/(Size(nuLocal)/20160),"\n");
if Size(nuLocal)<>80640 or Size(cuLocal)<>1 then Error("unexpectedlocalfusion");fi;
# N_U43(T)=T by the complete U43 TOM.  The displayed orbit length2
# fuses both classes in uMax; one global computation therefore exhausts them.
SaveWorkspace("work/co1_co2_u43_t_before_global.ws");;
cuGlobal:=Centralizer(co1G,uT);;
Print("GLOBAL Co1 U43-source Tcentralizer=",Size(cuGlobal),"\n");
SaveWorkspace("work/co1_co2_u43_t_after_centralizer.ws");;
nuGlobal:=Normalizer(co1G,uT);;
Print("GLOBAL Co1 U43-source Tnormalizer=",Size(nuGlobal)," automizer=",Size(nuGlobal)/Size(cuGlobal),"\n");
if Size(cuGlobal)<>1 or Size(nuGlobal)<>241920 then Error("unexpectedglobalcore");fi;
SaveWorkspace("work/co1_co2_u43_t_global.ws");;
Print("ALL ACTUAL CO2 U43-SOURCE L34 CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
