# Develop the finite class-list interpretation of DefClassLists

Status: Resolved / Implemented
Snapshot: `obeliskproofassistant.github.io` commit `bb346f112ae91d1649940068c7f210a53b8674bf`, inspected 2026-11-07; resolved in `foundations` on 2026-11-15.

## Evidence and scope

The read-only site snapshot `bb346f112ae91d1649940068c7f210a53b8674bf`
exports `DefClassLists` (3.51) in
`generated/proofs/DefClassLists.html`, `generated/proofs/item-3.51.html`,
and `generated/theory_db.json`.

Its list-constructor clauses can be written as follows, naming the
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
development and structural induction/transport principle over Dunaev Tagged Ordered Pairs.

## Proven mathematical route in the book

The medium-list subsection of `130_classes_as_types.tex` defines
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

## Resolution Summary (SML, Python, and LaTeX Implementations)

1. **Standard ML Formalization (`examples/mktd_foundations.ML`)**:
   - Added `ClassListDunaev` constructor to `class_term` for `MKTD1-system` / `MKTD2-system`.
   - Implemented `encode_class_list_dunaev`, `decode_class_list_dunaev`, `eval_class_lists_dunaev`, `axiom_class_list_dunaev_transport`, and `prove_class_list_dunaev_transport` (Item 3.51) using iterated `TagPair` (`DunaevTaggedPair`), verifying roundtrip encoding/decoding, `Fst`/`Snd` head/tail destructors, structural induction transport, and strict rejection of `KuratowskiPair`.
   - Verified in `run_self_tests()` under `poly -q --use`.
2. **Python Formalization (`foundations/classes.py`, `foundations/type_semantics.py`, `foundations/__init__.py`)**:
   - Implemented `EMPTY_LIST_SENTINEL`, `encode_class_list_dunaev`, `decode_class_list_dunaev`, `is_valid_class_list_dunaev`, `class_list_induction_transport`, and `eval_class_lists_dunaev`.
3. **LaTeX Exposition (`100_class_theory.tex` and `131_class_polynomial_trees.tex`)**:
   - Added Subsection `Finite Class-Lists over Dunaev Tagged Ordered Pairs (3.51)` in `100_class_theory.tex` and Subsection `Transport of Finite Class-Lists and Address Words via Dunaev Tagged Pairs (3.51)` in `131_class_polynomial_trees.tex`.
