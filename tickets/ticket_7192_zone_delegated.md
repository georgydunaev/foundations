# [Foundations Cosmetic 5/8] Document SML Constructors & Complexity Annotations in foundations/presentation.ML

Status: Resolved / Implemented
**State:** closed

Added documentation header and companion markdown guide `foundations/PRESENTATION_ML_GUIDE.md` explaining the SML pseudo-code in `foundations/presentation.ML` (MK + Tarski's axiom, `Sets : Term`, global choice `c`, `Compr`, Dunaev `Lam x.t`, and syntactic complexity weights) as well as the executable SML architecture in `examples/mktd_foundations.ML`, while keeping the 10,460-byte original suffix of `presentation.ML` byte-for-byte intact.

---
- **Repository**: `/botworkspace/foundations`
- **Status**: Resolved / Implemented
- **Verification**: Verified via `tests/test_presentation_ml.py` and `tests/test_ticket_7436.py` (all 221 tests passing).
