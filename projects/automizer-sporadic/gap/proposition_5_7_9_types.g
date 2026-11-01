# Proposition 5.7.9 (mixed realizers with nonabelian normal Sylow 3-subgroup)
#
# The 6568 nonabelian classes with central quotient of order 9 or 81, and
# their abstract types.
#
# Input: work/fi22_class2_candidate_lattice.ws (see run_checks.sh for the script that writes it).
# Writes: work/fi22_mixed_p3_abstract_types.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   nonabel eligible classes 6568 abstract types [ [ [ 27, 3 ], 1023 ], [...
# Original file: fi22_mixed_p3_abstract_types.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_class2_candidate_lattice.ws gap/lib.g gap/proposition_5_7_9_types.g
rrmix:=Filtered(rf,h->Size(h)/Size(Centre(h)) in [9,81]);;
mixtypes:=List(rrmix,IdGroup);;
Print("nonabel eligible classes ",Length(rrmix)," abstract types ",Collected(mixtypes),"\n");
SaveWorkspace("work/fi22_mixed_p3_abstract_types.ws");
Assert(0,Length(rrmix)=6568 and Collected(mixtypes)=[[[27,3],1023],[[27,4],102],[[81,3],76],[[81,12],3908],[[81,13],106],[[243,62],446],[[243,63],8],[[243,65],846],[[729,441],6],[[729,501],47]]);
Print("FINAL\n");
QUIT;
