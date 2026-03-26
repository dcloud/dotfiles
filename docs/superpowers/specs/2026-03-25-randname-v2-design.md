# randname v2 — Themed Grammar-Aware Name Generator

**Date:** 2026-03-25
**Status:** Approved

## Overview

Evolves `randname` from a shell function with a flat word pool into a standalone script with:
- Grammar-aware output: `(N-1) adjectives + 1 noun`
- Swappable, mixable themes backed by external word list files
- Optional per-theme weighting

The existing `randname()` function in `zsh/functions.zsh` is removed. Its word list is split into adjectives and nouns and migrated to the default theme file.

## Interface

```
randname [N] [-t|-theme SPEC] [-l] [-h]
```

### Options

- `N` — optional positional integer, word count (default: 3, minimum: 2). The first non-option, non-flag argument is taken as `N`; subsequent bare arguments are silently ignored. Both `randname 4 --theme tech` and `randname --theme tech 4` are valid.
- `-t SPEC` / `--theme SPEC` — comma-separated theme specification (default: `default`). Each entry is `name` or `name:weight`. Valid theme names match `[a-z0-9_-]+`. Empty segments (from leading, trailing, or consecutive commas) are silently skipped. Equal weights (1) are used when no weight suffix is given.
- `-l` / `--list` — list available theme names one per line, sorted. Prints nothing and exits 0 if no theme files are found.
- `-h` / `--help` — print usage to stdout, return 0

### Output

Words joined by `-` (hyphen), printed to stdout with a trailing newline. Example: `crispy-silent-machine`.

### Examples

```zsh
randname                              # → crispy-silent-machine       (default theme, 3 words)
randname 2                            # → serene-lantern              (1 adj + 1 noun)
randname 4                            # → crispy-silent-bold-machine  (3 adj + 1 noun)
randname 4 --theme tech               # → stateless-compiled-deep-daemon  (N before --theme)
randname --theme tech 4               # → stateless-compiled-deep-daemon  (N after --theme)
randname 3 4                          # → crispy-silent-machine  (second 4 silently ignored)
randname --theme tech                 # → stateless-compiled-daemon
randname --theme tech,mystical        # → arcane-recursive-sigil      (equal mix)
randname --theme tech:2,mystical:1    # → compiled-phantom-kernel     (tech 2× more likely)
randname --theme tech,tech            # valid; tech counted at weight 2
randname --theme ,tech                # valid; empty segment skipped, same as --theme tech
randname --theme tech -- 4            # → bold-compiled-recursive-daemon  (-- stops option parsing; 4 is N)
randname --list                       # one theme name per line, sorted
randname -h                           # prints usage to stdout, exit 0
```

### Error cases

All errors print a message to stderr and return 1:

- `N` is not all digits: "N must be a positive integer"
- `N < 2`: "N must be at least 2" (checked after the digit check)
- Unrecognised flag (token starting with `-` that isn't a known option): "unknown option: <flag>"
- Theme name does not match `[a-z0-9_-]+`: "invalid theme name: <name>"
- Unknown theme name (file not found): "unknown theme: <name>"
- Theme file exists but is unreadable: "cannot read theme file: <path>"
- Theme weight is not a positive integer: "invalid weight for theme '<name>': must be a positive integer". Weight is parsed from the string after `:` using the same all-digits check (`<->`) as `N`. A trailing colon with no digits (`tech:`) produces this error. Leading zeros are accepted (`tech:01` = weight 1). Weight 0 produces this error.
- Fewer unique adjectives across all themes than needed: "adjective pool too small (have M, need K)" where M and K are resolved integers
- Zero unique nouns across all themes: "noun pool is empty"

Pool-size checks are performed **eagerly** after all themes are loaded, before any word selection begins. M counts **unique** words (a word appearing in multiple themes counts once). If either pool is too small, the script exits without producing any output.

**Duplicate theme names** (e.g. `--theme tech,tech` or `--theme tech:1,mystical,tech:1`) are silently accepted. Duplicate entries have their weights summed. The theme retains the position of its **first occurrence** in input order. Example: `--theme tech,mystical,tech` → iteration order is [tech (weight 2), mystical (weight 1)].

**Theme file with no recognised sections** contributes zero words. The pool-empty errors cover this outcome; no separate parse error is raised.

## File locations

| Path | Description |
|------|-------------|
| `local/bin/randname` | The script (rcm symlinks to `~/.local/bin/randname`) |
| `local/share/randname/default.txt` | Default theme file |
| `local/share/randname/<name>.txt` | Additional theme files |
| `~/.local/share/randname/` | Runtime lookup path |

**rcm note:** rcm symlinks individual files from `local/share/randname/` into `~/.local/share/randname/` by default (creating the target directory if needed). After adding a new theme file to `local/share/randname/`, run `rcup` to create its symlink. Because `~/.local/share/randname/` is a real directory (not a directory symlink), custom theme files can also be placed there directly without touching the dotfiles repo — they will be discovered at runtime.

`local/share/randname` should **not** be added to `SYMLINK_DIRS` in `rcrc`. Adding it there would make `~/.local/share/randname` a symlink to the dotfiles directory, which would cause files written there directly to land inside the repo.

## Theme file format

```
# Comments start with #
# Blank lines are ignored

[adjectives]
ancient
bold
crispy

[nouns]
machine
river
lantern
```

- Section headers are `[adjectives]` and `[nouns]` (case-sensitive)
- Unknown section headers (any other `[...]` line) reset the current section to none
- Each non-blank, non-comment line within a known section is treated as one word
- Lines containing whitespace are silently skipped (not added to the pool)
- Words are used as-is; no normalisation is applied

## Implementation

### Location

`local/bin/randname` — a standalone zsh script following the pattern of `local/bin/phonetic` and `local/bin/naco`. Must not set `KSH_ARRAYS` or any option that makes arrays 0-based; all array indexing assumes standard zsh 1-based arrays.

### Theme parsing

A simple zsh state machine reads each theme file line by line:
- Blank lines and `#`-prefixed lines are skipped
- Lines containing whitespace are skipped
- `[adjectives]` and `[nouns]` set the current section
- Any other `[...]` line resets the current section to none (unknown section)
- All other lines in a known section are appended to the corresponding array for that theme

Each theme is stored as separate adjective and noun arrays keyed by theme name (e.g. using associative arrays or naming convention like `theme_adjs_<name>`).

### Pool construction and word selection

Weighting is implemented at the **theme-selection** level to guarantee no word is repeated in a single name.

Themes are iterated in **input order** (the order they appear left-to-right in the `--theme` spec string). This order is used for both the weighted random selection walk and the fallback sequence.

For each word slot (the `N-1` adjective slots, then the 1 noun slot):

1. **Select a theme** proportionally by weight:
   - Compute `total_weight` = sum of all theme weights
   - Pick `r = RANDOM % total_weight`
   - Walk through themes in input order, accumulating weights, until the cumulative weight exceeds `r` — that theme is selected

2. **Pick an unused word** from the selected theme's pool for the current POS (adjective or noun):
   - If the selected theme has no unused words of that POS remaining, scan **all themes in input order from the beginning** and pick from the first one that has an unused word of that POS
   - Mark the chosen word as used in the **per-POS used-words set** for the current name. Adjectives and nouns are tracked independently — the same word (if it appears in both `[adjectives]` and `[nouns]` sections) may be selected as both an adjective and the noun in the same name.

3. Repeat until all slots are filled.

The fall-through in step 2 is guaranteed to succeed whenever the eager pool-size check has passed: if there are at least `N-1` unique adjectives across all themes, selecting `N-1` adjectives will always find an available theme. Exhaustion of all themes mid-selection cannot occur under a passing pool-size check.

This guarantees no word appears twice within the same POS role in a single name.

**Eager pool-size check (before selection):**
- Count unique adjectives across all themes (union of all theme adj lists)
- Count unique nouns across all themes
- If unique adj count < `N-1`: error and exit
- If unique noun count < 1: error and exit

**Modulo bias:** `$RANDOM % total_weight` produces slight bias when `total_weight` does not evenly divide 32768. Accepted trade-off.

### Argument parsing

- `-h`/`--help` checked first; prints usage to stdout, return 0
- `-l`/`--list` globs `~/.local/share/randname/*.txt`, strips path and extension, prints one name per line sorted; prints nothing and exits 0 if no files found
- `-t`/`--theme` accepts a comma-separated spec string; empty segments skipped; parsed into name/weight pairs; theme names validated against `[a-z0-9_-]+`; duplicate names have their weights summed and retain the position of their first occurrence
- `--` stops option parsing; the first remaining argument after `--` (if any) is treated as `N` only if `N` has not already been set by an earlier positional argument. If `N` was already set, arguments after `--` are silently ignored. Example: `randname 3 -- 4` → N=3 (4 is ignored); `randname --theme tech -- 4` → N=4.
- Tokens starting with `-` that are not known options produce "unknown option: <flag>" and return 1
- The first non-option, non-flag argument is taken as `N`; additional bare arguments are silently ignored
- `N` digit check runs before the `N < 2` check

### Migration

- Remove `randname()` from `zsh/functions.zsh`
- Split the existing flat word list into `[adjectives]` and `[nouns]` in `local/share/randname/default.txt`
- Run `rcup` to create `~/.local/share/randname/default.txt` symlink

## Performance

After implementation, verify that reading theme files and constructing pools does not introduce noticeable latency. The expected path (a few small text files, pure zsh array operations, no subprocesses) should be fast, but measure with `time randname` to confirm.

## Out of scope

- Bash compatibility (zsh only)
- Completion function (deferred)
- Per-POS weighting within a single theme
