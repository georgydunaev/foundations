# Ticket 7709 — [foundations] Foundations: Mechanize Separation and Subclass Sethood Theorems in MKTD SML
**Importance:** 7/10
**State:** resolved
**Labels:** foundations, math, formal-methods, sml, morse-kelley

## Description
In `examples/mktd_foundations.ML`, formalize the deductive proof of the Separation Theorem: any subclass of a set is a set (`IsSet(A)` and `Subclass(B, A)` implies `IsSet(B)`). Provide constructive derivation and theorem verification compatible with CakeML and Poly/ML.

## What Has Been Done
- Implemented `axiom_separation : class_term -> class_term -> thm` producing `Thm ([IsSet a, Subclass (b, a)], IsSet b)`.
- Implemented `prove_separation` and validated inference in `run_self_tests`.
- Verified Poly/ML compilation and execution in `tests/test_mktd_foundations.py`.
