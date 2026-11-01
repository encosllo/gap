# Proposition 5.6.14 (all simple L3(4) cores in Co1)
#
# Unitary branch, Levi complement class: global centralizer 1.
#
# Input: work/co1_u6_selected_complements.ws (see run_checks.sh for the script that writes it).
# Writes: work/co1_u6_levi_global_centralizer.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   Levi global centralizer 1 1
# Original file: co1_u6_levi_global_centralizer.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_u6_selected_complements.ws gap/lib.g gap/proposition_5_6_14_u6_levi.g
TTlevi:=ulcomp[2];;
CClevi:=Centralizer(GG1,TTlevi);;
Print("Levi global centralizer ",Size(CClevi)," ",StructureDescription(CClevi),"\n");
SaveWorkspace("work/co1_u6_levi_global_centralizer.ws");
Assert(0,Size(CClevi)=1);
Print("FINAL\n");
QUIT;
