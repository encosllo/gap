# Theorem 5.2.1 (the Rudvalis double cover)
#
# [C3] is in Spec(Ru) and not in Spec(2.Ru). Builds Ru (degree 4060) and 2.Ru
# (degree 16240) from the ATLAS generators in gap/data/; the paper records 5751
# abelian Sylow 2-subgroup classes, 123 full normalizer checks, 351 strict profile
# exclusions and 17 mixed-subgroup checks. The workspace
# work/ru_c3_canonical_after_lattice.ws is an optional checkpoint.
#
# Expected: the output ends with ALL RUDVALIS C3 CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_5_2_1.g
# Complete standalone Rudvalis C3 certificate. Run from project root.
LoadPackage("ctbllib");;
Read("gap/data/ru_p4060b0.g1");;basea:=bin1;;Read("gap/data/ru_p4060b0.g2");;baseb:=bin1;;
baseS:=Group(basea,baseb);;baseH:=Centre(Centralizer(baseS,basea));;
baseN:=Normalizer(baseS,baseH);;baseC:=Centralizer(baseN,baseH);;
Assert(0,Size(baseH)=4 and IsElementaryAbelian(baseH));
Assert(0,[Size(baseN),Size(baseC)]=[349440,116480]);
Print("Ru C3 witness H,N,C ",[Size(baseH),Size(baseN),Size(baseC)],"\n");
Read("gap/data/2ru_p16240b0.g1");;a:=bin1;;Read("gap/data/2ru_p16240b0.g2");;b:=bin1;;
gg:=Group(a,b);;PP:=SylowSubgroup(gg,2);;iso:=IsomorphismPcGroup(PP);;pc:=Image(iso);;
Assert(0,Size(gg)=2*Size(baseS) and Size(Centre(gg))=2);
cl:=ConjugacyClassesSubgroups(LatticeByCyclicExtension(pc,IsAbelian,true));;
Assert(0,Length(cl)=5751);Print("cover abelian Sylow2 classes ",Length(cl),"\n");
SaveWorkspace("work/ru_c3_canonical_after_lattice.ws");;
ruF2:=GF(2);;ruVecs:=rec();;ruC3perms:=rec();;
for rr in [2,3,4] do
 vv:=Filtered(Tuples([Zero(ruF2),One(ruF2)],rr),v->not IsZero(v));
 pg:=Action(GL(rr,2),vv,OnRight);
 ruVecs.(String(rr)):=vv;
 ruC3perms.(String(rr)):=Filtered(Elements(pg),q->Order(q)=3);
 Print("rank ",rr," order3 matrices ",Length(ruC3perms.(String(rr))),"\n");
od;
num:=0;;checks:=0;;colorSkipped:=0;;poss:=[];;
priority:=Filtered([1..Length(cl)],i->AbelianInvariants(Representative(cl[i])) in [[2,2,4],[2,2,2,2,2]]);;
orderclasses:=Concatenation(priority,Difference([1..Length(cl)],priority));;
for ii in orderclasses do
 hh:=Representative(cl[ii]);inv:=AbelianInvariants(hh);
 if Length(inv)>=2 and ForAny(Set(inv),q->Number(inv,x->x=q)>=2) then
  if Size(Normalizer(pc,hh))<>Size(Centralizer(pc,hh)) then continue;fi;
  could:=true;
  if IsElementaryAbelian(hh) and Length(inv)<=4 then
   rr:=Length(inv);vv:=ruVecs.(String(rr));gens:=Pcgs(hh);
   cols:=List(vv,v->NrMovedPoints(PreImagesRepresentative(iso,Product([1..rr],j->gens[j]^(Int(v[j]))))));
   possibleC3:=Filtered(ruC3perms.(String(rr)),q->ForAll([1..Length(cols)],j->cols[j]=cols[j^q]));
   could:=Length(possibleC3)>0;
   if could then
    hm:=List(vv,v->PreImagesRepresentative(iso,Product([1..rr],j->gens[j]^Int(v[j]))));
    hp:=PreImage(iso,hh);orbs:=Orbits(hp,[1..16240]);keys:=[];cts:=[];
    for orb in orbs do
     pt:=orb[1];key:=Filtered([1..Length(hm)],j->pt^hm[j]=pt);pos:=Position(keys,key);
     if pos=fail then Add(keys,key);Add(cts,1);else cts[pos]:=cts[pos]+1;fi;
    od;
    could:=ForAny(possibleC3,q->ForAll([1..Length(keys)],j->Position(keys,Set(keys[j],i->i^q))<>fail and cts[j]=cts[Position(keys,Set(keys[j],i->i^q))]));
   fi;
  fi;
  if could then
   Add(poss,ii);hp:=PreImage(iso,hh);nn:=Normalizer(gg,hp);zz:=Centralizer(nn,hp);ao:=Size(nn)/Size(zz);checks:=checks+1;
   Print("class ",ii," inv ",inv," Aorder ",ao,"\n");
   if ao=3 then num:=num+1;Print("C3 COVER FOUND\n");break;fi;
  else colorSkipped:=colorSkipped+1;
  fi;
 fi;
od;
Print("PROFILE SCAN COMPLETE checks ",checks," skipped ",colorSkipped," C3 ",num,"\n");
Assert(0,num=0);

# Every odd abelian primary has rank at most two and exponent p.
for oddp in [3,5] do
 oddP:=SylowSubgroup(gg,oddp);;Assert(0,Size(oddP)=oddp^3 and Exponent(oddP)=oddp);
 oddvals:=[];;
 for oddcl in ConjugacyClassesSubgroups(oddP) do
  oddH:=Representative(oddcl);
  if IsAbelian(oddH) then
   Assert(0,Size(oddH)<=oddp^2);
   if Size(oddH)=oddp^2 then
    oddN:=Normalizer(gg,oddH);oddC:=Centralizer(oddN,oddH);
    Assert(0,Size(oddC)=2*oddp^2);
    AddSet(oddvals,Size(oddN)/Size(oddC));
   fi;
  fi;
 od;
 if oddp=3 then Assert(0,oddvals=[48]);else Assert(0,oddvals=[40,480]);fi;
 Print("odd rank2 p ",oddp," C order ",2*oddp^2," automizer orders ",oddvals,"\n");
od;
# One class of cyclic 3,7,13,15 subgroups; two cyclic 5 classes
# have distinct centralizer orders. Sylow 29-subgroups are conjugate.
ct:=CharacterTable("2.Ru");oo:=OrdersClassRepresentatives(ct);
Assert(0,List([3,5,7,13,15],p->Number(oo,x->x=p))=[1,2,1,1,1]);
tot:=0;;found:=0;;
for pp in [3,5,7,13,29] do
 syl:=SylowSubgroup(gg,pp);;
 cyclicodds:=List(Filtered(ConjugacyClassesSubgroups(syl),c->Size(Representative(c))=pp),Representative);;
 seencent:=[];
 for kk in cyclicodds do
  cc:=Centralizer(gg,kk);if Size(cc) in seencent then continue;fi;Add(seencent,Size(cc));qq:=SylowSubgroup(cc,2);Print("BEGIN p ",pp," C ",Size(cc)," Q ",IdGroup(qq),"\n");
  vals:=[];
  for cs in ConjugacyClassesSubgroups(qq) do
   hh2:=Representative(cs);
   if IsAbelian(hh2) and (Size(AutomorphismGroup(hh2))*(pp-1)) mod 3=0 then
    hh:=ClosureGroup(kk,hh2);nn:=Normalizer(gg,hh);zz:=Centralizer(nn,hh);aa:=FactorGroup(nn,zz);tot:=tot+1;
    AddSet(vals,[AbelianInvariants(hh2),IdGroup(aa)]);
    if Size(aa)=3 then found:=found+1;Print("MIXED C3 COVER FOUND p ",pp," H2 ",AbelianInvariants(hh2),"\n");fi;
   fi;
  od;
  Print("p ",pp," C=",Size(cc)," P2=",IdGroup(qq)," mixed ",vals,"\n");
 od;
od;
# An odd cyclic subgroup of order 15 is the unique odd Hall subgroup
# above an element of order 15 in Ru; there is one such class.
x:=Random(gg);while Order(x) mod 15<>0 do x:=Random(gg);od;;kk:=Subgroup(gg,[x^(Order(x)/15)]);;
cc:=Centralizer(gg,kk);qq:=SylowSubgroup(cc,2);vals:=[];;
for cs in ConjugacyClassesSubgroups(qq) do
 hh2:=Representative(cs);
 if IsAbelian(hh2) and (Size(AutomorphismGroup(hh2))*8) mod 3=0 then
  hh:=ClosureGroup(kk,hh2);nn:=Normalizer(gg,hh);zz:=Centralizer(nn,hh);aa:=FactorGroup(nn,zz);tot:=tot+1;
  AddSet(vals,[AbelianInvariants(hh2),IdGroup(aa)]);
  if Size(aa)=3 then found:=found+1;Print("MIXED C3 COVER FOUND 15 ",AbelianInvariants(hh2),"\n");fi;
 fi;
od;
Print("odd 15 C=",Size(cc)," P2=",IdGroup(qq)," mixed ",vals,"\n");
Print("ALL MIXED CHECKS ",tot," C3 ",found,"\n");
Assert(0,found=0);Print("ALL RUDVALIS C3 CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
