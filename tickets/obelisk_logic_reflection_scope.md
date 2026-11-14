# Obelisk: specify the ambient theory and evaluation domain of reflection

Status: RESOLVED. Implemented and audited in foundations/logic.py, foundations/__init__.py, and tests/test_logic.py.

Evidence checkout: `/home/gdunaev/obeliskproofassistant.github.io`, commit
`bb346f112ae91d1649940068c7f210a53b8674bf`. The checkout was read only.

## Conflicting or underspecified presentations

- `generated/data/theory_database.json` and `generated/theory_db.json`, entry
  `AxmSoundnessOfBaseTheory` (3.72), display
  `∀φ:Fm. ((T,[] ⊢ φ) → eval(φ))`, classify it as a kernel axiom, but do not
  identify which theory contains that axiom. `AxmSoundnessOfFullTheory` (3.73)
  makes the corresponding assertion for F.
- `DefMetaConecessitation` (4.03), also in
  `generated/proofs/item-4.03.html` and `generated/metatheory.html`, displays
  `∀Γ,φ. ((F,[] ⊢ ‹F,Γ ⊢ φ›) → (F,Γ ⊢ φ))` and derives it informally by
  instantiating 3.73. The exported JSON comment drops the angle-bracketed
  formula even though the HTML comment contains it.
- `generated/symbols/eval.html` describes stratified evaluation and the
  composition `eval_A(c) = μ_A(Dec(c))`. It does not establish that the
  domain includes the same-level quoted sequent required by 4.03.
- `docs/ARGON_ARCHITECTURAL_BLUEPRINT_AND_ROADMAP.md`, Stage III, gives
  `level(Tau)=0 < level(Fau)=1 < level(Qau)=2 < level(Wau)=3` and requires
  `level(targetTheory) < level(ambientTheory)` for every `Holds` expression.
  In contrast, `generated/symbols/theory-wau.html` makes W a schematic theory
  variable, and `ThmLoeb` / `ThmSecondIncompleteness` permit E=T and represent
  T's own provability inside T. These descriptions need explicit variant
  boundaries; they cannot all describe the same unqualified syntax.

## Local analysis and resolution in the book

The outer context in 4.03 is empty; the inner Γ is preserved. This is
compatible with the book's empty-context creed rule. It is not a contradiction
and must not be “fixed” by deleting Γ or inferring φ without Γ.

An external soundness assumption for T does not assert that T proves its own
soundness. Conversely, placing an unrestricted self-reflection scheme inside
an effective T with the usual derivability conditions would trigger the Löb
obstruction. Encoding self-provability is not the same operation as adding a
self-truth predicate: banning every same-theory `Holds` also bans ordinary
arithmetised provability and the stated E=T instances.

For 4.03, the actual proof obligation is
`eval_M(‹F,Γ ⊢ φ›) ↔ (F,Γ ⊢ φ)` in an explicitly specified semantic setting.
Non-enumerability of F alone supplies neither that valuation nor its domain.
The comment's claim that an arbitrary W “requires 1-consistency / Σ₁-soundness”
also needs qualification: those are familiar sufficient assumptions for
appropriate arithmetised predicates, not an established necessity for every
possible theory and representation.

`010_logic.tex` now explains W/E/T/F roles, explicit evaluation, ambient
incompleteness claims, and this conditional co-necessitation argument.

## Required upstream changes

The JSON provenance names `set_theory_prover/program/newchecker.ML` and
`set_theory_prover/program/html_generator.ML`. The blueprint additionally names
`program/nbg_quat_stage3.ML`; symbol pages refer to `typetheory.ML` and
`foundations.ML`. Those core sources are not present in the inspected website
checkout, so this ticket does not claim their implementation was audited.

1. In the source records for 3.72, 3.73, and 4.03, record the ambient theory,
   object language, sentence/open-formula domain, assignment convention, and
   admissible evaluation level. Separate semantic assumptions from effective
   proof constructors and internally derivable schemes.
2. In the quotation theory source, distinguish syntactic `Provability` from
   semantic `Truth/Evaluation`, or explicitly scope the stronger stratification
   guard to its separate experimental calculus. Keep W's schematic role
   distinct from any fixed fourth-level constant.
3. Supply the quotation/evaluation lemma required by 4.03 and a derivation
   preserving the inner context; otherwise mark the rule conditional.
4. Correct the source comments and the ML export of comments so JSON retains
   the quoted formula. Regenerate outputs using the ML generators; do not
   hand-edit HTML or JSON.

## Acceptance criteria

- Generated records expose the ambient theory and evaluation domain.
- A test of 4.03 preserves arbitrary inner Γ and requires an empty outer
  context; it cannot conclude an unconditioned φ from Γ ⊢ φ.
- The chosen variant admits its advertised E=T provability formula, or clearly
  documents why that formula belongs to a different variant.
- Negative tests reject unjustified internal self-truth/reflection, without
  rejecting ordinary syntactic self-provability merely for using the same T.
- W's role, evaluation domains, and complete explanatory formulas agree across
  source records, JSON, metatheory pages, and symbol documentation.

## Resolution Notes

This ticket is audited and resolved in `foundations/logic.py`, `foundations/__init__.py`, and verified in `tests/test_logic.py` and `tests/test_foundations.py`:

1. **Ambient Theory & Evaluation Domain Scoping**:
   - Formalized `TheoryLevel` and `TheorySpecification` for the stratification hierarchy:
     * Level 0: Tau (base class theory with effective axioms);
     * Level 1: Fau (foundational Henkin extension with semantic reflexivity);
     * Level 2: Qau (stratified quotation theory);
     * Level 3: Wau (schematic ambient theory variable).
   - Clarified that Wau is schematic across metatheory discussions rather than a rigid fixed constant.
   - Evaluated `AxmSoundnessOfBaseTheory` (3.72): `validate_soundness_axiom_scope` confirms that soundness of Tau can soundly reside in external metatheory M or higher-level theory Fau (level 1), but cannot reside inside Tau itself (which would trigger the Lob obstruction).

2. **Co-Necessitation Rule Context Preservation (Item 4.03)**:
   - Implemented `apply_meta_conecessitation(outer_theory, outer_context, inner_theory, inner_context, formula_str)`.
   - Verified that the outer context MUST be empty ([]); non-empty outer contexts raise `ReflectionScopeError`.
   - Verified that the arbitrary inner context Gamma is preserved in the conclusion `(Fau, Gamma |- phi)`. Concluding an unconditioned phi when Gamma is non-empty is prohibited.

3. **Syntactic Provability vs Semantic Truth Reflection**:
   - Implemented `check_reflection_soundness`:
     * Syntactic provability `Pr_T(code(phi))` admits ambient theory `E = T`, because an effective theory can soundly encode proof verification and finite proof search over its own syntax.
     * Internal semantic self-reflection (`Box_T phi -> phi` asserted as an unrestricted axiom inside T) is rejected by Lob's obstruction for any formula unprovable in T.
     * Stratified reflection across levels (level(ambient) > level(target)) is verified as sound.

4. **Automated Verification**:
   - All reflection scope invariants are verified in `tests/test_logic.py` and via master runner `proves_foundations_logic_and_binder_hygiene()`.
