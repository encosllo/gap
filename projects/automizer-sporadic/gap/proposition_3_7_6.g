# Proposition 3.7.6 (automizers in M22 and its covers)
#
# The automizers of M22 (156 subgroup classes; [C2^3] is not in Spec(M22)) and the
# witnesses in 2.M22, 3.M22 and 4.M22, built from the ATLAS generators in gap/data/.
#
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/proposition_3_7_6.g
LoadPackage("smallgrp");
AutIn := function(G,H)
  return FactorGroup(Normalizer(G,H),Centralizer(G,H));
end;
M := Group(
 (1,13)(2,8)(3,16)(4,12)(6,22)(7,17)(9,10)(11,14),
 (1,22,3,21)(2,18,4,13)(5,12)(6,11,7,15)
 (8,14,20,10)(17,19));
if Size(M)<>443520 then Error("wrong base group"); fi;
cc := ConjugacyClassesSubgroups(M);
if Length(cc)<>156 then Error("unexpected subgroup list"); fi;
ids8 := [];
for cl in cc do
 H := Representative(cl);
 if Size(H)>1 and Size(H)<Size(M) then
  N := Normalizer(M,H); C := Centralizer(M,H);
  if Index(N,C)=8 then Add(ids8,IdGroup(FactorGroup(N,C))); fi;
 fi;
od;
if Set(ids8)<>[[8,3],[8,4]] then Error("order-8 types"); fi;
Print("M22 subgroup classes: ",Length(cc),
      "; order-8 types: ",Set(ids8),"\n");

AbelianPrimaryIds := function(G,p)
 local cls,cl,H,ids,A;
 cls := ConjugacyClassesSubgroups(SylowSubgroup(G,p));
 ids := [];
 for cl in cls do
  H := Representative(cl);
  if Size(H)>1 and IsAbelian(H) then
   A := AutIn(G,H); Add(ids,IdGroup(A));
  fi;
 od;
 return Set(ids);
end;
ids2 := AbelianPrimaryIds(M,2);
Print("M22 abelian-2 automizer IDs: ",ids2,"\n");
for id in ids2 do
 A := SmallGroup(id); P := SylowSubgroup(A,2);
 if Size(P)>8 or (Size(P)=8 and IdGroup(P)=[8,4]) then
  Error("quaternion subgroup not excluded");
 fi;
od;
P := SylowSubgroup(M,3);
if IdGroup(AutIn(M,P))<>[8,4] then Error("Q8 witness"); fi;

Read("gap/data/3m22_p693b0.g1"); a := a11;
Read("gap/data/3m22_p693b0.g2"); b := a21;
E3 := Group(a,b);
if Size(E3)<>1330560 or Size(Centre(E3))<>3 then
 Error("wrong triple cover");
fi;
ids3 := AbelianPrimaryIds(E3,3);
if ids3<>[[1,1],[2,1],[6,1]] then Error("abelian-3 types"); fi;
Print("3.M22 abelian-3 automizer IDs: ",ids3,"\n");

FindElementaryWitness := function(G)
 local cls,cl,H,N,C,A;
 cls := ConjugacyClassesSubgroups(SylowSubgroup(G,2));
 for cl in cls do
  H := Representative(cl);
  if Size(H)>1 and IsAbelian(H) then
   N := Normalizer(G,H); C := Centralizer(G,H);
   if Index(N,C)=8 then
    A := FactorGroup(N,C);
    if IdGroup(A)=[8,5] then
     Print("witness: ",StructureDescription(H),
       "; |H|=",Size(H),"; |N|=",Size(N),
       "; |C|=",Size(C),"; ID=",IdGroup(A),"\n");
     return H;
    fi;
   fi;
  fi;
 od;
 Error("no elementary-abelian witness found");
end;
Read("gap/data/2m22_p352ab0.g1"); a := a11;
Read("gap/data/2m22_p352ab0.g2"); b := a21;
E2 := Group(a,b);
if Size(E2)<>887040 or Size(Centre(E2))<>2 then
 Error("wrong double cover");
fi;
H2 := FindElementaryWitness(E2);
Read("gap/data/4m22_p4928ab0.g1"); a := bin1;
Read("gap/data/4m22_p4928ab0.g2"); b := bin1;
E4 := Group(a,b);
if Size(E4)<>1774080 or Size(Centre(E4))<>4 then
 Error("wrong quadruple cover");
fi;
H4 := FindElementaryWitness(E4);
Print("FINAL\n");
QUIT;
