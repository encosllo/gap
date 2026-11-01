# Theorem 5.1.3 (extraction for Co1)
#
# The character-table and numerical checks used in the proof.
#
# Expected: the output ends with ALL CO1 EXTRACTION CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_5_1_3.g
LoadPackage("ctbllib");;
bt := CharacterTable("Co2") mod 2;;
small := Filtered(Irr(bt), x -> DegreeOfCharacter(x) <= 25);;
if List(small,DegreeOfCharacter) <> [1,22] then
  Error("unexpected small Brauer degrees");
fi;
ch := small[2];;
pos := Filtered([1..Length(ch)],
  i -> OrdersClassRepresentatives(bt)[i] = 11);;
if Length(pos) = 0 then Error("missing order 11 classes"); fi;
for i in pos do
  fixed := (22 + Sum([1..10], k -> ch[PowerMap(bt,k)[i]]))/11;
  if fixed <> 2 then Error("unexpected fixed dimension"); fi;
od;
if 42305421312000/18393661440 <> 2300 then Error("index"); fi;
if not (2^22 <= 2300^2 and 2300^2 < 2^26 and
        3^22 > 2300^2 and 2^20 > 2300) then Error("bounds"); fi;
if not (2*2690072985600 < 42305421312000) then
  Error("cover bound");
fi;
Print("ALL CO1 EXTRACTION CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
