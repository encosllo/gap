# Lemma 5.6.14 (the Co2 sources)
#
# Co2 source McL (TOM classes 357, 358): full Co1 centralizer 1 and
# normalizer 241920.
#
# Input: work/co1_co2_standard.ws (see run_checks.sh for the script that writes it).
# Writes: work/co1_co2_mcl_tclasses.ws, work/co1_co2_mcl_tclasses_done.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL CO2-MCL SOURCE CHECKS PASSED
# Original file: co1_co2_mcl_l34_global.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_co2_standard.ws gap/lib.g gap/lemma_5_6_14_mcl.g
LoadPackage("atlasrep");;LoadPackage("tomlib");;
co2mclProg:=AtlasProgram("Co2","maxes",3);;
co2mclGens:=ResultOfStraightLineProgram(co2mclProg.program,co2StdGens);;
co2McL:=Group(co2mclGens);;
Assert(0,Size(co2McL)=898128000);Print("actual Co2 McL size ",Size(co2McL),"\n");
co2McLStd:=StandardGeneratorsData(co2McL,"McL");;Assert(0,co2McLStd<>fail);
mcTom:=TableOfMarks("McL");;mcU:=UnderlyingGroup(mcTom);;
Assert(0,StandardGeneratorsInfo(mcTom)[1].ATLAS=true);
mcMap:=GroupHomomorphismByImages(mcU,co2McL,GeneratorsOfGroup(mcU),co2McLStd.stdgens);;
Assert(0,mcMap<>fail and Size(Image(mcMap))=898128000);
mcT357:=Image(mcMap,RepresentativeTom(mcTom,357));;
mcT358:=Image(mcMap,RepresentativeTom(mcTom,358));;
Assert(0,Size(mcT357)=20160 and Size(mcT358)=20160);
SaveWorkspace("work/co1_co2_mcl_tclasses.ws");;
for dat in [[357,mcT357],[358,mcT358]] do
 mcC:=Centralizer(co1G,dat[2]);Print("Co2 McL T class ",dat[1]," fullCo1 C ",Size(mcC),"\n");
 mcN:=Normalizer(co1G,dat[2]);Print("Co2 McL T class ",dat[1]," fullCo1 N ",Size(mcN)," auto ",Size(mcN)/Size(mcC),"\n");
od;
SaveWorkspace("work/co1_co2_mcl_tclasses_done.ws");;
Print("ALL CO2-MCL SOURCE CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
