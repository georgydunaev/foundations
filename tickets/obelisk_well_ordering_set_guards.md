# Obelisk: restore set guards in the well-ordering equivalence dossier

- **Assignee**: `Antigravity-bot0001`
- **Bot-Number**: `bot0001`
- **Worker-Host**: `bot0001-worker`
- **Process-ID**: `2759`
- **Agent-Hash**: `5b94e013`
- **Claimed-At**: `2026-11-07T20:02:30Z`
- **Status**: `Resolved / Implemented`

Status: Resolved / Implemented in `obeliskproofassistant.github.io/docs/theorems/well_ordering.md`.

## Evidence

Read-only checkout `../obeliskproofassistant.github.io`, commit
`bb346f112ae91d1649940068c7f210a53b8674bf`, inspected 2026-11-07.
`docs/theorems/well_ordering.md` discusses well-ordering **sets**, and its
final code snippet quantifies `X : Set`. Its equivalence section instead
displays

\[
\forall X\;\exists\alpha\in\mathrm{On}\;(X\sim\alpha)
\]

without a set restriction. The displayed Choice principle similarly
quantifies over all families `F`, without requiring `Set(F)`.

## The two quantifier changes have different consequences

In the class-language convention used by the catalog, the first formula
applies to `X=V`. It would provide a bijection between `V` and an ordinal
set. This is impossible: the inverse class function would have a set
domain and image `V`, contradicting class replacement and properness of
`V`. Global Choice does not make a proper class bijective with an
ordinal **set**. A set-like well-order of `V` has proper ordinal-class
type `On` instead.

For the Choice formula, taking the unrestricted family to be the class
of all nonempty sets requires a single class choice function on all
nonempty sets. This is Global Choice, not merely the ordinary Choice
axiom for set-indexed families. Thus the unguarded displays cannot serve
as an unqualified equivalence cycle with the ordinary set forms of
Zorn's lemma and well-ordering.

## Requested correction

For the set-level equivalence, write

\[
\forall X\;(\operatorname{Set}(X)\Rightarrow
 \exists\alpha\in\mathrm{On}\;(X\sim\alpha))
\]

and restrict the Choice family to a set of nonempty sets (or a set-indexed
family, with its indexing explicitly given). Keep Zorn's lemma on
set-sized partially ordered sets. State the particular Tychonoff version
being compared, since additional restrictions on compact factors can
change the choice strength.

If a global class principle is intended instead, label it separately
and prove the relevant class equivalences with their own hypotheses.
Do not replace `alpha in On` by a class quantifier without explaining
the changed well-order type. The final set-typed code snippet and the
prose theorem should have the same scope.

The book's `150_ordinals.tex` already distinguishes the set well-ordering
theorem, the injection definition of Hartogs' bound, and class-size
assertions. Its `090_proving_limitation_of_size.tex` explains why
assigning the default cardinal value `On` to proper classes does not
supply a bijection. These local distinctions should be preserved.

## Acceptance checks

Test the empty set and an arbitrary set in the corrected theorem;
confirm that substituting `V` is disallowed in the set statement. Check
that the Choice family quantifier excludes the proper family of all
nonempty sets unless the theorem is explicitly global. Repair owning
source documentation and regenerate exports rather than editing them.
