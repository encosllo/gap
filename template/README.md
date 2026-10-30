# GAP code for "<title>"

This directory contains the [GAP](https://www.gap-system.org) programs used for the computations
reported in

> <authors>, *<title>*.

together with the output of the runs (`logs/`).

<Definitions and notation. Theorem and section numbers refer to the paper.>

## Requirements

GAP 4.16 or later, with the SmallGroups library (included in the standard GAP distribution).
The runs in `logs/` were made with GAP <version>. The shell script needs `bash` and `xargs`. All commands
are run from this directory (`projects/<name>/`).

## Files

| File | Contents |
|---|---|
| `gap/lib.g` | Common functions: <...>. Must be loaded before the other scripts. |
| `gap/example_1_1.g` | <Statement>: <what it checks>. |
| `run_checks.sh` | Reproduces all the files in `logs/`. |
| `logs/` | Output of the runs. `logs/run_*.txt` records the machine, the software and the duration of each job of each run. |

## Usage

```
gap -q gap/lib.g gap/example_1_1.g
```

To reproduce all the logs (4 parallel processes, <time>):

```
./run_checks.sh
```

Output lines: <format of the output, failure tags>. Every run ends with a line `FINAL`.

## Results

- **<Statement>** (`example_1_1.g`): <result>.

## License

The code (all `.g` and `.sh` files) is released under the MIT License (see `LICENSE`).
The output of the computations in `logs/` is released under the Creative Commons Attribution 4.0
International License (CC BY 4.0; see `logs/LICENSE`).

## How to cite

Please cite the article above. Citation metadata for this code are in `CITATION.cff`.
