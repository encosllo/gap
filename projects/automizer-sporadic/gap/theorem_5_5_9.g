# Theorem 5.5.9 (the triple-cover obstruction and recognition of Fi24')
#
# The cohomology and vector-orbit computations for the triple cover, on six-
# and seven-dimensional matrix groups over F_3; the maximal lists and Brauer
# tables are stated data inputs.
#
# Expected: the output ends with ALL FI24 TRIPLE-COVER CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_5_5_9.g
LoadPackage("ctbllib");;
tord:=6065280;;
rows:=[
 ["F3+",["Fi23","2.Fi22.2","(3xO8+(3):3):2","3^7.O7(3)"]],
 ["Fi23",["2.Fi22","O8+(3).3.2","S3xO7(3)"]],
 ["Fi22",["O7(3)","Fi22M3"]],
 ["O7(3)",["L4(3).2_2"]],
 ["O8+(3)",["O7(3)","O8+(3)M2","O8+(3)M3",
  "O8+(3)M4","O8+(3)M5","O8+(3)M6",
  "3^6:L4(3)","O8+(3)M8","O8+(3)M9"]]
];;
for row in rows do
 tab:=CharacterTable(row[1]);
 kept:=Filtered(Maxes(tab),nm->Size(CharacterTable(nm)) mod tord=0);
 if Set(kept)<>Set(row[2]) then Error("maximal filter");fi;
 Print(row[1]," retained maximal classes = ",Length(kept),"\n");
od;
eligible:=function(nm,bound)
 return Filtered(Maxes(CharacterTable(nm)),x->
  Size(CharacterTable(x)) mod tord=0 and
  Size(CharacterTable(x)) mod 3^bound=0);
end;;
if Set(eligible("F3+",12))<>
 Set(["Fi23","(3xO8+(3):3):2","3^7.O7(3)"]) or
 Set(eligible("Fi23",12))<>Set(["O8+(3).3.2"]) or
 Set(eligible("O8+(3)",10))<>
 Set(["3^6:L4(3)","O8+(3)M8","O8+(3)M9"]) then
 Error("abelian normalizer order filters");fi;
tt:=CharacterTable("L4(3)");;
b2:=tt mod 2;;b3:=tt mod 3;;
if Minimum(Filtered(List(Irr(b2),c->c[1]),d->d>1))<>26 or
 Filtered(List(Irr(b3),c->c[1]),d->d<=8)<>[1,6] then
 Error("small L4(3) modules");fi;
bc:=CharacterTable("2.L4(3)") mod 3;;
if SortedList(Filtered(List(Irr(bc),c->c[1]),d->d<=8))<>
 [1,4,4,6] then Error("small SL4(3) modules");fi;
small4:=Filtered(Irr(bc),c->c[1]=4);;
if ComplexConjugate(small4[1])<>small4[2] or
 small4[1]=small4[2] then Error("degree-four duality");fi;
qo:=CharacterTable("O7(3)") mod 3;;
if Filtered(List(Irr(qo),c->c[1]),d->d<=7)<>[1,7] then
 Error("natural seven-dimensional module");fi;
mt:=CharacterTable("3^7.O7(3)");;
if ClassPositionsOfCentre(mt)<>[1] then Error("M5 center");fi;
st:=CharacterTable("F3+");;
pos:=Filtered([1..NrConjugacyClasses(st)],
 i->OrdersClassRepresentatives(st)[i]=13);;
if Length(pos)<>1 or
 Size(st)/SizesConjugacyClasses(st)[pos[1]]<>234 or
 Size(CharacterTable("(3^2:2xG2(3)).2")) mod 5=0 then
 Error("13-centralizer input");fi;
Print("small-module and centralizer inputs passed\n");
for d in [6,7] do
 if d=6 then mat:=Omega(1,6,3);else mat:=Omega(0,7,3);fi;
 aff:=AffineActionByMatrixGroup(mat);
 vec:=Group(GeneratorsOfGroup(aff){[1..d]});
 if Size(vec)<>3^d or Size(aff)<>3^d*Size(mat) then
  Error("affine model");fi;
 co:=OneCocycles(aff,vec);
 if not co.isSplitExtension or Dimension(co.oneCocycles)<>d or
 Dimension(co.oneCoboundaries)<>d then Error("nonzero H1");fi;
 Print("dimension ",d,": dim Z1 = dim B1 = ",d,"\n");
od;
mat:=Omega(0,7,3);;
orbs:=OrbitsDomain(mat,Elements(GF(3)^7),OnRight);;
if SortedList(List(orbs,Length))<>[1,702,728,756] then
 Error("natural vector orbits");fi;
orb:=First(orbs,o->Length(o)=756);;
stab:=Stabilizer(mat,orb[1],OnRight);;
if Size(stab)<>tord or Size(Centre(stab))<>1 or
 not IsSimpleGroup(stab) then Error("covering witness stabilizer");fi;
Print("orbit 756 stabilizer: order ",Size(stab),", simple = true\n");
Print("ALL FI24 TRIPLE-COVER CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
