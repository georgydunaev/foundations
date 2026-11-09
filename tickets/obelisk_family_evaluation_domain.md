# Obelisk: reconcile guarded evaluation with the family-evaluation theorem

Status: Resolved / Implemented (2026-11-09). Guarded domain premise `x in Dom(F)` added to `family_eval_thm_entry_fm` in `program/types/foundations.ML` (Entry 3.37 / ThmFamilyEvaluation), reconciling with `DefValueAtArg` (Entry 3.25), and site artifacts regenerated via `html_generator.ML`.

## Evidence

Inspected local site checkout `../obeliskproofassistant.github.io` at commit
`bb346f112ae91d1649940068c7f210a53b8674bf` on 2026-11-07.
The generated database identifies its source as
`set_theory_prover/program/newchecker.ML` and its generator as
`program/html_generator.ML`.

In `generated/theory_db.json` (also exported in the generated data copies):

- `DefValueAtArg`, 3.25, defines `F(x)` to be `union {s | (x,s) in F}` when
  the fibre is nonempty, and `V` otherwise.
- `DefHasConcentratedValues`, 3.29, and `DefFlatValues`, 3.30, impose their
  conditions only at `x in Dom(F)`.
- `DefFamily`, 3.31, conjoins those two conditions.
- `ThmFamilyEvaluation`, 3.37, is marked `Verified (Kernel)` and states
  `forall F,x:Class, Family(F) -> F(x) = union {s | (x,s) in F}` without a
  domain restriction. The displayed theorem and exported side-condition
  field supply no missing domain assumption.

The separate `data/theory_database.json` entry 3.69 repeats the unguarded
family theorem and maps it to source entry 3.37. These numbers are distinct
catalog namespaces, not stable interchangeable identifiers.

## Reproduction and analysis

Take `F = emptyclass` and any set argument `x`, for instance `emptyclass`.
Its domain is empty. Both family conditions hold vacuously, so the exported
family definition admits `F`. Entry 3.25 gives `F(x) = V`; entry 3.37 gives
`F(x) = union emptyclass = emptyclass`. With the usual nonempty universal
class these conclusions conflict.

This is a conflict between displayed statements in one exported setting.
It is not resolved by calling the book old, or by observing that its separate
chapters sometimes use a different evaluation. It also does not establish
that the unavailable kernel actually derives a contradiction: the source
proof and export pipeline must be inspected to locate the defect.

The book has legitimate alternatives:

1. Unconditional union evaluation, as in `presentation.ML` and the early
   family proposal in `040_old_variant_of_iota_defs.tex`, defaults to empty.
2. Guarded evaluation in `060_axioms.tex` defaults to `V` off-domain.
3. PFOL in `210_partial_functions_semantics.tex` uses partial unique
   description. It is not either total convention.

Retain those distinctions. Both total conventions agree on a nonempty
fibre; their off-domain behavior differs deliberately.

## Requested source-level correction

Inspect `DefValueAtArg`, `ThmFamilyEvaluation`, their proof construction,
and their exporters in the Obelisk source named above. If the guarded
`V`-default convention is intended, use the theorem

    Family(F) and x in Dom(F) -> F(x) = union {s | (x,s) in F}.

In fact the union branch follows from the evaluation definition for any
relation with a represented fibre. A family hypothesis may be retained to
match the intended interface. State the off-domain equation separately.
If unconditional union evaluation is intended instead, change the
source definition deliberately and audit all results that rely on `V`
as a failure marker. Do not silently combine the alternatives.

For lambda-family beta laws, prove that the encoded argument lies in the
domain. Distinguish set arguments represented by graph entries from proper
class arguments; class quantification alone is not a proof of graph
representability.

Regenerate all affected pages and JSON from the corrected ML source.
Do not patch generated HTML/JSON or merely change the verification badge.

## Acceptance criteria

- The empty-family/off-domain example has one consistent documented value.
- A represented empty value is tested separately from an absent fibre.
- Multi-record and proper-class-valued fibres are tested under the chosen
  encoding, rather than assumed to behave like ordinary function graphs.
- Exported hypotheses and side conditions match the checked theorem.
- A replayable derivation, including axiom dependencies, justifies the
  corrected theorem's verification status.
- Current and legacy catalogs identify the same semantic convention with
  explicit ID mapping; no catalog number alone serves as proof provenance.
