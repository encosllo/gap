# Section 4.10 (the Baby Monster: Theorem 4.10.3, Proposition 4.10.4)
#
# The numerical bounds, the centres of the two local groups, and the stored
# class fusion into 2.B. It does not replace the cited subgroup
# classification or module theorem.
#
# Expected: the output ends with ALL BABY MONSTER CHECKS PASSED.
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/section_4_10.g
LoadPackage("ctbllib");;
t := CharacterTable("2E6(2)");;
a := 2*Size(t);;
u := Size(CharacterTable("F4(2)"));;
b := QuoInt(a,u);;
if b <> 46227456 or a mod u <> 0 then Error("index"); fi;
if not (b^2 < 2^52 and 2^77 > b^2) then
  Error("module bound");
fi;
if not (Size(CharacterTable("Fi23")) > b and
        Size(t)*6 mod 23 <> 0) then Error("second witness"); fi;
j := CharacterTable("2.2E6(2).2");;
k := CharacterTable("2^2.2E6(2).2");;
if Number(SizesConjugacyClasses(j),x->x=1) <> 2 or
   Number(SizesConjugacyClasses(k),x->x=1) <> 2 then
  Error("center sizes");
fi;
if Size(j)/2 <> a or Size(k)/2 <> 2*a then
  Error("automizer orders");
fi;
if GetFusionMap(k,CharacterTable("2.B"))=fail then
  Error("missing recorded fusion");
fi;
Print("ALL BABY MONSTER CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
