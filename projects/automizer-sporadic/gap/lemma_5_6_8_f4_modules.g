# Lemma 5.6.8 (the unitary L3(4) subgroups lie in a Siegel parabolic)
#
# The four faithful degree-3 modules of 3.L3(4) are fixed by the fourth-power
# Frobenius; the smallest nontrivial absolute 2-degree of L3(4) is 8; |GU3(2)| = 648.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   GU3(2)order=648 SL3(4)order=60480
# Original file: co1_3l34_f4_modules.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_8_f4_modules.g
LoadPackage("ctbllib");;
tt:=CharacterTable("3.L3(4)");;bt:=tt mod 2;;
three:=Filtered(Irr(bt),chi->chi[1]=3);;
Print("faithful3dim count=",Length(three),"\n");
for chi in three do
 Print("degree3 Frob4fixed=",List(chi,x->GaloisCyc(x,4))=chi,"\n");
od;
Print("T smallest nontriv abs2degree=",Minimum(Filtered(List(Irr(CharacterTable("L3(4)") mod 2),chi->chi[1]),d->d>1)),"\n");
Print("GU3(2)order=",Size(GU(3,2))," SL3(4)order=",Size(SL(3,4)),"\n");
Assert(0,Length(three)=4 and ForAll(three,chi->List(chi,x->GaloisCyc(x,4))=chi));
Assert(0,Minimum(Filtered(List(Irr(CharacterTable("L3(4)") mod 2),chi->chi[1]),d->d>1))=8);
Assert(0,Size(GU(3,2))=648 and Size(SL(3,4))=60480);
Print("F4 MODULE CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
