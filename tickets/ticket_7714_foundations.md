# Ticket 7714 — [foundations] Foundations: Formalize Descriptor Calculus Semantics in MKTD SML and Python
**Importance:** 8/10
**State:** resolved
**Labels:** foundations, math, descriptors, sml, python, formal-methods

## Description
In `examples/mktd_foundations.ML` and `foundations/descriptors.py`, formalize descriptor calculus distinguishing:
1. Indefinite Hilbert choice tau (tau = tau^Un) with arbitrary conglomerate default;
2. Definite description iota with unique-witness requirement;
3. Choice with empty default epsilon (epsilon = tau^{{empty}});
4. Partial description varepsilon (tau^empty) without default;
5. Unique choice with empty fallback (epsilon^{exists!}).

Mechanize constructor terms `Tau`, `Epsilon`, `Iota` in SML `class_term`, substitution rules, and deductive axioms `axiom_tau_spec`, `axiom_iota_spec`, `axiom_iota_elim`, and `axiom_epsilon_empty`. Verify consistency in Python and SML unit tests.

## What Has Been Done
- Enriched `class_term` in `examples/mktd_foundations.ML` with `Tau of string * fm`, `Epsilon of string * fm`, and `Iota of string * fm`.
- Added capture-avoiding substitution rules for descriptor binders in `subst_term`.
- Implemented deductive axiom constructors: `axiom_tau_spec`, `axiom_iota_spec`, `axiom_iota_elim`, and `axiom_epsilon_empty`.
- Implemented executable descriptor evaluators: `eval_tau`, `eval_epsilon`, `eval_iota`, and `eval_unique_choice`.
- Added `unique_choice_descriptor` in `foundations/descriptors.py` providing total choice with empty fallback when uniqueness is violated or empty.
- Added comprehensive unit tests in `tests/test_descriptors.py` and `tests/test_mktd_foundations.py`, passing Poly/ML syntax and unit tests 100%.
