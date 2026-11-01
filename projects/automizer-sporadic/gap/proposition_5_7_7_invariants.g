# Proposition 5.7.7 (no realization with abelian Sylow 3-subgroup)
#
# The 122 groups of order 1296: 36 with Sylow 2-subgroup [16,8], 6 with
# [16,14], and 80 with exactly two normal C3 (F has none).
#
# Input: work/fi22_abelian_parent_twoextensions.ws (see run_checks.sh for the script that writes it).
# Writes: work/fi22_abelian_order1296_invariant_audit.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   BASE ABELIAN 1296 INVARIANT AUDIT PASSED
# Original file: fi22_abelian_order1296_invariant_audit.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_abelian_parent_twoextensions.ws gap/lib.g gap/proposition_5_7_7_invariants.g
abe1296cases:=Concatenation(List(abeMixedData,r->r[7]));;
if Length(abe1296cases)<>122 then Error("wrong number of base order1296 hits");fi;
if Number(NormalSubgroups(Ftarget),n->Size(n)=3)<>0 then Error("wrong target invariant");fi;
coarseAbe:=[];;sigsAbe:=[];;
for ca in abe1296cases do
 a:=ca[4];;v:=PCore(a,3);;q:=SylowSubgroup(a,2);;
 sig:=[Size(v),IsElementaryAbelian(v),IdGroup(q)];;
 if Size(v)=81 and IsElementaryAbelian(v) and IdGroup(q)=[16,12] then
  nc3:=Number(NormalSubgroups(a),n->Size(n)=3);;Add(sig,nc3);;
  if nc3=0 then Error("order1296 hit not separated by certified invariants");fi;
  Add(coarseAbe,sig);
 fi;
 Add(sigsAbe,sig);
od;
Print("all 122 base abelian-parent order1296 hits separated by O3/Sylow2/normalC3 invariants\n");
Print("coarse target-shape hit count ",Length(coarseAbe)," signatures ",Collected(coarseAbe),"\n");
Print("signature table ",Collected(sigsAbe),"\n");
Print("BASE ABELIAN 1296 INVARIANT AUDIT PASSED\n");
SaveWorkspace("work/fi22_abelian_order1296_invariant_audit.ws");
Print("FINAL\n");
QUIT;
