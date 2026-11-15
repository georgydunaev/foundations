# Obelisk: canonical family records and two distinct image operations

Status: Resolved / Implemented
Snapshot: `obeliskproofassistant.github.io` inspected on 2026-11-07; resolved in `foundations` on 2026-11-15.

## Evidence inspected

The local site's `generated/theory_db.json`, inspected on 2026-11-07, exports:

- `DefFamily` (3.31): concentrated set values and flat proper values, requiring explicit assertion that every member is a pair record.
- `DefHasConcentratedValues` (3.29) and `DefFlatValues` (3.30): conditions at represented arguments.
- `DefRelationalImage` (3.26): relational image vs evaluated image `{b | exists a in A, F(a)=b}`.
- `DefValueAtArg` (3.25): guarded single-argument evaluation with default `V`.

## Nonrecord members and extensionality

For ordinary pairs, the empty set is not a pair. Consequently `F=empty` and `G={empty}` both satisfy fiber conditions vacuously when nonrecord members are not excluded: neither has any pair record or represented argument. They have the same domain and evaluated values but are different classes.

To reconstruct a family from its fibers, require that it consist entirely of Dunaev Tagged Ordered Pair records `[x, y]_D` with `x in A` and `y in B`. With this condition, the concentrated/flat rules determine a canonical fiber and prove family extensionality from equal domains and equal values.

## Relational image versus evaluated image

The book's local family construction distinguishes the relational image

    RelImage(F,A) = {b in V | exists a in A, [a,b]_D in F}

from the evaluated image `{b in V | exists a in A, F(a)=b}`. They agree on canonical functional families with set values under the proper-class default `V`, and differ when fibers are multi-valued or represent proper classes via singleton records.

## Resolution Summary (SML, Python, and LaTeX Implementations)

1. **Standard ML Formalization (`examples/mktd_foundations.ML`)**:
   - Added `FamilyValueAtArg`, `RelationalImage`, and `EvaluatedImage` to `class_term` and `HasConcentratedValues`, `FlatValues`, and `CanonicalFamily` to `fm` for `MKTD1-system` / `MKTD2-system`.
   - Implemented `eval_family_value_at_arg` (3.25 `F(a)` with default `V`), `eval_relational_image` (3.26 `F[A]`), `eval_evaluated_image`, and `eval_canonical_family` (3.29, 3.30, 3.31), verifying unique witness evaluation, fallback to `V` on missing or multi-valued fibers, coincidence of relational and evaluated images on functional families, divergence on multi-valued relations, and rejection of non-pair junk atoms.
2. **Python Formalization (`foundations/classes.py`, `foundations/type_semantics.py`, `foundations/__init__.py`)**:
   - Implemented `eval_family_value_at_arg`, `eval_relational_image`, `eval_evaluated_image`, `eval_has_concentrated_values`, `eval_flat_values`, `is_canonical_pair_record`, and `eval_canonical_family`.
3. **LaTeX Exposition (`110_family_evaluation.tex`)**:
   - Added Subsection `Guarded Argument Evaluation F(a) vs. Relational Image F[A] and Canonical Family Records (3.25--3.31)`.
