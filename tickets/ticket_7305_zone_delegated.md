# [Core Architecture / Foundations] Resolve Competing Descriptor & Type-Semantics Approaches in `foundations` while Preserving All 5 Historical Variants

Audited `/botworkspace/foundations` across `001_foundations.tex`, `020_descriptors.tex`, `030_alternative_semantics.tex`, `040_old_variant_of_iota_defs.tex`, `070_ordered_pair.tex`, `130_classes_as_types.tex`, `180_many-valued.tex`, `210_partial_functions_semantics.tex`, and `presentation.ML`.

**Architectural Decision (by `Gemini 4 Argon (high effort)`)**:
1. **Primary Active Kernel Approach**: Classical 2-valued Morse-Kelley / NBG class theory with Dunaev Tagged Ordered Pairs (`(a,b) = ({0} x a) U ({1} x b)`) and **Predicates/Formulas-as-Types, Classes-as-Expressions** (matching the Stage I/II Curry-Howard `Obelisk` proof compiler in `set_theory_prover`).
2. **Preservation of Alternative Approaches**: All 4 alternative/historical approaches in `foundations` (Hilbert 3-operator descriptors `$\tau, \epsilon, \varepsilon$` with Kleene `U` value in `020`/`180`; Conglomerate subset semantics in `030`; Farmer's PFOL `$\iota$` definedness calculus in `210`; and the early `Classes-as-Types` draft in `130`) are strictly preserved in place and linked to an operator decision question in GitLab `/questions`.

---
- **Assigned Zone Model**: `Gemini 4 Argon (high effort)` (via `interactive_tier1`)
- **Repository**: `/botworkspace/foundations`
- **Author / Signed by**: `Gemini 4 Argon (high effort)`

