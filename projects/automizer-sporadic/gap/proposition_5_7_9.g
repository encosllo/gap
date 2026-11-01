# Proposition 5.7.9 (mixed realizers with nonabelian normal Sylow 3-subgroup)
#
# All 6278 parents: 84 quaternion-positive, 29 families and 55 fusions by
# explicit conjugating elements, 336 extensions, 22 automizers of order 1296,
# none isomorphic to F.
#
# Input: work/fi22_mixed_p3_type_auts.ws (see run_checks.sh for the script that writes it).
# Writes: work/fi22_f1296_base_mixed_found_all.ws, work/fi22_mixed_nonabel_checkpoint.ws, work/fi22_mixed_nonabel_allparents.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL NONABEL MIXED FINISHED parents 6278 globalfamilies 29 fused 55 ex...
# Original file: fi22_mixed_nonabel_allparents.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_mixed_p3_type_auts.ws gap/lib.g gap/proposition_5_7_9.g
Read("gap/data/fi22_target1296_matrix4.g");;
v4:=AsList(FullRowSpace(GF(3),4));;
fl4:=List(GeneratorsOfGroup(TargetK16),g->PermList(List(v4,v->Position(v4,v*g))));;
ft4:=List(IdentityMat(4,GF(3)),e->PermList(List(v4,v->Position(v4,v+e))));;
Fmix:=Group(Concatenation(fl4,ft4));;
Assert(0,Size(Fmix)=1296 and IdGroup(SylowSubgroup(Fmix,2))=[16,12]);
normalOrdersMix:=Set(List(NormalSubgroups(Fmix),Size));;
keptMix:=Filtered([1..Length(rrmix)],i->First(typeinfo,t->t[1]=mixtypes[i])[7]);;
Assert(0,Length(rrmix)=6568 and Length(keptMix)=6278);
cacheDmix:=[];;familiesMix:=[];;bucketsMix:=rec();;q8CacheMix:=[];;fusionMix:=[];;
allRowsMix:=[];;hitMix:=false;;countParentsMix:=0;;countExtMix:=0;;countOrderMix:=0;;
ProcessMixParent:=function(idx)
 local hp,dp,cd,dc,dperm,nd,ism,model,pmod,nmod,cmod,amod,pa2,aid,jj,haveq8,aqpc,ak,
 sigkey,bucket,famidx,cnj,ncalc,pcalc,ccalc,isn,pn2,in2,pc2,qhom,nquot,zp,
 qcls,qcl,q2,qbar,zpf,zqf,zhs,innord,ce,nqe,aos,ne,he,ae,ov,sv,sig,extrows,localchecks,orderhits,cp;
 hp:=rrmix[idx];dp:=DerivedSubgroup(hp);cd:=PositionProperty(cacheDmix,c->c.dp=dp);
 if cd=fail then
  dperm:=PreImage(ip,dp);nd:=Normalizer(Sbase,dperm);ism:=fail;model:=nd;
  if IsSolvableGroup(nd) then ism:=IsomorphismPcGroup(nd);model:=Image(ism);fi;
  Add(cacheDmix,rec(dp:=dp,nd:=nd,ism:=ism,model:=model));cd:=Length(cacheDmix);
  Print("DERIVED CACHE ",cd," Dorder ",Size(dp)," NDorder ",Size(nd)," pc ",ism<>fail,"\n");
 fi;
 dc:=cacheDmix[cd];pmod:=PreImage(ip,hp);if dc.ism<>fail then pmod:=Image(dc.ism,pmod);fi;
 nmod:=Normalizer(dc.model,pmod);cmod:=Centralizer(nmod,pmod);amod:=FactorGroup(nmod,cmod);
 pa2:=SylowSubgroup(amod,2);haveq8:=false;
 if Size(pa2)>=8 then
  aid:=fail;if IdGroupsAvailable(Size(pa2)) then aid:=IdGroup(pa2);fi;
  jj:=PositionProperty(q8CacheMix,c->c[1]=aid and aid<>fail);
  if jj<>fail then haveq8:=q8CacheMix[jj][2];
  else
   aqpc:=pa2;if not IsPcGroup(pa2) then aqpc:=Image(IsomorphismPcGroup(pa2));fi;
   haveq8:=ForAny(ConjugacyClassesSubgroups(aqpc),c->Size(Representative(c))=8 and IdGroup(Representative(c))=[8,4]);
   if aid<>fail then Add(q8CacheMix,[aid,haveq8]);fi;
  fi;
 fi;
 Add(allRowsMix,[idx,mixtypes[idx],cd,Size(nmod),Size(cmod),Size(amod),Size(pa2),haveq8]);
 countParentsMix:=countParentsMix+1;
 if not haveq8 then return;fi;
 sigkey:=String([cd,mixtypes[idx],Size(nmod),Size(cmod)]);
 if IsBound(bucketsMix.(sigkey)) then bucket:=bucketsMix.(sigkey);else bucket:=[];bucketsMix.(sigkey):=bucket;fi;
 for famidx in bucket do
  cnj:=RepresentativeAction(dc.model,pmod,familiesMix[famidx].pmod,OnPoints);
  if cnj<>fail then
   Assert(0,pmod^cnj=familiesMix[famidx].pmod);Add(fusionMix,[idx,familiesMix[famidx].idx]);return;
  fi;
 od;
 famidx:=Length(familiesMix)+1;Add(bucket,famidx);
 Add(familiesMix,rec(idx:=idx,dc:=cd,pmod:=pmod,nmod:=nmod,cmod:=cmod,amod:=amod));
 Print("NEW GLOBAL FAMILY ",famidx," parent ",idx," type ",mixtypes[idx]," N,C,A ",[Size(nmod),Size(cmod),Size(amod)],"\n");
 # The extension calculation is in a polycyclic copy whenever possible.
 ncalc:=nmod;pcalc:=pmod;ccalc:=cmod;isn:=fail;
 if not IsPcGroup(nmod) and IsSolvableGroup(nmod) then
  isn:=IsomorphismPcGroup(nmod);ncalc:=Image(isn);pcalc:=Image(isn,pmod);ccalc:=Image(isn,cmod);
 fi;
 pn2:=SylowSubgroup(ncalc,2);in2:=fail;pc2:=pn2;
 if not IsPcGroup(pn2) then in2:=IsomorphismPcGroup(pn2);pc2:=Image(in2);fi;
 qhom:=NaturalHomomorphismByNormalSubgroup(ncalc,pcalc);nquot:=Image(qhom);zp:=Centre(pcalc);
 qcls:=Filtered(ConjugacyClassesSubgroups(pc2),c->Size(Representative(c))>1);
 localchecks:=0;orderhits:=0;extrows:=[];
 for qcl in qcls do
  q2:=Representative(qcl);if in2<>fail then q2:=PreImage(in2,q2);fi;qbar:=Image(qhom,q2);
  zpf:=Centralizer(zp,q2);zqf:=Centralizer(Centre(q2),pcalc);zhs:=Size(zpf)*Size(zqf);
  innord:=Size(pcalc)*Size(q2)/zhs;if not innord in normalOrdersMix then continue;fi;
  ce:=Centralizer(ccalc,q2);nqe:=Normalizer(nquot,qbar);aos:=Size(pcalc)*Size(nqe)/Size(ce);
  localchecks:=localchecks+1;countExtMix:=countExtMix+1;
  if aos=1296 then
   orderhits:=orderhits+1;countOrderMix:=countOrderMix+1;
   ne:=PreImage(qhom,nqe);he:=PreImage(qhom,qbar);ae:=FactorGroup(ne,ce);ov:=PCore(ae,3);sv:=SylowSubgroup(ae,2);
   sig:=[idx,Size(q2),Size(he),zhs,Size(ne),Size(ce),Size(ov),IsElementaryAbelian(ov),IdGroup(sv)];Print("ORDER1296 ",sig,"\n");Add(extrows,[sig]);
   if Size(ov)=81 and IsElementaryAbelian(ov) and IdGroup(sv)=[16,12] and IsomorphismGroups(ae,Fmix)<>fail then
    hitMix:=true;
    if isn<>fail then he:=PreImage(isn,he);ne:=PreImage(isn,ne);ce:=PreImage(isn,ce);fi;
    if dc.ism<>fail then he:=PreImage(dc.ism,he);ne:=PreImage(dc.ism,ne);ce:=PreImage(dc.ism,ce);fi;
    MIXED_REALIZER:=he;MIXED_NORMALIZER:=ne;MIXED_CENTRALIZER:=ce;MIXED_AUTOMIZER:=ae;
    Print("FULL F1296 BASE MIXED FOUND\n");SaveWorkspace("work/fi22_f1296_base_mixed_found_all.ws");return;
   fi;
  fi;
 od;
 familiesMix[famidx].checks:=localchecks;familiesMix[famidx].hits:=orderhits;familiesMix[famidx].extrows:=extrows;
 Print("FAMILY FINISHED ",famidx," PN2 ",Size(pn2)," subgroupclasses ",Length(qcls)," extchecks ",localchecks," order1296 ",orderhits,"\n");
end;;
for mixIndex in keptMix do
 ProcessMixParent(mixIndex);
 if hitMix then break;fi;
 if countParentsMix mod 100=0 then Print("PROGRESS parents ",countParentsMix," families ",Length(familiesMix)," fused ",Length(fusionMix)," extchecks ",countExtMix,"\n");fi;
 if countParentsMix mod 500=0 then SaveWorkspace("work/fi22_mixed_nonabel_checkpoint.ws");fi;
od;
Print("ALL NONABEL MIXED FINISHED parents ",countParentsMix," globalfamilies ",Length(familiesMix)," fused ",Length(fusionMix)," extchecks ",countExtMix," order1296 ",countOrderMix," target ",hitMix,"\n");
SaveWorkspace("work/fi22_mixed_nonabel_allparents.ws");;
Assert(0,countParentsMix=6278 and Length(familiesMix)=29 and Length(fusionMix)=55);
Assert(0,countExtMix=336 and countOrderMix=22 and hitMix=false);
Print("MIXED ABSENCE ASSERTED\n");
Print("FINAL\n");
QUIT;
