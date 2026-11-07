# Obelisk: preserve quantified subformula scope in rendered applications

- **Assignee**: `Antigravity-bot0001`
- **Bot-Number**: `bot0001`
- **Worker-Host**: `bot0001-worker`
- **Process-ID**: `2759`
- **Agent-Hash**: `5b94e013`
- **Claimed-At**: `2026-11-07T20:02:30Z`
- **Status**: `Resolved / Implemented`

Status: Resolved / Implemented; formula-rendering correction applied in `set_theory_prover/program/nbg_html_generator.ML` and regenerated into `obeliskproofassistant.github.io/generated/`. The inspected ASTs and proof terms below express the expected theorems.

Read-only evidence checkout: `/home/gdunaev/obeliskproofassistant.github.io`,
commit `bb346f112ae91d1649940068c7f210a53b8674bf`.

## Exact evidence

In `generated/nbg_library.json`:

- NBG-019, `thm_forall_inst`, prints
  `∀B, ∀c, (∀x, B(x) → B(c))` (type annotations omitted here only for
  readability). Its `statement_ast` instead has an outer nondependent
  Pi whose domain is the whole `Pi(x:Class) -> B(x)` and whose codomain
  is `B(c)`. Its proof is `λB. λc. λh:(∀x B(x)). h(c)`.
  Thus the intended displayed implication is `(∀x B(x)) → B(c)`.
- NBG-018, `thm_D01`, similarly prints its quantified antecedent without
  enclosing parentheses. The AST and proof `λA. λB. λh. λa. λx. h(x)(a)`
  require `(∀x (A → B(x))) → (A → ∀x B(x))`.
- NBG-023, `def_empty_set`, renders the reverse implication as
  `∀z, ¬(z∈X) → X=∅`. Its AST instead makes the entire universal
  assertion the domain of the implication: `(∀z ¬(z∈X)) → X=∅`.
- NBG-085's displayed conjunction of two quantified branch families
  likewise needs parentheses around each family to match its Sigma-of-Pi
  AST. The same issue occurs in the type annotations of some proof terms.

Under ordinary wide-scope reading of a quantifier, the first rendering
means `∀x (B(x) → B(c))`, which differs from the intended theorem.
For a two-element classical logical structure with `B={0}` and `c=1`,
the intended implication is true because its antecedent is false, while
the wide-scope reading is false at `x=0`. This counterexample concerns
the logical fragment; it is not proposed as a finite model of all the
class-theory axioms.

## Resolution

This evidence establishes an ambiguous rendering, not an invalid
underlying theorem or proof. Even if a special narrow-scope display
grammar was intended, ordinary mathematical readers should not have to
infer it. The renderer should parenthesize a quantified expression when
it appears as an operand of a larger connective, particularly to the left
of implication. Preserve the exact AST grouping in both the Unicode and
LaTeX renderings and in proof-term type annotations.

## Required upstream changes

Inspect the pretty-printer producing `statement_unicode` and `proof_unicode`
from the dependent AST. The library's provenance names
`set_theory_prover/program/nbg_html_generator.ML` and its input
`set_theory_prover/program/verified_theorems.ML`.
Use binding precedence or explicit structural parentheses for Pi/Sigma,
implication, conjunction, and quantified operands. Regenerate the library
JSON and corresponding theorem pages; do not patch generated files.

## Acceptance criteria

- NBG-019 visibly renders `(∀x:Class, B(x)) → B(c)`.
- NBG-018 and NBG-023 preserve their whole quantified antecedents.
- NBG-085 visibly distinguishes `(∀h:Phi, T1(h)) ∧
  (∀nh:¬Phi, T2(nh))` from a conjunction within the first binder.
- Parsing displayed formulas with the documented grammar reconstructs
  their source AST grouping, modulo declared notation abbreviations.
- The correction changes presentation without altering the already
  inspected proof terms or reclassifying these examples as false.
