# Obelisk: distinguish syntactic quotation from semantic valuation

Status: open; documentation and source-signature reconciliation.

Read-only evidence checkout: `/home/gdunaev/obeliskproofassistant.github.io`,
commit `bb346f112ae91d1649940068c7f210a53b8674bf`.

## Concrete discrepancies

1. `docs/QUOTATION_AND_ANTIQUOTATION_IN_OBELISK.md`, Sections 1, 3.1,
   and 8, alternates between quotation of an expression and reification
   of an arbitrary semantic class/set/formula into a finite AST. These
   operations have different domains. The generated
   `generated/symbols/quotation.html` gives `Expression → Class` and
   describes coding a syntactic expression, which supports the first
   reading, not arbitrary semantic reification.
2. That document describes antiquotation as semantic valuation under an
   assignment. `generated/symbols/antiquotation.html` instead gives
   `Class → Expression` inside quotation and describes splicing decoded
   syntax. Syntax splicing and semantic valuation can both be supported,
   but their signatures and level transitions must not be conflated.
3. `generated/symbols/mu-interpretation.html` gives
   `(Variable → Class) → Expression → Class` and uses the index in `μ_A`
   for an assignment. `generated/symbols/eval.html` consequently describes
   `eval_A(c) = μ_A(Dec(c))` as semantic evaluation. The book's
   `130_classes_as_types.tex` uses `μ_A : A.Expression → Class.Expression`,
   indexed by a type, as an expression translation. This is a genuine
   signature difference, not an identity between syntax and its denotation.
   The conflict also occurs within the site itself: the comment on
   `DefMetaGeneralisation` (4.02) in both JSON exports explicitly gives
   `μ_Variable : Variable.Expression → Class.Expression` as a typed
   term interpretation, unlike the valuation signature on the symbol page.
4. Section 5.1 of the quotation document asserts that fixed finite
   stratification preserves all mathematical expressiveness. Finite depth
   of each individual syntax tree does not imply one common depth bound
   for a grammar closed under quotation. No typed translation or inverse
   interpretation establishing the claimed fixed-depth coverage is given.
5. Section 2.1 attributes a Russell contradiction to representing classes
   by an inductive datatype, citing formation of the Russell class itself.
   In guarded class comprehension, that class is a legitimate proper class;
   its existence is not a contradiction. A claim about a proposed datatype
   must instead identify an illicit membership, sethood, surjectivity, or
   elimination principle. Finite syntax datatypes are entirely compatible
   with a class-theoretic interpretation.

## Mathematical resolution

Keep separate maps for syntax coding, decoding valid codes, translation
between expression languages, and valuation in a model. With the book's
type-indexed convention the semantic composite is

`Eval_(A,rho)(c) = Val_rho(mu_A(Dec_A(c)))`.

With the symbol page's assignment-indexed convention the final two maps
are already combined. Neither convention is intrinsically wrong; mixing
their signatures is the error. A syntax round trip does not assert that
every semantic value has a finite name. Countable finite syntax cannot
denote every function `N → {0,1}` in the fixed full interpretation: diagonal
against the coded denotations, using a fixed default for unsuitable codes.
Nor is valuation injective: distinct arithmetic expressions `0+0` and `0`
have the same value.

The book now gives code-carrier and semantic-surjectivity transport results
in `010_logic.tex`, a scoped signature comparison, and the finite-syntax
diagonal proof in `130_classes_as_types.tex`. It does not claim that the
implementation's intended finite representation is impossible. A fixed
implementation datatype may encode arbitrarily deep trees; such an encoding
is different from identifying their logical levels.

## Required upstream changes

- Give every quotation, splicing, decoding, and valuation constructor its
  input/output syntactic category, level, code-validity requirements, and
  assignment parameters. Reserve different names or indices for the two
  meanings currently denoted by `μ_A`.
- Specify whether quotation consumes existing syntax, a supplied code, or
  a semantic value together with a chosen representation. Do not claim
  universal semantic reification merely from an AST constructor.
- Replace the fixed-depth expressiveness assertion with either a bounded
  fragment statement or an explicit typed encoding and preservation theorem.
- Correct the Russell-class explanation while retaining the author's
  shift-to-expression architecture.
- Inspect the actual constructors in the cited `program/types/typetheory.ML`,
  `program/newchecker.ML`, and symbol-page generator before changing their
  documented signatures. Those core sources are absent from this inspected
  website checkout; this ticket does not claim to have audited them.
- Regenerate symbol pages from their producing sources. Do not edit
  generated HTML or JSON directly.

## Acceptance criteria

- Every round-trip identity is well typed and states its valid-code domain.
- Distinct syntax with equal denotation is not forced to have equal raw codes.
- Quotation of an already represented expression needs no universal naming
  theorem for semantic classes.
- Nested examples state their logical levels or exhibit a proved encoding.
- The companion docs and symbol pages agree on the meaning of each `μ`,
  `eval`, quotation, and antiquotation operation.

The separate ticket `obelisk_logic_reflection_scope.md` covers ambient
theories and reflection domains; this ticket concerns the underlying maps
and their signatures.
