# Lemma 5.6.2 (location of an abelian realizer)
#
# The U6(2):S3 maximal of Co1, built from the standard generators: its socle
# U6(2) fixes three points of Co1/Co2.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   U6 orbitlengths onCo1/Co2=[ [ 1, 3 ], [ 891, 3 ], [ 2816, 3 ], [ 2073...
# Original file: co1_u6_co2_embedding.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_2_u6_embedding.g
Read("gap/data/co1_p98280b0.g1");;
Read("gap/data/co1_p98280b0.g2");;
GG1:=Group(a11,a21);;
a:=GeneratorsOfGroup(GG1)[1];;b:=GeneratorsOfGroup(GG1)[2];;
ug:=Group((a*b*b*a*b)^3,b);;
Print("U6:S3 max order=",Size(ug),"\n");
us:=DerivedSubgroup(DerivedSubgroup(ug));;
Print("U6 socle order=",Size(us),"\n");
Print("U6 orbitlengths onCo1/Co2=",Collected(List(Orbits(us,[1..98280]),Length)),"\n");
Assert(0,Size(ug)=55180984320 and Size(us)=9196830720);
Assert(0,Collected(List(Orbits(us,[1..98280]),Length))=[[1,3],[891,3],[2816,3],[20736,3],[24948,1]]);
Print("U6 EMBEDDING CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
