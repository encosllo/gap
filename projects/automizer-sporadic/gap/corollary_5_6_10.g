# Corollary 5.6.10 (automizers in Co1 of the two Co3 classes)
#
# Both Co3 classes of L3(4), transported into the degree-98280 Co1: full
# centralizer 1 and full normalizer of order 241920.
#
# Writes: work/co1_co3_actual_tclasses.ws, work/co1_co3_actual_tclasses_done.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL CO3-SOURCE CO1 CHECKS PASSED
# Original file: co1_co3_l34_global.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/corollary_5_6_10.g
LoadPackage("atlasrep");;LoadPackage("tomlib");;
Read("gap/data/co1_p98280b0.g1");;ca:=a11;;Read("gap/data/co1_p98280b0.g2");;cb:=a21;;
co1G:=Group(ca,cb);;
cx:=(ca*cb)^20;;cy:=(ca*cb^2)^-3*(ca*cb*ca*cb*ca*cb^2*ca*cb^2)^5*(ca*cb^2)^3;;
co3Actual:=Group(cx,cy);;
Print("actual Co3 size ",Size(co3Actual),"\n");Assert(0,Size(co3Actual)=495766656000);
co3Std:=StandardGeneratorsData(co3Actual,"Co3");;
Assert(0,co3Std<>fail);Print("Co3 standard generators found\n");
co3Tom:=TableOfMarks("Co3");;co3TomGroup:=UnderlyingGroup(co3Tom);;
Assert(0,StandardGeneratorsInfo(co3Tom)[1].ATLAS=true);
co3Map:=GroupHomomorphismByImages(co3TomGroup,co3Actual,GeneratorsOfGroup(co3TomGroup),co3Std.stdgens);;
Assert(0,co3Map<>fail and Size(Image(co3Map))=Size(co3Actual));
co3T1:=Image(co3Map,RepresentativeTom(co3Tom,2373));;
co3T2:=Image(co3Map,RepresentativeTom(co3Tom,2374));;
Print("T1/T2 sizes ",[Size(co3T1),Size(co3T2)],"\n");
SaveWorkspace("work/co1_co3_actual_tclasses.ws");;
C1:=Centralizer(co1G,co3T1);;Assert(0,Size(C1)=1);
Print("Co1 class2373 centralizer1; normalizer241920 by fullAut bound\n");
C2:=Centralizer(co1G,co3T2);;Print("Co1 class2374 centralizer ",Size(C2),"\n");
N2:=Normalizer(co1G,co3T2);;Print("Co1 class2374 normalizer ",Size(N2)," automizer ",Size(N2)/Size(C2),"\n");
SaveWorkspace("work/co1_co3_actual_tclasses_done.ws");;
Assert(0,Size(C2)=1 and Size(N2)=241920);
Print("ALL CO3-SOURCE CO1 CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
