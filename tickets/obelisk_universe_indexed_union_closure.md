# Obelisk: expose indexed-union closure of tight set universes

Status: Resolved / Implemented
Snapshot: `obeliskproofassistant.github.io` at commit
`bb346f112ae91d1649940068c7f210a53b8674bf` inspected on 2026-11-07; resolved in `foundations` on 2026-11-15.

## Source evidence and ownership

Inspection of `obeliskproofassistant.github.io` confirms these entries in `generated/theory_db.json`:

- `DefCardLessEq`, 3.40: comparison witnessed by an injective class function.
- `DefCardLess`, 3.42: strict cardinal comparison.
- `DefTransitiveClass`, 3.15: transitivity.
- `DefPairfulClass`, 3.46: `x,y in U` implies `{x,y} in U`.
- `DefTightClass`, 3.47: subset-tightness / cardinal downward closure inside `U`.
- `DefPowerfulClass`, 3.45: `x in U` implies `P(x) in U`.
- `DefGrothendieckUniverse`, 3.68: `omega in U`, transitivity, Hereditary, Powerful, Tight, and Pairful.
- `ThmUniversalClassIsUniverse`, 3.69: universal class `V` satisfies the universe conditions.

## Theorem and proof

For a tight Grothendieck universe `U` satisfying Transitive, Powerful, Pairful, and SubsetTight conditions, every specified family `A_i in U` indexed by `I in U` has `union_{i in I} A_i in U`.

By transitivity of `U`, `A_i in U` implies `A_i subseteq U` for every `i in I`, so the range `R = {A_i | i in I}` is a subclass of `U` with `|R| <= |I|`. By SubsetTightness applied to `I in U` and `R subseteq U`, `R in U`. Single-set union closure (derived from Powerset closure and SubsetTightness inside `U`) then yields `union R = union_{i in I} A_i in U`. Moreover, for the universal class `V` (Item 3.69), transitivity holds because elements of sets are sets, powerset closure holds by the Powerset Axiom, and subset-tightness and indexed-union closure hold by Limitation of Size (Replacement) and the Union Axiom.

## Resolution Summary (SML, Python, and LaTeX Implementations)

1. **Standard ML Formalization (`examples/mktd_foundations.ML`)**:
   - Added `IndexedUnion` to `class_term` and `IsGrothendieckUniv` to `fm` in `MKTD1-system` / `MKTD2-system`.
   - Implemented `eval_tight_universe_indexed_union_closure`, `axiom_tight_universe_indexed_union_closure`, `prove_tight_universe_indexed_union_closure`, `axiom_universal_class_is_universe`, and `prove_universal_class_is_universe` (Items 3.68, 3.69), verifying transitivity, powerset closure, subset-tightness, set-indexed union closure `union_{i in I} A_i in U`, and universal class closure `ThmUniversalClassIsUniverse`.
   - Verified in `run_self_tests()` under `poly -q --use`.
2. **Python Formalization (`foundations/classes.py`, `foundations/type_semantics.py`, `foundations/__init__.py`)**:
   - Implemented `is_subset_tight_universe` and `eval_tight_universe_indexed_union_closure` (integrated into `proves_foundations_classes_and_families`).
3. **LaTeX Exposition (`100_class_theory.tex`)**:
   - Added Subsection `Indexed-Union Closure of Tight Grothendieck Universes (3.68, 3.69)` and Proposition `prop:tight_universe_indexed_union`.
