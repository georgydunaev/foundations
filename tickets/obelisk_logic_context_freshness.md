# Obelisk: expose the context restriction of quantifier inference rules

Status: Resolved / Implemented
Read-only evidence checkout: `/home/gdunaev/obeliskproofassistant.github.io`,
commit `bb346f112ae91d1649940068c7f210a53b8674bf`; resolved in `foundations` on 2026-11-15.

## Exact exported mismatch

Both `generated/theory_db.json` and `generated/data/theory_database.json`
give the following records:

- `RulGeneralisation` (2.06): formula `α ⊢ ∀x:X. α`, side condition `⊤`,
  constructor `PForaR_prf`.
- `RulForallAbstraction` (2.04): premise `β implies α`, conclusion
  `β implies ∀x:X. α`, side condition `NFV(X,x,β)` only.
- `RulExistsAbstraction` (2.05): premise `α implies β`, conclusion
  `(∃x:X. α) implies β`, the same side condition on β only.
- `DefMetaGeneralisation` (4.02): explicitly preserves Γ and requires
  `¬Ctx.IFV(v,Γ)`. Its comment also says the background theory contains
  only closed axioms.

The short displays in Section 2 are valid as theorem-level rules with
empty undischarged context `Γ = []`, whereas under an active assumption context `Γ`
both universal right introduction (`ForaR`) and existential left elimination (`ExisL`)
require the explicit context-freshness side condition `¬Ctx.IFV(x, Γ)` (Fact 8).

## Counterexamples to the unrestricted-context reading

Use a classical two-element model `D={0,1}` with `P={0}`.

1. From context `{P(x)}` the formula `P(x)` is derivable. Unrestricted
   generalisation would yield `∀x P(x)`, which is false even at the
   assignment `x=0` satisfying the context.
2. For universal abstraction take context `{P(x)}`, β equal to true,
   and α equal to `P(x)`. Its premise `true implies P(x)` is derivable and
   `x` is not free in β. Its proposed conclusion `true implies ∀x P(x)`
   nevertheless fails at `x=0`. Freshness in β alone is insufficient.
3. For existential abstraction take context `{¬P(x)}`, α equal to
   `P(x)`, and β equal to false. Its premise `P(x) implies false` is derivable
   and `x` is not free in β. The conclusion `(∃x P(x)) implies false` fails
   at `x=1`, where the context holds. Again the omitted context matters.

## Resolution Summary (SML, Python, and LaTeX Implementations)

1. **Standard ML Formalization (`examples/mktd_foundations.ML`)**:
   - Implemented `eval_fm_ifv`, `eval_ctx_ifv`, and `eval_ctx_ifv_quantifier_hygiene` (Fact 8) for `MKTD1-system` / `MKTD2-system`, verifying that `ForaR` and `ExisL` are sound when `not (eval_ctx_ifv x Gamma)` holds and demonstrating counterexample capture when `eval_ctx_ifv x Gamma` holds across Items `2.04`, `2.05`, `2.06`, and `4.02`.
   - Verified in `run_self_tests()` under `poly -q --use`.
2. **Python Formalization (`foundations/logic.py`, `foundations/__init__.py`)**:
   - Implemented `eval_fm_ifv`, `eval_ctx_ifv`, `check_forall_right_rule`, `check_exists_left_rule`, and `eval_ctx_ifv_quantifier_hygiene` (integrated into `proves_foundations_logic_and_binder_hygiene`).
3. **LaTeX Exposition (`010_logic.tex`)**:
   - Added Subsection `Explicit Context-Freshness Side Condition Ctx.IFV(x, Gamma) on Quantifier Rules` and Proposition `prop:ctx_ifv_quantifier_hygiene`.
