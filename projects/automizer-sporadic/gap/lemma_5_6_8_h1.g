# Lemma 5.6.8 (the unitary L3(4) subgroups lie in a Siegel parabolic)
#
# Z^1(T,R) has dimension 11 and B^1(T,R) dimension 9: four complement classes.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   T Hermitian9 H1 Z1dim=11 B1dim=9
# Original file: co1_u6_hermitian_h1.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_8_h1.g
ff4:=GF(4);;ff2:=GF(2);;ww:=Z(4);;
hermBasis:=[];;
for i in [1..3] do
 bb:=NullMat(3,3,ff4);;bb[i][i]:=One(ff4);;Add(hermBasis,bb);
od;
for ij in [[1,2],[1,3],[2,3]] do
 for zz in [One(ff4),ww] do
  bb:=NullMat(3,3,ff4);;bb[ij[1]][ij[2]]:=zz;;bb[ij[2]][ij[1]]:=zz^2;;Add(hermBasis,bb);
 od;
od;
hermEls:=List(Tuples(Elements(ff2),9),c->Sum([1..9],i->c[i]*hermBasis[i]));;
hermCoeff:=Tuples(Elements(ff2),9);;
actmat:=aa->List(hermBasis,bb->hermCoeff[Position(hermEls,aa*bb*TransposedMat(List(aa,r->List(r,x->x^2))))]);;
sl3:=SL(3,4);;gl3:=GL(3,4);;
l34Herm:=Group(List(GeneratorsOfGroup(sl3),actmat));;
pglHerm:=Group(List(GeneratorsOfGroup(gl3),actmat));;
frobHerm:=List(hermBasis,bb->hermCoeff[Position(hermEls,List(bb,r->List(r,x->x^2)))]);;
fullHerm:=Group(Concatenation(GeneratorsOfGroup(pglHerm),[frobHerm]));;
Print("L34 Hermitian module order=",Size(l34Herm)," irreducible=",MTX.IsIrreducible(GModuleByMats(GeneratorsOfGroup(l34Herm),ff2)),"\n");
Print("PGL3order=",Size(pglHerm)," fullmodule normalizerorder=",Size(fullHerm),"\n");
af9:=AffineActionByMatrixGroup(l34Herm);;
v9:=Group(GeneratorsOfGroup(af9){[1..9]});;
co9:=OneCocycles(af9,v9);;
Print("T Hermitian9 H1 Z1dim=",Dimension(co9.oneCocycles)," B1dim=",Dimension(co9.oneCoboundaries),"\n");
Assert(0,Size(l34Herm)=20160 and Size(pglHerm)=60480 and Size(fullHerm)=120960);
Assert(0,Dimension(co9.oneCocycles)=11 and Dimension(co9.oneCoboundaries)=9);
Print("H1 CHECKS PASSED: FOUR COMPLEMENT CLASSES\n");
Print("FINAL\n");
QUIT;
