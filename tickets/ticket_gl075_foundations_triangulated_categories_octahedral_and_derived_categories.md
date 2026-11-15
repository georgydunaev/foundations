# Ticket 75: Triangulated Categories, Distinguished Triangles, the Octahedral Axiom, and Derived Categories via Gabriel-Zisman Calculus of Fractions

- **Issue ID**: `#8007` (Sub-ticket `gl075`)
- **State**: `closed`
- **Status**: `Resolved / Implemented`
- **Target Frameworks**: `MKTD1-framework`, `MKTD2-framework`
- **Target Systems**: `MKTD1-system` (`MKTD1-prover`), `MKTD2-system` (`MKTD2-prover`)
- **Target Theories**: `MKTD1-theory`, `MKTD2-theory`

## Summary

Formalized triangulated categories $(\mathcal{D}, [1], \Delta)$, distinguished triangles, rotation invariance \textup{(TR2)}, mapping cones $\mathrm{Cone}(u)$, the Octahedral Axiom \textup{(TR4)}, multiplicative systems of quasi-isomorphisms via Gabriel-Zisman roofs, and universal derived category localizations $\mathbf{D}(\mathcal{A}) = \mathbf{K}(\mathcal{A})[S^{-1}]$ in `MKTD1-theory` and `MKTD2-theory` over Dunaev Tagged Ordered Pairs (`TagPair` / `DunaevTaggedPair`).

## Implemented Artifacts

1. **Standard ML Kernel (`examples/mktd_foundations.ML`)**:
   - Added AST constructors `SuspensionShiftFunctor`, `DistinguishedTriangle`, `MappingConeComplex`, `QuasiIsomorphismRoof`, `DerivedCategoryLocalization` (`datatype class_term`) and `IsTriangulatedCategory`, `IsDistinguishedTriangle`, `SatisfiesOctahedralAxiom`, `IsMultiplicativeSystemOfQuasiIsos`, `IsDerivedCategoryUniversal` (`datatype fm`).
   - Added semantic evaluators `eval_is_triangulated_category`, `eval_distinguished_triangle_rotation`, `eval_octahedral_axiom`, `eval_quasi_iso_roof_calculus`, `eval_derived_category_localization`.
   - Added derived theorem checkers `prove_distinguished_triangle_rotation_invariance`, `prove_octahedral_mapping_cone_coherence`, and `prove_gabriel_zisman_derived_localization_universal`.
2. **Python Verification Suite (`foundations/classes.py`, `foundations/type_semantics.py`, `foundations/__init__.py`)**:
   - Implemented `eval_is_triangulated_category`, `eval_distinguished_triangle_rotation`, `eval_octahedral_axiom`, `eval_quasi_iso_roof_calculus`, `eval_derived_category_localization`, and `proves_triangulated_categories_octahedral_and_derived_categories`.
3. **LaTeX Exposition (`300_category_theory.tex`)**:
   - Added subsection `\subsection{Triangulated Categories, Distinguished Triangles, the Octahedral Axiom, and Derived Categories}`.
