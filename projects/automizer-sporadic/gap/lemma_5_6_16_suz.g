# Lemma 5.6.16 (the two triple-core sources)
#
# Builds the 3.Suz.2 model (degree 5346) for the other core source.
#
# Writes: work/co1_3suz2_local.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   3Suz2 model true 3Suz2 order 2690072985600 degree 5346
# Original file: co1_three_l34_local_central_products.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_16_suz.g
LoadPackage("atlasrep");;
ccas:=AtlasGroup("3.Suz.2",IsPermGroup);;
Print("3Suz2 model ",ccas<>fail,"\n");
if ccas=fail then Error("3.Suz.2 model not available");fi;
Print("3Suz2 order ",Size(ccas)," degree ",LargestMovedPoint(ccas),"\n");
SaveWorkspace("work/co1_3suz2_local.ws");
Assert(0,Size(ccas)=2690072985600 and LargestMovedPoint(ccas)=5346);
Print("FINAL\n");
QUIT;
