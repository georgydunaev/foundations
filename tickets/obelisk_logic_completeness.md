# Obelisk: distinguish semantic completeness from negation-completeness

Status: Resolved / Implemented
Evidence: `/home/gdunaev/obeliskproofassistant.github.io` at commit
`bb346f112ae91d1649940068c7f210a53b8674bf`, inspected read only; resolved in `foundations` on 2026-11-15.

## Exact discrepancy

In both `generated/data/theory_database.json` and `generated/theory_db.json`,
`AxmCompletenessOfFullTheory` (3.74) has:

- Formula: `∀φ:Fm. (eval(φ) implies (F,[] ⊢ φ))`.
- Constructor: `POmnis_prf`.
- Classification: `Definition`; verification: `Definitional (Kernel AST)`.
- Comment: “Negation-completeness ... for every sentence φ, if ¬φ is not
  derivable in F, then φ is derivable in F.”

Entry `AxmSoundnessOfFullTheory` (3.73) separately asserts
`(F,[] ⊢ φ) implies eval(φ)`.

The displayed formula is semantic completeness relative to the chosen
interpretation, called *omniscience* in `010_logic.tex`. The comment states
syntactic negation-completeness. They concern different data and require
explicit stratification across the recursively enumerable base theory `Tau`
and the non-recursively-enumerable Henkin completion `Fau`.

## Local analysis

With classical bivalent evaluation and soundness of `Fau` in the chosen
interpretation, syntactic negation-completeness implies semantic completeness. If φ is
true, soundness excludes a proof of ¬φ; negation-completeness gives a proof
of φ. Conversely, semantic completeness and bivalence imply that one of φ and
¬φ is provable. By Godel's first incompleteness theorem, the consistent recursively
enumerable base theory `Tau` is neither syntactically negation-complete nor semantically
complete with respect to unrestricted truth `eval`, whereas the Lindenbaum-Henkin
completion `Fau` (non-recursively-enumerable) satisfies both syntactic negation-completeness
on closed sentences and semantic adequacy with respect to its canonical Henkin model.

## Resolution Summary (SML, Python, and LaTeX Implementations)

1. **Standard ML Formalization (`examples/mktd_foundations.ML`)**:
   - Implemented `eval_semantic_vs_negation_completeness` (Item 3.74) in `MKTD1-system` / `MKTD2-system`, contrasting semantic adequacy (`eval(φ) implies (W, [] ⊢ φ)`) with syntactic negation-completeness (`(W, [] ⊢ φ) ∨ (W, [] ⊢ ¬φ)`) across the recursively enumerable base theory `Tau` vs the non-recursively-enumerable Henkin completion `Fau`.
   - Verified in `run_self_tests()` under `poly -q --use`.
2. **Python Formalization (`foundations/logic.py`, `foundations/__init__.py`)**:
   - Implemented `eval_semantic_vs_negation_completeness` and integrated it into `proves_foundations_logic_and_binder_hygiene`.
3. **LaTeX Exposition (`010_logic.tex`)**:
   - Added Subsection `Semantic Adequacy in a Model vs. Syntactic Negation-Completeness (3.74)` and Proposition `prop:tau_vs_fau_completeness`.
