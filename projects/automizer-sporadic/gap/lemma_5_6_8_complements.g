# Lemma 5.6.8 (the unitary L3(4) subgroups lie in a Siegel parabolic)
#
# Constructs the four complement classes of R = 2^9 in the parabolic P of the
# Co1-embedded U6(2), with their local normalizer orders. Also used by
# Proposition 5.6.15.
#
# Writes: work/co1_u6_p_complements.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   class=4 local max6 normalizer=40320 centralizer=1
# Original file: co1_u6_actual_complements.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_8_complements.g
Read("gap/data/co1_p98280b0.g1");;
Read("gap/data/co1_p98280b0.g2");;
GG1:=Group(a11,a21);;
a:=GeneratorsOfGroup(GG1)[1];;b:=GeneratorsOfGroup(GG1)[2];;
ug:=Group((a*b*b*a*b)^3,b);;
Print("U6:S3 max order=",Size(ug),"\n");
us:=DerivedSubgroup(DerivedSubgroup(ug));;
Print("U6 socle order=",Size(us),"\n");
Print("U6 orbitlengths onCo1/Co2=",Collected(List(Orbits(us,[1..98280]),Length)),"\n");
uorbs:=Orbits(us,[1..98280]);;
uo891:=First(uorbs,o->Length(o)=891);;
up:=Stabilizer(us,uo891[1]);;
ur:=PCore(up,2);;
Print("U6parabolic order=",Size(up)," radical=",Size(ur)," elementary=",IsElementaryAbelian(ur),"\n");
ulcomp:=ComplementClassesRepresentatives(up,ur);;
Print("Tcomplement classes=",Length(ulcomp)," orders=",List(ulcomp,Size),"\n");
SaveWorkspace("work/co1_u6_p_complements.ws");
Assert(0,Size(up)=10321920 and Size(ur)=512 and IsElementaryAbelian(ur));
Assert(0,List(ulcomp,Size)=[20160,20160,20160,20160]);
for uli in [1..Length(ulcomp)] do
 Print("class=",uli," local max6 normalizer=",Size(Normalizer(ug,ulcomp[uli]))," centralizer=",Size(Centralizer(ug,ulcomp[uli])),"\n");
od;
# The order of the classes depends on the GAP version; lemma_5_6_8_select.g fixes it.
Assert(0,SortedList(List(ulcomp,l->Size(Normalizer(ug,l))))=[40320,40320,40320,241920]);
Assert(0,ForAll(ulcomp,l->Size(Centralizer(ug,l))=1));
Print("ALL COMPLEMENT CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
