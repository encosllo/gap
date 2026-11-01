# Proposition 5.7.3 (no abelian realization of the 1296-entry in Fi22)
#
# The 26 automizers of order divisible by 1296: 13 of order 1296 with Sylow
# 2-subgroup [16,11], 12 of order 3888 with [16,8], and one of order 51840
# with nonabelian Sylow 3-subgroup of order 81; also the centralizer bounds.
#
# Input: work/fi22_base_allabelian3.ws (see run_checks.sh for the script that writes it).
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL FI22 ABELIAN3 EMBEDDING ROWS AUDIT CHECKS PASSED
# Original file: fi22_f1296_all_abelian3_embedding_audit.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_base_allabelian3.ws gap/lib.g gap/proposition_5_7_3.g
possibleAll:=Set(List(Filtered(rowsall,r->r[6] mod 1296=0),r->r[6]));;
Assert(0,possibleAll=[1296,3888,51840]);
embeddingAuditCount:=0;;embeddingAuditTypes:=[];;
for rowAudit in Filtered(rowsall,r->r[6] mod 1296=0) do
 hAudit:=PreImage(ip,rr[rowAudit[1]]);;
 nAudit:=Normalizer(Sbase,hAudit);;cAudit:=Centralizer(nAudit,hAudit);;
 aAudit:=FactorGroup(nAudit,cAudit);;
 Assert(0,Size(aAudit)=rowAudit[6]);
 syl2Audit:=SylowSubgroup(aAudit,2);;syl3Audit:=SylowSubgroup(aAudit,3);;
 if Size(aAudit)=1296 then
  Assert(0,IdGroup(syl2Audit)=[16,11]);
 elif Size(aAudit)=3888 then
  Assert(0,IdGroup(syl2Audit)=[16,8]);
 elif Size(aAudit)=51840 then
  Assert(0,Size(syl3Audit)=81 and not IsAbelian(syl3Audit));
 else Error("uncovered ambient automizer");fi;
 embeddingAuditCount:=embeddingAuditCount+1;;
 AddSet(embeddingAuditTypes,[Size(aAudit),IdGroup(syl2Audit),Size(syl3Audit),IsAbelian(syl3Audit)]);
od;
Assert(0,Length(rowsall)=1535);
highCentralizersAudit:=Set(List(Filtered(rowsall,r->Length(r[3])>=3),r->r[5]));;
Assert(0,highCentralizersAudit=[81,162,243,486,729,972,1458]);
Print("all divisible-order abelian3 automizers checked: ",embeddingAuditCount," types ",embeddingAuditTypes,"\n");
Print("ALL FI22 ABELIAN3 EMBEDDING ROWS AUDIT CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
