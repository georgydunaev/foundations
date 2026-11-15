# Ticket #GL067: Separately Continuous Integral Kernel Criterion, Bounded-Potential Dyson-Phillips Series, Feynman-Kac Positivity, and Quantitative Lipschitz Regularity for Dynamical Schroedinger Semigroups

- **Project:** `foundations`
- **Track:** `track:foundations`
- **Parent Issue:** `#8007`
- **State:** closed
- **Status:** Resolved / Implemented

## Summary

Formalized the free heat / Gaussian semigroup contraction, separately continuous integral kernel uniqueness criterion, bounded-potential Dyson-Phillips perturbation series convergence, Feynman-Kac positivity preservation, and quantitative spatial Lipschitz regularity for dynamical Schroedinger semigroups $e^{-t(H_0+V)}$ in `MKTD1-theory` and `MKTD2-theory` over Dunaev Tagged Ordered Pairs (`TagPair` / `DunaevTaggedPair`).

## Implementation Details

1. **Standard ML (`examples/mktd_foundations.ML`)**:
   - Added AST constructors `HeatSemigroupKernel`, `SchrodingerSemigroupKernel`, `DysonPhillipsSeries` (`datatype class_term`) and `IsIntegralKernelOperator`, `DysonPhillipsConverges`, `SchrodingerLipschitzRegular`, `FeynmanKacPositivity` (`datatype fm`).
   - Implemented `eval_heat_semigroup_contraction`, `eval_integral_kernel_criterion`, `eval_dyson_phillips_series_bound`, `eval_schrodinger_lipschitz_regularity`, and theorem checkers `prove_integral_kernel_criterion`, `prove_dyson_phillips_perturbation_converges`, and `prove_schrodinger_kernel_lipschitz_regularity`.
   - Extended `run_self_tests ()` and verified via `poly -q --use /hostramdisk/foundations/examples/mktd_foundations.ML </dev/null` (exit code 0, 0 warnings, 0 non-ASCII bytes).
2. **Python (`foundations/classes.py`, `foundations/type_semantics.py`, `foundations/__init__.py`)**:
   - Implemented `eval_heat_semigroup_contraction`, `eval_integral_kernel_criterion`, `eval_dyson_phillips_series_bound`, `eval_schrodinger_lipschitz_regularity`, and `proves_schrodinger_semigroup_lipschitz_regularity_and_feynman_kac`, enforcing `DunaevTaggedPair` and rejecting `KuratowskiPair` with `ProperClassError`.
3. **LaTeX (`295_schrodinger_semigroups.tex`)**:
   - Added Subsection `\ref{subsec:mktd_schrodinger_semigroup_formalization}` using standard preamble macros.
4. **Unit Tests (`tests/test_foundations.py`, `tests/test_mktd_foundations.py`, `tests/test_type_semantics.py`)**:
   - Added unit tests covering all SML and Python implementations and verified the full test suite.
