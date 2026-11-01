# Lemma 5.6.1 (Cover presence)
#
# Independent check of the presence of L3(4):2_2 in 2.Co1, from the Golay code
# of M24.
#
# Expected: the output ends with ALL CO1 GOLAY WITNESS CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_1_check.g
LoadPackage("ctbllib");;
M24:=MathieuGroup(24);;ff:=GF(2);;
gm:=List(GeneratorsOfGroup(M24),g->PermutationMat(g,24,ff));;
bg:=First(MTX.BasesSubmodules(GModuleByMats(gm,ff)),b->Length(b)=12);;
Assert(0,bg<>fail);
constraints:=List(bg,v->[v[1],v[2]+v[3]]);;
wb:=NullspaceMat(constraints)*bg;;
onesword:=List([1..24],i->One(ff));;
Assert(0,Length(wb)=10 and not onesword in VectorSpace(ff,wb));
characters:=TransposedMat(wb);;
Assert(0,Collected(List(Set(characters),v->Number(characters,x->x=v)))=[[1,22],[2,1]]);
Assert(0,Filtered([1..24],i->IsZero(characters[i]))=[1]);
Assert(0,characters[2]=characters[3]);
kw:=Intersection(Stabilizer(M24,1),Stabilizer(M24,[2,3],OnSets));;
Assert(0,Size(kw)=40320 and Size(DerivedSubgroup(kw))=20160);
Assert(0,IsomorphismGroups(DerivedSubgroup(kw),PSL(3,4))<>fail);
Assert(0,TransformingPermutationsCharacterTables(CharacterTable(kw),CharacterTable("L3(4).2_2"))<>fail);
wa:=Group(List(GeneratorsOfGroup(kw),g->List(wb,v->SolutionMat(wb,v*PermutationMat(g,24,ff)))));;
Assert(0,Size(wa)=40320);
Print("Golay W: dimension10, misses scalar centre; faithful automizer L3(4).2_2 of order40320\n");
Print("ALL CO1 GOLAY WITNESS CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
