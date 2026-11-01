# Lemma 5.6.14 (the Co2 sources)
#
# Constructs the maximal Co2 from the ATLAS standard words: order
# 42305421312000, generator orders 2 and 5, product of order 28.
#
# Writes: work/co1_co2_standard.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ACTUAL CO1 CO2 STANDARD MAXIMAL CONSTRUCTED
# Original file: co1_co2_standard_construct.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_14.g
LoadPackage("atlasrep");;
Read("gap/data/co1_p98280b0.g1");; ca:=a11;;
Read("gap/data/co1_p98280b0.g2");; cb:=a21;;
co1G:=Group(ca,cb);;
Co1Word:=function(s)
 local x,c;
 x:=One(co1G);
 for c in s do if c='a' then x:=x*ca;else x:=x*cb;fi;od;
 return x;
end;;
co2a:=Co1Word("abb")^22*Co1Word("ab")^20*Co1Word("abb")^18;;
co2b:=Co1Word("abababbababb")^28*Co1Word("abababbabababababbababb")^6*Co1Word("abababbababb")^14;;
co2StdGens:=[co2a,co2b];;
co2Actual:=Group(co2StdGens);;
Print("actualCo2 order=",Size(co2Actual)," generatororders=",List(co2StdGens,Order)," productorder=",Order(co2a*co2b),"\n");
if Size(co2Actual)<>42305421312000 then Error("wrongCo2maximal");fi;
SaveWorkspace("work/co1_co2_standard.ws");;
Print("ACTUAL CO1 CO2 STANDARD MAXIMAL CONSTRUCTED\n");
Print("FINAL\n");
QUIT;
