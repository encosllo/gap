# Proposition 5.7.6 (no 3-group realization of the 1296-entry in Fi22)
#
# The hereditary-filtered lattice of the Sylow 3-subgroup: 8179 classes
# (1, 63, 592, 1840, 4254, 1371, 58 of orders 1, ..., 729). Also used by
# Proposition 5.7.9.
#
# Input: work/fi22_f1296_base_bootstrap.ws (see run_checks.sh for the script that writes it).
# Writes: work/fi22_class2_candidate_lattice.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ELIGIBLE LATTICE COMPLETE count 8179 sizes [ [ 1, 1 ], [ 3, 63 ], [ 9...
# Original file: fi22_class2_candidate_lattice.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_f1296_base_bootstrap.ws gap/lib.g gap/proposition_5_7_6_lattice.g
EligibleF1296:=function(h)
 local zh,inn;
 if NilpotencyClassOfGroup(h)>2 then return false;fi;
 zh:=Centre(h);inn:=Size(h)/Size(zh);
 if inn>81 then return false;fi;
 if inn=1 then return true;fi;
 return ForAll(GeneratorsOfGroup(h),g->g^3 in zh);
end;;
Print("start class2+elementaryInn<=81 Sylow3 lattice\n");
lf:=LatticeByCyclicExtension(pp,EligibleF1296,true);;
rf:=List(ConjugacyClassesSubgroups(lf),Representative);;
Print("ELIGIBLE LATTICE COMPLETE count ",Length(rf)," sizes ",Collected(List(rf,Size)),"\n");
SaveWorkspace("work/fi22_class2_candidate_lattice.ws");
Assert(0,Length(rf)=8179 and Collected(List(rf,Size))=[[1,1],[3,63],[9,592],[27,1840],[81,4254],[243,1371],[729,58]]);
Print("FINAL\n");
QUIT;
