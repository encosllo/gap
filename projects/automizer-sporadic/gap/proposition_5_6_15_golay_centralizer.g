# Proposition 5.6.15 (all simple L3(4) cores in Co1)
#
# Golay branch: for L = K', C(L) = 1 and |N(L)| = 241920.
#
# Input: work/co1_l34_22_before_normalizer.ws (see run_checks.sh for the script that writes it).
# Writes: work/co1_l34_core_global.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   L34 core N 241920 C 1 outer image 12
# Original file: co1_l34_core_centralizer.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_l34_22_before_normalizer.ws gap/lib.g gap/proposition_5_6_15_golay_centralizer.g
LL:=DerivedSubgroup(KK);;
CCL:=Centralizer(GG1,LL);;
Print("L34 core centralizer order ",Size(CCL)," structure ",StructureDescription(CCL),"\n");
NNL:=Normalizer(GG1,LL);;
Print("L34 core N ",Size(NNL)," C ",Size(CCL)," outer image ",Size(NNL)/Size(CCL)/20160,"\n");
SaveWorkspace("work/co1_l34_core_global.ws");
Assert(0,Size(LL)=20160 and Size(CCL)=1 and Size(NNL)=241920);
Print("FINAL\n");
QUIT;
