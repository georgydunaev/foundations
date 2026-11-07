# Obelisk: preserve the predicate head in semi-singleton definition exports

Status: source audit required; no upstream files changed.
Snapshot: `obeliskproofassistant.github.io` commit `bb346f112ae91d1649940068c7f210a53b8674bf`, inspected 2026-11-07.

## Evidence

- `/home/gdunaev/obeliskproofassistant.github.io/generated/theory_db.json`, `DefSemiSingleton` (3.35; constructor `TpSemiSingleton`), exports:
  `∀s:Class ∀x:Class ∀y:Class, ((x∈s ∧ y∈s) → x=y)`.
- The same file, `DefSemiSingletonSubclass` (3.36; `TpSss`), exports:
  `∀s:Class ∀A:Class, s⊆A ∧ ∀x:Class ∀y:Class, ((x∈s ∧ y∈s) → x=y)`.
- The corresponding `generated/proofs/DefSemiSingleton.html` and `generated/proofs/DefSemiSingletonSubclass.html` present those strings as the entity's Formula, classified as Definition / Definitional (Kernel AST).
- `/home/gdunaev/obeliskproofassistant.github.io/data/theory_database.json`, entries `item-3-67` and `item-3-68`, retain explicit predicate equivalences in `semantic`, while their `sml_math_untyped` fields contain the formulas above.
- `/home/gdunaev/obeliskproofassistant.github.io/generated/nbg_library.json`, `NBG-081`, `thm_semi_singleton_sub_char`, correctly uses the conjunction as a hypothesis; it does not assert it for every pair of classes.

## Local analysis

The intended bodies express useful predicates: at most one member, and at most one member plus subclass inclusion. Universally closing the bodies without their predicate heads changes their mathematical meaning.

For 3.35, take `s={0,1}`, `x=0`, `y=1`, where `0=∅` and `1={∅}`. The displayed closed formula would imply `0=1`.
For 3.36, take `s={0}`, `A=∅`; its displayed closed formula would imply `{0}⊆∅`.

This is evidence of an incorrect or insufficiently identified exported statement, not proof that the kernel accepts those universal assertions. The AST store may hold parameterized definition bodies that the exporter has closed incorrectly. The underlying ML source is not in this checkout and has not been audited.

## Requested source-level correction

Inspect `set_theory_prover/program/types/foundations.ML` entries `semi_singleton_def_entry` and `sss_def_entry` (source locations named in `data/theory_database.json`), their registration through `program/newchecker.ML`, and `program/html_generator.ML`.

Export either explicit definition equivalences

- `∀s, SemiSingleton(s) ↔ ∀x∀y, ((x∈s ∧ y∈s) → x=y)`;
- `∀s∀A, Sss(s,A) ↔ (s⊆A ∧ SemiSingleton(s))`;

or clearly identified parameterized predicate bodies with their formal parameters and heads. Keep all binders Class-typed. Do not hand-edit generated HTML or JSON.

## Acceptance tests

1. Check the source AST distinguishes a definitional body from a closed proposition and retains the defined predicate's identity and arity.
2. Regenerated JSON, HTML, Unicode, and LaTeX agree on that distinction.
3. Finite examples classify `∅` and `{0}` as semi-singletons, and `{0,1}` as not a semi-singleton.
4. `Sss({0},∅)` is false; `Sss(∅,A)` is true; no universal subclass theorem is introduced by definition export.
5. Replay `NBG-081` with its hypothesis retained; a status label alone is not a proof artifact.

The book retains its local at-most-one definition in `200_uniqueness.tex` and explains the distinction from the exported predicate bodies.
