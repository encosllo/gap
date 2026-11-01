# Lemma 4.3.3 (two small modules)
#
# The integer sieve of the proof: the pairs (p, d) with p prime, p^d <= 28900 and
# 979200 dividing |GL_d(p)| are exactly (2, d), 8 <= d <= 14.
#
# The paper prints this sieve as a program.
# Usage: gap -q --quitonbreak gap/lib.g gap/lemma_4_3_3.g
pairs := [];;
for p in Filtered([2..28900], IsPrimeInt) do
  d := 1;
  while p^d <= 28900 do
    order := 1;
    for i in [0..d-1] do
      order := order * (p^d - p^i);
    od;
    if order mod 979200 = 0 then
      Add(pairs, [p, d]);
    fi;
    d := d + 1;
  od;
od;
Print("pairs [p, d] with 979200 | |GL_d(p)| and p^d <= 28900: ", pairs, "\n");
Assert(0, pairs = List([8..14], d -> [2, d]));
Print("FINAL\n");
QUIT;
