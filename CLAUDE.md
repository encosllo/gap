# Conventions for this repository

This repository is the reference for all the GAP code of Enric Cosme Llópez's papers. Every new
project with GAP computations goes in `projects/<name>/`, starting from `template/`, and follows the
conventions below (they are those of the existing projects; read one of them before starting).

## Structure of a project

- `projects/<name>/` is self-contained: it must run when copied out of the repository. Do not load
  files from other projects or from the root; if a function from another project is needed, copy it
  into the project's `gap/lib.g`.
- `gap/lib.g` holds the common functions and is loaded first: `gap -q gap/lib.g gap/<script>.g`.
  Its header gives the paper and the notation.
- Each script starts with a comment block giving the statements it checks, what output is expected,
  and a `# Usage:` line.

## Names

- Project directories: short kebab-case name of the paper, without `-gap` (`derived-norm`).
- Everything inside a project is lowercase snake_case. A hyphen is used only for a range
  (`1-100`, `sections_4-5`). Statement numbers are written with `_` for the dot (`example_5_2`
  is Example 5.2), and a lettered statement keeps its letter (`theorem_c`).
- Scripts are named after the statement of the paper that they check:

  | Script | Contents | Example |
  |---|---|---|
  | `<kind>_<number>.g` | one statement (`theorem`, `proposition`, `lemma`, `corollary`, `example`, `remark`, `question`, `table`), together with the immediate consequences it implies | `example_5_2.g`, `theorem_6_11.g`, `table_1.g` |
  | `example_after_<kind>_<number>.g` | an unnumbered example | `example_after_corollary_6_6.g` |
  | `section_<n>.g` / `sections_<a>-<b>.g` | several statements with no main one | `section_3.g`, `sections_4-5.g` |
  | `theorems.g` | systematic check of the general statements over the SmallGroups library | `theorems.g` |
  | `search_<statement>.g` | a search (for examples, counterexamples or evidence) about a statement | `search_section_5.g` |
  | `<script>_<qualifier>.g` | a variant or an independent check of another script | `example_5_2_check.g`, `table_1_order_192.g` |

  When the paper is renumbered, rename the scripts and their logs (`git mv`) and update the README.
- Logs: `logs/<script>[_<orders>][_part<i>of<k>].log`, where `<orders>` is `n` or `nmin-nmax`
  and `part<i>of<k>` is the i-th of k slices of a split computation, with `i` from 1 to k
  (`theorems_1-100.log`, `theorems_192_part1of2.log`, `search_section_5_896.log`).
- Run scripts: `run_checks.sh` reproduces every log, except for very long computations, which go in
  `run_<script>.sh` (`run_search_section_5.sh`).

## Parameters

- Parameters are global variables passed with `-c`:
  `gap -q -c 'nmin:=1;; nmax:=100;;' gap/lib.g gap/theorems.g`. Every optional parameter gets its
  own default: `if not IsBound(nparts) then nparts := 1; fi;`.
- Standard names: `nmin`, `nmax` (range of orders), `skip` (list of orders to leave out),
  `GROUPS` (explicit list of `[n, i]`), `long` (`true` to include the slow cases).
- Splitting: `part`, `nparts` split the groups of each order by id (only `SmallGroup(n, i)` with
  `i mod nparts = part mod nparts`); `orderpart`, `norderparts` split the range of orders in the
  same way. `part` and `orderpart` go from 1 to `nparts` and `norderparts`, matching the
  `_part<i>of<k>` of the log name.

## Output

- Every script ends with `Print("FINAL\n"); QUIT;`, and `FINAL` is printed on a line of its own, so
  that a log is complete if and only if its last line is `FINAL`.
- Failures are printed on their own lines with a fixed tag (`FAIL <tag> [n, i]`,
  `COUNTEREXAMPLE [n, i]`), so that `grep` finds them. A summary of all of them (`FAILURES ...`,
  `COUNTEREXAMPLES ...`) may precede `FINAL`.
- Groups from the SmallGroups library are always identified as `[n, i]`.

## Logs and reproducibility

- Each job of a `run_*.sh` is a line `<GAP assignments>|<script>|<log name>` (script and log name
  without extension), run with `gap -q -c "$args" gap/lib.g gap/<script>.g < /dev/null 2>&1 |
  tr -d '\r' > logs/<log name>.log`, 4 jobs in parallel with `xargs -P 4`. Copy `run_checks.sh`
  from `template/`. Its header gives the running time.
- Each `run_<x>.sh` also writes `logs/run_<x>.txt`: the machine, the system, the versions of GAP and
  SmallGrp, and the duration of each job. Commit it together with the logs; it is not a `.log`, so
  the logs themselves stay comparable byte by byte between machines. If some logs come from an
  earlier run on another machine, keep a `.txt` for that run too (write it by hand if needed).
- The README states the GAP version of the runs. After any change to a script, its logs are
  regenerated and committed together with it; check them with `tools/check_logs.sh <name>`.
- The figures in the README (Results section) must agree with the logs.

## Documentation and licensing

- README sections: the paper, notation, Requirements, Files (table), Usage, Results, License, How to
  cite. Theorem and section numbers refer to the paper; update them when the paper changes.
- `LICENSE` (MIT) for the code and `logs/LICENSE` (CC BY 4.0) for the logs, with the authors of the
  paper as copyright holders.
- `CITATION.cff` with `repository-code: "https://github.com/encosllo/gap/tree/main/projects/<name>"`.
- Add the project to the table in the root `README.md`.
