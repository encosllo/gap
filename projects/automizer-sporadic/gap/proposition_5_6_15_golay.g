# Proposition 5.6.15 (all simple L3(4) cores in Co1)
#
# Golay branch: K = L3(4):2_2 from an actual M23 complement of the Golay
# maximal, with N(K) = 80640 and C(K) = 1.
#
# Writes: work/co1_l34_22_before_normalizer.ws, work/co1_l34_22_global.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   K GLOBAL N=80640 C=1 A=80640
# Original file: co1_l34_22_base_presence.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/proposition_5_6_15_golay.g
LoadPackage("atlasrep");;
Read("gap/data/co1_p98280b0.g1");; aa:=a11;;
Read("gap/data/co1_p98280b0.g2");; bb:=a21;;
GG1:=Group(aa,bb);;
if Size(GG1)<>4157776806543360000 then Error("Co1 order");fi;
Word:=function(s)
 local g,c; g:=One(GG1);
 for c in s do if c='a' then g:=g*aa;else g:=g*bb;fi;od;
 return g;
end;
xm:=Word("ab")^-6*Word("ababb")^3*Word("ab")^6;;
ym:=Word("abb")^-5*Word("abababbabababbab")^4*Word("abb")^5;;
MM:=Group(xm,ym);;
Print("M order ",Size(MM),"\n");
VV:=PCore(MM,2);;
Print("V order ",Size(VV)," elementary ",IsElementaryAbelian(VV),"\n");

blocks:=Filtered(Orbits(VV,[1..98280]),o->Length(o)=2048);;
Print("full support V orbits ",Length(blocks),"\n");
if Length(blocks)<>24 then Error("expected24blocks");fi;
UU:=Stabilizer(MM,blocks[1][1]);;
Print("point stabilizer order ",Size(UU),"\n");
if Size(UU)<>10200960 then Error("M23 expected");fi;
actU:=ActionHomomorphism(UU,List(blocks,Set),OnSets);;PU:=Image(actU);;
moved:=MovedPoints(PU);;
KKperm:=Stabilizer(PU,Set(moved{[1,2]}),OnSets);;
KK:=PreImage(actU,KKperm);;
Print("candidate K order ",Size(KK)," centre ",Size(Centre(KK))," derived ",Size(DerivedSubgroup(KK)),"\n");
SaveWorkspace("work/co1_l34_22_before_normalizer.ws");
NN:=Normalizer(GG1,KK);; CC:=Centralizer(NN,KK);;
Print("K GLOBAL N=",Size(NN)," C=",Size(CC)," A=",Index(NN,CC),"\n");
SaveWorkspace("work/co1_l34_22_global.ws");
if Index(NN,CC)=40320 then Print("CO1 L34_22 BASE PRESENCE PASSED\n");fi;
Print("FINAL\n");
QUIT;
