# Lemma 12.13 (Program B.1)
#
# [A4] and [D8] are not in Spec(A6) and Spec(A7). Prints the identifiers of the
# two spectra, their structure descriptions, and "A4 occurs: false, D8 occurs:
# false" for each n (the output printed in Appendix B).
# The program printed in Appendix B is SpectrumIds from gap/lib.g followed by
# this loop.
# Usage: gap -q gap/lib.g gap/lemma_12_13.g
for n in [6, 7] do
 ss := SpectrumIds(AlternatingGroup(n));
 Print("A", n, " identifiers: ", ss, "\n");
 Print("A", n, ": ",
       List(ss, i -> StructureDescription(SmallGroup(i))), "\n");
 Print("  A4 occurs: ", IdGroup(AlternatingGroup(4)) in ss,
       ", D8 occurs: ", IdGroup(DihedralGroup(8)) in ss, "\n");
od;
Print("FINAL\n");
QUIT;
