# GAP code for "Recognition of Alternating Groups by Proper-Subgroup Automizer Spectra"

This directory contains the [GAP](https://www.gap-system.org) programs used for the computations
reported in

> L. Gong, Y. Yan and E. Cosme Llópez, *Recognition of Alternating Groups by Proper-Subgroup Automizer
> Spectra*.

together with the output of the runs (`logs/`).

For a finite group $G$, its *proper-subgroup automizer spectrum* $\mathrm{Spec}(G)$ is the set of
isomorphism types of the groups $N_G(H)/C_G(H)$, for $1<H<G$. The paper proves that every alternating
group $A_n$, $n\ge5$, is determined by $\mathrm{Spec}(A_n)$ among all finite groups. The only computer
calculation used in the proof is Lemma 12.13, $[A_4],[D_8]\notin\mathrm{Spec}(A_n)$ for $n=6,7$
(Program B.1). The other two scripts are consistency checks of statements proved by hand.
$d.A_n$ denotes the perfect central cover of $A_n$ with centre of order $d$. Theorem and section
numbers refer to the paper.

## Requirements

GAP 4.16 or later, with the SmallGroups library, Polycyclic and CTblLib (included in the standard GAP
distribution). The runs in `logs/` were made with GAP 4.16.1. The shell script needs `bash` and `xargs`. All commands are run from
this directory (`projects/automizer-alternating/`).

## Files

| File | Contents |
|---|---|
| `gap/lib.g` | Common functions: the SmallGroups identifiers of $\mathrm{Spec}(G)$ (`SpectrumIds`). Must be loaded before the other scripts. |
| `gap/lemma_12_13.g` | Lemma 12.13 (Program B.1): $\mathrm{Spec}(A_6)$ and $\mathrm{Spec}(A_7)$, and the absence of $[A_4]$ and $[D_8]$. Together with `SpectrumIds`, this is the program printed in Appendix B. |
| `gap/lemma_12_13_covers.g` | Consistency check after Program B.1 (not used in any proof): $\mathrm{Spec}(d.A_n)\ne\mathrm{Spec}(A_n)$ for every nontrivial perfect central cover with $n=5,6,7$, with the types that differ. |
| `gap/table_4.g` | Table 4 and Lemmas A.1 and 11.1: the values $\mu(T)$ of the 26 sporadic groups, the inclusions of maximal subgroups used in Appendix A, and the 18 simple-group orders of Lemma 11.1, against CTblLib. |
| `run_checks.sh` | Reproduces all the files in `logs/`. |
| `logs/` | Output of the runs. `logs/run_*.txt` records the machine, the software and the duration of each job of each run. |

## Usage

```
gap -q gap/lib.g gap/lemma_12_13.g
```

To reproduce all the logs (3 jobs in parallel, about 15 seconds):

```
./run_checks.sh
```

Output lines:
- `lemma_12_13.g`: for $n=6,7$, the identifiers of $\mathrm{Spec}(A_n)$, their structure descriptions,
  and `A4 occurs: false, D8 occurs: false`.
- `lemma_12_13_covers.g`: for each cover $d.A_n$, `equal? false` and the types in only one of the two
  spectra (`extra`, `missing`).
- `table_4.g`: a line `PASS ...` for each check; a failed check stops with an assertion error.
- Every run ends with a line `FINAL`.

## Results

- **Lemma 12.13** (`lemma_12_13.g`): $\mathrm{Spec}(A_6)$ has 9 types and $\mathrm{Spec}(A_7)$ has 16;
  neither contains $[A_4]$ or $[D_8]$.
- **Covers** (`lemma_12_13_covers.g`): all seven nontrivial covers $d.A_n$, $n=5,6,7$, have spectra
  different from $\mathrm{Spec}(A_n)$; $[A_4]$ appears exactly when $3\mid d$, $[D_8]$ exactly when
  $2\mid d$ ($n=6,7$), and $[C_3]\notin\mathrm{Spec}(\mathrm{SL}_2(5))$.
- **Table 4** (`table_4.g`): the 26 values of $\mu(T)$, the six inclusions and the 18 orders agree with
  CTblLib.

## License

The code (all `.g` and `.sh` files) is released under the MIT License (see `LICENSE`).
The output of the computations in `logs/` is released under the Creative Commons Attribution 4.0
International License (CC BY 4.0; see `logs/LICENSE`).

## How to cite

Please cite the article above. Citation metadata for this code are in `CITATION.cff`.
