# Theorem 3.9.3 (a graph subgroup distinguishes the triple cover)
#
# The small fiber-product model and the graph subgroup; the stored
# character-table values are a consistency check only.
#
# Expected: the output ends with ALL J3 LOCAL CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_3_9_3.g
LoadPackage("ctbllib");;
Y:=PGL(2,9);;A6sub:=DerivedSubgroup(Y);;
c:=(11,12,13);;
y:=First(Elements(Y),g->Order(g)=2 and not g in A6sub);;
t:=y*(12,13);;
M:=Group(Concatenation(GeneratorsOfGroup(A6sub),[c,t]));;
D:=Group(Concatenation(GeneratorsOfGroup(A6sub),[c]));;
Print([Size(M),Size(Centre(M)),Size(D),
 Size(Centralizer(M,A6sub)),c^t=c^-1],"\n");
tbl:=CharacterTable("j3m6");;
Print([Size(tbl),
 Number(SizesConjugacyClasses(tbl),n->n=1)],"\n");
Zcyc:=CyclicGroup(IsPermGroup,3);;F:=DirectProduct(Zcyc,M);;
iZ:=Embedding(F,1);;iM:=Embedding(F,2);;
z:=Image(iZ,GeneratorsOfGroup(Zcyc)[1]);;
K:=Group(Concatenation(
 List(GeneratorsOfGroup(A6sub),g->Image(iM,g)),
 [z*Image(iM,c)]));;
N:=Normalizer(F,K);;C:=Centralizer(F,K);;Q:=FactorGroup(N,C);;
Print([Size(K),Size(N),Size(C),Size(Q),IdGroup(Q)],"\n");
if Size(M)<>2160 or Size(Centre(M))<>1 or
 Size(N)<>3240 or Size(C)<>9 or IdGroup(Q)<>[360,118]
 then Error("unexpected local data");fi;
Print("ALL J3 LOCAL CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
