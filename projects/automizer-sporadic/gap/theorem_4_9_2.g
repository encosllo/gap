# Theorem 4.9.2 (recognition of the Monster)
#
# The numerical inequalities used in the proof, from the stored character
# tables of B and Fi23.
#
# Expected: the output ends with ALL MONSTER ARITHMETIC CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_4_9_2.g
LoadPackage("ctbllib");;
a := Size(CharacterTable("B"));;
u := Size(CharacterTable("Fi23"));;
f := Size(CharacterTable("Fi24'"));;
b := QuoInt(a,u);;
if a <> 4154781481226426191177580544000000 then
  Error("B order");
fi;
if b <> 1015970529280000 or a mod u <> 0 then
  Error("index");
fi;
if not (b^2 < 2^100 and 2^4370 > b^2) then
  Error("module bound");
fi;
if not (f > b and f mod 29 = 0 and a mod 29 <> 0) then
  Error("second witness");
fi;
if Size(CharacterTable("L2(71)")) <> 178920 then
  Error("order 71 witness");
fi;
Print("ALL MONSTER ARITHMETIC CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
