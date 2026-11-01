# Lemma 3.6.2 (local character-table input)
#
# The local data of Lemma 3.6.2 and the maximal-subgroup orders used in
# Lemma 3.6.4, from CTblLib. Its output is printed in Appendix A.
#
# This is the program printed in the paper,
# with the ATLAS input files read from gap/data/.
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_3_6_2.g
if LoadPackage("CTblLib") <> true then Error("CTblLib unavailable"); fi;
Print("GAP ",GAPInfo.Version,"; CTblLib ",PackageInfo("CTblLib")[1].Version,"\n");
t := CharacterTable("2.HSM11");;
zc := PositionsProperty(SizesCentralizers(t),x->x=Size(t));;
Print("D order = ",Size(t),"; central class positions = ",zc,
      "; class sizes = ",SizesConjugacyClasses(t){zc},"\n");
if Size(t)<>5760 or Length(zc)<>2 then Error("Unexpected cover data"); fi;
for name in ["2^4:A6","2^4.s6"] do
 t := CharacterTable(name);;
 no := Set(List(ClassPositionsOfNormalSubgroups(t),
           pos->Sum(SizesConjugacyClasses(t){pos})));;
 Print(name," normal subgroup orders = ",no,"\n");
od;
t := CharacterTable("HS");;
Print("HS maximal subgroup orders divisible by 2880:\n");
for name in Maxes(t) do
 u := CharacterTable(name);;
 if Size(u) mod 2880=0 then Print(name," ",Size(u),"\n"); fi;
od;
for name in ["L3(4)","A8.2"] do
 t := CharacterTable(name);;
 Print(name," maximal subgroup orders = ",
       List(Maxes(t),n->Size(CharacterTable(n))),"\n");
od;
Print("FINAL\n");
QUIT;
