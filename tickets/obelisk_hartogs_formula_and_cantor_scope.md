# Obelisk: repair the Hartogs formula and Cantor proof scope

- **Assignee**: `Antigravity-bot0001`
- **Bot-Number**: `bot0001`
- **Worker-Host**: `bot0001-worker`
- **Process-ID**: `2759`
- **Agent-Hash**: `5b94e013`
- **Claimed-At**: `2026-11-07T20:02:30Z`
- **Status**: `Resolved / Implemented`

Status: Resolved / Implemented in `obeliskproofassistant.github.io/docs/axioms/cardinals.md`.

## Evidence

Read-only checkout `../obeliskproofassistant.github.io`, commit
`bb346f112ae91d1649940068c7f210a53b8674bf`, inspected 2026-11-07.
The source dossier `docs/axioms/cardinals.md` defines set cardinal assignment
under Global Choice, but later gives a supposedly choice-free Hartogs formula

\[
\aleph(X)=\min\{\alpha\in\mathrm{On}:\neg(\alpha\leq|X|)\}.
\]

## Hartogs counterexample and repair

With ordinary ordinal comparison, the displayed formula gives `omega+1`
at `X=omega`. But `omega+1` injects into `omega`: map its last point
`omega` to zero and map each finite ordinal `n` to `n+1`. Thus this
formula does not describe an ordinal that fails to inject into `X`.

The correct choice-free definition is

\[
\mathfrak h(X)=\min\{\alpha\in\mathrm{On}:\neg(\alpha\preccurlyeq X)\},
\]

where `preccurlyeq` explicitly means existence of an injection. Construct
the bound from the order types of well-ordered subsets of `X`; this neither
requires a cardinal representative of `X` nor presupposes that `X` is
well-orderable. The book's `thm:hartogs_bound` supplies this proof.
For a well-orderable `X`, the result is the successor **cardinal** of
`|X|`, not generally its ordinal successor.

If the dossier intends `<=` to mean injection comparison even for arbitrary
ordinals, it must say so and use a distinguishable notation. Even that
reading does not make the expression through an assumed ordinal cardinal
representative of arbitrary `X` a choice-free construction. The primary
book convention assigns `On` when such a set representative is absent;
substituting this default does not supply the missing Hartogs argument.

## Cantor proof snippet

The mathematical diagonal argument preceding the snippet is sound. The
purported mechanized code then declares an existential `D` before the
universal `F`, defines `D` using that not-yet-bound `F`, and asserts
`subclass(D,power(X))`. The diagonal gives `D subseteq X`, hence
`D in power(X)`, which is the membership needed to apply surjectivity.

State the intended theorem directly as: for every set `X`, no function
`F:X -> power(X)` is surjective. Introduce `F` and its surjectivity
assumption before defining its diagonal `D_F`. Prove `D_F subseteq X`,
derive `D_F in power(X)`, and then extract the impossible preimage.
An outer existential `D` independent of `F` is unnecessary. Although the
snippet's final no-surjection assertion is mathematically true, its
displayed binding order is not a certificate of the stated diagonal proof.

## Acceptance checks

- Test Hartogs at the empty set, finite sets, and `omega`; distinguish
  ordinal successor from successor cardinal.
- Record the choice-free construction independently of cardinal assignment.
- Replay a scoped Cantor derivation with the exact membership conclusion.
- Verify claims against the owning source implementation before regenerating
  any export; this review has not inspected an actual kernel proof term.
