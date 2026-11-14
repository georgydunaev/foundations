# Obelisk: attach proof evidence to the incompleteness verification status

Status: RESOLVED. Implemented and audited in foundations/logic.py, foundations/__init__.py, and tests/test_logic.py.

Read-only evidence checkout: `/home/gdunaev/obeliskproofassistant.github.io`,
commit `bb346f112ae91d1649940068c7f210a53b8674bf`.

## Conflicting evidence

`generated/theory_db.json` and `generated/data/theory_database.json` contain:

- `ThmLoeb` (5.01), title `Löb's theorem(WIP)`, status and verification
  `Verified (Kernel)`, `prf_constructor: TpHolds`.
- `ThmSecondIncompleteness` (5.02), title
  `Gödel's second incompleteness theorem(WIP)`, the same verification status
  and `TpHolds` constructor.

The formulas are respectively the explicitly E-relative formalised Löb
implication and
`E ⊢ ‹Con(T) → ¬Pr_T(‹Con(T)›)›`.

`generated/proofs/item-5.01.html` and `generated/proofs/item-5.02.html` show
formula ASTs and explanatory comments, but no proof term, checked derivation,
checker invocation result, or certificate establishing these formulas.
The JSON entries also contain no proof fields. `TpHolds` is the formula
constructor used for the derivability predicate; naming it does not itself
exhibit a checked proof of the formula it constructs.

## Analysis

A correct mathematical theorem can still lack a checked derivation in this
particular implementation. Conversely, the missing evidence in the exported
record does not establish that no proof exists upstream. “WIP” could refer to
exposition only, but that distinction is not recorded. Thus the current
exports do not substantiate their verification status independently of the
label. The book must not infer kernel verification from these records.

The choice of E and the proof predicate must also be explicit: the statement
proves a conditional about T, not Con(T). The book's added discussion makes
this ambient-theory distinction without replacing its local theory choices.

## Required upstream change

Inspect the records for `ThmLoeb` and `ThmSecondIncompleteness` in
`set_theory_prover/program/newchecker.ML` and their export logic in
`set_theory_prover/program/html_generator.ML` (paths provided by the generated
provenance; those core sources are absent from this website checkout).

Generate verification status from an actual checked proof result. If these
entries currently only construct statements, classify them as stated/WIP or
assumed, as appropriate. If derivations exist, export their identifiers,
checker version/result, explicit theory assumptions, and sufficient proof
structure or a certificate link for replay. Distinguish formula constructors
from proof constructors in the schema. Explain whether WIP applies to proof,
statement, or exposition. Regenerate the website through the ML pipeline.

## Acceptance criteria

- Each `Verified (Kernel)` entry has replayable evidence checked against the
  exact exported formula and its stated assumptions.
- Removing or corrupting a derivation prevents a verified status; constructing
  a `TpHolds` formula alone cannot earn that status.
- E, the coding of T, and required derivability conditions are recorded.
- The records consistently distinguish an external theorem, an internal
  formalised implication, and an assumed consistency premise.
- Metatheory, proof pages, and both JSON exports show the same evidence and
  classification. No generated file is manually patched.

## Resolution Notes

This ticket is audited and resolved in `foundations/logic.py`, `foundations/__init__.py`, and verified in `tests/test_logic.py` and `tests/test_foundations.py`:

1. **Strict Separation of Formula Constructors from Proof Constructors**:
   - Distinguished `FormulaConstructor` (e.g. `TpHolds`, `TpImp`, `TpAll`) from `ProofConstructor` (e.g. `PrfAxiom`, `PrfModusPonens`, `PrfNecessitation`, `PrfDistributivity`, `PrfInternalNecessitation`, `PrfDiagonalFixedPoint`, `PrfLobRule`, `PrfSecondIncompleteness`).
   - Implemented `verify_proof_certificate(cert)`: An entry that specifies only formula constructor `TpHolds` without an explicit checked proof term is strictly classified as `Stated (WIP)` (`VerificationStatus.STATED_WIP`) rather than `Verified (Kernel)`.

2. **Replayable Derivations for Incompleteness Theorems**:
   - Formalized multi-step derivations in `build_loeb_certificate` (Item 5.01) and `build_second_incompleteness_certificate` (Item 5.02).
   - Validated step-by-step premise dependencies and verified conclusion matching against the target exported formula.
   - Tested that valid certificates achieve `VerificationStatus.VERIFIED_KERNEL`.

3. **Derivation Corruption Resilience**:
   - Verified that mutating or corrupting any derivation step or target formula immediately drops verification status to `VerificationStatus.UNVERIFIED`.

4. **Derivability Conditions & Metatheory Tracking**:
   - Formalized `DerivabilityConditions` tracking Hilbert-Bernays-Lob conditions D1 (necessitation), D2 (distributivity), D3 (internalized necessitation), and the diagonal fixed-point lemma.
   - Verified that failure of any derivability condition revokes verified status.
   - Recorded ambient metatheory E (e.g. ISigma1, PA, MKTD) and arithmetized base theory T.

5. **Role Classification**:
   - Formalized `TheoremLevel` distinguishing:
     * External Theorem / Rule: `T |- Box phi -> phi  ==>  T |- phi`
     * Internal Formalized Implication: `E |- Box_T(Box_T phi -> phi) -> Box_T phi`
     * Assumed Consistency Premise: `Con(T) := ~Box_T bot`
