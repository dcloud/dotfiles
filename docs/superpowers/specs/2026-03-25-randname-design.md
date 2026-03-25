# randname — Random Repo Name Generator

**Date:** 2026-03-25
**Status:** Approved

## Overview

A zsh shell function that generates random hyphen-separated names in the style of GitHub's auto-generated repository names (e.g., `crispy-computing-machine`). Lives in `zsh/functions.zsh`.

## Interface

```
randname [N]
```

- `N` — optional positional integer, number of words (default: 3, minimum: 2)
- `-h` / `--help` — print usage message to stdout, return 0. The usage text is the same content as the error-path usage, but printed to stdout without an error prefix.
- Only `-h`/`--help` and `--` are recognized flags. Any other flag (e.g. `-v`, `-n`) is treated as the positional argument and will fail the digit check.
- Output: hyphen-joined lowercase words printed to stdout
- Error message + usage printed to stderr, returns 1, in these cases:
  - `N` is not a sequence of digits (e.g., `foo`, `-3`, `-v`): "N must be a positive integer"
  - `N` is 0 or 1: "N must be at least 2"
  - `N` exceeds the word pool size: "N exceeds word pool size (max: NNN)" where NNN is computed dynamically from `${#words}`
- Extra positional arguments beyond the first are ignored.

### Examples

```zsh
randname        # → crispy-computing-machine
randname 2      # → silent-river
randname 5      # → bold-ancient-copper-drifting-forest
randname --     # → crispy-computing-machine  (-- stops option parsing; defaults to 3)
randname -- 2   # → silent-river              (-- stops option parsing; 2 is consumed as N)
randname -- foo # error: N must be a positive integer
randname 0      # error: N must be at least 2
randname 1      # error: N must be at least 2
randname foo    # error: N must be a positive integer
randname -3     # error: N must be a positive integer (leading dash fails digit check)
```

## Implementation

### Location

Added to `zsh/functions.zsh` as a single self-contained function.

### Word list

A curated local array of ~150 single-token lowercase words defined inside the function body. Words are drawn from three thematic categories to produce varied, evocative combinations:

- **Qualities:** `crispy`, `ancient`, `bold`, `silent`, `drifting`, etc.
- **Nature:** `river`, `forest`, `stone`, `ember`, `tide`, etc.
- **Objects:** `machine`, `copper`, `lantern`, `compass`, `anchor`, etc.

Words must be:
- All lowercase, single token (no internal hyphens or spaces)
- Non-offensive and memorable
- Varied enough that 2–5 word combinations feel distinct

### Word selection

1. Copy the word pool into a local array.
2. Validate that `N` does not exceed `${#words}`; error with the pool size if so.
3. Loop `N` times: pick a random 1-based index via `$(( RANDOM % ${#pool} + 1 ))`, append `$pool[$idx]` to results, then splice it out with `pool[$idx]=()` (assigns an empty list to a scalar subscript, which in zsh removes that element and shifts remaining elements down).
4. Join results with hyphens using `${(j:-:)result}` and print.

This guarantees uniqueness within a single name without needing a separate seen-set.

**Modulo bias note:** `$RANDOM` ranges 0–32767. For a pool of ~150 words, `32767 % 150 = 67`, meaning indices 1–68 are very slightly more likely than 69–150. This is an accepted trade-off for name generation, where perfect uniformity is not required.

### Randomness

Uses zsh's built-in `$RANDOM` (0–32767). Adequate for name generation; `$SRANDOM` is not needed.

### Argument parsing

- No arguments (or `--` with nothing after) → use default of 3
- `[[ $1 != <-> ]]` checks whether the argument is purely decimal digits (`<->` is a zsh extended glob). Anything that is not all digits — including `-3`, `foo`, `-v` — triggers the "N must be a positive integer" error.
- `(( n < 2 ))` is a separate check that catches 0 and 1 with message "N must be at least 2".
- `(( n > ${#words} ))` catches requests larger than the word pool; the error includes the actual pool size.
- `-h` / `--help` is handled before any positional argument check.
- `--` stops option parsing; the first remaining argument (if any) is treated as `N` and goes through normal validation.

## Out of scope

- Completion function (a generator has no meaningful completions)
- Tests (not planned for this function)
- Configurable word lists or external word files
