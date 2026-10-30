# GAP code for "The derived norm of H-subgroups in finite groups"

This repository contains the [GAP](https://www.gap-system.org) programs used for the computations
reported in

> L. Gong, B. Wang and E. Cosme Llópez, *The derived norm of $\mathcal{H}$-subgroups in finite groups*.

together with the output of the runs (`logs/`).

This project was previously published as the repository `encosllo/derived-norm-gap`, now archived; it is now part of
[encosllo/gap](https://github.com/encosllo/gap), which collects all the GAP code of the author.

A subgroup $H$ of a finite group $G$ is an $\mathcal{H}$-subgroup if $N_G(H)\cap H^g\le H$ for all $g\in G$.
Notation follows the paper: $D(G)$ is the intersection of the normalizers of the derived subgroups of all
subgroups of $G$, $D_{\mathcal H}(G)$ is the same intersection over the $\mathcal H$-subgroups of $G$,
$Z_\infty(G)$ is the hypercenter and $Z_{\mathfrak{NA}}(G)$ is the $\mathfrak{NA}$-hypercenter of $G$.
Theorem and section numbers refer to the paper.

## Requirements

GAP 4.16 or later, with the SmallGroups library (included in the standard GAP distribution).
The `search_section_5_*` logs were made with GAP 4.16 and the other logs with GAP 4.16.1. The shell scripts need `bash` and `xargs`. All commands are run from this directory (`projects/derived-norm/`).

## Files

| File | Contents |
|---|---|
| `gap/lib.g` | Common functions: the test for $\mathcal H$-subgroups, $D(G)$, $D_{\mathcal H}(G)$ and $A(G)$ (`NormData`), the terminal term of an ascending series (`UpperSeries`) and $Z_{\mathfrak{NA}}(G)$ (`ZNA`). Must be loaded before the other scripts. |
| `gap/theorems.g` | Checks Theorem 1.4, Corollary 1.5, Theorem 1.6, Corollary 1.7, Theorem 1.8, Theorem 4.1(3), Theorem 4.3 and Remark 4.4 for the non-nilpotent groups of a range of orders. It also lists the outer-$D_{\mathcal H}$-groups (Remark 4.4) and the groups with $D_{\mathcal H}(G)\ne D(G)Z_\infty(G)$ (Section 5). |
| `gap/question_5_3.g` | Checks the inclusion $D_{\mathcal H}(G)\cap K\le D_{\mathcal H}(K)$ of Question 5.3 for all subgroups $K$. |
| `gap/example_5_1.g` | Example 5.1: builds $G=\mathbb Z[\omega]/4\mathbb Z[\omega]\rtimes\langle-\omega\rangle$ and checks its claims. |
| `gap/example_5_2.g` | Example 5.2: builds the model $G=Q\rtimes\langle t,\varphi\rangle$ over $\mathbb F_{16}$ and checks its claims. |
| `gap/example_5_2_check.g` | Independent check of $D(G)$ and $D_{\mathcal H}(G)$ for `SmallGroup(384,592)`: runs over all subgroups and all $g\in G$, without `NormData`. |
| `gap/search_section_5.g` | Search for groups with $[D_{\mathcal H}(G),G]\not\le D(G)Z_\infty(G)$ (Section 5), with a cheap filter based on Theorem 1.6. |
| `run_checks.sh` | Reproduces `logs/theorems_*`, `logs/question_5_3_*` and `logs/example*`. |
| `run_search_section_5.sh` | Reproduces `logs/search_section_5_*` (all orders from 201 to 1000). |
| `logs/` | Output of the runs. `logs/run_*.txt` records the machine, the software and the duration of each job of each run. |

All scripts skip nilpotent groups, for which all the statements are trivial ($Z_\infty(G)=G$).

## Usage

The scripts read the range of orders from the variables `nmin` and `nmax`. The optional variables
`part`, `nparts` (and `orderpart`, `norderparts`, `skip` in `search_section_5.g`) split a computation among several processes; see the
header of each script. For example:

```
gap -q -c 'nmin:=1;; nmax:=100;;' gap/lib.g gap/theorems.g
gap -q gap/lib.g gap/example_5_2.g
```

To reproduce all the logs (4 parallel processes):

```
./run_checks.sh           # orders up to 200 and Examples 5.1 and 5.2: about 70 minutes
./run_search_section_5.sh # orders 201 to 1000: about 5 hours, mostly order 768
```

Output lines:
- `theorems.g`: `FAIL <tag> [n, i]` for every failure of a statement (there are none),
  `OUTER [n, i] case <c> ...` for every outer-$D_{\mathcal H}$-group, and
  `GAP [n, i] ...` for every group with $D_{\mathcal H}(G)\ne D(G)Z_\infty(G)$. The last line before `FINAL` gives the
  failures of each statement (`FAILURES`).
- `question_5_3.g` and `search_section_5.g`: `COUNTEREXAMPLE [n, i]` for every counterexample. `question_5_3.g` ends with the list
  of all of them (`COUNTEREXAMPLES`). `search_section_5.g` also
  prints `GAP [n, i] ...` for the groups that pass the filter and have $D_{\mathcal H}(G)\ne D(G)Z_\infty(G)$.
- Every run ends with a line `FINAL`.

## Results

- **Orders up to 200** (`theorems.g`): no failures. There is no group of order less than 96 with
  $D_{\mathcal H}(G)\ne D(G)Z_\infty(G)$, and there are exactly 30 such groups of order at most 200 (three of
  order 96 and 27 of order 192), 12 of which are supersoluble; all of them satisfy $G'\le D(G)$.
  There are exactly 34 outer-$D_{\mathcal H}$-groups of order at most 200: 3 in case 1, 9 in case 2 and 22 in
  case 3 of Theorem 4.3 and Remark 4.4.
- **Question 5.3** (`question_5_3.g`): no counterexample of order at most 200.
- **Examples 5.1 and 5.2** (`example_5_1.g`, `example_5_2.g`, `example_5_2_check.g`): all claims verified.
- **Groups with $[D_{\mathcal H}(G),G]\not\le D(G)Z_\infty(G)$** (`search_section_5.g` for orders 201–1000, and the
  `GAP` lines of `theorems.g` for orders up to 200): the logs cover all orders up to 1000. There are
  exactly 13 such groups of order at most 1000: `SmallGroup(384,592)` (Example 5.2) and
  `SmallGroup(768,i)` for i = 1083507, 1083509, 1083511, 1083520, 1083521, 1083522, 1083523, 1083530,
  1083534, 1083784, 1083786, 1083788.

## License

The code (all `.g` and `.sh` files) is released under the MIT License (see `LICENSE`).
The output of the computations in `logs/` is released under the Creative Commons Attribution 4.0
International License (CC BY 4.0; see `logs/LICENSE`).

## How to cite

Please cite the article above. Citation metadata for this code are in `CITATION.cff`.
