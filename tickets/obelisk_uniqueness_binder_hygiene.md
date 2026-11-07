# Obelisk: expose hygiene requirements for the at-most-one binder

Status: open; source-level binder/export audit, not a claim of an accepted
kernel contradiction.

Evidence snapshot: `bb346f112ae91d1649940068c7f210a53b8674bf` in the read-only
checkout `/home/gdunaev/obeliskproofassistant.github.io`.

## Exported statement

`generated/theory_db.json`, `DefAtMostOneBinder` (4.04), title
`Quantifier “unique”(meta,WIP)`, constructor `TpUniq`, renders the schema

```
∀φ:Fm. (!z:Class. eval(φ)) ↔
  ∀x:Class ∀y:Class.
    (eval(φ[x/z]) ∧ (let z=y in eval(φ))) → x=y
```

The displayed `formula_unicode`, `scheme_of_types_unicode`, and
`kernel_ast_unicode` use fixed names `x`, `y`, `z`. The export's
`side_condition_unicode` is empty. No condition says that `x` and `y` are
fresh for the substituted formula, nor explains an automatic freshening
operation. This issue is separate from whether `!` means at most one or
exactly one: the displayed implication is intended to mean at most one.

## Why freshness matters

Under ordinary capture-prone insertion, take `φ(z) := z ≠ x`, with `x`
a free parameter, in a classical domain with at least three elements.
The left side says that at most one object differs from the fixed parameter
`x`, which is false. On the right, substitution of `x` for `z` produces
`x ≠ x`. Its occurrence makes every antecedent false, so the universally
closed right side is true. A freshness or hygiene convention is therefore
essential; capture-avoiding substitution *inside* `φ` alone does not prevent
new surrounding quantifiers from capturing a parameter of the inserted
formula.

A hygienic quotation/antiquotation implementation might already distinguish
these names and avoid this example. In that case the exported formula is
underspecified rather than the source rule being unsound. The producing ML
source is not available in this checkout, so this ticket requires source
inspection rather than attributing the example to the kernel.

## Requested source-level change

Inspect `TpUniq` and its binder/substitution representation in the producing
checker source. Either:

1. generate two distinct bound variables fresh for `φ` and the original
   binder, and document the freshening operation; or
2. expose explicit distinctness/freshness conditions and reject instances
   that fail them.

Make the renderer show enough hygiene information to distinguish a free
parameter named `x` from an introduced bound variable printed as `x`.
Regenerate the website from source; do not hand-edit generated artifacts.

## Acceptance checks

- Formulas containing free parameters named `x` and/or `y` retain those
  parameters after expanding uniqueness.
- `!z. z ≠ x` agrees with its correctly freshened expansion in a three-object
  test structure.
- Expansion is invariant under alpha-renaming of the introduced variables.
- The empty predicate and singleton predicate satisfy at-most-one uniqueness;
  a predicate with two distinct witnesses does not.
- Documentation distinguishes at-most-one from existence-and-uniqueness and
  identifies any quotation-level hygiene mechanism used by this rule.

## Book comparison

`200_uniqueness.tex` already requires distinct fresh variables `Y_1,Y_2`
free for the substituted variable. Its mathematical definition avoids this
problem. No change to that definition is proposed.
