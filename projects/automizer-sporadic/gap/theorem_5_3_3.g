# Theorem 5.3.3 (recognition of McL)
#
# The table of marks of McL is the completeness input; checks its
# representative and normalizer orders, and computes every required
# centralizer and graph-subgroup quotient.
#
# Expected: the output ends with ALL MCL COVER CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_5_3_3.g
LoadPackage("tomlib");;
t:=TableOfMarks("McL");;
G:=UnderlyingGroup(t);;
ord:=OrdersTom(t);;lens:=LengthsTom(t);;
if Length(ord)<>373 or Size(G)<>898128000 then
 Error("wrong McL data");
fi;
checked:=0;;order12:=[];;hits:=[];;
for i in [2..Length(ord)-1] do
 H:=RepresentativeTom(t,i);
 if Size(H)<>ord[i] then Error("subgroup order");fi;
 inn:=Size(H)/Size(Centre(H));
 if inn in [1,4,12] then
  checked:=checked+1;
  N:=Normalizer(G,H);
  if Size(N)<>Size(G)/lens[i] then
   Error("normalizer order");
  fi;
  C:=Centralizer(N,H);
  if Size(N)/Size(C)=12 then
   A:=FactorGroup(N,C);
   Add(order12,[i,ord[i],IdGroup(A)]);
   if IdGroup(A)=[12,3] then Add(hits,i);fi;
  fi;
 fi;
od;
Print("all classes = ",Length(ord),"; checks = ",checked,"\n");
Print("order-12 automizers = ",order12,"\n");
if Length(hits)>0 then Error("A4 is present");fi;
H:=RepresentativeTom(t,58);;
if IdGroup(H)<>[24,3] then Error("wrong 2A4");fi;
z:=First(Elements(Centre(H)),x->Order(x)=2);;
I:=Centralizer(G,z);;
if Size(I)<>40320 then Error("involution centralizer");fi;
Z3:=CyclicGroup(IsPermGroup,3);;
phi:=NaturalHomomorphismByNormalSubgroup(H,DerivedSubgroup(H));;
chi:=CompositionMapping(IsomorphismGroups(Image(phi),Z3),phi);;
M:=DirectProduct(I,Z3);;
iI:=Embedding(M,1);;iZ:=Embedding(M,2);;
K:=Group(List(GeneratorsOfGroup(H),
 h->Image(iI,h)*Image(iZ,Image(chi,h))));;
N:=Normalizer(M,K);;C:=Centralizer(M,K);;
A:=FactorGroup(N,C);;
Print("M,K,N,C orders = ",
 [Size(M),Size(K),Size(N),Size(C)],"\n");
if IdGroup(K)<>[24,3] or IdGroup(A)<>[12,3] then
 Error("graph witness");
fi;
Print("ALL MCL COVER CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
