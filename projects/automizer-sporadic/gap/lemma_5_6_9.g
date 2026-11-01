# Lemma 5.6.9 (L3(4) subgroups of four smaller sources)
#
# Complete table-of-marks enumeration of the L3(4) classes in Co3, U4(3), McL
# and HS, with their normalizers, centralizers and maximal overgroups; explicit
# isomorphisms distinguish A8.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   order20160 class 581 element orders [ 1, 2, 3, 4, 5, 6, 7, 15 ]
# Original file: co1_l34_tom_complete.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_9.g
LoadPackage("tomlib");;
l34rows:=[];;
for nam in ["Co3","U4(3)","McL","HS"] do
 tt:=TableOfMarks(nam);
 if tt<>fail then
  gg:=UnderlyingGroup(tt);ord:=OrdersTom(tt);minds:=MaximalSubgroupsTom(tt)[1];subs:=SubsTom(tt);
  Print(nam," TOM classes ",Length(ord)," maximal indices ",minds,"\n");
  for ii in Filtered([1..Length(ord)],i->ord[i]=20160) do
   hh:=RepresentativeTom(tt,ii);
   eo:=Set(List(ConjugacyClasses(hh),c->Order(Representative(c))));
   Print("order20160 class ",ii," element orders ",eo,"\n");
   if not 15 in eo and IsSimpleGroup(hh) then
    ism:=IsomorphismGroups(hh,PSL(3,4));Assert(0,ism<>fail);
    nn:=Normalizer(gg,hh);cc:=Centralizer(nn,hh);
    cont:=Filtered(minds,j->ii in subs[j]);
    Add(l34rows,[ii,[Size(nn),Size(cc)],List(cont,j->[j,ord[j]])]);
    Print("L34 ",ii," N,C ",[Size(nn),Size(cc)]," maximal containment ",List(cont,j->[j,ord[j]]),"\n");
   fi;
  od;
 fi;
od;
Assert(0,l34rows=[
[2373,[ 241920, 1 ],[ [ 2482, 1796256000 ], [ 2479, 13063680 ], [ 2458, 241920 ] ]],
[2374,[ 80640, 1 ],[ [ 2482, 1796256000 ], [ 2480, 44352000 ], [ 2479, 13063680 ],  [ 2478, 10200960 ] ]],
[376,[ 20160, 1 ],[ [ 376, 20160 ] ]],
[377,[ 20160, 1 ],[ [ 377, 20160 ] ]],
[357,[ 40320, 1 ],[ [ 372, 3265920 ], [ 366, 40320 ] ]],
[358,[ 20160, 1 ],[ [ 372, 3265920 ], [ 371, 443520 ], [ 370, 443520 ] ]],
[580,[ 40320, 1 ],[ [ 588, 443520 ], [ 583, 40320 ] ]]]);
Print("ALL L34 CONTAINMENT CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
