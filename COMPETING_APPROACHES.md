<!-- Approach comparison: opencode-go/kimi-k3.1-pro (Capability Tier 2). -->
# Five Distinct Approaches

The five approaches are preserved, but they are not interchangeable semantic
backends. See [APPROACHES_INVENTORY.md](APPROACHES_INVENTORY.md) for the
implementation status and preservation rules, and
[summary_of_approaches.tex](summary_of_approaches.tex) for the book guide.

| # | Approach | Sources | Status |
|---|---|---|---|
| 1 | Classical two-valued MK/NBG, total comprehension evaluation, and Dunaev Tagged Ordered Pairs | `presentation.ML`, `060_axioms.tex`, `070_ordered_pair.tex` | Active mainline |
| 2 | Predicates/formulas-as-types and classes-as-expressions; older classes-as-types attempt retained as outdated | `001_foundations.tex`, `130_classes_as_types.tex` | Active mainline with historical drafts |
| 3 | Three-valued/uncertain descriptor calculus with `tau`, `epsilon`, and partial `varepsilon` | `020_descriptors.tex`, `180_many-valued.tex` | Preserved alternative |
| 4 | Farmer's PFOL with iota-definedness and Kleene equality | `210_partial_functions_semantics.tex` | Preserved alternative |
| 5 | Conglomerate-valued/subset semantics | `030_alternative_semantics.tex` | Preserved outdated alternative |

Approaches (1) and (2) form the active proof-compiler line. Approaches (3),
(4), and (5) remain independent. There is no general descriptor tuple,
semantics-selection flag, or unproved translation layer connecting them.

Within the classical thread, two total evaluation conventions remain distinct:
unconditional union evaluation has the empty default, while guarded evaluation
uses `V` outside the represented domain. Likewise, the book's recursive pair,
the newer marker-tagged pair, and Kuratowski pairing are different encodings.
These distinctions are local mathematical data, not additional truth-value
systems. The front guide explains when an explicit domain condition or a
change of encoding is needed.

The newer Obelisk exports do not automatically supersede the book. For
example, the exported dependent-product statement omits a pointwise section
condition that the book supplies, whereas its marker-tagged pair can be
studied independently of the book's recursive proposal. The comparison
therefore preserves useful ideas from each source and records concrete
upstream corrections in `tickets/obelisk_*.md`.
