# Lemma 5.6.1 (Cover presence)
#
# Presence: W = 2^10 misses the centre, has character multiplicities 1^22 2^1,
# its monomial stabilizer K has order 40320 and table L3(4).2_2, acting faithfully.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   Wactionorder=40320
# Original file: co1_l34outer_cover_presence.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_1.g
LoadPackage("ctbllib");;
m24:=MathieuGroup(24);;ff:=GF(2);;
gm:=List(GeneratorsOfGroup(m24),g->PermutationMat(g,24,ff));;
bg:=First(MTX.BasesSubmodules(GModuleByMats(gm,ff)),b->Length(b)=12);;
cons:=List(bg,v->[v[1],v[2]+v[3]]);;
wb:=NullspaceMat(cons)*bg;;
kw:=Intersection(Stabilizer(m24,1),Stabilizer(m24,[2,3],OnSets));;
Print("source overgrouporders=",[Size(Stabilizer(m24,1)),Size(Stabilizer(m24,[2,3],OnSets)),Size(Stabilizer(m24,[1,2,3],OnSets))],"\n");
Print("Wdimension=",Length(wb)," containscentre=",List([1..24],i->One(ff)) in VectorSpace(ff,wb)," Korder=",Size(kw),"\n");
chs:=TransposedMat(wb);;
Print("Wcharacters=",Collected(List(Set(chs),v->Number(chs,x->x=v)))," zerocharacterindexes=",Filtered([1..24],i->IsZero(chs[i])),"\n");
Print("Ktableidentified=",TransformingPermutationsCharacterTables(CharacterTable(kw),CharacterTable("L3(4).2_2"))<>fail,"\n");
Bwb:=Basis(VectorSpace(ff,wb),wb);;
wa:=Group(List(GeneratorsOfGroup(kw),g->List(wb,v->Coefficients(Bwb,v*PermutationMat(g,24,ff)))));;
Print("Wactionorder=",Size(wa),"\n");
Assert(0,Length(wb)=10 and not List([1..24],i->One(ff)) in VectorSpace(ff,wb));
Assert(0,Size(kw)=40320 and Size(wa)=40320);
Assert(0,Collected(List(Set(chs),v->Number(chs,x->x=v)))=[[1,22],[2,1]]);
Assert(0,TransformingPermutationsCharacterTables(CharacterTable(kw),CharacterTable("L3(4).2_2"))<>fail);
Print("ALL COVER PRESENCE CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
