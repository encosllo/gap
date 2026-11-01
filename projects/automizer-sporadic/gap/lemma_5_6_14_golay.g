# Lemma 5.6.14 (the Co2 sources)
#
# The Co2 maximal 2^10:M22:2 lies in the Golay maximal: Golay orbits 48576,
# 49152, 552, and the 552-orbit point stabilizer has order 908328960.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   CO2 2^10:M22:2 MAX CONTAINED IN GOLAY MAX CERTIFIED
# Original file: co1_co2_golay_max_embedding.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_14_golay.g
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
morbs:=Orbits(MM,[1..98280]);;
Print("Golay maximal orbitlengths=",List(morbs,Length),"\n");
mo552:=First(morbs,o->Length(o)=552);;
if mo552=fail then Error("no552orbit");fi;
intersectionCo2:=Stabilizer(MM,mo552[1]);;
Print("Golay-Co2 intersectionorder=",Size(intersectionCo2),"\n");
if Size(intersectionCo2)<>908328960 then Error("wrongCo2maxorder");fi;
Print("CO2 2^10:M22:2 MAX CONTAINED IN GOLAY MAX CERTIFIED\n");
Print("FINAL\n");
QUIT;
