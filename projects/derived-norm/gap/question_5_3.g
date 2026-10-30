# Question 5.3: is D_H(G) ∩ K <= D_H(K) for every subgroup K of G?
# Checks it for every non-nilpotent group G with nmin <= |G| <= nmax. It suffices to take K among
# representatives of the conjugacy classes of subgroups, since D_H(G) is normal in G.
# (For nilpotent G and K <= G, K is nilpotent and D_H(K) = K, so the inclusion is trivial.)
# Prints "COUNTEREXAMPLE [n, i]" for every counterexample.
# Optional variables part and nparts: only the groups SmallGroup(n, i) with i = part mod nparts are checked
# (to split an order among several processes).
# Usage:  gap -q -c 'nmin:=1;; nmax:=200;;' gap/lib.g gap/question_5_3.g
if not IsBound(part) then part := 1; fi;
if not IsBound(nparts) then nparts := 1; fi;
bad := [];
for n in [nmin..nmax] do
  for i in Filtered([1..NrSmallGroups(n)], j -> j mod nparts = part mod nparts) do
    G := SmallGroup(n, i);
    if not IsNilpotentGroup(G) then
      d := NormData(G);
      for K in d.reps do
        if not IsSubset(NormData(K).DH, Intersection(d.DH, K)) then
          Add(bad, [n, i]); Print("COUNTEREXAMPLE ", [n, i], "\n"); break;
        fi;
      od;
    fi;
  od;
  Print("order ", n, " done\n");
od;
Print("COUNTEREXAMPLES ", bad, "\nFINAL\n");
QUIT;
