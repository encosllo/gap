# Proposition 5.7.7 (no realization with abelian Sylow 3-subgroup)
#
# Recheck of the same 13 records one by one, and of the counts
# 1535 = 154 + 1381 (the 13 are among the 1381 excluded).
#
# Input: work/fi22_abelian_parent_twoextensions.ws (see run_checks.sh for the script that writes it).
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL THIRTEEN OMITTED-STRING ENTRIES ARE ALREADY WITHIN THE 1381 EXCLU...
# Original file: fi22_omitted_entries_detail.g (L. Gong and Y. Yan, 2026-10-25).
# Change: the thirteen records are selected as those with a string label or with automizer
# order 1296. Under GAP 4.12 they had the string label "(C3 x C3 x C3) : (C2 x S4)"; under
# GAP 4.16 (SmallGrp 1.7) they have the identifier [1296, 3490], so the original filter on
# string labels selected none of them. Both criteria select the same thirteen records.
# Usage: gap -q --quitonbreak -L work/fi22_abelian_parent_twoextensions.ws gap/lib.g gap/proposition_5_7_7_omitted_check.g
omittedDetail:=Filtered(rowsall,r->(IsString(r[7]) or r[6]=1296) and not r[7] in q8types);;
retainedIndicesDetail:=Set(List(abeparents,r->r[1]));;
Assert(0,Length(rowsall)=1535 and Length(abeparents)=154 and Length(omittedDetail)=13);
Print("TOTAL ",Length(rowsall)," RETAINED ",Length(abeparents)," EXCLUDED ",Length(rowsall)-Length(abeparents)," OMITTED-STRING-SUBSET ",Length(omittedDetail),"\n");
Print("index\tP_order\tN_order\tC_order\tautomizer_order\tSylow2_Id\tHasQ8\tretained\n");
for rdetail in omittedDetail do
 pdetail:=PreImage(ip,rr[rdetail[1]]);;
 ndetail:=Normalizer(Sbase,pdetail);;cdetail:=Centralizer(ndetail,pdetail);;
 adetail:=FactorGroup(ndetail,cdetail);;
 iddetail:=IdGroup(SylowSubgroup(adetail,2));;
 hasdetail:=HasQ8(adetail);;indetail:=rdetail[1] in retainedIndicesDetail;;
 Assert(0,Size(pdetail)=81 and Size(adetail)=1296 and iddetail=[16,11] and not hasdetail and not indetail);
 Print(rdetail[1],"\t",Size(pdetail),"\t",Size(ndetail),"\t",Size(cdetail),"\t",Size(adetail),"\t",iddetail,"\t",hasdetail,"\t",indetail,"\n");
od;
Print("stored descriptions ",Set(List(omittedDetail,r->r[7])),"\n");
Print("ALL THIRTEEN OMITTED-STRING ENTRIES ARE ALREADY WITHIN THE 1381 EXCLUDED REPRESENTATIVES\n");
Print("FINAL\n");
QUIT;
