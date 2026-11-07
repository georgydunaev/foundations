# Obelisk: expose the context restriction of quantifier inference rules

Status: open; exported rule-scope reconciliation, not a finding that the
unavailable kernel implementation accepts an invalid derivation.

Read-only evidence checkout: `/home/gdunaev/obeliskproofassistant.github.io`,
commit `bb346f112ae91d1649940068c7f210a53b8674bf`.

## Exact exported mismatch

Both `generated/theory_db.json` and `generated/data/theory_database.json`
give the following records:

- `RulGeneralisation` (2.06): formula `α ⊢ ∀x:X. α`, side condition `⊤`,
  constructor `PForaR_prf`.
- `RulForallAbstraction` (2.04): premise `β → α`, conclusion
  `β → ∀x:X. α`, side condition `NFV(X,x,β)` only.
- `RulExistsAbstraction` (2.05): premise `α → β`, conclusion
  `(∃x:X. α) → β`, the same side condition on β only.
- `DefMetaGeneralisation` (4.02): explicitly preserves Γ and requires
  `¬Ctx.IFV(v,Γ)`. Its comment also says the background theory contains
  only closed axioms.

The short displays in Section 2 can be correct as theorem-level rules with
empty undischarged context. They are not unrestricted rules under arbitrary
assumptions. Their presentation must specify which interpretation is intended;
entry 4.02 already records the necessary distinction for generalisation.

## Counterexamples to the unrestricted-context reading

Use a classical two-element model `D={0,1}` with `P={0}`.

1. From context `{P(x)}` the formula `P(x)` is derivable. Unrestricted
   generalisation would yield `∀x P(x)`, which is false even at the
   assignment `x=0` satisfying the context.
2. For universal abstraction take context `{P(x)}`, β equal to true,
   and α equal to `P(x)`. Its premise `true → P(x)` is derivable and
   `x` is not free in β. Its proposed conclusion `true → ∀x P(x)`
   nevertheless fails at `x=0`. Freshness in β alone is insufficient.
3. For existential abstraction take context `{¬P(x)}`, α equal to
   `P(x)`, and β equal to false. Its premise `P(x) → false` is derivable
   and `x` is not free in β. The conclusion `(∃x P(x)) → false` fails
   at `x=1`, where the context holds. Again the omitted context matters.

These are failures of the unrestricted reading, not contradictions between
the correctly scoped theorem-level and context-level rules.

## Required upstream source changes

Inspect the actual `PForaR_prf` and `PExisL_prf` checking branches and the
rule records in the ML source named by the export provenance
(`set_theory_prover/program/newchecker.ML` and the HTML generator). Those
core sources are absent from the inspected site checkout.

- If Section 2 describes theorem-level rules, explicitly state that the
  input derivation has no undischarged assumptions and the theory axioms
  have no free occurrence of the generalized variable.
- For context-indexed rules display Γ on both sides and require freshness
  for Γ as well as the displayed unchanged formula. Include relevant type
  dependencies if the binder sort is itself dependent.
- Make Section 2 and 4.02 agree about these restrictions and explain the
  rule/entailment distinction in their turnstile notation.
- Regenerate the proof pages and JSON from corrected source records rather
  than modifying generated files.

## Acceptance criteria

- A derivation from `{P(x)}` cannot be generalized over x while retaining
  that context; generalisation over a genuinely fresh variable remains valid.
- All three counterexamples above are rejected under the context reading.
- Closed-context instances continue to work.
- Exported side conditions match the implemented checks and the metatheory.

The book's `010_logic.tex` keeps the context restrictions explicit and now
proves the deduction transformation for these exact rules. The separate
`obelisk_uniqueness_binder_hygiene.md` concerns capture in the at-most-one
definition, not this inference-context restriction.
