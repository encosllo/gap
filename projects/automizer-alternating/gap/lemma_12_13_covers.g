# Lemma 12.13, consistency check for the covers (Appendix B; not used in any proof)
#
# For n = 5, 6, 7 compares Spec(d.A_n) with Spec(A_n) for every perfect central
# cover d.A_n, obtained as a quotient of SchurCover(AlternatingGroup(n)). Every
# comparison prints "equal? false": [A4] lies in the spectra of the covers with
# 3 | d and [D8] in those with 2 | d (Theorems 10.2 and 12.11, Lemma 12.12),
# and [C3] is not in Spec(SL2(5)).
# Usage: gap -q gap/lib.g gap/lemma_12_13_covers.g
if LoadPackage("polycyclic") = fail then Error("Polycyclic is required"); fi;
for n in [5,6,7] do
 a := AlternatingGroup(n);
 sa := SpectrumIds(a);
 f := SchurCover(a);
 e := Image(IsomorphismPermGroup(f));
 e := Image(SmallerDegreePermutationRepresentation(e));
 z := Centre(e);
 Print("n=",n," |Z(cover)|=",Size(z),"\n");
 for k in NormalSubgroups(z) do
  if Size(k) < Size(z) then
   x := e/k; x := Image(SmallerDegreePermutationRepresentation(x));
   sx := SpectrumIds(x);
   Print("  ", Size(z)/Size(k), ".A", n, ": equal? ", sx = sa,
     "  extra=", List(Difference(sx,sa), i->StructureDescription(SmallGroup(i))),
     "  missing=", List(Difference(sa,sx), i->StructureDescription(SmallGroup(i))), "\n");
  fi;
 od;
od;
Print("FINAL\n");
QUIT;
