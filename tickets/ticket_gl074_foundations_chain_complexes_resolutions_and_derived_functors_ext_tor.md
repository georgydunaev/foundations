# Ticket 74: Chain Complexes, Projective/Injective Resolutions, Derived Functors Ext/Tor, and Long Exact Cohomology Sequences

- **Issue ID**: `#8007` (Sub-ticket `gl074`)
- **State**: `closed`
- **Status**: `Resolved / Implemented`
- **Target Frameworks**: `MKTD1-framework`, `MKTD2-framework`
- **Target Systems**: `MKTD1-system` (`MKTD1-prover`), `MKTD2-system` (`MKTD2-prover`)
- **Target Theories**: `MKTD1-theory`, `MKTD2-theory`

## Summary

Formalized chain complexes $(C_\bullet, d_\bullet)$ with boundary nilpotency $d_{n-1} \circ d_n = 0$, chain homotopy equivalences $f_\bullet \simeq g_\bullet$, projective and injective resolutions, the Comparison Theorem for projective resolutions, left/right derived functors $\mathrm{Tor}_n^{\mathcal{A}}(A, B)$ and $\mathrm{Ext}^n_{\mathcal{A}}(A, B)$, and long exact homology/cohomology sequences in `MKTD1-theory` and `MKTD2-theory` over Dunaev Tagged Ordered Pairs (`TagPair` / `DunaevTaggedPair`).

## Implemented Artifacts

1. **Standard ML Kernel (`examples/mktd_foundations.ML`)**:
   - Added AST constructors `ChainComplex`, `ProjectiveResolution`, `InjectiveResolution`, `RightDerivedExt`, `LeftDerivedTor` (`datatype class_term`) and `IsChainComplex`, `IsChainHomotopyEquivalent`, `IsProjectiveResolution`, `SatisfiesLongExactCohomologySequence` (`datatype fm`).
   - Added semantic evaluators `eval_is_chain_complex`, `eval_chain_homotopy_equivalence`, `eval_is_projective_resolution`, `eval_derived_ext_tor`, `eval_long_exact_cohomology_sequence`.
   - Added derived theorem checkers `prove_chain_boundary_squared_zero`, `prove_comparison_theorem_projective_resolutions`, and `prove_ext_tor_long_exact_sequence_naturality`.
2. **Python Verification Suite (`foundations/classes.py`, `foundations/type_semantics.py`, `foundations/__init__.py`)**:
   - Implemented `eval_is_chain_complex`, `eval_chain_homotopy_equivalence`, `eval_is_projective_resolution`, `eval_derived_ext_tor`, `eval_long_exact_cohomology_sequence`, and `proves_chain_complexes_resolutions_and_derived_functors_ext_tor`.
3. **LaTeX Exposition (`300_category_theory.tex`)**:
   - Added subsection `\subsection{Chain Complexes, Projective and Injective Resolutions, and Derived Functors $\mathrm{Ext}^n$ and $\mathrm{Tor}_n$}`.
