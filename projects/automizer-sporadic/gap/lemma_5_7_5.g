# Lemma 5.7.5 (a finite reduction for the order-1296 candidate)
#
# Character-table bounds that exclude central Sylow p-subgroups for
# p = 5, 7, 11, 13, and the Sylow 2-subgroup order and exponent.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL F1296 ODD CENTRAL NORMALIZER BOUNDS PASSED
# Original file: fi22_f1296_odd_central_bound.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_5_7_5.g
LoadPackage("ctbllib");;
tt:=CharacterTable("Fi22");;
Assert(0,16 in OrdersClassRepresentatives(tt));;
Assert(0,Number(FactorsInt(Size(tt)),p->p=2)=17);;
for pp in [5,7,11,13] do
 inds:=Filtered([1..NrConjugacyClasses(tt)],i->OrdersClassRepresentatives(tt)[i]=pp);;
 cs:=Set(SizesCentralizers(tt){inds});;
 va:=0;if pp=5 then va:=1;elif pp=7 or pp=13 then va:=1;fi;
 bound:=Maximum(List(cs,n->Number(FactorsInt(n),p->p=3)))+va;
 Print("p=",pp," centralizers=",cs," v3 bound N(nontrivial central Sylow p)=",bound,"\n");
 Assert(0,bound<4);
od;
Print("ALL F1296 ODD CENTRAL NORMALIZER BOUNDS PASSED\n");
Print("FINAL\n");
QUIT;
