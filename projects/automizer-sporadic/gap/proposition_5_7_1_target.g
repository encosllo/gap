# Proposition 5.7.1 (the witness in the triple and sixfold covers)
#
# Independent check that the matrix input of the absence searches
# (gap/data/fi22_target1296_matrix4.g) and the group F of the paper are
# isomorphic, with no normal C3.
#
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL F1296 SEARCH TARGET/CANONICAL IDENTIFICATION AUDIT CHECKS PASSED
# Original file: fi22_f1296_search_target_identification_audit.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak gap/lib.g gap/proposition_5_7_1_target.g
Read("gap/data/fi22_target1296_matrix4.g");;
AffTarget:=function(k)
 local vv,ln,tr;
 vv:=AsList(FullRowSpace(GF(3),4));
 ln:=List(GeneratorsOfGroup(k),g->PermList(List(vv,v->Position(vv,v*g))));
 tr:=List(IdentityMat(4,GF(3)),e->PermList(List(vv,v->Position(vv,v+e))));
 return Group(Concatenation(ln,tr));
end;;
u:=One(GF(3));;z:=Zero(GF(3));;
i:=[[z,u],[-u,z]];;j:=[[u,u],[u,-u]];;
k:=Group(KroneckerProduct(IdentityMat(2,GF(3)),i),KroneckerProduct(IdentityMat(2,GF(3)),j),DiagonalMat([u,u,-u,-u]));;
a:=AffTarget(TargetK16);;b:=AffTarget(k);;
if Size(a)<>1296 or Size(b)<>1296 or IsomorphismGroups(a,b)=fail then Error("search target differs from canonical target");fi;
if Number(NormalSubgroups(a),h->Size(h)=3)<>0 then Error("wrong target normal C3 count");fi;
Print("ALL F1296 SEARCH TARGET/CANONICAL IDENTIFICATION AUDIT CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
