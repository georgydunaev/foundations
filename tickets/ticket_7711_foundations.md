# Ticket 7711 — [foundations] Foundations: Formalize Dunaev Pair Injectivity and Kuratowski Obstruction in SML
**Importance:** 7/10
**State:** resolved
**Labels:** foundations, math, dunaev-pair, sml, formal-methods

## Description
In `examples/mktd_foundations.ML`, formalize the proof of Dunaev tagged pair injectivity for all classes including proper classes (`dunaev_pair a b = dunaev_pair c d` implies `a = c` and `b = d`), and verify that Kuratowski pair construction is obstructed when applied to proper classes.

## What Has Been Done
- Implemented `axiom_dunaev_pair_injectivity` and `prove_dunaev_pair_injectivity`.
- Verified in `run_self_tests` that `dunaev_fst` and `dunaev_snd` extract components identically for proper classes (such as `Univ` and `Var "Ord"`).
- Verified that `kuratowski_pair_checked` rejects proper classes with `ProperClassKuratowskiException`.
- Verified integration in `tests/test_mktd_foundations.py`.
