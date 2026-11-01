# Common file for the computations in
#   L. Gong, Y. Yan, E. Cosme Llopez, "Recognition of All Sporadic Simple Groups
#   by Proper-Subgroup Automizer Spectra".
# Load this file before any of the other scripts:  gap -q --quitonbreak gap/lib.g gap/<script>.g
# A script whose header has an "Input:" line also needs the workspace written by
# an earlier script:  gap -q --quitonbreak -L work/<input>.ws gap/lib.g gap/<script>.g
#
# The scripts load the packages they use (AtlasRep, CTblLib, TomLib, SmallGrp)
# and read their fixed inputs from gap/data/. No common function is needed.
#
# Notation (as in the paper):
#   Spec(X)    the set of isomorphism types of N_X(H)/C_X(H), 1 < H < X
#   S, E       the simple group and a central cover of it
#   T          L3(4) (Section 5.6) or L4(3) (Section 5.5)
#   F          the target automizer: L3(4):2_2 for Co1 (Section 5.6), the affine
#              group 3^4:(Q8 x C2) of order 1296 for Fi22 (Section 5.7)
