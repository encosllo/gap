# Proposition 5.5.1 (the local inputs for the Fi24' witness)
#
# Part (6): H^1(T,Q) = 0 for T = L4(3) on the parabolic radical Q = 3^6.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   split=true Z1=6 B1=6
# Original file: fi24_l43_h1.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/proposition_5_5_1_l43_h1.g
g:=Omega(1,6,3);;
aff:=AffineActionByMatrixGroup(g);;
v:=Group(GeneratorsOfGroup(aff){[1..6]});;
Print("affine order ",Size(aff)," radical ",Size(v),"\n");
co:=OneCocycles(aff,v);;
Print("split=",co.isSplitExtension," Z1=",Dimension(co.oneCocycles)," B1=",Dimension(co.oneCoboundaries),"\n");
Assert(0,Size(v)=729 and co.isSplitExtension and Dimension(co.oneCocycles)=6 and Dimension(co.oneCoboundaries)=6);
Print("FINAL\n");
QUIT;
