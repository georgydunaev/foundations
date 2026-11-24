<!-- Approach organization: opencode-go/kimi-k3.1-pro (Capability Tier 2). -->
# Approaches Inventory

This inventory organizes the five approaches to descriptors,
partial functions, and types in `foundations`. The approaches are not five
interchangeable backends of one semantics.

## Implementation Choice and Local Reading

The book should be read section by section: each construction is assessed
under its stated assumptions. “Active” identifies the implementation choice,
not a global standard for judging the independent mathematical explorations.
Historical labels record development status; they do not replace a local
explanation of an idea. Editorial clarification preserves those ideas while
making changes of context explicit.

The active proof-compiler line uses **approaches (1) and (2) together**:
classical two-valued Morse–Kelley/NBG class theory, Dunaev Tagged Ordered
Pairs, total class-comprehension evaluation, and formulas/predicates as types.
Approaches **(3), (4), and (5) are preserved independently** for study and
future development. None is silently imported into the active kernel, and no
translation between their semantics is claimed.

## 1. Classical Two-Valued MK + Total Comprehension Evaluation

**Status:** active mainline.

**Sources:** `presentation.ML`, `060_axioms.tex`, and `070_ordered_pair.tex`.

- Class comprehension is impredicative in MK; NBG fragments retain their usual
  predicative restriction that quantified variables inside comprehension formulas
  range over sets (`Set`), whereas in MK quantified variables default to `Class`
  (and bound quantifiers `\forall(x \in Y), \varphi(x)` / `\exists(x \in Y), \varphi(x)`
  are short forms for `\forall(x:Class), (x \in Y) \rightarrow \varphi(x)` and
  `\exists(x:Class), (x \in Y) \land \varphi(x)`).
- Total evaluation has two locally documented conventions. The prototype
  `presentation.ML` uses `F(x) := union {s | (x,s) in F}`, with empty default.
  `060_axioms.tex` and the newer Obelisk export `DefValueAtArg` use that
  union only on a represented fibre and use `V` otherwise. Preserve this
  difference explicitly; the generated `ThmFamilyEvaluation` needs a
  domain hypothesis under the guarded convention. See
  `tickets/obelisk_family_evaluation_domain.md`.
- The book explores the recursive Dunaev pair
  `(a,b) = ({0} × a) ∪ ({1} × b)`, not a Kuratowski pair of proper classes.
  The newer Obelisk `DefDunaevOrderedPair` uses a marker-tagged construction
  with a different empty-pair value. Keep their definitions and projection
  claims separate; see `tickets/obelisk_classes_pair_conventions.md`.

## 2. Predicates/Formulas-as-Types, Classes-as-Expressions

**Status:** active mainline, with explicitly retained historical drafts.

**Sources:** `001_foundations.tex` and `130_classes_as_types.tex`.

- The active type discipline is **Predicates/Formulas-as-Types, Classes-as-Expressions**:
  unlike standard settings where terms are interpreted as sets and classes are
  interpreted as types, here **terms are interpreted as classes** and
  **conglomerates (= predicates on the conglomerate of all classes, `Class -> Bool`)
  are interpreted as types**. In particular, the default type `Class` is the
  constant-true predicate on classes `\lambda(C:Class). \top`.
- Formulas and predicates play the role of types; proofs are terms.
- Class expressions are syntax. An SML value representing a class expression
  is not itself a class in the object theory.
- The earlier classes-as-types/sets-as-expressions attempt remains marked
  `[OUTDATED]`. In particular, interpreting every `(A : Type)` as `top` was
  found insufficient for the intended uniqueness of the term–type relation.
  That is a local objection to the displayed interpretation, not a judgment
  on all possible class-as-type systems.

## 3. Three-Valued / Uncertain Descriptor Calculus

**Status:** preserved alternative; not active kernel semantics.

**Sources:** `020_descriptors.tex` and `180_many-valued.tex`.

The source distinguishes three choice defaults rather than conflating them:

- `\tau = \tau^{\Un}`: an arbitrary class from the conglomerate of all
  classes may be the default;
- `\epsilon = \tau^{\{\emptyclass\}}`: the empty class is the specified
  default;
- partial `\varepsilon = \tau^{\emptyclass}`: no default is supplied, so the
  descriptor may be undefined.

The uncertain value `U` and the many-valued experiments stay in these files.
They are not truth values of the classical active kernel.

## 4. Farmer's Partial First-Order Logic (PFOL)

**Status:** preserved alternative; not active kernel semantics.

**Source:** `210_partial_functions_semantics.tex`.

PFOL uses definedness and Kleene equality. Its central iota condition is
`(iota x, φ)↓ iff (∃!x, φ)`, and function values use `≃` rather than being
identified with the active total union evaluation. The shorter
`archive/040_partial_functions.tex` and `archive/050_descriptor_systems.tex` files are only
secondary drafts; the source above is authoritative for this alternative.

## 5. Conglomerate-Valued / Subset Semantics

**Status:** preserved `[OUTDATED]` alternative; not active kernel semantics.

**Source:** `030_alternative_semantics.tex`.

Assignments are conglomerate-valued, schematically
`A : Var → P(K)`. This semantics is retained as an independent historical
alternative, with explanatory context. Its assignment and definedness
conventions must not be mixed into the active classical semantics.

## Book Organization

1. `summary_of_approaches.tex` is the reader-facing guide and is included at
   the front of `001_foundations.tex`.
2. The class-theoretic thread develops approaches (1) and (2), but individual
   chapters also contain explicitly scoped experiments.
3. Approaches (3), (4), and (5) remain in their original files. The assembled
   book includes the many-valued, PFOL, and subset-semantics discussions;
   `020_descriptors.tex` supplies the included descriptor comparison. These are independent
   mathematical approaches, not kernel configuration options.
4. `archive/025_unified_descriptors.tex` and `archive/035_unified_type_semantics.tex` are
   retained only as explicitly `[OUTDATED]` rejected unification drafts.
   `archive/050_unified_interface.tex` is a navigation document, not a semantics or a
   switch between foundations.

## Preservation Boundary

No theorem, translation, or compatibility claim follows merely from putting
these approaches in one repository. Any future bridge must state its source
and target semantics and prove the required metatheory. The mathematical
ideas of approaches (3), (4), and (5) are preserved in
their source files. Presentation edits may clarify their own assumptions and
proof obligations without replacing them with the active semantics.

## Unification under MKTD1 and MKTD2 and Historical Variant Cross-Reference

Across the Obelisk and Foundations architecture (Tickets `7191` and `7305`), the active mainline (Approaches 1 and 2) is organized into two co-existing, strictly typed variants:

1. **MKTD1 (`MKTD1-framework`, `MKTD1-system` / `MKTD1-prover`, `MKTD1-theory`)**:
   - Sequent-calculus and typed-AST formulation built on classical Morse–Kelley / NBG statements about classes (`Class_Expre`, `Fm_Expre`, `Stmt`, `Ctx`, `Theory`, `Prf`).
   - Enforces the Off-by-One level invariant: SML code manipulates syntactic expressions of classes (`Class_Expre`), never raw semantic classes, while all class comprehensions bind `Class` variables (`TClass`) and class-level pairing uses Dunaev Tagged Ordered Pairs (`TagPair` / `DunaevTaggedPair`).
2. **MKTD2 (`MKTD2-framework`, `MKTD2-system` / `MKTD2-prover`, `MKTD2-theory`)**:
   - Constructive Curry–Howard / Formulas-as-Types variant in which formulas are types (implications as function spaces, universal/existential quantifiers as dependent $\Pi$/$\Sigma$ types) and proofs are $\lambda$-terms over the same Morse–Kelley / NBG class-theoretic base.

### Summary Matrix of Historical and Active Files

| Approach / Variant | Primary Manuscript Files | Executable / Reference Modules | Role in `MKTD1` / `MKTD2` |
| --- | --- | --- | --- |
| Approach 1: Classical MK/NBG + Total Evaluation + Dunaev Pairs | `060_axioms.tex`, `070_ordered_pair.tex`, `100_class_theory.tex`, `archive/100_classes.tex`, `110_family_evaluation.tex` | `presentation.ML`, `examples/mktd_foundations.ML`, `foundations/type_semantics.py`, `foundations/classes.py` | Active object-theory base of `MKTD1-theory` and `MKTD2-theory` |
| Approach 2: Predicates/Formulas-as-Types, Classes-as-Expressions | `001_foundations.tex`, `010_logic.tex`, `130_classes_as_types.tex`, `131_class_polynomial_trees.tex` | `examples/mktd_foundations.ML`, `foundations/logic.py`, `foundations/type_semantics.py` | Active type and proof discipline of `MKTD1-framework` and `MKTD2-framework` |
| Historical Iota & Family Drafts | `040_old_variant_of_iota_defs.tex` | `foundations/descriptors.py`, `foundations/classes.py` | Preserved `[OUTDATED]` historical iota and class-family canonicalization notes |
| Approach 3: Three-Valued / Uncertain Descriptors ($\tau, \epsilon, \varepsilon$) | `020_descriptors.tex`, `180_many-valued.tex` | `foundations/descriptors.py` | Independent preserved alternative (not imported into classical kernel) |
| Approach 4: Farmer's PFOL ($\iota$-definedness & Kleene equality $\simeq$) | `210_partial_functions_semantics.tex`, `archive/040_partial_functions.tex`, `archive/050_descriptor_systems.tex` | `foundations/pfol.py` | Independent preserved alternative |
| Approach 5: Conglomerate-Valued / Subset Semantics | `030_alternative_semantics.tex` | `foundations/type_semantics.py` | Independent `[OUTDATED]` historical alternative |
| Rejected Unification Drafts | `archive/025_unified_descriptors.tex`, `archive/035_unified_type_semantics.tex`, `archive/050_unified_interface.tex` | Tested in `tests/test_approach_organization.py` | Non-normative historical notes and navigation guide |
