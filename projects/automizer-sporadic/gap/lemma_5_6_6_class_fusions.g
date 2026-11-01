# Lemma 5.6.6 (the possible quasisimple L3(4) cores)
#
# No possible class fusion into Co1 for the eight 2-centred covers of L3(4)
# (decompose:=false); the centre of a surviving 3.L3(4) maps to class 3A.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   COVER CLASSFUSION CHECKS FINISHED
# Original file: co1_l34_cover_classfusions.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_6_6_class_fusions.g
LoadPackage("ctbllib");;
ssnames:=["2.L3(4)","3.L3(4)","2^2.L3(4)","4_1.L3(4)","4_2.L3(4)","6.L3(4)","(2^2x3).L3(4)","12_1.L3(4)","12_2.L3(4)"];;
Co1tbl:=CharacterTable("Co1");;
nfus:=[];;centimg:=[];;
for nm in ssnames do
 Print("START ",nm,"\n");;
 tt:=CharacterTable(nm);;
 fus:=PossibleClassFusions(tt,Co1tbl,rec(decompose:=false));;
 Add(nfus,Length(fus));if Length(fus)>0 then Add(centimg,Set(List(fus,f->f{ClassPositionsOfCentre(tt)})));fi;
 Print("CO1 FUSIONS ",nm," ",Length(fus),"\n");
 if Length(fus)>0 then
  Print("centre images ",Set(List(fus,f->f{ClassPositionsOfCentre(tt)})),"\n");
 fi;
od;
Print("COVER CLASSFUSION CHECKS FINISHED\n");
Assert(0,nfus=[0,3,0,0,0,0,0,0,0] and centimg=[[[1,5,5]]]);
Assert(0,ClassNames(Co1tbl)[5]="3a");
Print("ALL COVER CLASS FUSION CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
