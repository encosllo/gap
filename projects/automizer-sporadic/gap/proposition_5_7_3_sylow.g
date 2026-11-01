# Proposition 5.7.3 (no abelian realization of the 1296-entry in Fi22)
#
# Builds Fi22 (degree 3510) and the complete lattice of abelian subgroups of
# a Sylow 3-subgroup (1536 classes, including the trivial one). Also used by
# Propositions 5.7.6-5.7.9.
#
# Writes: work/fi22_f1296_base_bootstrap.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   FI22 F1296 BASE BOOTSTRAP PASSED
# Original file: fi22_f1296_base_bootstrap.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/proposition_5_7_3_sylow.g
# Fresh-session producer shared by the absence branches.
LoadPackage("atlasrep");;LoadPackage("smallgrp");;
Sbase:=AtlasGroup("Fi22",IsPermGroup);;
Assert(0,Size(Sbase)=64561751654400 and LargestMovedPoint(Sbase)=3510);
Pbase:=SylowSubgroup(Sbase,3);;Assert(0,Size(Pbase)=3^9);
ip:=IsomorphismPcGroup(Pbase);;pp:=Image(ip);;
lat:=LatticeByCyclicExtension(pp,IsAbelian,true);;
rr:=List(ConjugacyClassesSubgroups(lat),Representative);;
Assert(0,Length(rr)=1536);
Print("Fi22 full base model and complete abelian Sylow3 lattice: ",Length(rr)," including trivial subgroup\n");
SaveWorkspace("work/fi22_f1296_base_bootstrap.ws");
Print("FI22 F1296 BASE BOOTSTRAP PASSED\n");
Print("FINAL\n");
QUIT;
