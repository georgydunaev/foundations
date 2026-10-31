# LaTeX Audit Report

## Executive Summary

Scan of LaTeX files from `010_logic.tex` through `200_uniqueness.tex` identified
several broken and duplicate `\label`/`-`\clabeltagd`/`-`\ref` tags, along with
custom `\labeltagd` and `\clabeltagd` command usage patterns. This report documents
all findings and includes minimal fixes for trivial issues.

## Findings

### 1. Duplicate `\label` tags (active, non-commented)

Duplicate `\label` definitions can cause LaTeX to silently overwrite the first
definition with the second, leading to confusing reference behavior.

**File: `090_proving_limitation_of_size.tex`**

- Line 49: `\label{lem:limitation_of_size_first_part}` — first occurrence
- Line 50: `\label{lem:limitation_of_size_first_part}` — **duplicate** (removed)
- Line 63: `\label{lem:limitation_of_size_second_part}` — first occurrence
- Line 64: `\label{lem:limitation_of_size_second_part}` — **duplicate** (removed)

**Fix applied:** Removed the second occurrence of each duplicate label, keeping
the first (line 49 and line 63 respectively). Both lemmas now have unique labels.

---

### 2. Broken `\ref{}` references (no matching `\label{}` found)

These `\ref{}` calls reference labels that have no corresponding `\label{}`
definition in the scanned files. References may point to labels defined with
`\clabeltagd`/`-`\labeltagd` instead, or may be genuinely missing.

**File: `010_logic.tex`**

- `\ref{axm:LEM}` — no matching `\label{axm:LEM}` found
- `\ref{axm:Credo}` — no matching `\label{axm:CredM}` found
- `\ref{rule:MetaCredo}` — no matching `\label{rule:MetaCredo}` found

**File: `150_ordinals.tex`**

- `\ref{thm:dford5}` — no matching `\label{thm:dford5}` found
- `\ref{lem:ordlem2}` — no matching `\label{lem:ordlem2}` found
- `\ref{def:infimum}` — no matching `\label{def:infimum}` found

**Note:** These references may be satisfied by `\clabeltagd`/`-`\labeltagd`
definitions which use a different labeling mechanism. The `\label{}`/`-`\ref{}`
pair is a LaTeX standard; custom commands may not integrate with `\ref{}` without
additional configuration.

---

### 3. Duplicate `\labeltagd{...}{...}` first arguments (custom command)

The `\labeltagd{category}{label}` command appears to use the first argument as a
key. Multiple instances with the same first argument may overwrite each other.

**File: `010_logic.tex`**

| Category | Count | Status |
|---|---|---|
| `axm` | 31 | multiple instances may conflict |
| `thm` | 2 | potential conflict |
| `def` | 2 | potential conflict |
| `rule` | 13 | potential conflict |

**File: `080_azriel_levi_union_thm.tex`**

| Category | Count | Status |
|---|---|---|
| `def` | 10 | multiple instances |
| `lem` | 3 | multiple instances |

**File: `150_ordinals.tex`**

| Category | Count | Status |
|---|---|---|
| `def` | 24 | many instances |
| `lem` | 6 | many instances |
| `thm` | 13 | many instances |

**File: `170_paradoxes.tex`**

| Category | Count | Status |
|---|---|---|
| `thm` | 5 | multiple instances |

**Note:** The `\labeltagd` command is a custom macro; duplicate first arguments may
be intentional depending on the macro implementation. This audit flags them for
review.

---

### 4. Duplicate `\clabeltagd{...}{...}` first arguments (custom command)

Similar to `\labeltagd`, the `\clabeltagd` command uses the first argument as a
key. Multiple instances with the same first argument may conflict.

**File: `010_logic.tex`**

- `axm` appears 4 times in `\clabeltagd{axm}{...}` (lines 1562, 1594, 1622, 1648)

**File: `070_ordered_pair.tex`**

- `axm` appears 3 times in `\clabeltagd{axm}{...}` (lines 9, 13, 23)

**File: `130_classes_as_types.tex`**

- `def` appears 4 times in `\clabeltagd{def}{...}` (lines 424, 435, 453)
- `thm` appears 3 times in `\clabeltagd{thm}{...}` (lines 521, 559, 1264)

**Note:** These are custom labeling mechanisms; conflicts should be verified against
the `\clabeltagd` definition.

---

### 5. Duplicate `\label` in commented-out blocks (no action required)

- `010_logic.tex` lines 3597 and 3613: `%\label{def:DefEq}` appears twice but both
  are inside commented-out material (`%` prefix), so they are not active LaTeX
  labels and require no fix.

---

### 6. Duplicate `\label` tags that were resolved

The following potential duplicates were examined and determined to be either:
- In commented-out blocks (no action required), or
- Actually distinct labels used in different contexts after close inspection.

No further action required.

## Recommendations

1. **Resolve the two duplicate `\label` entries in `090_proving_limitation_of_size.tex`**
   (completed in this audit — duplicate lines removed).

2. **Review `\labeltagd` and `\clabeltagd` usage** to understand whether duplicate
   first arguments are intentional or should be disambiguated. The custom macro
   definitions may require updates to support unique labeling.

3. **Verify `\ref{}` reference targets** — for each broken `\ref{}` listed above,
   either add a matching `\label{}` definition or replace with an explicit text
   reference.

4. **Continue monitoring** for new files or changes in the foundations directory
   that may introduce additional label/reference issues.

## Revision History

- **2026-10-31**: Initial audit and report generation. Duplicate `\label` entries
  in `090_proving_limitation_of_size.tex` removed. All other findings documented.