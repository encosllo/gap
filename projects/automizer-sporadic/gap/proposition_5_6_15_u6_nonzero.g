# Proposition 5.6.15 (all simple L3(4) cores in Co1)
#
# Unitary branch, nonzero complement class: global C = 1 and N = 241920.
#
# Input: work/co1_u6_selected_complements.ws (see run_checks.sh for the script that writes it).
# Writes: work/co1_u6_nonzero_l34_global.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   nonzero complement GLOBAL N 241920 C 1 A 241920
# Original file: co1_u6_nonzero_l34_global.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_u6_selected_complements.ws gap/lib.g gap/proposition_5_6_15_u6_nonzero.g
TTnonzero:=ulcomp[1];;
Print("nonzero complement order ",Size(TTnonzero),"\n");
CCnonzero:=Centralizer(GG1,TTnonzero);;
Print("nonzero complement global C ",Size(CCnonzero),"\n");
NNnonzero:=Normalizer(GG1,TTnonzero);;
Print("nonzero complement GLOBAL N ",Size(NNnonzero)," C ",Size(CCnonzero)," A ",Index(NNnonzero,CCnonzero),"\n");
SaveWorkspace("work/co1_u6_nonzero_l34_global.ws");
Assert(0,Size(TTnonzero)=20160 and Size(CCnonzero)=1 and Size(NNnonzero)=241920);
Print("FINAL\n");
QUIT;
