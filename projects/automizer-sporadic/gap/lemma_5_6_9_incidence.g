# Lemma 5.6.9 (L3(4) subgroups of four smaller sources)
#
# Independent incidence-only check of the same containments.
#
# Writes: work/co1_co3_tom_tclasses.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   A8 class 581 N,C [ 40320, 1 ] maximal containment [ [ 582, 40320 ] ]
# Original file: co1_l34_tom_incidence.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_9_incidence.g
LoadPackage("tomlib");;
co3tom:=TableOfMarks("Co3");;co3group:=UnderlyingGroup(co3tom);;
co3T1:=RepresentativeTom(co3tom,2373);;co3T2:=RepresentativeTom(co3tom,2374);;
SaveWorkspace("work/co1_co3_tom_tclasses.ws");;
incid:=[];;
for nam in ["Co3","U4(3)","McL","HS"] do
 tt:=TableOfMarks(nam);gg:=UnderlyingGroup(tt);ord:=OrdersTom(tt);subs:=SubsTom(tt);minds:=MaximalSubgroupsTom(tt)[1];fifteen:=Filtered([1..Length(ord)],j->ord[j]=15);
 Print(nam," classes ",Length(ord)," maximal order map ",List(minds,j->[j,ord[j]]),"\n");
 for ii in Filtered([1..Length(ord)],i->ord[i]=20160) do
  hh:=RepresentativeTom(tt,ii);
  if IsSimpleGroup(hh) then
   if ForAny(fifteen,j->j in subs[ii]) then typ:="A8";else typ:="L3(4)";fi;
   nn:=Normalizer(gg,hh);cc:=Centralizer(nn,hh);cont:=Filtered(minds,j->ii in subs[j]);
   Add(incid,[typ,ii,[Size(nn),Size(cc)],List(cont,j->[j,ord[j]])]);
   Print(typ," class ",ii," N,C ",[Size(nn),Size(cc)]," maximal containment ",List(cont,j->[j,ord[j]]),"\n");
  else Add(incid,ii);Print("nonsimple order20160 class ",ii,"\n");fi;
 od;
od;
Assert(0,incid=[
["L3(4)",2373,[ 241920, 1 ],[ [ 2482, 1796256000 ], [ 2479, 13063680 ], [ 2458, 241920 ] ]],
["L3(4)",2374,[ 80640, 1 ],[ [ 2482, 1796256000 ], [ 2480, 44352000 ], [ 2479, 13063680 ],  [ 2478, 10200960 ] ]],
["A8",2375,[ 40320, 1 ],[ [ 2480, 44352000 ], [ 2478, 10200960 ] ]],
["L3(4)",376,[ 20160, 1 ],[ [ 376, 20160 ] ]],
["L3(4)",377,[ 20160, 1 ],[ [ 377, 20160 ] ]],
["L3(4)",357,[ 40320, 1 ],[ [ 372, 3265920 ], [ 366, 40320 ] ]],
["L3(4)",358,[ 20160, 1 ],[ [ 372, 3265920 ], [ 371, 443520 ], [ 370, 443520 ] ]],
["L3(4)",580,[ 40320, 1 ],[ [ 588, 443520 ], [ 583, 40320 ] ]],
["A8",581,[ 40320, 1 ],[ [ 582, 40320 ] ]]]);
Print("ALL INCIDENCE CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
