# Obelisk: remove the circular ordinal-comparison proof dependency

- **Assignee**: `Antigravity-bot0001`
- **Bot-Number**: `bot0001`
- **Worker-Host**: `bot0001-worker`
- **Process-ID**: `2759`
- **Agent-Hash**: `5b94e013`
- **Claimed-At**: `2026-11-07T20:41:00Z`
- **Status**: `Resolved / Implemented`

Status: Resolved / Implemented in `set_theory_prover/program/ordinal_theorems.ML`, `set_theory_prover/tests/test_ordinal_theorems.py`, `set_theory_prover/formal/ORDINAL_THEOREMS_PROOFS.md`, and `obeliskproofassistant.github.io/docs/ORDINAL_THEOREMS_PROOFS.md`.

## Evidence

Read-only snapshot: `../obeliskproofassistant.github.io`, commit
`bb346f112ae91d1649940068c7f210a53b8674bf`, inspected 2026-11-07.

`docs/ORDINAL_THEOREMS_PROOFS.md` identifies its source as
`set_theory_prover/formal/ORDINAL_THEOREMS_PROOFS.md` and links claimed
proof implementations in `program/ordinal_theorems.ML`.

- Theorem O9, `thm_O9_ord_ssub_in`, step 5(b), uses ordinal trichotomy to
  show that every member of alpha belongs to the chosen minimal gamma.
- Theorem O10, `thm_O10_ord_trichotomy`, steps 5–7, invokes O9 to prove
  trichotomy.
- The initial `Ord` definition is only transitivity plus transitivity of
  every member. Linearity is not included as a premise of O9.

The dossier declares all twelve results typed and verified, but the displayed
O9–O10 proof dependency is circular unless an earlier independent trichotomy
lemma is supplied. This is a defect in the available proof exposition; the
unavailable ML source has not been inspected, so it is not evidence that the
kernel accepted a circular proof.

## Distinguish two valid settings

The book's general ordinal definition explicitly includes a strict membership
well-order. Its proper-transitive-subclass lemma may therefore use linearity
locally without importing a future comparison theorem. With that lemma,
comparing the intersection of two ordinals gives a noncircular proof of their
comparison. This route is now written out in `150_ordinals.tex`.

The shorter generated `DefOrdinalClass` (3.16) can be retained under
`AxmRegularity` (3.14). It needs a proof that the shorter condition implies
the well-order condition. The book supplies one using its independently
established ordinal class and founded induction. Alternatively, the source
may prove comparison for the shorter definition by a separate minimal-
counterexample argument. Either route must expose its dependencies.

There is a second scope detail: O9 quantifies over ordinal classes without
sethood hypotheses, but calls `beta \ alpha` a set and invokes the
set-only regularity statement listed in the dossier. For proper beta the
difference need not be a set. Use class-foundedness (and establish it from
the background axiom), or explicitly restrict O9 to ordinal sets. Do not
silently switch meanings of `Ord`; `docs/axioms/ordinals.md` uses a set-only
predicate whereas generated `DefOrdinalClass` does not.

## Requested source-level changes

1. Repair the mathematical proof in the source dossier and its actual
   `program/ordinal_theorems.ML` derivations, if affected.
2. Introduce a separate lemma establishing linearity or well-ordering for
   the shorter definition under explicit regularity assumptions.
3. Make the proof-dependency graph acyclic: the revised O9 must not depend
   on O10 if O10 still depends on O9.
4. State whether each theorem accepts ordinal classes or ordinal sets;
   expose any sethood/class-foundedness hypotheses in the theorem record.
5. Regenerate exported copies from source. A verification label is not a
   substitute for the missing derivation.

## Acceptance criteria

- O9 and O10 have replayable proofs with an acyclic dependency graph.
- The actual checker conclusion and the published formula have the same
  hypotheses and domains.
- The set-ordinal instance and the proper ordinal-class instance `On` are
  tested separately when both are supported.
- Regularity is visible in the short-definition route, while the book's
  general well-order-based route does not acquire it without explanation.
- Catalog semantic IDs, prose definitions, and source-level proof names are
  mapped explicitly; bare item numbers do not stand in for provenance.
