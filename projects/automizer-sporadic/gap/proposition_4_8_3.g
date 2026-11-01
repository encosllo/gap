# Proposition 4.8.3 (local data for the O'Nan cover)
#
# The local checks on groups of order at most 512 used to exclude 3.O'N
# (Theorem 4.8.4). The epicentre step takes longer than the others.
#
# Expected: the output ends with ALL ON LOCAL CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/proposition_4_8_3.g
LoadPackage("smallgrp");;
LoadPackage("transgrp");;
LoadPackage("primgrp");;
F := Stabilizer(PrimitiveGroup(81,90),1);;
if IdGroup(F) <> [320,1581] then Error("F"); fi;
if List(MinimalNormalSubgroups(F),Size) <> [2] then
  Error("minimal normal subgroup");
fi;
if Set(List(Filtered(NormalSubgroups(F),IsAbelian),Size))
   <> [1,2] then Error("abelian normal subgroups"); fi;
ids := Set(List(Filtered(NormalSubgroups(F),
                        h -> Size(h)>1),IdGroup));;
if ids <> [[2,1],[32,50],[160,199],[320,1581]] then
  Error("normal subgroup list");
fi;
for id in ids do
  if Size(Epicentre(SmallGroup(id[1],id[2]))) <> 2 then
    Error("epicentre");
  fi;
od;
P := TransitiveGroup(16,975);;
cc := ConjugacyClassesSubgroups(P);;
if Size(P)<>512 or Length(cc)<>420 then Error("P"); fi;
seen := [];; rows := [];;
for cl in cc do
  H := Representative(cl);
  if Size(H)=512 then id := "full Sylow";
  else id := IdGroup(H); fi;
  if not id in seen then
    Add(seen,id);
    aut := AutomorphismGroup(H);
    if Size(aut) mod 320 = 0 then
      o2 := PCore(aut,2);
      Add(rows,[id,Size(aut),Size(o2),
                IsElementaryAbelian(o2)]);
    fi;
  fi;
od;
if Length(seen)<>77 or Set(rows) <>
  [[[32,50],1920,16,true],
   [[64,266],23040,32,true]] then Error("aut groups"); fi;
Print("ALL ON LOCAL CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
