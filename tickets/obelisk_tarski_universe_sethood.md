# Obelisk: restore sethood in the Tarski-universe axiom dossier

- **Assignee**: `Antigravity-bot0001`
- **Bot-Number**: `bot0001`
- **Worker-Host**: `bot0001-worker`
- **Process-ID**: `2759`
- **Agent-Hash**: `5b94e013`
- **Claimed-At**: `2026-11-07T20:02:30Z`
- **Status**: `Resolved / Implemented`

Status: Resolved / Implemented in `obeliskproofassistant.github.io/docs/axioms/66_tarski_universes.md`; generated files unchanged.

## Exact mismatch

Read-only snapshot `../obeliskproofassistant.github.io`, commit
`bb346f112ae91d1649940068c7f210a53b8674bf`, inspected 2026-11-07.

`docs/axioms/66_tarski_universes.md` displays

\[
\forall X\;(\operatorname{Set}(X)\Rightarrow
 \exists U\;(X\in U\land\operatorname{Universe}(U))).
\]

In `generated/theory_db.json`, the actual semantic ID
`AxmTarskiUniverses` (3.70) additionally requires `Set(U)`.
The same catalog defines `DefGrothendieckUniverse` (3.68) as a closure
predicate on classes without a sethood conjunct and explicitly asserts
`ThmUniversalClassIsUniverse` (3.69), namely `Universe(V)`.

## Why the missing conjunct matters

Under that shared class-valued predicate, the prose formula follows
immediately from `Universe(V)`: for any set `X`, choose `U=V`, since
`X in V`. It then requires no containing **set** universe and supplies
none of the intended additional set-existence strength.

This cannot be repaired merely by calling the quantified object a
universe in surrounding prose: the catalog deliberately allows proper
universe classes. Nor should the predicate itself silently be changed to
exclude `V`, since that would contradict the separately preserved
universal-class theorem and erase the distinction between these settings.

## Requested repair

Use the exact source axiom

\[
\forall X\;(\operatorname{Set}(X)\Rightarrow
 \exists U\;(\operatorname{Set}(U)\land
             \operatorname{Universe}(U)\land X\in U)).
\]

Explain that `Universe(U)` describes closure properties, while `Set(U)`
makes the Tarski axiom assert a sufficiently large **set** with those
properties. Keep `Universe(V)` as the separate proper-class instance.
Any identification with inaccessible-cardinal set universes should name
its background assumptions and its equivalence theorem.

The book's intersection results concern explicitly transitive **set**
universes with stated ambient closure properties; they assert preservation
of those properties, not existence of arbitrary larger universes. No
Tarski existence conclusion follows from intersection closure alone.

## Acceptance checks

- Match the dossier formula to semantic ID `AxmTarskiUniverses`, including
  both sethood conditions and the membership direction `X in U`.
- Check that `U=V` satisfies the weaker prose formula but fails the set
  witness requirement of the intended axiom.
- Preserve the distinction between a closure predicate and an additional
  set-existence axiom in documentation, dependency diagrams, and exports.
- Repair source documentation and regenerate through its owning pipeline;
  do not patch the generated catalog directly.
