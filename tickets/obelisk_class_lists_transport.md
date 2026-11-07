# Develop the finite class-list interpretation of DefClassLists

Status: source-level mathematical development proposed, not a report of a
proved kernel defect. No generated files edited.

## Evidence and scope

The read-only site snapshot `bb346f112ae91d1649940068c7f210a53b8674bf`
exports `DefClassLists` (3.51), marked TBI, in
`generated/proofs/DefClassLists.html`, `generated/proofs/item-3.51.html`,
and `generated/theory_db.json`.

Its list-constructor clauses can be rewritten as follows, naming the
constructor `mark_2` and using ordinary unordered braces:

```text
e(a) = {{a}}
mark_2(H,k) = {{0,k}} union {{e(a),k} | a in H}
[] = empty
[H] = mark_2(H,1)
[H,K] = mark_2(H,1) union mark_2(K,2).
```

The outer braces in `{{{a}},k}` form the unordered pair; the payload
`e(a)` has two singleton layers. This differs from entry 3.76's three
layers. The existing `obelisk_classes_pair_conventions.md` ticket covers
that notation/provenance issue. The present ticket supplies a finite-list
development rather than requesting replacement of either representation.

## Proven mathematical route in the book

The medium-list subsection of `130_classes_as_types.tex` now defines
canonical semisingleton record relations with finite ordinal represented
domain. At every index, an empty record preserves presence, and singleton
records encode the members of the possibly proper-class entry. These
records differ from the concentrated/flat family convention of entry 3.31.

For a canonical record list F of length n, define, as a class-parameter
operation,

```text
M(F) = {{0,i+1} | i<n}
       union {{e(a),i+1} | i<n and a in U_F(i)}.
D_k(L) = {a | {e(a),k} in L}.
```

The book proves:

- For a set a, e(a) is not an ordinal. If its sole member were zero,
  then `{a}=empty`, contradicting singleton membership.
- Positive finite tags distinguish markers `{0,k}`; payloads have exactly
  one ordinal member, their tag. Markers and payloads cannot collide.
- The marker tags in M(F) are exactly 1 through n, including positions
  whose entries are empty. Hence the encoding retains length.
- `D_(i+1)(M(F)) = U_F(i)` for every represented index.
- Equal marker encodings imply equal canonical record lists.
- Nil, one-entry, and two-entry lists translate to the formulas in 3.51;
  its first and second projection formulas decode those entries.

Every payload parameter a is a set because a belongs to an entry class.
The proof permits proper-class entries but does not permit arbitrary
proper-class tags. It uses no Foundation or choice principle for tag
separation. No ordinary graph collects proper-class list arguments or
proper-class entries as its coordinates.

## Requested source work and acceptance

Inspect the producing ML theory before adding statements. Introduce a
precise finite-list representation predicate and prove the decoding and
length properties under its hypotheses. State the positive-natural tag
restriction on these theorems, even if the raw constructor remains defined
for a larger domain.

Include empty lists, empty entries at multiple positions, and proper-class
entries in the examples. Distinguish the ordinary record representation,
the 3.51 marker representation, and the 3.76 pair representation in emitted
metadata. A transport theorem must not become a definitional identification
of the underlying codes.

Record source proof provenance before changing TBI or verification status.
The book's mathematical proof is not evidence that the kernel already
checked it. Make any changes in the producing theory and generator, then
regenerate the site; do not patch generated HTML or JSON.
