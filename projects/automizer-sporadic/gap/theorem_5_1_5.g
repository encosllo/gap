# Theorem 5.1.5 (extraction for Suz)
#
# The degree minima, the small Frobenius orbits and every relevant order-7
# class.
#
# Expected: the output ends with ALL SUZ EXTRACTION CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/theorem_5_1_5.g
LoadPackage("ctbllib");;
t := CharacterTable("G2(4)");;
primes := [0,3,5,7,13];;
expected := [65,64,65,65,65];;
for j in [1..Length(primes)] do
  p := primes[j];
  if p = 0 then bt := t; else bt := t mod p; fi;
  d := Minimum(Filtered(List(Irr(bt),DegreeOfCharacter),x->x>1));
  if d <> expected[j] then Error("odd degree bound"); fi;
od;
bt := t mod 2;;
small := Filtered(Irr(bt),x->DegreeOfCharacter(x)<=17);;
if List(small,DegreeOfCharacter) <> [1,6,6,14,14] then
  Error("small binary degrees");
fi;
for d in [6,14] do
  pair := Filtered(small,x->DegreeOfCharacter(x)=d);
  if List(pair[1],x->GaloisCyc(x,2)) <> pair[2] or
     List(pair[2],x->GaloisCyc(x,2)) <> pair[1] then
    Error("Frobenius pair");
  fi;
od;
for ch in Filtered(small,x->DegreeOfCharacter(x)=6) do
  pos := Filtered([1..Length(ch)],
    i->OrdersClassRepresentatives(bt)[i]=7);
  if Length(pos)=0 then Error("missing order 7 class"); fi;
  for i in pos do
    if (6+Sum([1..6],k->ch[PowerMap(bt,k)[i]]))/7 <> 0 then
      Error("order 7 fixed dimension");
    fi;
  od;
od;
if 251596800/604800 <> 416 then Error("index"); fi;
if not (2^17 <= 416^2 and 416^2 < 2^18 and 2^12 > 416)
  then Error("module bounds"); fi;
if not (6*19595520 < 251596800) then Error("cover bound"); fi;
Print("ALL SUZ EXTRACTION CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
