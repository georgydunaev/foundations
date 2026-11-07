# Obelisk: expose indexed-union closure of tight set universes

Status: proposed development and proof-interface request, not an alleged contradiction or definition bug. Generated files remain untouched.

## Source evidence and ownership

Read-only inspection of `../obeliskproofassistant.github.io` at commit
`bb346f112ae91d1649940068c7f210a53b8674bf` on 2026-11-07 confirms these entries in `generated/theory_db.json` and the `sml_kernel_catalog` field of
`data/theory_database.json` (its separate `sections` catalog uses different numbering):

- `DefCardLessEq`, 3.40: the comparison is witnessed by an injective class function, restricted to the specified source set when used here.
- `DefCardLess`, 3.42: `A ≺ B` means there is no injection from `B` to `A`.
- `DefTransitiveClass`, 3.15: transitivity.
- `DefPairfulClass`, 3.46: `x,y in U` implies `{x,y} in U`.
- `DefTightClass`, 3.47: for `B subset U`, `B ≺ U` iff `B in U`.
- `DefPowerfulClass`, 3.45: `x in U` implies `P(x) in U`.
- `DefGrothendieckUniverse`, 3.68: `omega in U`, transitivity, Hereditary, Powerful, Tight, and Pairful.

The generated database identifies its producing source as
`set_theory_prover/program/newchecker.ML` and its generator as
`set_theory_prover/program/html_generator.ML`. Implement and register the theorem in the owning source module, then regenerate the interface. These upstream source files are not supplied by the generated-site checkout; this request does not claim their proof inventory has been inspected.

## Proposed theorem and proof

For a **wellorderable set** `U` satisfying the transitive, Pairful, Tight, and `omega in U` conditions, every specified family `X_i in U`, indexed by `I in U`, has `union_i X_i in U`.

Fix a wellordering of `U` and put `kappa = |U|`. Transitivity and Tight imply `|I|, |X_i| < kappa`. Every ordinary Kuratowski graph `f:I -> U` is a subset of `U`: its pair entries belong to `U` by repeated unordered pairing. Its cardinality is `|I|`, so Tight gives `f in U`.

Let `Y = union_i X_i`, a subset of `U`. The empty index case follows from Tight. If `Y notin U`, Tight and comparability of these wellordered sets give a bijection `e:Y -> U`. For each `i`, let

    D_i = {f(i) : f in e[X_i] and f is a function I -> U}.

Then `|D_i| <= |X_i| < kappa`; least preimages in the inherited wellordering justify the image bound without an additional choice assumption. Define `t(i)` to be the least member of `U minus D_i`. Replacement forms `t:I -> U`, and the graph observation gives `t in U`. Surjectivity of `e` yields `t in e[X_j]` for some `j`, forcing `t(j) in D_j`, a contradiction.

The proof needs only wellorderability of this particular `U`; ordinary set Choice suffices. It does not require Global Choice, identification of `U` with a rank stage, or a strongly inaccessible cardinal theorem. It does not extend the set cardinality argument to proper-class universes.

## Intended interface and acceptance criteria

- Export the exact sethood and wellorderability hypotheses and a replayable derivation, including graph representation and axiom dependencies.
- Keep ordinary Kuratowski auxiliary graphs explicit, or prove the corresponding transport for the source's chosen ordered-pair convention.
- Derive the indexed-union premise used by `prop:WM_universe_closure` in `130_classes_as_types.tex`. With Powerful and the other exported universe clauses, this proves that the address-based W- and M-carriers belong to `U`.
- Preserve the distinction between a set carrier and membership in an arbitrary chosen universe. The book's lemma is `lem:tight_universe_indexed_union`.
- Keep proper-class universes, including the exported universal-class example, outside this particular theorem's scope.
- Regenerate HTML and JSON from the source; do not patch generated artifacts or assign a verification badge without a checked derivation.
