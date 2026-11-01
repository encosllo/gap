# Theorem 5.1.7 (extraction for Fi22)
#
# The character-table and numerical checks used in the proof.
#
# Expected: the output ends with ALL FI22 EXTRACTION CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_5_1_7.g
LoadPackage("ctbllib");;
t := CharacterTable("U6(2)");;
primes := [0,2,3,5,7,11];;
expected := [22,20,21,22,22,22];;
for j in [1..Length(primes)] do
  p := primes[j];
  if p = 0 then bt := t; else bt := t mod p; fi;
  d := Minimum(Filtered(List(Irr(bt),DegreeOfCharacter),x->x>1));
  if d <> expected[j] then Error("minimum degree"); fi;
od;
if 9196830720/13685760 <> 672 then Error("index"); fi;
if not (2^20 > 672^2) then Error("module bound"); fi;
if not (4585351680 < 9196830720) then
  Error("maximal bound");
fi;
Print("ALL FI22 EXTRACTION CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
