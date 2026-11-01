# Table 4, Lemma A.1 and Lemma 11.1 (CTblLib audit; written for the 2026-10-21 internal review)
#
# For the 26 sporadic groups, checks with the stored maximal-subgroup tables that
# mu(T) (the order of a largest maximal subgroup, divided by its centre when the
# largest maximal has centre of order 2) is the value of Table 4, printing one
# line "PASS <group>: mu=..." each; then six inclusions of maximal subgroups used
# in Appendix A, the U3(5) parabolic 5^(1+2):8, and the 18 simple-group orders of
# Lemma 11.1. A failed check stops with an assertion error.
# Agreement with the stored tables does not itself prove that the maximal lists
# are complete; the paper cites the classifications separately.
# Usage: gap -q gap/lib.g gap/table_4.g
LoadPackage("ctbllib");;

ReviewTables := function()
 local expected, row, t, tabs, sizes, largest, tops, smaller, mu,
       inclusions, inclusion, q, orders;
 Print("GAP ", GAPInfo.Version, "; CTblLib ",
       PackageInfo("ctbllib")[1].Version, "\n");
 expected := [
  ["M11",720,1], ["M12",7920,1], ["M22",20160,1],
  ["M23",443520,1], ["M24",10200960,1], ["J1",660,1],
  ["J2",6048,1], ["J3",8160,1], ["J4",501397585920,1],
  ["HS",443520,1], ["McL",3265920,1], ["He",1958400,1],
  ["Ru",35942400,1], ["Suz",251596800,1], ["ON",3753792,1],
  ["Co1",42305421312000,1], ["Co2",18393661440,1],
  ["Co3",1796256000,1], ["HN",239500800,1], ["Ly",5859000000,1],
  ["Th",634023936,1], ["Fi22",9196830720,2],
  ["Fi23",64561751654400,2], ["F3+",4089470473293004800,1],
  ["B",153064959367549707878400,2],
  ["M",4154781481226426191177580544000000,2]
 ];
 for row in expected do
  t := CharacterTable(row[1]);
  # A missing complete list is a failure of this audit, not a passed check.
  if not HasMaxes(t) then Error("Complete Maxes data unavailable: ",row[1]); fi;
  tabs := List(Maxes(t),CharacterTable);
  sizes := List(tabs,Size);
  largest := Maximum(sizes);
  tops := Filtered(tabs,s->Size(s)=largest);
  Assert(0, ForAll(tops,s->Length(ClassPositionsOfCentre(s))=row[3]));
  smaller := Filtered(sizes,s->s<largest);
  if row[3]=2 then Assert(0, Maximum(smaller)<=largest/2); fi;
  mu := largest/row[3];
  Assert(0, mu=row[2]);
  Print("PASS ",row[1],": mu=",mu,"; largest-center=",row[3],"\n");
 od;

 inclusions := [["U4(3)","U4(2)",25920],
                ["S6(2)","S8",40320],
                ["O8+(2)","S6(2)",1451520],
                ["J2","U3(3)",6048],
                ["HS","U3(5).2",252000],
                ["U3(5)","A7",2520]];
 for inclusion in inclusions do
  t := CharacterTable(inclusion[1]);
  q := CharacterTable(inclusion[2]);
  Assert(0, Identifier(q) in List(Maxes(t),n->Identifier(CharacterTable(n))));
  Assert(0, Size(q)/Length(ClassPositionsOfCentre(q))=inclusion[3]);
  Print("PASS inclusion ",inclusion[2]," < ",inclusion[1],"\n");
 od;
 q := CharacterTable("5^(1+2)+:8");
 Assert(0, Identifier(q) in Maxes(CharacterTable("U3(5)")));
 Assert(0, Size(q)=1000 and Length(ClassPositionsOfCentre(q))=1);
 Print("PASS U3(5) parabolic: order 1000, center trivial\n");

 # Check the 18 orders used in the arithmetic candidate filter.
 orders := [["A5",60],["A6",360],["U4(2)",25920],["L2(7)",168],
            ["L2(8)",504],["U3(3)",6048],["A7",2520],["L2(49)",58800],
            ["U3(5)",126000],["L3(4)",20160],["A8",20160],["A9",181440],
            ["J2",604800],["A10",1814400],["U4(3)",3265920],
            ["S4(7)",138297600],["S6(2)",1451520],["O8+(2)",174182400]];
 for row in orders do Assert(0, Size(CharacterTable(row[1]))=row[2]); od;
 Print("PASS all 18 simple-group orders in Lemma 11.1\n");
end;
ReviewTables();
Print("FINAL\n");
QUIT;
