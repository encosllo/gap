# Lemma 5.6.7 (quasisimple L3(4) subgroups in the Golay maximal)
#
# For the standard L3(4) on the Golay code: dim C^T = 1, dim V^T = 0,
# and H^1(T,V) = 0 (Z^1 and B^1 of dimension 11).
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   H1 V11: Z1dim=11 B1dim=11
# Original file: co1_l34_golay_h1.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_7.g
m24:=MathieuGroup(24);;ff:=GF(2);;
gm:=List(GeneratorsOfGroup(m24),g->PermutationMat(g,24,ff));;
bg:=First(MTX.BasesSubmodules(GModuleByMats(gm,ff)),b->Length(b)=12);;
Bbg:=Basis(VectorSpace(ff,bg),bg);;
kk:=Intersection(Stabilizer(m24,1),Stabilizer(m24,[2,3],OnSets));;
tt:=DerivedSubgroup(kk);;
tm12:=List(GeneratorsOfGroup(tt),g->List(bg,v->Coefficients(Bbg,v*PermutationMat(g,24,ff))));;
cv:=Coefficients(Bbg,List([1..24],i->One(ff)));;
nb:=[cv];;
for v in IdentityMat(12,ff) do
 if RankMat(Concatenation(nb,[v]))>Length(nb) then Add(nb,v);fi;
od;
Bnb:=Basis(VectorSpace(ff,nb),nb);;
tm11:=List(tm12,m->List(nb{[2..12]},v->Coefficients(Bnb,v*m){[2..12]}));;
fixedDim:=function(mats)
 local d,eq;
 d:=Length(mats[1]);;
 eq:=TransposedMat(Concatenation(List(mats,m->TransposedMat(m-IdentityMat(d,ff)))));;
 return Length(NullspaceMat(eq));
end;;
Print("Torder=",Size(tt)," C12fixed=",fixedDim(tm12)," V11fixed=",fixedDim(tm11),"\n");
g11:=Group(tm11);;
af11:=AffineActionByMatrixGroup(g11);;
vr11:=Group(GeneratorsOfGroup(af11){[1..11]});;
co11:=OneCocycles(af11,vr11);;
Print("H1 V11: Z1dim=",Dimension(co11.oneCocycles)," B1dim=",Dimension(co11.oneCoboundaries),"\n");
Assert(0,Size(tt)=20160 and fixedDim(tm12)=1 and fixedDim(tm11)=0);
Assert(0,Dimension(co11.oneCocycles)=11 and Dimension(co11.oneCoboundaries)=11);
Print("GOLAY COHOMOLOGY CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
