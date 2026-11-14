# Ticket 63 - Foundations: Formalize Class Inner Model Relativization and Forcing Posets with Dunaev Tagged Names in MKTD

**Project:** foundations
**Importance:** 8/10
**State:** opened
**Labels:** foundations, math, forcing, inner-models, mktd1, mktd2, sml, python
**Label Justification:** Extends foundations formalizations beyond Ticket 7731 (Large Cardinals) and Ticket 7732 (Constructible Universe L and GCH) to forcing posets and P-names.

## Context and Audit Finding
Following Ticket 7731 (Inaccessible, Mahlo, and Measurable Cardinals, Ultrafilters, and Scott's Theorem) and Ticket 7732 (Constructible Universe `L`, Condensation Lemma, and `L` models `AC` and `GCH`), the next core pillar in `foundations` (`examples/mktd_foundations.ML` and `foundations/type_semantics.py`) is general inner model relativization and Cohen forcing infrastructure in Morse-Kelley class theory with Tarski universes and Dunaev pairs (`MKTD`).

## Deliverables
1. **Inner Model Criterion in MKTD**: Formalize syntactic formula relativization `phi^M` for transitive proper classes `M` and verify closure conditions under which `(M, in)` models `NBG` / `ZF` axioms.
2. **Forcing Notions and Dense Subsets**: Formalize forcing posets `(P, leq, 1_P)`, compatibility of conditions, antichains, the countable chain condition (ccc), filters, and `M`-generic filters `G` over countable transitive ground stages.
3. **Dunaev-Tagged P-Names and Generic Evaluation**: Represent `P`-names `tau` as sets of Dunaev Tagged Ordered Pairs `(sigma, p)` (strictly avoiding Kuratowski pairs on proper classes) and implement recursive generic evaluation `val_G(tau)` and canonical ground-set check names `check(x)`.
4. **Dual Verification**: Implement both in portable SML'97 (`examples/mktd_foundations.ML`, zero raw non-ASCII bytes, verified under Poly/ML) and Python (`foundations/type_semantics.py`), with unit tests in `tests/test_foundations.py`.
