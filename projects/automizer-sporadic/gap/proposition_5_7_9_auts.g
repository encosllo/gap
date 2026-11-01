# Proposition 5.7.9 (mixed realizers with nonabelian normal Sylow 3-subgroup)
#
# Ten abstract types; the quaternion filter removes 290 classes in four types
# and keeps 6278.
#
# Input: work/fi22_mixed_p3_abstract_types.ws (see run_checks.sh for the script that writes it).
# Writes: work/fi22_mixed_p3_type_auts.ws.
# Expected: the recorded output (GAP 4.12.1) ends with
#   ABSTRACT AUT Q8 FILTER COMPLETE
# Original file: fi22_mixed_p3_type_auts.g (L. Gong and Y. Yan, 2026-10-25).
# Usage: gap -q --quitonbreak -L work/fi22_mixed_p3_abstract_types.ws gap/lib.g gap/proposition_5_7_9_auts.g
typeinfo:=[];;
for typ in Set(mixtypes) do
 p:=SmallGroup(typ);;au:=AutomorphismGroup(p);;p2:=SylowSubgroup(au,2);;
 hasQ8:=false;;
 if Size(p2)>=8 then hasQ8:=ForAny(ConjugacyClassesSubgroups(p2),cl->Size(Representative(cl))=8 and IdGroup(Representative(cl))=[8,4]);fi;
 info:=[typ,Size(Centre(p)),AbelianInvariants(Centre(p)),Exponent(p),Size(au),Size(p2),hasQ8];;
 Add(typeinfo,info);Print(info,"\n");
od;
Print("ABSTRACT AUT Q8 FILTER COMPLETE\n");
SaveWorkspace("work/fi22_mixed_p3_type_auts.ws");
Assert(0,List(Filtered(typeinfo,r->not r[7]),r->r[1])=[[27,4],[81,3],[81,13],[729,441]]);
Assert(0,Number(mixtypes,t->not First(typeinfo,r->r[1]=t)[7])=290 and Number(mixtypes,t->First(typeinfo,r->r[1]=t)[7])=6278);
Print("Q8 FILTER: 290 REMOVED, 6278 KEPT\n");
Print("FINAL\n");
QUIT;
