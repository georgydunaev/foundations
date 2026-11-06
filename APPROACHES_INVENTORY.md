<!-- Approach organization: opencode-go/kimi-k3.1-pro (Capability Tier 2). -->
# Approaches Inventory

This is the authoritative inventory for the five approaches to descriptors,
partial functions, and types in `foundations`. The approaches are not five
interchangeable backends of one semantics.

## Normative Decision

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
- Family evaluation is total by comprehension:
  `F(x) := union {s | (x,s) in F}`.
- The outer ordered pair of arbitrary classes is the Dunaev tagged pair
  `(a,b) = ({0} × a) ∪ ({1} × b)`, not a Kuratowski pair of proper classes.

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
  rejected because it destroys uniqueness of the term–type relation.

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
`040_partial_functions.tex` and `050_descriptor_systems.tex` files are only
secondary drafts; the source above is authoritative for this alternative.

## 5. Conglomerate-Valued / Subset Semantics

**Status:** preserved `[OUTDATED]` alternative; not active kernel semantics.

**Source:** `030_alternative_semantics.tex`.

Assignments are conglomerate-valued, schematically
`A : Var → P(K)`. This semantics is retained verbatim as a historical
alternative. Its assignment and definedness conventions must not be mixed
into the active classical semantics.

## Book Organization

1. `summary_of_approaches.tex` is the reader-facing guide and is included at
   the front of `001_foundations.tex`.
2. The main chapters develop approaches (1) and (2).
3. Approaches (3), (4), and (5) remain in their original standalone files and
   are presented as alternatives or historical material, not as kernel
   configuration options.
4. `025_unified_descriptors.tex` and `035_unified_type_semantics.tex` are
   retained only as explicitly `[OUTDATED]` rejected unification drafts.
   `050_unified_interface.tex` is a navigation document, not a semantics or a
   switch between foundations.

## Preservation Boundary

No theorem, translation, or compatibility claim follows merely from putting
these approaches in one repository. Any future bridge must state its source
and target semantics and prove the required metatheory. The original source
files for approaches (3), (4), and (5) remain intact.
