# Proposition 5.7.3 (no abelian realization of the 1296-entry in Fi22)
#
# Independent check of the abstract types and of the abelian 3-subgroups of
# rank at most two.
#
# Input: work/fi22_base_allabelian3.ws (see run_checks.sh for the script that writes it).
# Expected: the recorded output (GAP 4.12.1) ends with
#   all rank<=2 abelian3 types [ [ 3 ], [ 3, 3 ], [ 3, 9 ], [ 9 ] ]
# Original file: fi22_f1296_abelian_order_types_audit.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_base_allabelian3.ws gap/lib.g gap/proposition_5_7_3_types.g
for ord in [1296,3888,51840] do
 Print("order ",ord," all abstract type multiplicities ",Collected(List(Filtered(rowsall,r->r[6]=ord),r->r[7])),"\n");
od;
Print("all rank<=2 abelian3 types ",Set(List(Filtered(rowsall,r->Length(r[3])<=2),r->r[3])),"\n");
Assert(0,Number(rowsall,r->r[6]=1296)=13 and Number(rowsall,r->r[6]=3888)=12 and Number(rowsall,r->r[6]=51840)=1);
Assert(0,Set(List(Filtered(rowsall,r->Length(r[3])<=2),r->r[3]))=[[3],[3,3],[3,9],[9]]);
Print("FINAL\n");
QUIT;
