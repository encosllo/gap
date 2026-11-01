# Theorem 5.1.4 (extraction for McL)
#
# The character-table and numerical checks used in the proof.
#
# Expected: the output ends with ALL MCL EXTRACTION CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_5_1_4.g
LoadPackage("ctbllib");;
t := CharacterTable("U4(3)");;
primes := [0,2,3,5,7];;
expected := [21,20,15,21,21];;
for j in [1..Length(primes)] do
  p := primes[j];
  if p = 0 then bt := t; else bt := t mod p; fi;
  d := Minimum(Filtered(List(Irr(bt),DegreeOfCharacter),x->x>1));
  if d <> expected[j] then Error("unexpected minimum degree"); fi;
od;
if 3265920/20160 <> 162 then Error("index"); fi;
if not (2^15 > 162^2) then Error("module bound"); fi;
if not (3*443520 < 3265920) then Error("cover bound"); fi;
Print("ALL MCL EXTRACTION CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
