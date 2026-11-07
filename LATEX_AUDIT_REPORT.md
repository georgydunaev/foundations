# Manuscript and LaTeX Source Audit

Reviewed on 2026-11-07. This report supersedes the earlier label scan.

## Scope and result

The editorial pass reviewed the numbered manuscript files section by section,
including standalone alternatives and application outlines. It preserves local
foundational settings and adds context where evaluation, pairing, types,
quantifiers, or proof assumptions change. Obelisk's newer generated material
was used as comparative evidence, not as an automatic replacement for the
book.

The current verification checkpoint covers the extended mathematical pass:

- `PYTHONDONTWRITEBYTECODE=1 python3 run_tests.py` ran 90 tests: 89 passed
  and one was skipped because Poly/ML is unavailable for the SML syntax
  check. These are repository regression checks, not a formal verification
  of the mathematics.
- `git diff --check` reported no whitespace errors.
- A supplemental source scan found balanced active braces and environments
  in the 41 numbered body files. The scan strips comments, listings, and
  disabled draft branches and accounts for the book's proof macros. It is
  a limited source check, not a TeX interpreter.
- The assembled manuscript's 34 files had 236 distinct recognized labels
  and 54 distinct referenced keys, with no duplicate labels or unresolved
  keys among the recognized commands. This covers ordinary references and
  the custom label commands; Biber separately resolved five active citation
  keys.
- The complete 286-page book compiled successfully with Tectonic 0.17.0
  and Biber 2.17 using a temporary toolchain outside the repository. The
  latest log has no overfull boxes, undefined references or citations,
  duplicate labels, missing characters, or dropped listing text. Extracted
  PDF text contains no Unicode replacement characters.
- The inspected Obelisk checkout remained unchanged. Thirteen local tickets
  record source-level corrections, clarifications, and proposed development.

These checks do not certify every mathematical claim. The mathematical
review is documented separately below; any later source edits require
relevant checks to be rerun.

## Correct interpretation of custom macros

The earlier report treated repeated category arguments to `\labeltagd` and
`\clabeltagd` as possible duplicate labels. The actual definitions in
`000_preamble.tex` produce `\label{#1:#2}`. Repeating `thm` or `axm` as the
first argument is intentional; the complete combined key determines whether
there is a collision.

Similarly, `\labeltag{key}` and `\clabeltag{key}` define `key` directly.
For example, the `MetaGen` references resolve through `\clabeltag{MetaGen}`.
A scan limited to literal `\label` commands would falsely report them missing.

The active `\Proof`, `\ProofPar`, and `\ProofNoPar` macros open a `proof`
environment; `\Done` and `\DoneNoPar` close it. The earlier disabled variants
merely printed text. Environment checks must use the active definitions.

The real TeX build also revealed automatic theorem-heading labels such as
`Definition:` and `Axiom:1` that collided across unnumbered environments and
distinct counters. These unused automatic labels were removed; explicit
reference keys are retained.

Actual repairs include a missing theorem boundary in the ordered-pair
chapter, duplicated complete keys in the logic/type/historical-iota material,
missing or misdirected references in the ordinal discussions, and malformed
comprehension or generator delimiters. Proof sketches are now distinguished
from completed arguments.

## Differences preserved and conflicts identified

The following differences are meaningful local choices:

- Unconditional union evaluation has an empty default; guarded union
  evaluation has a `V` default; PFOL evaluation may be undefined.
- Recursive Dunaev, marker-tagged, and Kuratowski pairs have different
  encodings and empty-pair values. Their projection results cannot be
  transferred merely by reusing `(a,b)`.
- Predicate models of types and classes collecting set-valued instances have
  different size scopes. Expression translation and semantic valuation are
  separate operations.
- An outer proof context and the context inside a quoted sequent play
  different roles in reflection rules.

Other discrepancies occur within the displayed assumptions of an export and
need upstream correction or source inspection. The tickets preserve exact
IDs, counterexamples where applicable, and acceptance criteria. The class-list
ticket is a proposed theorem development, not a contradiction report:

| Issue | Ticket |
| --- | --- |
| Guarded evaluation versus unguarded family theorem | [Family evaluation](tickets/obelisk_family_evaluation_domain.md) |
| Missing pointwise dependent-product membership condition | [Pi membership](tickets/obelisk_classes_pi_membership.md) |
| Pair-constructor notation and proof provenance | [Pair conventions](tickets/obelisk_classes_pair_conventions.md) |
| Predicate bodies exported without their defining heads | [Semi-singleton export](tickets/obelisk_applications_semisingleton_export.md) |
| Singleton introduction for arbitrary proper classes | [Singleton sethood](tickets/obelisk_applications_singleton_sethood.md) |
| Size of functor and transformation collections | [Category size](tickets/obelisk_applications_category_size.md) |
| Ambient theory, evaluation, and reflection scope | [Reflection scope](tickets/obelisk_logic_reflection_scope.md) |
| Semantic completeness versus negation-completeness | [Completeness](tickets/obelisk_logic_completeness.md) |
| Exported incompleteness verification status | [Verification evidence](tickets/obelisk_logic_verification_status.md) |
| Circular ordinal-comparison proof dependencies | [Ordinal dependencies](tickets/obelisk_ordinals_comparison_dependency.md) |
| Family-record domains and image conventions | [Family records](tickets/obelisk_family_records_and_image_conventions.md) |
| Fresh binders in uniqueness expansions | [Binder hygiene](tickets/obelisk_uniqueness_binder_hygiene.md) |
| Finite class-list representation and transport development | [Class-list transport](tickets/obelisk_class_lists_transport.md) |

The inspected site snapshot is commit
`bb346f112ae91d1649940068c7f210a53b8674bf` in
`../obeliskproofassistant.github.io`. Its producing ML source is unavailable
in this workspace. A counterexample to an exported statement does not by
itself prove that the kernel accepted that statement; the tickets ask for
source-level investigation and regeneration. No generated files were edited.

## Mathematical development and independent review

Successive waves of specialist agents contributed section reviews, mathematical
development, and independent integration checks, including dedicated
functional-analysis work. Files were assigned separately to avoid competing
edits, and completed proof clusters were reassigned for fresh review.
Completed arguments added or reconstructed in this revision include recursive
pairing and projections, approximation-based transfinite recursion, the Levy
boundedness argument and its union consequence, descriptor canonicalization,
ordinal and order results, topology recovery, the Yoneda correspondence, and
uniform-integrability and Vitali lemmas. Each uses its section's stated
assumptions. The subsequent extended pass completed both directions of the sequential
finite-measure Dunford–Pettis criterion, including the needed L1 duality
and Hilbert-space arguments. Topological weak compactness is still
distinguished from this sequential formulation.

Further completed developments include finite and hereditarily finite
countermodels for the minimal axioms, Hartogs and Mostowski theorems,
Boolean, option and list elimination, finite lists with proper-class entries,
set-level W/M constructions and their universal properties, simple-type
normalization and confluence, the diagonal construction and Löb's theorem with explicit hypotheses,
Knaster–Tarski fixed points, and ordinal-ranked choice descriptors on
class parameters. The analytic development now includes construction of
the integral, monotone/dominated convergence, compact operators, and
Schur's theorem, and the contraction principle with error bounds.
The class-list model has a proved length- and entry-preserving translation
to Obelisk 3.51's marker encoding, explicitly distinguished from 3.76.
None of these results identifies different descriptor
semantics merely because they share notation.

The choice audit separates countable choice in the metric compactness
criterion from the stronger setting of Hahn–Banach, Baire, and open mapping.
The weakly null net with unbounded tails was reconstructed without a
simultaneous choice of vectors. Later reviews also caught and repaired
capture in an arbitrary-term existential proof and overbroad substitution
claims for undefined terms. Further corrections restrict the older beta rule
to set-valued arguments, prevent eta capture, and replace a descriptor proof that had
confused uniqueness among classes with uniqueness among sets. The proof
scan found no remaining literal ellipses or empty active proof blocks;
this syntactic observation does not establish the correctness of every proof.

An early independent review of six proof clusters led to two explicit additions:
heredity/separation in the recursion assumptions, and ordinary set-pair coding
in the union proof to avoid relying on a recursive pairing construction that
itself uses union. The Levy argument was checked against the author's local
handwritten notes. None of this is a claim of kernel-checked verification.

## Build and completeness limits

The full main manuscript builds with its local `references.bib`; all five
active citation keys resolve. The bibliography records the provenance of the
restored entries and the replacement of one unidentified citation. The
standalone wrapper also checks for the companion bibliography as a fallback.
The missing `../THESIS/TEX/AcademicWriting.tex` and external proof-assistant
listing have explicit fallbacks; these do not supply the absent material.
Chapters 260–290 are now part of the assembled book.

The PDF is generated from the edited sources. Line numbers are off for the
reading copy; defining `\ShowLineNumbers` before loading the preamble restores
an editing copy. Sample rendered pages were visually inspected, and oversized
displays and proof trees received a layout pass. Remaining underfull-box and package/bookmark warnings
are recorded by the build. The temporary toolchain also reports a missing
default Fontconfig configuration and an encoding warning inside `lineno.sty`;
these do not prevent compilation, and the inspected PDF has neither missing
glyphs nor replacement characters. A successful compilation is not a
guarantee of perfect typography on every page.

Some sections remain research sketches or incomplete model constructions.
In particular, the uniform predicate-level translation involving `Emb` and
`kappa`, the proposed serial-reflection hierarchy, and extension of the
simple operational calculus to additional constructors remain separate
obligations. The intended Alexandrov and Strang statements have not been
identified; their headings do not assert an arbitrarily chosen theorem.
The external companion manuscript remains unavailable. These limits are
stated locally, and the revised mathematics has not been kernel-verified.
Further development is therefore needed for a complete publication edition.
