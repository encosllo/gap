# Proposition 5.7.9 (mixed realizers with nonabelian normal Sylow 3-subgroup)
#
# Rebuilds the 336 extensions of the 29 families and checks the 22 groups of
# order 1296; the last three have four normal C3 (F has none).
#
# Input: work/fi22_mixed_nonabel_allparents.ws (see run_checks.sh for the script that writes it).
# Expected: the recorded output (GAP 4.12.1) ends with
#   all 29 families / 336 extensions / 22 order1296 groups checked; final...
# Original file: fi22_f1296_nonabel_final_invariant_audit.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_mixed_nonabel_allparents.ws gap/lib.g gap/proposition_5_7_9_invariants.g
# Reconstruct every order-1296 result in all completed parent families.
Assert(0,countParentsMix=6278 and Length(familiesMix)=29 and countExtMix=336);
Assert(0,Size(Fmix)=1296 and Number(NormalSubgroups(Fmix),h->Size(h)=3)=0);
Assert(0,Size(Centralizer(PCore(Fmix,3),DerivedSubgroup(SylowSubgroup(Fmix,2))))=1);
finalExtCount:=0;;finalOrderCount:=0;;finalCoarseCount:=0;;
for fam in familiesMix do
 nmAudit:=fam.nmod;;pmAudit:=fam.pmod;;cmAudit:=fam.cmod;;
 if not IsPcGroup(nmAudit) and IsSolvableGroup(nmAudit) then
  imAudit:=IsomorphismPcGroup(nmAudit);;
  pmAudit:=Image(imAudit,pmAudit);;cmAudit:=Image(imAudit,cmAudit);;nmAudit:=Image(imAudit);;
 fi;
 sylAudit:=SylowSubgroup(nmAudit,2);;ipAudit:=fail;;pcAudit:=sylAudit;;
 if not IsPcGroup(sylAudit) then ipAudit:=IsomorphismPcGroup(sylAudit);;pcAudit:=Image(ipAudit);;fi;
 rhoAudit:=NaturalHomomorphismByNormalSubgroup(nmAudit,pmAudit);;quotAudit:=Image(rhoAudit);;
 zpAudit:=Centre(pmAudit);;thisExtCount:=0;;thisOrderCount:=0;;
 for qcAudit in ConjugacyClassesSubgroups(pcAudit) do
  qqAudit:=Representative(qcAudit);;if Size(qqAudit)=1 then continue;fi;
  if ipAudit<>fail then qqAudit:=PreImage(ipAudit,qqAudit);;fi;
  zzAudit:=Size(Centralizer(zpAudit,qqAudit))*Size(Centralizer(Centre(qqAudit),pmAudit));;
  if not Size(pmAudit)*Size(qqAudit)/zzAudit in normalOrdersMix then continue;fi;
  thisExtCount:=thisExtCount+1;;finalExtCount:=finalExtCount+1;;
  qbAudit:=Image(rhoAudit,qqAudit);;ceAudit:=Centralizer(cmAudit,qqAudit);;
  nqAudit:=Normalizer(quotAudit,qbAudit);;
  if Size(pmAudit)*Size(nqAudit)/Size(ceAudit)<>1296 then continue;fi;
  thisOrderCount:=thisOrderCount+1;;finalOrderCount:=finalOrderCount+1;;
  aaAudit:=FactorGroup(PreImage(rhoAudit,nqAudit),ceAudit);;
  vvAudit:=PCore(aaAudit,3);;ssAudit:=SylowSubgroup(aaAudit,2);;
  if Size(vvAudit)=81 and IsElementaryAbelian(vvAudit) and IdGroup(ssAudit)=[16,12] then
   fixedAudit:=Size(Centralizer(vvAudit,DerivedSubgroup(ssAudit)));;
   n3Audit:=Number(NormalSubgroups(aaAudit),h->Size(h)=3);;
   Assert(0,fixedAudit=9 and n3Audit=4);
   finalCoarseCount:=finalCoarseCount+1;;
   Print("coarse family ",fam.idx," derived-involution fixed=",fixedAudit," normalC3=",n3Audit,"\n");
  fi;
 od;
 Assert(0,thisExtCount=fam.checks and thisOrderCount=fam.hits);
od;
Assert(0,finalExtCount=336 and finalOrderCount=22 and finalCoarseCount=3);
Print("all 29 families / 336 extensions / 22 order1296 groups checked; final3 distinguished by normal C3 count 4 versus 0\n");
Print("ALL FI22 NONABELIAN FINAL INVARIANT AUDIT CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
