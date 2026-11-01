# Proposition 5.7.3 (no abelian realization of the 1296-entry in Fi22)
#
# Full normalizers and centralizers in Fi22 of all 1535 nontrivial abelian
# subgroups of the Sylow 3-subgroup.
#
# Input: work/fi22_f1296_base_bootstrap.ws (see run_checks.sh for the script that writes it).
# Writes: work/fi22_base_allabelian3.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL BASE ABELIAN 3 AUTOMIZERS FINISHED
# Original file: fi22_base_allabelian3.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_f1296_base_bootstrap.ws gap/lib.g gap/proposition_5_7_3_automizers.g
rowsall:=[];;
for ii in [1..Length(rr)] do
 if Size(rr[ii])=1 then continue; fi;
 h:=PreImage(ip,rr[ii]);;
 nn:=Normalizer(Sbase,h);; ce:=Centralizer(nn,h);; au:=FactorGroup(nn,ce);;
 if IdGroupsAvailable(Size(au)) then typ:=IdGroup(au);else typ:=StructureDescription(au);fi;
 Add(rowsall,[ii,Size(h),AbelianInvariants(h),Size(nn),Size(ce),Size(au),typ]);;
 Print(rowsall[Length(rowsall)],"\n");
od;
Assert(0,Length(rowsall)=1535 and Collected(List(rowsall,r->r[6]))=[[2,359],[4,55],[6,132],[8,37],[12,128],[16,16],[18,208],[36,172],[48,61],[54,56],[72,62],[108,31],[144,9],[162,46],[216,2],[324,23],[432,73],[486,24],[720,2],[1152,3],[1296,13],[3888,12],[5616,10],[51840,1]]);
Print("ALL BASE ABELIAN 3 AUTOMIZERS FINISHED\n");
SaveWorkspace("work/fi22_base_allabelian3.ws");
Print("FINAL\n");
QUIT;
