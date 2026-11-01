# Proposition 5.7.6 (no 3-group realization of the 1296-entry in Fi22)
#
# All 1252 fully normalized candidates checked in Fi22: no automizer of
# order 1296.
#
# Input: work/fi22_class2_candidate_lattice.ws (see run_checks.sh for the script that writes it).
# Writes: work/fi22_pure3_f1296_localcandidates.ws, work/fi22_base_pure3_f1296_found.ws, work/fi22_pure3_f1296_fullcheck.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   PURE3 F1296 COMPLETE CHECKS 1252 TARGET HIT false
# Original file: fi22_pure3_f1296_fullcheck.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_class2_candidate_lattice.ws gap/lib.g gap/proposition_5_7_6.g
Read("gap/data/fi22_target1296_matrix4.g");;
vecs:=AsList(FullRowSpace(GF(3),4));;
afflins:=List(GeneratorsOfGroup(TargetK16),g->PermList(List(vecs,v->Position(vecs,v*g))));;
afftrs:=List(IdentityMat(4,GF(3)),e->PermList(List(vecs,v->Position(vecs,v+e))));;
Ftarget:=Group(Concatenation(afflins,afftrs));;
if Size(Ftarget)<>1296 or IdGroup(SylowSubgroup(Ftarget,2))<>[16,12] then Error("wrong target");fi;
candf:=[];;
for hhpc in rf do
 inn:=Size(hhpc)/Size(Centre(hhpc));;
 if not inn in [9,81] then continue;fi;
 np:=Normalizer(pp,hhpc);;cp:=Centralizer(pp,hhpc);;
 if Size(np)/Size(cp)<>81 then continue;fi;
 ap:=FactorGroup(np,cp);;
 if not IsElementaryAbelian(ap) then continue;fi;
 Add(candf,hhpc);
od;
Print("fully normalized E81 local candidates ",Length(candf)," size/Inn counts ",Collected(List(candf,h->[Size(h),Size(h)/Size(Centre(h))])),"\n");
SaveWorkspace("work/fi22_pure3_f1296_localcandidates.ws");
checks:=[];;targethit:=false;;
for ii in [1..Length(candf)] do
 hh:=PreImage(ip,candf[ii]);;nn:=Normalizer(Sbase,hh);;cc:=Centralizer(nn,hh);;aa:=FactorGroup(nn,cc);;
 id2:=IdGroup(SylowSubgroup(aa,2));;
 sig:=[ii,Size(hh),Size(nn),Size(cc),Size(aa),id2];;Add(checks,sig);Print(sig,"\n");
 if Size(aa)=1296 and Size(PCore(aa,3))=81 and IsElementaryAbelian(PCore(aa,3)) and id2=[16,12] then
  if IsomorphismGroups(aa,Ftarget)<>fail then targethit:=true;Print("FULL F1296 BASE PURE3 PRESENT\n");SaveWorkspace("work/fi22_base_pure3_f1296_found.ws");break;fi;
 fi;
od;
Print("PURE3 F1296 COMPLETE CHECKS ",Length(checks)," TARGET HIT ",targethit,"\n");
Assert(0,Collected(List(candf,h->[Size(h),Size(h)/Size(Centre(h))]))=[[[81,9],34],[[243,9],399],[[243,81],819]]);
Assert(0,targethit=false and Length(checks)=1252);
Assert(0,Set(checks,c->c[5])=[81,162,324,486,648,972,1458,1944,2592,2916,3888,7776,11664]);
Print("PURE3 F1296 ABSENCE ASSERTED\n");
SaveWorkspace("work/fi22_pure3_f1296_fullcheck.ws");
Print("FINAL\n");
QUIT;
