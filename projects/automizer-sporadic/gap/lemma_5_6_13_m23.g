# Lemma 5.6.13 (the Co2 sources)
#
# Co2 source M23 (self-contained: builds the standard Co2): full Co1
# centralizer 1 and normalizer 241920.
#
# Writes: work/co1_co2_m23_before_global.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL ACTUAL CO2 M23-SOURCE CO1 CHECKS PASSED classes 1
# Original file: co1_co2_m23_l34_global.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_13_m23.g
LoadPackage("atlasrep");;LoadPackage("tomlib");;
Read("gap/data/co1_p98280b0.g1");;aa:=a11;;
Read("gap/data/co1_p98280b0.g2");;bb:=a21;;
GG:=Group(aa,bb);;
Word:=function(s)
 local g,c;g:=One(GG);
 for c in s do if c='a' then g:=g*aa;else g:=g*bb;fi;od;
 return g;
end;
co2a:=Word("abb")^22*Word("ab")^20*Word("abb")^18;;
co2b:=Word("abababbababb")^28*Word("abababbabababababbababb")^6*Word("abababbababb")^14;;
C2actual:=Group(co2a,co2b);;
Assert(0,Size(C2actual)=42305421312000);
Print("actual standard Co2 ",[Order(co2a),Order(co2b),Order(co2a*co2b),Order(co2a*co2b^2)],"\n");
pg9:=AtlasProgram("Co2",1,"maxes",9);;
mg:=ResultOfStraightLineProgram(pg9.program,[co2a,co2b]);;
Mactual:=Group(mg);;Assert(0,Size(Mactual)=10200960);
mt:=TableOfMarks("M23");;MU:=UnderlyingGroup(mt);;
Print("M23 TOM standardinfo ",StandardGeneratorsInfo(mt),"\n");
Assert(0,StandardGeneratorsInfo(mt)[1].ATLAS=true);
mp:=GroupHomomorphismByImages(MU,Mactual,GeneratorsOfGroup(MU),mg);;
Assert(0,mp<>fail and Size(Image(mp))=10200960);
Tinds:=Filtered([1..Length(OrdersTom(mt))],i->OrdersTom(mt)[i]=20160);;
Print("M23 order20160 TOM indices ",Tinds,"\n");
count:=0;;
for ti in Tinds do
 TT:=RepresentativeTom(mt,ti);;
 if IsomorphismGroups(PSL(3,4),TT)<>fail then
  HH:=Image(mp,TT);;count:=count+1;
  SaveWorkspace("work/co1_co2_m23_before_global.ws");;
  CC:=Centralizer(GG,HH);;Print("M23source T globalC ",Size(CC),"\n");Assert(0,Size(CC)=1);
  NN:=Normalizer(GG,HH);;Print("M23source T globalN ",Size(NN),"\n");Assert(0,Size(NN)=241920);
 fi;
od;
Assert(0,count>0);Print("ALL ACTUAL CO2 M23-SOURCE CO1 CHECKS PASSED classes ",count,"\n");
Print("FINAL\n");
QUIT;
