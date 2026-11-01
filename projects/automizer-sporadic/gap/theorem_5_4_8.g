# Theorem 5.4.8
#
# [C2 x C6] is in Spec(2.Suz) and not in Spec(Suz), with the 3.Suz generators in
# gap/data/ and the character table of 2.Suz.
#
# Expected: the output ends with ALL SUZ DOUBLE-COVER CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_5_4_8.g
LoadPackage("ctbllib");;
LoadPackage("tomlib");;
Read("gap/data/3suz_p5346b0.g1");; aa:=a11;;
Read("gap/data/3suz_p5346b0.g2");; bb:=a21;;
cov:=Group(aa,bb);; zed:=Centre(cov);;
if Size(cov)<>1345036492800 or Size(zed)<>3 then Error("wrong model");fi;
act:=ActionHomomorphism(cov,List(Orbits(zed,[1..5346]),Set),OnSets);;
sim:=Image(act);;
if Size(sim)<>448345497600 then Error("wrong Suz quotient");fi;
checkH:=function(h)
 local n,c,a;
 n:=Normalizer(sim,h);c:=Centralizer(n,h);a:=FactorGroup(n,c);
 if Size(a)=12 and IdGroup(a)=[12,5] then Error("base witness exists");fi;
end;;
checkInner:=h->Size(h)/Size(Centre(h))<=4;;
# Pure 2, abelian branch.  A fully normalized representative must
# have Sylow-2 automizer V4.  All P-conjugacy classes are retained.
sp:=SylowSubgroup(sim,2);; pi:=IsomorphismPcGroup(sp);; pc:=Image(pi);;
acl:=ConjugacyClassesSubgroups(LatticeByCyclicExtension(pc,IsAbelian,true));;
if Length(acl)<>2120 then Error("abelian lattice size");fi;
count:=0;;
for cl in acl do
 hp:=Representative(cl);
 if Size(hp)>1 then
  n:=Normalizer(pc,hp);c:=Centralizer(n,hp);a:=FactorGroup(n,c);
  if Size(a)=4 and IsElementaryAbelian(a) then
   checkH(PreImage(pi,hp));count:=count+1;
  fi;
 fi;
od;
if count<>559 then Error("abelian local filter count");fi;
Print("pure-2 abelian global checks = ",count,"\n");
# Every odd-order Sylow subgroup of a possible H is central.
# For x of odd prime order, all H containing x are full preimages
# of subgroup classes of C_S(x)/<x>.
checkCentralizer:=function(x)
 local p,c,qmap,q,t,u,iqu,subgroups,iqp,qpc,accept,cls,
       h,k,count,centorder;
 p:=Subgroup(sim,[x]);c:=Centralizer(sim,x);centorder:=Size(c);
 if Order(x)=3 then
  qmap:=NaturalHomomorphismByNormalSubgroup(c,p);q:=Image(qmap);
  if centorder=9797760 then
   t:=TableOfMarks("U4(3)");u:=UnderlyingGroup(t);
   iqu:=IsomorphismGroups(u,q);
   if iqu=fail or Length(OrdersTom(t))<>381 then Error("U43 input");fi;
   subgroups:=List([1..Length(OrdersTom(t))],
                   i->Image(iqu,RepresentativeTom(t,i)));
  elif centorder=34992 then
   iqp:=IsomorphismPcGroup(q);qpc:=Image(iqp);
   accept:=k->checkInner(PreImage(qmap,PreImage(iqp,k)));
   cls:=ConjugacyClassesSubgroups(LatticeByCyclicExtension(qpc,accept,true));
   subgroups:=List(cls,k->PreImage(iqp,Representative(k)));
   if Length(subgroups)<>62 then Error("3B filtered lattice size");fi;
  elif centorder=3240 then
   subgroups:=List(ConjugacyClassesSubgroups(q),Representative);
   if Length(subgroups)<>50 then Error("3C subgroup class count");fi;
  else Error("unexpected 3-centralizer");fi;
  subgroups:=List(subgroups,k->PreImage(qmap,k));
 else
  subgroups:=Filtered(List(ConjugacyClassesSubgroups(c),Representative),
                      h->IsSubgroup(h,p));
 fi;
 count:=0;
 for h in subgroups do
  if checkInner(h) then checkH(h);count:=count+1;fi;
 od;
 Print("odd centralizer [p,|C|,global checks] = ",
       [Order(x),centorder,count],"\n");
 return [Order(x),centorder,count];
end;;
classes:=ConjugacyClasses(sim);;
results:=List(Filtered(classes,c->Order(Representative(c)) in [3,5,7,11,13]),
              c->checkCentralizer(Representative(c)));;
if SortedList(results)<>SortedList([[3,9797760,56],[3,34992,62],[3,3240,24],
 [5,300,5],[5,1800,10],[7,84,4],[11,11,1],[13,13,1],[13,13,1]]) then
 Error("odd branch counts");fi;
# Cover witness, from complete character-table power maps.
t:=CharacterTable("2.Suz");;
pos:=Filtered([1..NrConjugacyClasses(t)],i->OrdersClassRepresentatives(t)[i]=28);;
if Length(pos)<>1 then Error("order-28 class count");fi;
i:=pos[1];; units:=Filtered([1..28],k->Gcd(k,28)=1);;
if not ForAll(units,k->PowerMap(t,k)[i]=i) then Error("unit power class");fi;
a:=Group(List(units,k->PermList(List([0..27],j->(j*k mod 28)+1))));;
if IdGroup(a)<>[12,5] then Error("cover automizer type");fi;
Print("cover C28 automizer = ",IdGroup(a),"\n");
# Pure 2, nonabelian branch.  H'=C2 is characteristic, hence
# N_S(H) centralizes its generator z.  Work in each C_S(z).
involutions:=Filtered(classes,c->Order(Representative(c))=2);;
if Length(involutions)<>2 then Error("involution class count");fi;
nonabelResults:=[];;
for cl in involutions do
 z:=Representative(cl);cz:=Centralizer(sim,z);
 pz:=SylowSubgroup(cz,2);iz:=IsomorphismPcGroup(pz);pcz:=Image(iz);
 qmap:=NaturalHomomorphismByNormalSubgroup(pcz,Group(Image(iz,z)));
 q:=Image(qmap);
 cls:=ConjugacyClassesSubgroups(LatticeByCyclicExtension(q,IsAbelian,true));
 eligible:=0;count:=0;
 for qc in cls do
  hp:=PreImage(qmap,Representative(qc));
  if Size(hp)/Size(Centre(hp))=4 and Size(DerivedSubgroup(hp))=2 then
   eligible:=eligible+1;
   n:=Normalizer(pcz,hp);c:=Centralizer(n,hp);
   if Size(n)/Size(c)=4 then
    checkH(PreImage(iz,hp));count:=count+1;
   fi;
  fi;
 od;
 Add(nonabelResults,[Size(cz),Size(pz),Length(cls),eligible,count]);
 Print("nonabelian-2 [C,P,classes,eligible,global checks] = ",
       nonabelResults[Length(nonabelResults)],"\n");
od;
if SortedList(nonabelResults)<>SortedList([
 [3317760,8192,4950,3272,123],[161280,512,218,16,2]]) then
 Error("nonabelian-2 branch counts");fi;
Print("ALL SUZ DOUBLE-COVER CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
