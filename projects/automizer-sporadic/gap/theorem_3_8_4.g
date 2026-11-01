# Theorem 3.8.4 (a double-cover obstruction for J2)
#
# [A] is in Spec(2.J2) and not in Spec(J2), for A = 2^3:4 of order 32: fixed-space
# checks for the U3(3) modules and the witness in 2.J2, from the ATLAS generators in
# gap/data/. Its output is printed in Appendix C.
#
# Expected: the output ends with ALL J2 CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_3_8_4.g
LoadPackage("smallgrp");;
CheckFixed := function(a,b,F)
 local T,U,V,fixed;
 T:=Group(a,b); U:=Normalizer(T,SylowSubgroup(T,3));
 if Size(T)<>6048 or Size(U)<>216 or Size(Centre(U))<>1 then
  Error("unexpected unitary group or local subgroup");
 fi;
 V:=FullRowSpace(F,Length(a));
 fixed:=Intersection(List(GeneratorsOfGroup(U),g->Subspace(V,
  NullspaceMat(g-One(g)))));
 if Dimension(fixed)<>0 then Error("nonzero local fixed space");fi;
 Print("q=",Size(F)," degree=",Length(a)," |T|=",Size(T)," |U|=",Size(U),
  " fixed=",Dimension(fixed),"\n");
end;;
Read("gap/data/u33_f2r6b0.g1");; a:=matrix;;
Read("gap/data/u33_f2r6b0.g2");; b:=matrix;;
CheckFixed(a,b,GF(2));
Read("gap/data/u33_f9r3bb0.g1");; a:=matrix;;
Read("gap/data/u33_f9r3bb0.g2");; b:=matrix;;
CheckFixed(a,b,GF(9));
Read("gap/data/j2_p100b0.g1");; a:=b11;;
Read("gap/data/j2_p100b0.g2");; b:=b21;;
base:=Group(a,b);;
if Size(base)<>604800 then Error("wrong base group");fi;
classes:=ConjugacyClassesSubgroups(base);;
if Length(classes)<>146 then Error("unexpected subgroup class count");fi;
ids:=[];;centers:=[];;count:=0;;
for cl in classes do
 H:=Representative(cl);
 if Size(H)>1 and Size(H)<Size(base) then
  N:=Normalizer(base,H);C:=Centralizer(base,H);
  if Index(N,C)=32 then
   A:=FactorGroup(N,C);AddSet(ids,IdGroup(A));AddSet(centers,Size(Centre(A)));
  count:=count+1;
  fi;
 fi;
od;
if ids<>[[32,27]] or centers<>[4] or count<>3 then Error("base order-32 types");
  fi;
Print("J2 subgroup classes=",Length(classes),"; order32 cases=",count,"; IDs=",
  ids,"; centers=",centers,"\n");
Read("gap/data/2j2_p200b0.g1");; a:=b11;;
Read("gap/data/2j2_p200b0.g2");; b:=b21;;
cov:=Group(a,b);;
if Size(cov)<>1209600 or Size(Centre(cov))<>2 then Error("wrong double cover");fi;
found:=false;;
for cl in ConjugacyClassesSubgroups(SylowSubgroup(cov,2)) do
 H:=Representative(cl);
 if Size(H)=32 and IdGroup(H)=[32,8] then
  N:=Normalizer(cov,H);C:=Centralizer(cov,H);
  if Index(N,C)=32 then
   A:=FactorGroup(N,C);
   if Size(Centre(A))=2 then
    if IdGroup(A)<>[32,6] then Error("unexpected cover witness");fi;
    Print("2.J2 witness |H|=",Size(H)," H ID=",IdGroup(H)," |N|=",Size(N),
  " |C|=",Size(C)," A ID=",IdGroup(A)," |Z(A)|=",Size(Centre(A)),"\n");
    found:=true;break;
   fi;
  fi;
 fi;
od;
if not found then Error("no cover witness found");fi;
Print("ALL J2 CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
