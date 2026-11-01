# GAP code

[GAP](https://www.gap-system.org) programs used for the computations in the papers of
Enric Cosme Llópez and coauthors, together with the output of the runs.

Each paper has its own self-contained directory under `projects/`, with its own README, license,
citation metadata, scripts and logs. A project can be copied out of the repository and run on its own.

## Projects

| Project | Paper | Previous repository |
|---|---|---|
| [`automizer-alternating`](projects/automizer-alternating) | L. Gong, Y. Yan, E. Cosme Llópez, *Recognition of Alternating Groups by Proper-Subgroup Automizer Spectra* | — |
| [`automizer-sporadic`](projects/automizer-sporadic) | L. Gong, Y. Yan, E. Cosme Llópez, *Recognition of All Sporadic Simple Groups by Proper-Subgroup Automizer Spectra* | — |
| [`derived-automorphisms`](projects/derived-automorphisms) | L. Gong, Y. Yan, E. Cosme Llópez, *Derived automorphisms of finite groups* | `encosllo/derived-automorphisms-gap` |
| [`derived-norm`](projects/derived-norm) | L. Gong, B. Wang, E. Cosme Llópez, *The derived norm of $\mathcal H$-subgroups in finite groups* | `encosllo/derived-norm-gap` |
| [`residual-defect`](projects/residual-defect) | L. Gong, Y. Yan, E. Cosme Llópez, *Residual Subnormal Defect Two: Affine Criteria and Extremal Fitting Height* | `encosllo/residual-defect-gap` |

The previous repositories are archived; their full history is preserved here.

## Layout

```
projects/<name>/
  README.md        the paper, notation, files, usage, results
  LICENSE          MIT, for the code (*.g, *.sh)
  CITATION.cff     citation metadata (article and software)
  run_checks.sh    reproduces every file in logs/
  gap/lib.g        common functions of the project, loaded before every script
  gap/<script>.g   one script per statement or group of statements of the paper
  logs/            output of the runs, CC BY 4.0 (logs/LICENSE)
  logs/run_*.txt   machine, software and duration of each job of a run
template/          skeleton for a new project
tools/check_logs.sh  checks that every log ends with FINAL and contains no GAP error
```

## Requirements and usage

GAP 4.16 or later with the SmallGroups library; `bash` and `xargs` for the shell scripts.
Every command of a project is run from its directory:

```
cd projects/derived-norm
gap -q gap/lib.g gap/example_5_2.g
./run_checks.sh
```

From the root, `tools/check_logs.sh` checks the logs of all the projects (or of the projects given as
arguments).

## Adding a project

Copy `template/` to `projects/<name>/` and follow the conventions in [`CLAUDE.md`](CLAUDE.md).

## License

The code of each project is released under the MIT License and its logs under CC BY 4.0; see the
`LICENSE` files of each project. To cite the code of a paper, cite the paper and use the
`CITATION.cff` of its project.
