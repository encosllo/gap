# Proposition 5.5.1 (the local inputs for the Fi24' witness)
#
# Part (6): the Omega_7(3)-orbits on F_3^7 have lengths 1, 702, 728, 756, and
# the stabilizer on the orbit of length 756 is simple of order 6065280.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL FI24 O7 HYPERPLANE CHECKS PASSED
# Original file: fi24_o7_hyperplane_orbits.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/proposition_5_5_1_o7_orbits.g
g:=Omega(0,7,3);;
vs:=Elements(GF(3)^7);;
orbs:=OrbitsDomain(g,vs,OnRight);;
Print("vector orbit lengths = ",SortedList(List(orbs,Length)),"\n");
o:=First(orbs,x->Length(x)=756);;
f:=Stabilizer(g,o[1],OnRight);;
Print("orbit756 stabilizer order=",Size(f)," center=",Size(Centre(f))," simple=",IsSimpleGroup(f),"\n");
if Size(f)<>6065280 or not IsSimpleGroup(f) then Error("wrong stabilizer");fi;
Print("ALL FI24 O7 HYPERPLANE CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
