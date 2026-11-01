# Common functions for the computations in
#   L. Gong, Y. Yan, E. Cosme Llopez, "Recognition of Alternating Groups by
#   Proper-Subgroup Automizer Spectra".
# Load this file before any of the other scripts:  gap -q gap/lib.g gap/<script>.g
#
# Notation (as in the paper):
#   Spec(G)   the set of isomorphism types of N_G(H)/C_G(H), 1 < H < G
#   d.A_n     the perfect central cover of A_n with centre of order d

if LoadPackage("smallgrp") = fail then Error("SmallGrp is required"); fi;

# The SmallGroups identifiers of Spec(g): IdGroup of N_g(h)/C_g(h) for
# representatives h of the conjugacy classes of nontrivial proper subgroups.
SpectrumIds := function(g)
 local ss, cl, h, q;
 ss := [];
 for cl in ConjugacyClassesSubgroups(g) do
  h := Representative(cl);
  if Size(h) > 1 and Size(h) < Size(g) then
   q := FactorGroup(Normalizer(g, h), Centralizer(g, h));
   AddSet(ss, IdGroup(q));
  fi;
 od;
 return ss;
end;
