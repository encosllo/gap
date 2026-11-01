# Proposition 5.7.7 (no realization with abelian Sylow 3-subgroup)
#
# The 13 string-labelled records rejected by the quaternion filter: each has
# Sylow 2-subgroup C2 x D8 and contains no Q8.
#
# Input: work/fi22_abelian_parent_twoextensions.ws (see run_checks.sh for the script that writes it).
# Expected: the recorded output (GAP 4.12.1) ends with
#   ALL ABELIAN-P3 TWOEXTENSION ABSENCE CHECKS PASSED
# Original file: fi22_abelian_parent_omitted_string_check.g (L. Gong and Y. Yan, 2026-10-25).
# Change: the thirteen records are selected as those with a string label or with automizer
# order 1296. Under GAP 4.12 they had the string label "(C3 x C3 x C3) : (C2 x S4)"; under
# GAP 4.16 (SmallGrp 1.7) they have the identifier [1296, 3490], so the original filter on
# string labels selected none of them. Both criteria select the same thirteen records.
# Usage: gap -q --quitonbreak -L work/fi22_abelian_parent_twoextensions.ws gap/lib.g gap/proposition_5_7_7_omitted.g
omittedStrings:=Filtered(rowsall,r->(IsString(r[7]) or r[6]=1296) and not r[7] in q8types);;
for row in omittedStrings do
 p:=PreImage(ip,rr[row[1]]);;n:=Normalizer(Sbase,p);;c:=Centralizer(n,p);;a:=FactorGroup(n,c);;
 if HasQ8(a) then Error("Q8-containing string class was omitted");fi;
 if IdGroup(SylowSubgroup(a,2))<>[16,11] then Error("unexpected omitted Sylow2 type");fi;
od;
if Length(abeMixedData)<>154 or abeExtCount<>846 or abeOrderHit<>122 or abeTargetFound then Error("mixed scan incomplete");fi;
Print("all omitted string groups checked ",Length(omittedStrings),"; Sylow2=C2xD8, no Q8\n");
Print("ALL ABELIAN-P3 TWOEXTENSION ABSENCE CHECKS PASSED\n");
Print("FINAL\n");
QUIT;
