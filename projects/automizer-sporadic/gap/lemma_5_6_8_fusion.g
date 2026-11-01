# Lemma 5.6.8 (the unitary L3(4) subgroups lie in a Siegel parabolic)
#
# The outer S3 has orbits of lengths 3 and 1 on the complement classes:
# |N(P)| = 61931520, complement normalizer orders 40320, 120960, 40320, 40320.
#
# Input: work/co1_u6_selected_complements.ws (see run_checks.sh for the script that writes it).
# Expected: the recorded output (GAP 4.12.1) ends with
#   Pconjugacy class orbitlengths underA=[ 3, 1, 3, 3 ]
# Original file: co1_u6_complement_fusion.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/co1_u6_selected_complements.ws gap/lib.g gap/lemma_5_6_8_fusion.g
fpP:=Filtered([1..98280],i->ForAll(GeneratorsOfGroup(up),g->i^g=i));;
Print("parabolic fixedpointset size=",Length(fpP),"\n");
auP:=Stabilizer(ug,fpP,OnSets);;
Print("Nmax6(P) order=",Size(auP),"\n");
printNu:=List(ulcomp,l->Size(Normalizer(auP,l)));;
Print("N_A complement orders=",printNu,"\n");
Print("Pconjugacy class orbitlengths underA=",List(printNu,n->Size(auP)/Size(up)/(n/20160)),"\n");
Assert(0,Length(fpP)=6 and Size(auP)=61931520);
Assert(0,printNu=[40320,120960,40320,40320]);
Assert(0,List(printNu,n->Size(auP)/Size(up)/(n/20160))=[3,1,3,3]);
Print("ALL UNITARY COMPLEMENT FUSION CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
