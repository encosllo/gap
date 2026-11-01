# Proposition 5.5.1 (the local inputs for the Fi24' witness)
#
# Part (6): H^1(K,V) = 0 for K = Omega_7(3) on its natural module V = 3^7.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   split=true Z1=7 B1=7
# Original file: fi24_o7_h1.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/proposition_5_5_1_o7_h1.g
g:=Omega(0,7,3);;
aff:=AffineActionByMatrixGroup(g);;
v:=Group(GeneratorsOfGroup(aff){[1..7]});;
Print("affine order ",Size(aff)," radical ",Size(v),"\n");
co:=OneCocycles(aff,v);;
Print("split=",co.isSplitExtension," Z1=",Dimension(co.oneCocycles)," B1=",Dimension(co.oneCoboundaries),"\n");
Assert(0,Size(v)=2187 and co.isSplitExtension and Dimension(co.oneCocycles)=7 and Dimension(co.oneCoboundaries)=7);
Print("FINAL\n");
QUIT;
