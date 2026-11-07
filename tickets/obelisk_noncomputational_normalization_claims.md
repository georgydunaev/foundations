# Obelisk: separate non-computational semantics from normalization and checking

Status: open; preserve the verification-only architecture and correct its
mathematical justification.

Read-only evidence checkout: `/home/gdunaev/obeliskproofassistant.github.io`,
commit `bb346f112ae91d1649940068c7f210a53b8674bf`.

## Concrete claims requiring correction or hypotheses

- `docs/QUOTATION_AND_ANTIQUOTATION_IN_OBELISK.md`, Section 6.1, says that
  under classical logic with choice proofs do not normalize to canonical
  values; Section 6.2 infers static resolution and polynomial-time checking
  from the absence of bytecode/dynamic evaluation. These are different
  properties. The latter complexity conclusion has no specified checker,
  input representation, conversion algorithm, or cost model in the document.
- `docs/COMPILER_SEMANTICS_NON_COMPUTATIONAL.md`, Section 2.2, presents
  non-computation of arbitrary choice values as a general obstruction to
  computational behavior. An opaque constant with no reduction rules can
  already be a normal form; lack of a computable witness does not imply
  divergence or failure of normalization.
- The same section and invariant 2 say that classical set theory requires
  Choice, citing ordinal arithmetic and the Burali–Forti resolution among
  the reasons. Choice is the author's permitted foundational commitment;
  those particular arguments do not require it. Ordinary ordinal recursion
  and the Burali–Forti argument can be developed with the relevant set
  existence, separation/replacement, and ordinal principles without Choice.
  Well-ordering arbitrary sets and Zorn's lemma are different claims.
- Section 2.2 describes a global-choice operation on every nonempty class.
  Such a class-parameter operation must be distinguished from an ordinary
  class-function graph whose arguments and outputs are sets. Its existence
  on proper-class parameters needs the specified stronger framework or
  construction, not merely application of a set-choice graph off its domain.

## Local mathematical resolution

Three questions must be kept separate:

1. Is a supplied finite derivation accepted by the specified checker?
2. Does a specified reduction relation terminate on its well-typed terms?
3. Do closed normal forms compute values or witnesses of the desired kind?

The book now proves a concrete separation in `010_logic.tex`. Adding opaque
typed constants with no rewrite rules to its strongly normalizing simple
Boolean calculus preserves strong normalization: replace the finitely many
constants in a term by fresh typed free variables. This preserves every
reduction step and would transport an infinite reduction to the original
calculus. Yet an opaque closed constant of type Bool is a closed normal form
different from true and false, so the original canonicity result fails.
This is a scoped syntactic result, not a claim that arbitrary axiom constants
are semantically sound or that the full dependent checker normalizes.

The author's requirement to check proof certificates without emitting
executable code needs no change. Neither that choice nor a classical axiom
alone determines the complexity of proof checking or definitional equality.
Likewise a finite class expression can denote a noncomputable operation
without providing an effective procedure for obtaining arbitrary outputs.

For class-parameter choice, `220_simpler_img_thms.tex` proves a precise
ranked construction under a fixed injection `V → On`, the appropriate
comprehension, and the least-ordinal principle. It uses a proper-class
default when the class is empty and does not form a class graph of arbitrary
proper-class inputs. The proposed operation in `010_logic.tex` now makes
this size distinction explicit as well.

## Required upstream changes and acceptance criteria

- Retain verification-only compilation and the chosen classical/Choice
  foundations as project decisions. Remove claims that other mathematical
  settings or ordinary ordinal arithmetic logically require those decisions.
- State normalization and canonicity separately for a named syntax and
  reduction system; do not infer either from whether bytecode is emitted.
- Either prove the advertised polynomial checking bound for a precisely
  specified representation and conversion procedure, or describe it as
  unestablished. Static checking can still perform substantial computation.
- Give the domain and size convention of each choice operator and identify
  any additional comprehension or class-ranking assumptions.
- Correct producing documentation/source records and regenerate any derived
  pages. Do not patch generated HTML/JSON.

This ticket does not duplicate `obelisk_logic_verification_status.md`, which
asks for replayable evidence behind particular exported theorem statuses;
the present issue is the general relationship between semantics, reduction,
and algorithmic checking.
