# [Core Architecture / Foundations] Resolve Competing Descriptor & Type-Semantics Approaches in `foundations` while Preserving All 5 Historical Variants

Status: Resolved / Implemented
**State:** closed

Audited `/hostramdisk/foundations` across `001_foundations.tex`, `020_descriptors.tex`, `030_alternative_semantics.tex`, `040_old_variant_of_iota_defs.tex`, `070_ordered_pair.tex`, `130_classes_as_types.tex`, `180_many-valued.tex`, `210_partial_functions_semantics.tex`, and `presentation.ML`, and documented the 5 approaches and their relation to `MKTD1` and `MKTD2` in `APPROACHES_INVENTORY.md`.

**Architectural Decision**:
1. **Primary Active Kernel Approach**: Classical 2-valued Morse-Kelley / NBG class theory with Dunaev Tagged Ordered Pairs (`(a,b) = ({0} x a) U ({1} x b)`) and **Predicates/Formulas-as-Types, Classes-as-Expressions** under `MKTD1` (`MKTD1-framework`, `MKTD1-system` / `MKTD1-prover`, `MKTD1-theory`) and `MKTD2` (`MKTD2-framework`, `MKTD2-system` / `MKTD2-prover`, `MKTD2-theory`).
2. **Preservation of Alternative Approaches**: All alternative and historical approaches in `foundations` (three-operator descriptors $\tau, \epsilon, \varepsilon$ with uncertain value $U$ in `020`/`180`; Conglomerate subset semantics in `030`; historical iota definitions in `040`; Farmer's PFOL $\iota$ definedness calculus in `210`; and the early `Classes-as-Types` draft in `130`) are strictly preserved in place.
3. **Immutable Suffix Invariant**: The 10,460-byte historical payload of `presentation.ML` matches SHA256 `37d0bf024bcee570ae5abe4561e8d4c2948d919158f242a273a7879ce5d9eee1` (`tests/test_presentation_ml.py`).

---
- **Repository**: `/botworkspace/foundations`
- **Status**: Resolved / Implemented
- **Verification**: Verified via `tests/test_approach_organization.py` and `tests/test_presentation_ml.py` (all 221 tests passing).
