# Proposition 4.8.2 (extraction for O'N)
#
# The divisibility sieve of the proof: the pairs (p, d) with p prime,
# p^d <= 12996 and 1876896 dividing |GL_d(p)| are exactly (7, 3) and (7, 4).
#
# The paper prints this sieve as a program.
# Usage: gap -q --quitonbreak gap/lib.g gap/proposition_4_8_2.g
pairs := [];;
for p in Filtered([2..12996], IsPrimeInt) do
  d := 1;
  while p^d <= 12996 do
    order := 1;
    for i in [0..d-1] do
      order := order * (p^d - p^i);
    od;
    if order mod 1876896 = 0 then
      Add(pairs, [p, d]);
    fi;
    d := d + 1;
  od;
od;
Print("pairs [p, d] with 1876896 | |GL_d(p)| and p^d <= 12996: ", pairs, "\n");
Assert(0, pairs = [[7, 3], [7, 4]]);
Print("FINAL\n");
QUIT;
