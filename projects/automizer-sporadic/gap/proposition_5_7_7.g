# Proposition 5.7.7 (no realization with abelian Sylow 3-subgroup)
#
# 154 quaternion-compatible parents, 846 extensions, 122 automizers of order
# 1296, none isomorphic to F.
#
# Input: work/fi22_base_allabelian3.ws (see run_checks.sh for the script that writes it).
# Writes: work/fi22_base_f1296_abelian_parent_found.ws, work/fi22_abelian_parent_twoextensions.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL ABELIAN P3 MIXED COMPLETE parentcount 154 extensions 846 order129...
# Original file: fi22_abelian_parent_twoextensions.g (L. Gong and Y. Yan, 2026-10-25).
# Change: the variable Next is renamed NextN, since Next is a read-only global in GAP 4.16.
# Usage: gap -q --quitonbreak -L work/fi22_base_allabelian3.ws gap/lib.g gap/proposition_5_7_7.g
Read("gap/data/fi22_target1296_matrix4.g");;
vecs:=AsList(FullRowSpace(GF(3),4));;
fl:=List(GeneratorsOfGroup(TargetK16),g->PermList(List(vecs,v->Position(vecs,v*g))));;
ft:=List(IdentityMat(4,GF(3)),e->PermList(List(vecs,v->Position(vecs,v+e))));;
Ftarget:=Group(Concatenation(fl,ft));;
normalInnOrders:=Set(List(NormalSubgroups(Ftarget),Size));;
HasQ8:=function(a)local p2,ia2,pc2;p2:=SylowSubgroup(a,2);if Size(p2)<8 then return false;fi;ia2:=IsomorphismPcGroup(p2);pc2:=Image(ia2);return ForAny(ConjugacyClassesSubgroups(pc2),c->Size(Representative(c))=8 and IdGroup(Representative(c))=[8,4]);end;;
q8types:=[];;
for typ in Set(List(rowsall,r->r[7])) do
 if IsList(typ) and not IsString(typ) then aa:=SmallGroup(typ);
 else rr0:=First(rowsall,r->r[7]=typ);hp:=PreImage(ip,rr[rr0[1]]);np:=Normalizer(Sbase,hp);cp:=Centralizer(np,hp);aa:=FactorGroup(np,cp);fi;
 if HasQ8(aa) then Add(q8types,typ);fi;
od;
abeparents:=Filtered(rowsall,r->r[7] in q8types);;
Print("full-A Q8-containing abelian parents ",Length(abeparents)," types ",q8types,"\n");
abeMixedData:=[];;abeTargetFound:=false;;abeExtCount:=0;;abeOrderHit:=0;;
for row in abeparents do
 ipar:=row[1];Pmix:=PreImage(ip,rr[ipar]);Nmix:=Normalizer(Sbase,Pmix);Cmix:=Centralizer(Nmix,Pmix);
 PN2:=SylowSubgroup(Nmix,2);iPN2:=IsomorphismPcGroup(PN2);pcPN2:=Image(iPN2);
 nqmap:=NaturalHomomorphismByNormalSubgroup(Nmix,Pmix);Nquot:=Image(nqmap);Zpmix:=Pmix;
 sub2mix:=Filtered(ConjugacyClassesSubgroups(pcPN2),c->Size(Representative(c))>1);
 pcount:=0;ohit:=0;thiscases:=[];
 for qcl in sub2mix do
  Qmix:=PreImage(iPN2,Representative(qcl));qb:=Image(nqmap,Qmix);
  zPfix:=Centralizer(Zpmix,Qmix);zQfix:=Centralizer(Centre(Qmix),Pmix);
  zextSize:=Size(zPfix)*Size(zQfix);innExt:=Size(Pmix)*Size(Qmix)/zextSize;
  if not innExt in normalInnOrders or innExt=1 then continue;fi;
  Cext:=Centralizer(Cmix,Qmix);Nqb:=Normalizer(Nquot,qb);aextSize:=Size(Pmix)*Size(Nqb)/Size(Cext);
  pcount:=pcount+1;abeExtCount:=abeExtCount+1;
  if aextSize=1296 then
   ohit:=ohit+1;abeOrderHit:=abeOrderHit+1;
   NextN:=PreImage(nqmap,Nqb);Hext:=PreImage(nqmap,qb);Aext:=FactorGroup(NextN,Cext);
   o3ext:=PCore(Aext,3);p2ext:=SylowSubgroup(Aext,2);
   sigext:=[ipar,Size(Pmix),Size(Qmix),IdGroup(Qmix),Size(Hext),zextSize,Size(NextN),Size(Cext),Size(o3ext),IsElementaryAbelian(o3ext),IdGroup(p2ext)];
   Print("order1296 abelian-parent extension ",sigext,"\n");Add(thiscases,[Hext,NextN,Cext,Aext,sigext]);
   if Size(o3ext)=81 and IsElementaryAbelian(o3ext) and IdGroup(p2ext)=[16,12] and IsomorphismGroups(Aext,Ftarget)<>fail then
    abeTargetFound:=true;Print("FULL F1296 BASE MIXED ABELIAN-P3 PRESENT\n");SaveWorkspace("work/fi22_base_f1296_abelian_parent_found.ws");break;
   fi;
  fi;
 od;
 Add(abeMixedData,[ipar,Pmix,Nmix,Cmix,pcount,ohit,thiscases]);
 Print("parent finished ",ipar," Psize ",Size(Pmix)," eligible2extensions ",pcount," order1296 ",ohit,"\n");
 if abeTargetFound then break;fi;
od;
Print("ALL ABELIAN P3 MIXED COMPLETE parentcount ",Length(abeMixedData)," extensions ",abeExtCount," order1296 ",abeOrderHit," target ",abeTargetFound,"\n");
SaveWorkspace("work/fi22_abelian_parent_twoextensions.ws");
Assert(0,Length(abeMixedData)=154 and abeExtCount=846 and abeOrderHit=122 and abeTargetFound=false);
Print("ABELIAN-P ABSENCE ASSERTED\n");
Print("FINAL\n");
QUIT;
