# GAP code for "Recognition of All Sporadic Simple Groups by Proper-Subgroup Automizer Spectra"

This directory contains the [GAP](https://www.gap-system.org) programs used for the computations
reported in

> L. Gong, Y. Yan and E. Cosme Llópez, *Recognition of All Sporadic Simple Groups by Proper-Subgroup
> Automizer Spectra*.

together with the output of the runs (`logs/`).

For a finite group $X$, its *proper-subgroup automizer spectrum* $\mathrm{Spec}(X)$ is the set of
isomorphism types of the groups $N_X(H)/C_X(H)$, for $1<H<X$. The paper proves that every sporadic
simple group $S$ is determined by $\mathrm{Spec}(S)$ among all finite groups. The programs here are
all the GAP code of the paper: the certificates printed in it (Sections 3.6–5.5 and Appendices A–E;
the two integer sieves are printed in GAP), and the longer computations cited by file name, which
are the local inputs for $\mathit{Fi}_{24}'$ (Section 5.5), the exclusion of $2.\mathit{Co}_1$
(Section 5.6) and the exclusion of the covers of $\mathit{Fi}_{22}$ (Section 5.7). For $\mathit{Co}_1$ the witness is $F=L_3(4):2_2$, which lies in
$\mathrm{Spec}(2.\mathit{Co}_1)$ and not in $\mathrm{Spec}(\mathit{Co}_1)$; for $\mathit{Fi}_{22}$ it is
the affine group $F=3^4:(Q_8\times C_2)$ of order 1296, which lies in the spectra of
$2.\mathit{Fi}_{22}$, $3.\mathit{Fi}_{22}$ and $6.\mathit{Fi}_{22}$ and not in that of
$\mathit{Fi}_{22}$.
Theorem and section numbers refer to the paper.

## Requirements

GAP 4.16 or later, with the packages AtlasRep, CTblLib, TomLib and SmallGrp (included in the standard
GAP distribution). AtlasRep downloads the ATLAS representations and straight-line programs that are
not in its local cache, so the first run needs internet access. The large generator files
(among them $\mathit{Co}_1$ on 98280 points and $3.O_7(3)$ on 1134 points, which AtlasRep only
delivers with remote access) are read from `gap/data/`. The runs in `logs/` were made with
GAP 4.16dev (AtlasRep 2.1.12, CTblLib 1.3.11, TomLib 1.2.11, SmallGrp 1.7.0) on 2026-11-01; see
`logs/run_checks.txt`. The shell script needs `bash` and `xargs`. All commands are run from this directory
(`projects/automizer-sporadic/`).

## Files

| File | Contents |
|---|---|
| `gap/lib.g` | Header with the paper and the notation; it defines no function, since every script is self-contained. Must be loaded before the other scripts. |
| `gap/lemma_3_6_2.g` | Lemma 3.6.2: The local data of Lemma 3.6.2 and the maximal-subgroup orders used in Lemma 3.6.4, from CTblLib. Its output is printed in Appendix A. Printed in the paper. |
| `gap/proposition_3_7_5.g` | Proposition 3.7.5: The automizers of M22 (156 subgroup classes; [C2^3] is not in Spec(M22)) and the witnesses in 2.M22, 3.M22 and 4.M22, built from the ATLAS generators in gap/data/. Printed in the paper. |
| `gap/theorem_3_8_4.g` | Theorem 3.8.4: [A] is in Spec(2.J2) and not in Spec(J2), for A = 2^3:4 of order 32: fixed-space checks for the U3(3) modules and the witness in 2.J2, from the ATLAS generators in gap/data/. Its output is printed in Appendix C. Printed in the paper. |
| `gap/theorem_3_9_3.g` | Theorem 3.9.3: The small fiber-product model and the graph subgroup; the stored character-table values are a consistency check only. Printed in the paper. |
| `gap/lemma_4_3_3.g` | Lemma 4.3.3: The integer sieve of the proof: the pairs (p, d) with p prime, p^d <= 28900 and 979200 dividing |GL_d(p)| are exactly (2, d), 8 <= d <= 14. Printed in the paper. |
| `gap/proposition_4_8_2.g` | Proposition 4.8.2: The divisibility sieve of the proof: the pairs (p, d) with p prime, p^d <= 12996 and 1876896 dividing |GL_d(p)| are exactly (7, 3) and (7, 4). Printed in the paper. |
| `gap/proposition_4_8_3.g` | Proposition 4.8.3: The local checks on groups of order at most 512 used to exclude 3.O'N (Theorem 4.8.4). The epicentre step takes longer than the others. Printed in the paper. |
| `gap/theorem_4_9_2.g` | Theorem 4.9.2: The numerical inequalities used in the proof, from the stored character tables of B and Fi23. Printed in the paper. |
| `gap/section_4_10.g` | Section 4.10: The numerical bounds, the centres of the two local groups, and the stored class fusion into 2.B. It does not replace the cited subgroup classification or module theorem. Printed in the paper. |
| `gap/theorem_5_1_3.g` | Theorem 5.1.3: The character-table and numerical checks used in the proof. Printed in the paper. |
| `gap/theorem_5_1_4.g` | Theorem 5.1.4: The character-table and numerical checks used in the proof. Printed in the paper. |
| `gap/theorem_5_1_5.g` | Theorem 5.1.5: The degree minima, the small Frobenius orbits and every relevant order-7 class. Printed in the paper. |
| `gap/theorem_5_1_7.g` | Theorem 5.1.7: The character-table and numerical checks used in the proof. Printed in the paper. |
| `gap/theorem_5_2_1.g` | Theorem 5.2.1: [C3] is in Spec(Ru) and not in Spec(2.Ru). Builds Ru (degree 4060) and 2.Ru (degree 16240) from the ATLAS generators in gap/data/; the paper records 5751 abelian Sylow 2-subgroup classes, 123 full normalizer checks, 351 strict profile exclusions and 17 mixed-subgroup checks. The workspace work/ru_c3_canonical_after_lattice.ws is an optional checkpoint. Printed in the paper. |
| `gap/theorem_5_3_3.g` | Theorem 5.3.3: The table of marks of McL is the completeness input; checks its representative and normalizer orders, and computes every required centralizer and graph-subgroup quotient. Printed in the paper. |
| `gap/theorem_5_4_4.g` | Theorem 5.4.4: [L2(11)] is in Spec(3.Suz) and Spec(6.Suz) and not in Spec(Suz). Builds 3.Suz (degree 5346) from the ATLAS generators in gap/data/. Printed in the paper. |
| `gap/theorem_5_4_8.g` | Theorem 5.4.8: [C2 x C6] is in Spec(2.Suz) and not in Spec(Suz), with the 3.Suz generators in gap/data/ and the character table of 2.Suz. Printed in the paper. |
| `gap/proposition_5_5_1_l43_h1.g` | Proposition 5.5.1: Part (6): H^1(T,Q) = 0 for T = L4(3) on the parabolic radical Q = 3^6. |
| `gap/proposition_5_5_1_o7_h1.g` | Proposition 5.5.1: Part (6): H^1(K,V) = 0 for K = Omega_7(3) on its natural module V = 3^7. |
| `gap/proposition_5_5_1_o7_orbits.g` | Proposition 5.5.1: Part (6): the Omega_7(3)-orbits on F_3^7 have lengths 1, 702, 728, 756, and the stabilizer on the orbit of length 756 is simple of order 6065280. |
| `gap/theorem_5_5_9.g` | Theorem 5.5.9: The cohomology and vector-orbit computations for the triple cover, on six- and seven-dimensional matrix groups over F_3; the maximal lists and Brauer tables are stated data inputs. Printed in the paper. |
| `gap/lemma_5_6_1.g` | Lemma 5.6.1: Presence: W = 2^10 misses the centre, has character multiplicities 1^22 2^1, its monomial stabilizer K has order 40320 and table L3(4).2_2, acting faithfully. |
| `gap/lemma_5_6_1_check.g` | Lemma 5.6.1: Independent check of the presence of L3(4):2_2 in 2.Co1, from the Golay code of M24. Printed in the paper. |
| `gap/lemma_5_6_2_filters.g` | Lemma 5.6.2: Order filters on the maximal subgroups for automizer order 40320, including the 2-adic bounds used in the abelian branch. |
| `gap/lemma_5_6_2_modules.g` | Lemma 5.6.2: Complete small Brauer degree lists of L3(4) and its three outer extensions. |
| `gap/lemma_5_6_2_u6_embedding.g` | Lemma 5.6.2: The U6(2):S3 maximal of Co1, built from the standard generators: its socle U6(2) fixes three points of Co1/Co2. |
| `gap/lemma_5_6_3.g` | Lemma 5.6.3: The K-invariant Golay subspaces containing the centre have dimensions 1, 10, 11, 12, with stabilizers of orders 120960, 887040, 244823040. |
| `gap/lemma_5_6_4.g` | Lemma 5.6.4: The Hermitian 9-module R of L3(4) is irreducible; the actions of T, PGL3(4) and the full extension have orders 20160, 60480, 120960. |
| `gap/lemma_5_6_6_centre_bound.g` | Lemma 5.6.6: The order-7 centralizers 7 x A7 and 7 x L3(2); the largest abelian 2-subgroups of their other factors have order 4. |
| `gap/lemma_5_6_6_check.g` | Lemma 5.6.6: Independent check of the class-fusion exclusions for the eight covers of L3(4) with 2-part in the centre. Printed in the paper. |
| `gap/lemma_5_6_6_class_fusions.g` | Lemma 5.6.6: No possible class fusion into Co1 for the eight 2-centred covers of L3(4) (decompose:=false); the centre of a surviving 3.L3(4) maps to class 3A. |
| `gap/lemma_5_6_7.g` | Lemma 5.6.7: For the standard L3(4) on the Golay code: dim C^T = 1, dim V^T = 0, and H^1(T,V) = 0 (Z^1 and B^1 of dimension 11). |
| `gap/lemma_5_6_8_complements.g` | Lemma 5.6.8: Constructs the four complement classes of R = 2^9 in the parabolic P of the Co1-embedded U6(2), with their local normalizer orders. Also used by Proposition 5.6.14. |
| `gap/lemma_5_6_8_f4_modules.g` | Lemma 5.6.8: The four faithful degree-3 modules of 3.L3(4) are fixed by the fourth-power Frobenius; the smallest nontrivial absolute 2-degree of L3(4) is 8; |GU3(2)| = 648. |
| `gap/lemma_5_6_8_fusion.g` | Lemma 5.6.8: The outer S3 has orbits of lengths 3 and 1 on the complement classes: |N(P)| = 61931520, complement normalizer orders 40320, 120960, 40320, 40320. Input: `work/co1_u6_selected_complements.ws`. |
| `gap/lemma_5_6_8_h1.g` | Lemma 5.6.8: Z^1(T,R) has dimension 11 and B^1(T,R) dimension 9: four complement classes. |
| `gap/lemma_5_6_8_outer_type.g` | Lemma 5.6.8: Identifies the outer type L3(4).2_2 of the complement normalizers. Input: `work/co1_u6_selected_complements.ws`. |
| `gap/lemma_5_6_8_select.g` | Lemma 5.6.8: Orders the four complements by their local normalizer orders (index 1: a nonzero class, index 2: the Levi class), independently of the order returned by ComplementClassesRepresentatives. Input: `work/co1_u6_p_complements.ws`. |
| `gap/lemma_5_6_9.g` | Lemma 5.6.9: Complete table-of-marks enumeration of the L3(4) classes in Co3, U4(3), McL and HS, with their normalizers, centralizers and maximal overgroups; explicit isomorphisms distinguish A8. |
| `gap/lemma_5_6_9_incidence.g` | Lemma 5.6.9: Independent incidence-only check of the same containments. |
| `gap/corollary_5_6_10.g` | Corollary 5.6.10: Both Co3 classes of L3(4), transported into the degree-98280 Co1: full centralizer 1 and full normalizer of order 241920. |
| `gap/lemma_5_6_11.g` | Lemma 5.6.11: Maximal-subgroup filter of Suz for order 20160: four sources, and no simple L3(4) in G2(4) or J2. |
| `gap/lemma_5_6_12.g` | Lemma 5.6.12: Order filters on the maximal subgroups for subgroup order 20160; in O8+(2) only Sp6(2), 2^6:A8 and A9 remain (three classes each). |
| `gap/lemma_5_6_12_ninecover.g` | Lemma 5.6.12: The perfect residual of the maximal 3^2.U4(3).D8 has order 29393280 = 9|U4(3)|. |
| `gap/lemma_5_6_13.g` | Lemma 5.6.13: Constructs the maximal Co2 from the ATLAS standard words: order 42305421312000, generator orders 2 and 5, product of order 28. |
| `gap/lemma_5_6_13_golay.g` | Lemma 5.6.13: The Co2 maximal 2^10:M22:2 lies in the Golay maximal: Golay orbits 48576, 49152, 552, and the 552-orbit point stabilizer has order 908328960. |
| `gap/lemma_5_6_13_hs.g` | Lemma 5.6.13: Co2 source HS.2 (TOM class 580): full Co1 centralizer 1 and normalizer 241920. Input: `work/co1_co2_standard.ws`. |
| `gap/lemma_5_6_13_m23.g` | Lemma 5.6.13: Co2 source M23 (self-contained: builds the standard Co2): full Co1 centralizer 1 and normalizer 241920. |
| `gap/lemma_5_6_13_mcl.g` | Lemma 5.6.13: Co2 source McL (TOM classes 357, 358): full Co1 centralizer 1 and normalizer 241920. Input: `work/co1_co2_standard.ws`. |
| `gap/lemma_5_6_13_u43.g` | Lemma 5.6.13: Co2 source U4(3).D8 (TOM classes 376, 377, fused by the D8): full Co1 centralizer 1 and normalizer 241920. Input: `work/co1_co2_standard.ws`. |
| `gap/proposition_5_6_14_golay.g` | Proposition 5.6.14: Golay branch: K = L3(4):2_2 from an actual M23 complement of the Golay maximal, with N(K) = 80640 and C(K) = 1. |
| `gap/proposition_5_6_14_golay_centralizer.g` | Proposition 5.6.14: Golay branch: for L = K', C(L) = 1 and |N(L)| = 241920. Input: `work/co1_l34_22_before_normalizer.ws`. |
| `gap/proposition_5_6_14_u6_levi.g` | Proposition 5.6.14: Unitary branch, Levi complement class: global centralizer 1. Input: `work/co1_u6_selected_complements.ws`. |
| `gap/proposition_5_6_14_u6_nonzero.g` | Proposition 5.6.14: Unitary branch, nonzero complement class: global C = 1 and N = 241920. Input: `work/co1_u6_selected_complements.ws`. |
| `gap/lemma_5_6_15_outer.g` | Lemma 5.6.15: The centre-fixed quotient has order 40320 and is L3(4).2_1, not L3(4).2_2. Input: `work/co1_3l34_local_normalizer.ws`. |
| `gap/lemma_5_6_15_scan.g` | Lemma 5.6.15: Source maximal 9 of Suz.2: C(L) = C3 x A4, |N(L)| = 2903040; the 10 abelian central factors give automizers of orders 80640 (8) and 241920 (2). Input: `work/co1_3suz2_local.ws`. |
| `gap/lemma_5_6_15_suz.g` | Lemma 5.6.15: Builds the 3.Suz.2 model (degree 5346) for the other core source. |
| `gap/lemma_5_6_15_u43.g` | Lemma 5.6.15: Aligned U4(3) source in 3.Suz.2: unique aligned centre, all abelian central factors, and the centre-fixed outer type (not L3(4).2_2). Also checks the unitary-source facts of Lemma 5.6.11. |
| `gap/proposition_5_7_1.g` | Proposition 5.7.1: Triple cover: H of order 81 with full automizer of order 1296, identified with the block group F; O2(F) = 1, no normal C3, weight orbits 8, 8, 16, 16, 16, 16. Coprime transport gives the sextuple cover. |
| `gap/proposition_5_7_1_target.g` | Proposition 5.7.1: Independent check that the matrix input of the absence searches (gap/data/fi22_target1296_matrix4.g) and the group F of the paper are isomorphic, with no normal C3. |
| `gap/proposition_5_7_3.g` | Proposition 5.7.3: The 26 automizers of order divisible by 1296: 13 of order 1296 with Sylow 2-subgroup [16,11], 12 of order 3888 with [16,8], and one of order 51840 with nonabelian Sylow 3-subgroup of order 81; also the centralizer bounds. Input: `work/fi22_base_allabelian3.ws`. |
| `gap/proposition_5_7_3_automizers.g` | Proposition 5.7.3: Full normalizers and centralizers in Fi22 of all 1535 nontrivial abelian subgroups of the Sylow 3-subgroup. Input: `work/fi22_f1296_base_bootstrap.ws`. |
| `gap/proposition_5_7_3_sylow.g` | Proposition 5.7.3: Builds Fi22 (degree 3510) and the complete lattice of abelian subgroups of a Sylow 3-subgroup (1536 classes, including the trivial one). Also used by Propositions 5.7.6-5.7.9. |
| `gap/proposition_5_7_3_types.g` | Proposition 5.7.3: Independent check of the abstract types and of the abelian 3-subgroups of rank at most two. Input: `work/fi22_base_allabelian3.ws`. |
| `gap/lemma_5_7_5.g` | Lemma 5.7.5: Character-table bounds that exclude central Sylow p-subgroups for p = 5, 7, 11, 13, and the Sylow 2-subgroup order and exponent. |
| `gap/proposition_5_7_6.g` | Proposition 5.7.6: All 1252 fully normalized candidates checked in Fi22: no automizer of order 1296. Input: `work/fi22_class2_candidate_lattice.ws`. |
| `gap/proposition_5_7_6_lattice.g` | Proposition 5.7.6: The hereditary-filtered lattice of the Sylow 3-subgroup: 8179 classes (1, 63, 592, 1840, 4254, 1371, 58 of orders 1, ..., 729). Also used by Proposition 5.7.9. Input: `work/fi22_f1296_base_bootstrap.ws`. |
| `gap/proposition_5_7_7.g` | Proposition 5.7.7: 154 quaternion-compatible parents, 846 extensions, 122 automizers of order 1296, none isomorphic to F. Input: `work/fi22_base_allabelian3.ws`. |
| `gap/proposition_5_7_7_invariants.g` | Proposition 5.7.7: The 122 groups of order 1296: 36 with Sylow 2-subgroup [16,8], 6 with [16,14], and 80 with exactly two normal C3 (F has none). Input: `work/fi22_abelian_parent_twoextensions.ws`. |
| `gap/proposition_5_7_7_omitted.g` | Proposition 5.7.7: The 13 string-labelled records rejected by the quaternion filter: each has Sylow 2-subgroup C2 x D8 and contains no Q8. Input: `work/fi22_abelian_parent_twoextensions.ws`. |
| `gap/proposition_5_7_7_omitted_check.g` | Proposition 5.7.7: Recheck of the same 13 records one by one, and of the counts 1535 = 154 + 1381 (the 13 are among the 1381 excluded). Input: `work/fi22_abelian_parent_twoextensions.ws`. |
| `gap/proposition_5_7_9.g` | Proposition 5.7.9: All 6278 parents: 84 quaternion-positive, 29 families and 55 fusions by explicit conjugating elements, 336 extensions, 22 automizers of order 1296, none isomorphic to F. Input: `work/fi22_mixed_p3_type_auts.ws`. |
| `gap/proposition_5_7_9_auts.g` | Proposition 5.7.9: Ten abstract types; the quaternion filter removes 290 classes in four types and keeps 6278. Input: `work/fi22_mixed_p3_abstract_types.ws`. |
| `gap/proposition_5_7_9_coverage.g` | Proposition 5.7.9: Coverage audit: the processed indices are exactly the 6278 retained ones, 84 = 29 + 55 disjointly, and the totals 336 and 22. Input: `work/fi22_mixed_nonabel_allparents.ws`. |
| `gap/proposition_5_7_9_invariants.g` | Proposition 5.7.9: Rebuilds the 336 extensions of the 29 families and checks the 22 groups of order 1296; the last three have four normal C3 (F has none). Input: `work/fi22_mixed_nonabel_allparents.ws`. |
| `gap/proposition_5_7_9_types.g` | Proposition 5.7.9: The 6568 nonabelian classes with central quotient of order 9 or 81, and their abstract types. Input: `work/fi22_class2_candidate_lattice.ws`. |
| `gap/proposition_5_7_11.g` | Proposition 5.7.11: Explicit H of order 1944 in the degree-28160 2.Fi22: H meets the centre trivially, |N(H)| = 7776, |C(H)| = 6, and N(H)/C(H) is isomorphic to F. |
| `gap/data/*.g1`, `gap/data/*.g2` | Generators from the ATLAS of Group Representations, renamed in lower case: $\mathit{Co}_1$ on 98280 points (`co1_p98280b0`, file `Co1G1-p98280B0`), $\mathit{Ru}$ and $2.\mathit{Ru}$ (`ru_p4060b0`, `2ru_p16240b0`), $3.\mathit{Suz}$ (`3suz_p5346b0`), $2.M_{22}$, $3.M_{22}$, $4.M_{22}$ (`2m22_p352ab0`, `3m22_p693b0`, `4m22_p4928ab0`), $J_2$ and $2.J_2$ (`j2_p100b0`, `2j2_p200b0`), and two matrix representations of $U_3(3)$ (`u33_f2r6b0`, `u33_f9r3bb0`). |
| `gap/data/3o73_p1134b0.g1`, `.g2` | $3.O_7(3)$ on 1134 points, AtlasRep representation `3O73G1-p1134B0` (standard generators 1), used by `proposition_5_7_1.g`. AtlasRep delivers it only with remote access (`AtlasRepAccessRemoteFiles`), from its `ctblocks` data extension; the generators were saved with GAP 4.16 on 2026-11-01. SHA-256: `.g1` 7918b296…26e1a, `.g2` 1abc9fe3…5addef. The script checks the order and that the generators map onto those of the $O_7(3)$ maximal subgroup of $\mathit{Fi}_{22}$ with kernel of order 3. |
| `gap/data/fi22_target1296_matrix4.g` | The matrix group $K$ of the definition of $F$ (Section 5.7), as used by the $\mathit{Fi}_{22}$ searches. |
| `run_checks.sh` | Reproduces all the files in `logs/`. |
| `logs/` | Output of the runs. `logs/run_*.txt` records the machine, the software and the duration of each job of each run. |

## Usage

A script without an `Input:` line in its header runs on its own:

```
gap -q --quitonbreak gap/lib.g gap/proposition_5_5_1_o7_h1.g
```

The other scripts start from a workspace written by an earlier script (`SaveWorkspace`), in
`work/`:

```
mkdir -p work
gap -q --quitonbreak gap/lib.g gap/lemma_5_6_13.g   # writes work/co1_co2_standard.ws
gap -q --quitonbreak -L work/co1_co2_standard.ws gap/lib.g gap/lemma_5_6_13_mcl.g
```

The workspaces are large and are not committed. To reproduce all the logs (4 parallel processes,
about 20 minutes with `NJOBS=2` on a MacBook Air M2 with 8 GB; the workspaces in `work/` take about
9 GB of disk; `NJOBS=1 ./run_checks.sh` uses less memory):

```
./run_checks.sh
```

`run_checks.sh` runs the jobs in six stages, so that every workspace exists before it is loaded.
The chains are: `lemma_5_6_8_complements` → `lemma_5_6_8_select` → `lemma_5_6_8_fusion`,
`lemma_5_6_8_outer_type`, `proposition_5_6_14_u6_nonzero`, `proposition_5_6_14_u6_levi`;
`proposition_5_6_14_golay` → `proposition_5_6_14_golay_centralizer`; `lemma_5_6_14` →
`lemma_5_6_13_mcl`, `_hs`, `_u43`; `lemma_5_6_15_suz` → `lemma_5_6_15_scan` →
`lemma_5_6_15_outer`; `proposition_5_7_3_sylow` → `proposition_5_7_3_automizers` →
`proposition_5_7_3`, `proposition_5_7_3_types`, `proposition_5_7_7` → `proposition_5_7_7_*`; and
`proposition_5_7_3_sylow` → `proposition_5_7_6_lattice` → `proposition_5_7_6`, `proposition_5_7_9_types`
→ `proposition_5_7_9_auts` → `proposition_5_7_9` → `proposition_5_7_9_coverage`,
`proposition_5_7_9_invariants`.

Output lines: each script prints the orders and identifiers stated in the paper; most of them end with
a line `ALL ... PASSED`, `... ASSERTED` or `... CERTIFIED`. Every script asserts its decisive values
(`Assert` or `Error`) before its last line, `FINAL`; the listings assert the lists printed in the paper.
Run a script by hand with `gap -q --quitonbreak ...`, so that a failed check gives a nonzero exit status.

`run_checks.sh` counts a job as failed if GAP exits with nonzero status, if the log does not end with
`FINAL`, or if the log contains a GAP error. It then stops after the current stage, so that no job reads
the workspace of a failed producer, and exits with status 1. A complete run ends with the line
`Finished ..., all jobs passed` in `logs/run_checks.txt`.

## Results

The computations were first run by L. Gong and Y. Yan with GAP 4.12.1 (CTblLib 1.3.7, AtlasRep
2.1.8, TomLib 1.2.11, SmallGrp 1.5.3). All the scripts were run again with GAP 4.16.1 (2026-10-31) and,
after the terminal assertions were added, with GAP 4.16dev (2026-11-01; the logs here). Every log
contains every decisive line of the earlier runs; the only difference is the order in which
`lemma_5_6_8_complements.g` prints the four complement classes, which varies between runs and is
fixed by `lemma_5_6_8_select.g`. Two scripts were adapted to GAP 4.16 (see their headers): in
`proposition_5_7_7.g` a variable `Next`, now a read-only global, is renamed; in
`proposition_5_7_7_omitted.g` and `proposition_5_7_7_omitted_check.g` the thirteen records rejected by
the quaternion filter are selected by their automizer order 1296 as well as by their string label,
since SmallGrp 1.7 identifies them as `[1296, 3490]` instead of labelling them
"(C3 x C3 x C3) : (C2 x S4)". The scripts for the programs printed in the paper are those programs,
with the ATLAS files read from `gap/data/`; the printed outputs of Appendices A and C agree with the
logs, apart from the version line of Appendix A and the line breaks of Appendix C.

- **Printed certificates** (Sections 3.6–5.5, Appendices A–E): the sieves of Lemma 4.3.3 and
  Proposition 4.8.2 give exactly $(2,d)$, $8\le d\le14$, and $(7,3),(7,4)$; the Rudvalis
  certificate (`theorem_5_2_1.g`) checks 5751 abelian Sylow 2-subgroup classes, 123 full normalizers,
  351 profile exclusions and 17 mixed subgroups, with no automizer $C_3$ in $2.\mathit{Ru}$; the
  other certificates check the local data, orders and character-table facts used in their
  statements.

- **Proposition 5.5.1** (`proposition_5_5_1_*.g`): $H^1(\Omega_7(3),3^7)=0$ and $H^1(L_4(3),3^6)=0$;
  the vector orbits of $\Omega_7(3)$ have lengths 1, 702, 728, 756.
- **Co1, presence and abelian branch** (`lemma_5_6_1*.g`–`lemma_5_6_4.g`): $W=2^{10}$ has full automizer
  $L_3(4):2_2$ in $2.\mathit{Co}_1$; the invariant Golay subspaces have stabilizers of orders 120960,
  887040, 244823040, larger than $|F|=40320$.
- **Co1, quasisimple cores** (`lemma_5_6_6*.g`–`lemma_5_6_14*.g`, `corollary_5_6_10.g`, `proposition_5_6_14_*.g`): a
  quasisimple $L<\mathit{Co}_1$ with $L/Z(L)\cong L_3(4)$ is $L_3(4)$ or $3.L_3(4)$; every
  $L_3(4)<\mathit{Co}_1$, from each of its sources, has $C(L)=1$ and $|N(L)|=241920$.
- **Co1, triple cores** (`lemma_5_6_15_*.g`): both sources have $C(L)\cong C_3\times A_4$,
  $|N(L)|=2903040$, abelian central factors with automizers of orders 80640 (8) and 241920 (2), and
  centre-fixed quotient $L_3(4).2_1$.
- **Fi22, presence** (`proposition_5_7_1.g`, `proposition_5_7_11.g`): a subgroup of order 81 of
  $3.\mathit{Fi}_{22}$ and a subgroup of order 1944 of $2.\mathit{Fi}_{22}$ (with $|N|=7776$,
  $|C|=6$) have automizer isomorphic to $F$.
- **Fi22, absence** (`lemma_5_7_5.g`, `proposition_5_7_3*.g`, `proposition_5_7_6*.g`,
  `proposition_5_7_7*.g`, `proposition_5_7_9*.g`): 26 abelian candidates; 8179 classes in the
  hereditary lattice, 1252 pure 3-group candidates; 154 abelian parents with 846 extensions and 122
  automizers of order 1296; 6278 nonabelian parents in 29 families (55 fusions) with 336 extensions and
  22 automizers of order 1296. None is isomorphic to $F$.

## License

The code (all `.g` and `.sh` files) is released under the MIT License (see `LICENSE`).
The output of the computations in `logs/` is released under the Creative Commons Attribution 4.0
International License (CC BY 4.0; see `logs/LICENSE`). The generator files `gap/data/*.g1`,
`gap/data/*.g2` are copies of data from the ATLAS of Group Representations, distributed through
AtlasRep, and are not covered by these licenses; `gap/data/fi22_target1296_matrix4.g` is part of the
code.

## How to cite

Please cite the article above. Citation metadata for this code are in `CITATION.cff`.
