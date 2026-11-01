# Theorem 5.4.4 (a witness excluding 3.Suz and 6.Suz)
#
# [L2(11)] is in Spec(3.Suz) and Spec(6.Suz) and not in Spec(Suz). Builds 3.Suz
# (degree 5346) from the ATLAS generators in gap/data/.
#
# Expected: the output ends with ALL SUZ TRIPLE-COVER CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_5_4_4.g
LoadPackage("tomlib");;
Read("gap/data/3suz_p5346b0.g1");; a:=a11;;
Read("gap/data/3suz_p5346b0.g2");; b:=a21;;
cover:=Group(a,b);; zed:=Centre(cover);;
if Size(cover)<>1345036492800 or Size(zed)<>3 then
 Error("wrong 3.Suz model");
fi;
act:=ActionHomomorphism(cover,List(Orbits(zed,[1..5346]),Set),OnSets);;
sim:=Image(act);; aa:=Image(act,a);; bb:=Image(act,b);;
if Size(sim)<>448345497600 then Error("wrong Suz quotient");fi;
word:=function(x,y,s)
 local r,c;
 r:=One(x);
 for c in s do if c='a' then r:=r*x;else r:=r*y;fi;od;
 return r;
end;;
makeM5:=function(x,y)
 local w;
 w:=word(x,y,"abababbababb");
 return Group((x*y)^-6*w^4*(x*y)^6,
              (x*y*y)^-5*w^6*(x*y*y)^5);
end;;
baseM:=makeM5(aa,bb);; vec:=PCore(baseM,3);;
if Size(baseM)<>1924560 or Size(vec)<>243 or
 not IsElementaryAbelian(vec) then Error("wrong base M5");fi;
if Size(Normalizer(sim,vec))<>1924560 or
 Size(Centralizer(sim,vec))<>243 then Error("base radical automizer");fi;

# Exhaustive abelian 3-subgroup input.
sp:=SylowSubgroup(baseM,3);; pciso:=IsomorphismPcGroup(sp);;
pc:=Image(pciso);; cls:=ConjugacyClassesSubgroups(pc);;
large:=Filtered(List(cls,Representative),
 h->IsAbelian(h) and Size(h)>=243);;
if Size(sp)<>2187 or Length(cls)<>720 or Length(large)<>1 or
 AbelianInvariants(large[1])<>[3,3,3,3,3] then
 Error("abelian Sylow 3 classification");fi;
if not IsConjugate(pc,large[1],Image(pciso,vec)) then
 Error("large abelian subgroup is not V");fi;
Print("Sylow 3 classes = ",Length(cls),"; large abelian classes = 1\n");

checkL:=function(h,tag)
 local n,c;
 if Size(h)<>660 or not IsSimpleGroup(h) then Error("wrong L2(11)");fi;
 n:=Normalizer(sim,h);c:=Centralizer(sim,h);
 if Size(n)<>1320 or Size(c)<>1 then Error("unexpected L2 normalizer");fi;
 Print(tag," [H,N,C] = ",[Size(h),Size(n),Size(c)],"\n");
end;;

# All L2(11) subgroups in the affine maximal subgroup.
t11:=TableOfMarks("M11");; q:=NaturalHomomorphismByNormalSubgroup(baseM,vec);;
iso11:=IsomorphismGroups(UnderlyingGroup(t11),Image(q));;
inds:=Filtered([1..Length(OrdersTom(t11))],i->OrdersTom(t11)[i]=660);;
if Length(inds)<>1 or 1320 in OrdersTom(t11) then Error("M11 class input");fi;
lin:=Image(iso11,RepresentativeTom(t11,inds[1]));;
over:=PreImage(q,lin);; comps:=ComplementClassesRepresentatives(over,vec);;
if Length(comps)<>1 then Error("more affine complements");fi;
checkL(comps[1],"M5 complement");

# Complete TomLib classes in M12 and U5(2).
m12ext:=Group((aa*bb)^-2*bb*aa*bb,(aa*bb*bb)^-6*bb*(aa*bb*bb)^6);;
m12:=DerivedSubgroup(m12ext);;
v:=word(aa,bb,"abababbab");;
u5:=Group(word(aa,bb,"abababbababb")^4,
 v^9*word(aa,bb,"abababbabababababbababb")^6*v^-9);;
if Size(m12ext)<>190080 or Size(m12)<>95040 or
 Size(u5)<>13685760 then Error("wrong maximal models");fi;
for pair in [["M12",m12,2],["U5(2)",u5,1]] do
 tt:=TableOfMarks(pair[1]);
 iso:=IsomorphismGroups(UnderlyingGroup(tt),pair[2]);
 count:=0;
 for i in [1..Length(OrdersTom(tt))] do
  if OrdersTom(tt)[i] in [660,1320] then
   hh:=RepresentativeTom(tt,i);
   if IsPerfectGroup(hh) then
    if Size(hh)=1320 then Error("2.L2(11) present");fi;
    count:=count+1;
    checkL(Image(iso,hh),Concatenation(pair[1]," class ",String(i)));
   fi;
  fi;
 od;
 if count<>pair[3] then Error("wrong number of perfect 660 classes");fi;
od;

# The covering witness: the orbit of length 12 consists of complements.
covM:=Group(Concatenation(GeneratorsOfGroup(makeM5(a,b)),
 GeneratorsOfGroup(zed)));;
rad:=PCore(covM,3);;
if Size(covM)<>5773680 or Size(rad)<>729 or
 not IsElementaryAbelian(rad) then Error("wrong cover radical");fi;
orbs:=OrbitsDomain(covM,MaximalSubgroups(rad),OnPoints);;
if SortedList(List(orbs,Length))<>[12,55,66,66,165] then
 Error("hyperplane orbits");fi;
orb:=First(orbs,o->Length(o)=12);; h:=orb[1];;
n:=Normalizer(cover,h);; c:=Centralizer(n,h);;
aut:=FactorGroup(n,c);;
if Size(h)<>243 or Size(Intersection(h,zed))<>1 or
 Size(n)<>481140 or Size(c)<>729 or
 IsomorphismGroups(aut,PSL(2,11))=fail then Error("cover witness");fi;
Print("cover witness [H,N,C,A] = ",[Size(h),Size(n),Size(c),Size(aut)],"\n");
Print("ALL SUZ TRIPLE-COVER CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
