# Obelisk: retain sethood in singleton introduction across library variants

Status: source audit required; no upstream files changed.
Snapshot: `obeliskproofassistant.github.io` commit `bb346f112ae91d1649940068c7f210a53b8674bf`, inspected 2026-11-07.

## Evidence

- `/home/gdunaev/obeliskproofassistant.github.io/generated/nbg_library.json`, `NBG-060` / `def_singleton`, states for Class-typed `a,z`:
  `(z∈{a} → z=a) ∧ (z=a → z∈{a})`.
  Its proof field is `plan_singleton` and its AST also omits sethood.
- The same file, `NBG-071` / `thm_singleton_self_in`, states `∀a:Class, a∈{a}` and publishes the term `(λ(a:Class). (snd(((plan_singleton a) a)) refl(a)))`.
- `/home/gdunaev/obeliskproofassistant.github.io/generated/theory_db.json`, `DefSingletonSet` (3.48), instead defines `{a}={x | x=a}` under the primary catalog's set-member comprehension.
- The book's `200_uniqueness.tex` uses that comprehension; `190_union_intersection.tex` states `⋂{w}=w` for a set `w`.

## Conflict and scope

In the class-membership semantics, only sets can be members. Taking `a=V`, the purported universal singleton-introduction theorem gives `V∈{V}`, making the universal class a set. The comprehension singleton of a proper class is empty instead.

The published proof of NBG-071 correctly exposes its dependency on the stronger `plan_singleton` interface; a kernel-accepted term relative to that interface does not establish compatibility with the catalog's class semantics. It remains to inspect whether that plan is a postulate, a definitional primitive, or an incorrectly exported specialization. A variant with differently typed singleton arguments would need that restriction represented in both the AST and display.

## Requested source-level correction

Trace `plan_singleton`, `def_singleton`, and `thm_singleton_self_in` through `set_theory_prover/program/verified_theorems.ML` and their actual defining module; inspect `program/nbg_html_generator.ML` and the primary definition in `program/types/foundations.ML`. These upstream modules are identified by catalog provenance but are not present in this checkout.

For ordinary class membership, keep `a,z:Class` and use the characterization
`z∈{a} ↔ (Set(a) ∧ z=a)` (equivalently `Set(z) ∧ z=a`). Introduce `a∈{a}` only with `Set(a)`. If an alternative membership semantics is intended, explicitly isolate and name that theory instead of exporting these as the same NBG class singleton.

Regenerate outputs from the corrected source; do not hand-edit generated artifacts.

## Acceptance tests

1. A singleton of each finite set contains that set.
2. For a proper class parameter `V`, class comprehension yields `{V}=∅`; unconditional singleton self-membership is not derivable.
3. `NBG-071` either carries the sethood hypothesis in both AST and display, or is explicitly separated into a genuinely different theory.
4. `NBG-090` singleton elimination remains valid without a sethood premise.
5. Audit downstream singleton introductions, including `NBG-091` and `NBG-092`, without unnecessarily restricting valid singleton-subclass inclusions.
6. Replay proofs against the corrected primitive definitions; compare Unicode, AST, and generated proof dependencies.
