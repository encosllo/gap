# Lemma 5.6.3 (the Golay maximal subgroup)
#
# The K-invariant Golay subspaces containing the centre have dimensions
# 1, 10, 11, 12, with stabilizers of orders 120960, 887040, 244823040.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   dim=11 stab=887040 charmultiplicities=[ [ 1, 22 ], [ 2, 1 ] ]
# Original file: co1_l34outer_golay.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_3.g
m24:=MathieuGroup(24);;ff:=GF(2);;
gm:=List(GeneratorsOfGroup(m24),g->PermutationMat(g,24,ff));;
bg:=First(MTX.BasesSubmodules(GModuleByMats(gm,ff)),b->Length(b)=12);;
Bbg:=Basis(VectorSpace(ff,bg),bg);;
kg:=Intersection(Stabilizer(m24,1),Stabilizer(m24,[2,3],OnSets));;
Print("K order=",Size(kg)," structure=",StructureDescription(kg),"\n");
km:=List(GeneratorsOfGroup(kg),g->List(bg,v->Coefficients(Bbg,v*PermutationMat(g,24,ff))));;
ksp:=MTX.BasesSubmodules(GModuleByMats(km,ff));;
cv:=Coefficients(Bbg,List([1..24],i->One(ff)));;
ksp:=Filtered(ksp,b->Length(b)>0 and cv in VectorSpace(ff,b));;
Print("K-invariant centrecontaining dims=",List(ksp,Length),"\n");
allwords:=Set(Elements(VectorSpace(ff,IdentityMat(12,ff))));;
g12:=Group(List(gm,m->List(bg,v->Coefficients(Bbg,v*m))));;
ga:=ActionHomomorphism(g12,allwords,OnRight);;gact:=Image(ga);;
stabs:=[];;
for ib in [1..Length(ksp)] do
 bb:=ksp[ib];;
 if Length(bb)>1 and Length(bb)<12 then
 vset:=Set(List(Elements(VectorSpace(ff,bb)),v->PositionSorted(allwords,v)));;
 kk:=Stabilizer(gact,vset,OnSets);;
 ch:=TransposedMat(bb*bg);;
 Add(stabs,[Length(bb),Size(kk)]);
 Print("dim=",Length(bb)," stab=",Size(kk)," charmultiplicities=",Collected(List(Set(ch),v->Number(ch,x->x=v))),"\n");
 fi;
od;
Assert(0,Size(kg)=40320 and List(ksp,Length)=[1,10,11,12]);
Assert(0,stabs=[[10,120960],[11,887040]]);
Print("GOLAY SUBSPACE CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
