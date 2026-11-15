# [FOUNDATIONS] Ticket 7486 — foundations: Refactor PolyML Class Theory Axiom Signatures

Status: Resolved / Implemented
**State:** closed
**Repository:** `foundations`

## Resolution Summary
- Segregated Morse-Kelley class theory primitives (`class_term`, `fm`, `thm`, `TagPair`, `Compr`, `axiom_*`, `prove_*`) from derived user-level set and model-theoretic operations in `examples/mktd_foundations.ML` (`signature MKTD_FOUNDATIONS` and `structure MKTD_Foundations`), and documented the architecture in `PRESENTATION_ML_GUIDE.md`.
- Verified via `poly -q --use /hostramdisk/foundations/examples/mktd_foundations.ML </dev/null` and `tests/test_mktd_foundations.py` (221 tests, exit code 0).
