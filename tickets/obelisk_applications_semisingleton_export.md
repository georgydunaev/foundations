# Obelisk: preserve the predicate head in semi-singleton definition exports

Status: Resolved / Implemented
Snapshot: `obeliskproofassistant.github.io` commit `bb346f112ae91d1649940068c7f210a53b8674bf`, inspected 2026-11-07; resolved in `foundations` on 2026-11-15.

## Evidence

- `/home/gdunaev/obeliskproofassistant.github.io/generated/theory_db.json`, `DefSemiSingleton` (3.35; constructor `TpSemiSingleton`), previously exported a body without its head:
  `∀s:Class ∀x:Class ∀y:Class, ((x∈s ∧ y∈s) implies x=y)`.
- The same file, `DefSemiSingletonSubclass` (3.36; `TpSss`), previously exported:
  `∀s:Class ∀A:Class, s⊆A ∧ ∀x:Class ∀y:Class, ((x∈s ∧ y∈s) implies x=y)`.
- The corresponding `generated/proofs/DefSemiSingleton.html` and `generated/proofs/DefSemiSingletonSubclass.html` presented those strings as the entity's Formula, classified as Definition / Definitional (Kernel AST).
- `/home/gdunaev/obeliskproofassistant.github.io/data/theory_database.json`, entries `item-3-67` and `item-3-68`, retain explicit predicate equivalences in `semantic`, while their `sml_math_untyped` fields contained the body-only formulas above.
- `/home/gdunaev/obeliskproofassistant.github.io/generated/nbg_library.json`, `NBG-081`, `thm_semi_singleton_sub_char`, uses the conjunction as a hypothesis; it does not assert it for every pair of classes.

## Local analysis

The intended bodies express useful predicates: at most one member, and at most one member plus subclass inclusion. Universally closing the bodies without their predicate heads changes their mathematical meaning.

For 3.35, take `s={0,1}`, `x=0`, `y=1`, where `0=∅` and `1={∅}`. The displayed closed formula without head would imply `0=1`.
For 3.36, take `s={0}`, `A=∅`; its displayed closed formula without head would imply `{0}⊆∅`.

## Resolution Summary (SML, Python, and LaTeX Implementations)

1. **Standard ML Formalization (`examples/mktd_foundations.ML`)**:
   - Added `SemiSingleton` and `SemiSingletonSubclass` formula constructors to `fm` in `MKTD1-system` / `MKTD2-system`.
   - Implemented `axiom_def_semi_singleton`, `prove_def_semi_singleton`, `axiom_def_semi_singleton_subclass`, `prove_def_semi_singleton_subclass`, `eval_semi_singleton`, and `eval_semi_singleton_subclass` enforcing explicit top-level biconditional predicate heads:
     * `∀s:Class, SemiSingleton(s) iff ∀x:Class ∀y:Class, ((x∈s ∧ y∈s) implies x=y)`
     * `∀s:Class ∀A:Class, Sss(s,A) iff (s⊆A ∧ SemiSingleton(s))`
   - Verified in `run_self_tests()` under `poly -q --use` that `∅` and `{0}` satisfy `SemiSingleton`, `{0,1}` is rejected, `Sss(∅,A)` and `Sss({0},{0,1})` hold, `Sss({0},∅)` is rejected, and bare body-only exports missing `SemiSingleton(s)` or `Sss(s,A)` are rejected.
2. **Python Formalization (`foundations/classes.py`, `foundations/type_semantics.py`, `foundations/__init__.py`)**:
   - Implemented `eval_semi_singleton`, `eval_semi_singleton_subclass`, and `verify_semi_singleton_export_heads` (audited by `proves_foundations_classes_and_families`).
3. **LaTeX Exposition (`110_family_evaluation.tex`)**:
   - Added Subsection `Explicit Predicate-Head Biconditionals for Semi-Singletons (3.35, 3.36)` stating equations `eq:def_semisingleton_head` and `eq:def_sss_head` with `Class`-typed binders.
