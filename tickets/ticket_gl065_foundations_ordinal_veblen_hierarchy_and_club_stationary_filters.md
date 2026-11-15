# Ticket #GL065: Closed Unbounded (Club) Classes, Stationary Subclasses, Fodor's Pressing-Down Lemma, and Veblen Normal Function Fixed-Point Hierarchies

- **Project:** `foundations`
- **Track:** `track:foundations`
- **Parent Issue:** `#8007`
- **State:** closed
- **Status:** Resolved / Implemented

## Summary

Formalized normal ordinal class functions, Veblen fixed-point derivative hierarchies $\varphi_\alpha(\beta)$, closed unbounded (`club`) subclasses of a regular cardinal $\kappa$, stationary subclasses, diagonal intersections $\Delta_{\alpha < \kappa} C_\alpha$, and Fodor's Pressing-Down Lemma in `MKTD1-theory` and `MKTD2-theory` using Dunaev Tagged Ordered Pairs (`TagPair` / `DunaevTaggedPair`).

## Implementation Details

1. **Standard ML (`examples/mktd_foundations.ML`)**:
   - Added AST constructors `NormalOrdinalFn`, `VeblenPhi`, `DiagonalIntersection` (`datatype class_term`) and `IsNormalOrdinalFn`, `IsVeblenFixedPoint`, `IsClubIn`, `FodorsPressingDown` (`datatype fm`).
   - Implemented `eval_is_normal_ordinal_function`, `eval_veblen_fixed_point`, `eval_is_club_in_regular`, `eval_is_stationary_in_regular`, `eval_diagonal_intersection_club`, `eval_fodors_lemma_regressive_constant`, and theorem checkers `prove_normal_function_has_fixed_points`, `prove_club_diagonal_intersection_closed`, and `prove_fodors_pressing_down_lemma`.
   - Extended `run_self_tests ()` and verified via `poly -q --use /hostramdisk/foundations/examples/mktd_foundations.ML </dev/null` (exit code 0, 0 warnings, 0 non-ASCII bytes).
2. **Python (`foundations/classes.py`, `foundations/type_semantics.py`, `foundations/__init__.py`)**:
   - Implemented `eval_is_normal_ordinal_function`, `eval_veblen_fixed_point`, `eval_is_club_in_regular`, `eval_is_stationary_in_regular`, `eval_diagonal_intersection_club`, `eval_fodors_lemma_regressive_constant`, and `proves_ordinal_veblen_hierarchy_and_club_stationary_filters`, enforcing `DunaevTaggedPair` and rejecting `KuratowskiPair` with `ProperClassError`.
3. **Unit Tests (`tests/test_foundations.py`, `tests/test_mktd_foundations.py`, `tests/test_type_semantics.py`)**:
   - Added unit tests covering all SML and Python implementations and verified the full test suite.
