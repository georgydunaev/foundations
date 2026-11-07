# Manuscript and LaTeX Source Audit

Reviewed on 2026-11-07. This report supersedes the earlier label scan.

## Scope and result

The editorial pass reviewed the numbered manuscript files section by section,
including standalone alternatives and application outlines. It preserves local
foundational settings and adds context where evaluation, pairing, types,
quantifiers, or proof assumptions change. Obelisk's newer generated material
was used as comparative evidence, not as an automatic replacement for the
book.

The current verification checkpoint includes the standalone Schrödinger thesis
and its four chapters integrated into the book:

- The **52-page thesis** and **383-page book** compile with archived TeX Live
  2024 (pdfTeX 1.40.26 and Biber 2.20), using PdfLaTeX → Biber → PdfLaTeX
  twice. The corresponding LaTeX/DVI sequences also succeed. Texmaker's
  configured backend sequence was tested; its GUI was not launched.
- The final thesis logs contain no warnings, overfull boxes, underfull boxes,
  undefined references or citations. The book has no undefined references,
  citations, duplicate-label warnings, missing-character warnings or overfull
  boxes. The PDF book also has no underfull boxes after removing redundant
  paragraph-ending line breaks. The DVI book retains one underfull
  bibliography line; the rendered bibliography was inspected and is legible.
- PDF inspection found all fonts embedded, no invalid internal links, no text
  outside page boundaries and no Unicode replacement characters. The thesis
  has 117 links and 38 bookmarks; the book has 500 links and 284 bookmarks.
- `PYTHONDONTWRITEBYTECODE=1 python3 run_tests.py` ran **99 tests, all passing**,
  with temporary TeX Live and Poly/ML installations. These include both the
  present and absent companion-listing branches. Regression tests do not
  constitute a formal proof check of the mathematics.
- `git diff --check` passed. No unmerged Git entries or conflict markers were
  found. Decorative lines of equals signs in historical material are not
  merge conflicts.
- A limited active-source scan found balanced braces and environments in
  all 47 numbered body files and the standalone thesis wrapper. It strips
  comments, listings and disabled drafts and accounts for the proof macros;
  it is not a TeX interpreter.
- All **47 numbered body files** also passed a standalone PdfLaTeX smoke
  build. Two previously include-only files received the standard standalone
  wrapper. These isolated builds intentionally retain references to other
  chapters; reference resolution is checked in the assembled documents.
- The assembled book's 40 files have 341 recognized labels and 110 distinct
  referenced keys, with no duplicates or unresolved keys. Compilation and
  Biber separately check the active document's references and citations.
- The Obelisk checkout remains unchanged. **24 local tickets** record
  source-level corrections, clarifications and proposed development.

The thesis's core arguments and extensions received independent mathematical
review by other agents. Fourier–Plancherel and the self-adjoint spectral
calculus remain explicitly stated background inputs. The final spectral
argument proves a Euclidean specialization of the Beckus–Takase
localization method, with averaged smooth cutoffs and an explicit
Gaussian commutator constant. Independent review checked measurable
averaging, nonzero-vector selection, translation signs, spectral closures,
and the explicit bound at all subsystem distances. A qualitative
corollary combines the same localization lemma with uniform continuity
of localized operators on the compact parameter space; it requires only
continuous sampling and action. A further
corollary controls the bottom of the subsystem spectrum, using spectral
mapping on an interval bounded away from zero. The manuscript establishes
the bounded-potential and dynamical results with proofs; it does not claim
research novelty or reproduce the full unbounded Kato-class theory. The exact
Weidmann theorem number supplied in the programme remains unverified, while
the needed bounded Trotter formula is proved directly.

## Thesis result and scope

`thesis_schrodinger.tex` assembles chapters 293–296. They prove the Gaussian
construction and maximum principle, a precise version of Simon's abstract
kernel criterion, bounded self-adjoint perturbation, the Dyson kernel series,
joint continuity, Gaussian bounds, all-endpoint smoothing, and the strong
Trotter formula. The dynamical chapter proves covariance, pointwise Duhamel,
explicit Lipschitz estimates in exponentially weighted norms, a Hölder
extension, and stronger estimates for isometric actions.

The extended development also proves continuous first spatial derivatives,
smooth positive-time dependence, the precise heat-equation solution class,
potential order and scalar-shift identities, uniform initial traces on C0
and BUC (with BUC representatives characterized as the maximal such
L-infinity subspace), and quantitative estimates for
actions with exponential distortion. Continuous sampling and action alone
give weighted canonical-kernel continuity and localized operator-norm
continuity; stronger Lipschitz assumptions give explicit rates. A bounded
step potential illustrates why continuous second spatial derivatives cannot
be asserted in general. The literature comparison identifies the qualitative
continuity consequences of Broderix--Hundertmark--Leschke, rather than
presenting those consequences as new results.

The book additionally includes a complete executable de Bruijn substitution
example with scope and capture-avoidance proofs, separate from the preserved
historical prototype. Seven tests check it against an independent named-term
oracle, as well as normal forms, fuel bounds, invalid inputs and large
indices. Independent reviews also checked the full finite-measure
Dunford--Pettis argument, including the distinction between weak compactness
and sequential compactness. The optional absent companion manuscript no
longer produces an empty placeholder chapter.

Further independent passes corrected a missing carrier restriction in bound
comparisons and a missing fresh-variable condition in a uniqueness binder.
The type chapter now distinguishes set-level W/M constructions from their
membership in a chosen universe and proves sufficient closure conditions.
A separately reviewed diagonal argument derives indexed-union closure from
Obelisk's Tight condition for wellorderable set universes; a local development
ticket requests an upstream proof interface without changing generated files.
The following chapter extends the finite-address constructions to a possibly
proper class of set labels with set arities. Independently reviewed proofs
establish that individual trees are sets, and prove finality for class
coalgebras and initiality for class algebras in the stated NBG setting
without Choice. Proper-class arities remain explicitly outside that model.
A reconstruction proof for the preferred family encoding now distinguishes
its represented domain from the small domain used by another partial
evaluation proposal. The constant proper-class value makes the difference
explicit. The reading guide also records the actual forward dependencies
of ordinal recursion and the imported analytic background. A fresh logic
review made effective necessitation require provable certificate checking
and separated non-effective truth adjunction from inconsistency. The
ordinal chapter proves elementary-comprehension reductions for ordinal
sets and injections into set bounds, with explicit set-formation
assumptions and no added Choice.
The topology chapter gives a precise continuous-image preservation result
without silently defining the author's proposed inheritance hierarchy.
The completed local-Euclidean connectedness section is included in the book.
The shear-torus example now also distinguishes phase spectral discontinuity
from continuity of spectral unions over invariant subsystems. Its spectral
consequence follows from the proved localization corollary; the general
method is attributed to Beckus–Takase. The operator-norm counterexample
has its separate direct proof.
The thesis counterexample has a reproducible PDF/EPS illustration generated
from its explicit cosine potentials; it is explanatory, not numerical proof.

The sign in the proposed covariant formula is corrected: the convention
`V_z(g)=v(T(g,z))` requires `T(g,z)` in the formula. The negative action gives
the negative sign consistently. A short-time counterexample explains why
these conventions cannot be mixed. A separate shear-torus example shows that
weighted canonical-kernel regularity and strong semigroup continuity can
coexist with failure of operator-norm continuity.

See `THESIS_RESEARCH_PLAN.md` for verified source statements and the proposed
schedule, and `TEXMAKER_BUILD.md` for master-file and backend settings.

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
| Incompatible zero-base ordinal exponentiation claims | [Ordinal arithmetic zero cases](tickets/obelisk_ordinal_arithmetic_zero_cases.md) |
| Hartogs comparison and Cantor proof scope | [Hartogs and Cantor](tickets/obelisk_hartogs_formula_and_cantor_scope.md) |
| Proper-class fixed points versus powerclass members | [Fixed-point carrier](tickets/obelisk_class_fixed_point_carrier.md) |
| Cardinal defaults versus actual class bijections | [Size-axiom scope](tickets/obelisk_size_axiom_cardinal_default.md) |
| Missing sethood in the universe-axiom summary | [Universe sethood](tickets/obelisk_tarski_universe_sethood.md) |
| Set versus class well-ordering and choice | [Well-ordering guards](tickets/obelisk_well_ordering_set_guards.md) |
| Quotation and semantic interpretation signatures | [Quotation signatures](tickets/obelisk_quotation_semantic_signatures.md) |
| Noncomputational constants versus normalization | [Normalization claims](tickets/obelisk_noncomputational_normalization_claims.md) |
| Context freshness in quantifier rules | [Quantifier contexts](tickets/obelisk_logic_context_freshness.md) |
| Ambiguous quantifier scope in application exports | [Quantifier-scope rendering](tickets/obelisk_applications_quantifier_scope_rendering.md) |

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
assumptions. Subsequent passes completed the finite-measure Dunford–Pettis
equivalence between uniform integrability, compactness of the weak closure,
and the weak subsequence criterion. The proof supplies L1 duality,
Hilbert-ball weak compactness, proper ultrafilters and the compact product
theorem rather than assuming that weak topologies are metrizable.
Density constraints are weakly closed, and bounded expectations attain
their extrema on nonempty dominated families with bounded moment constraints.
The complex-valued finite-measure criterion follows by a proved realification
and weak-product-topology argument; no real representation theorem is simply
relabelled as complex.

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
The proved predicate/storage interface does not supply a uniform model for
every proposed dependent constructor. The serial-reflection hierarchy and
extensions beyond the explicitly proved operational calculus likewise retain
separate obligations. With the author's approval, the Alexandrov section
now develops the topology–preorder correspondence, and the unspecified
Strang placeholder is excluded from the assembled book.
The external companion manuscript remains unavailable. These limits are
stated locally, and the revised mathematics has not been kernel-verified.
Further development is therefore needed for a complete publication edition.

## Follow-up merge and foundations review

The follow-up pass checked the reported merge: its manuscript files preserved
the reviewed parent version, and no unmerged index entries or actual conflict
markers remained. Later user checkpoints were retained throughout the work.

Additional corrections distinguish predecessor membership in a proper class
from membership in a set-pair relation, and distinguish syntactic code
carriers from semantic classes. The closed-sentence Henkin property is no
longer presented as sufficient for uniform epsilon terms: a separate
model-expansion and conservativity proof uses nonempty set domains and
Choice. The local deduction theorem explicitly covers both displayed
abstraction rules and their freshness conditions. These new arguments are
active in the assembled manuscript. Separate classical-fragment and
candidate-selection lemmas remain inside a disabled historical source block;
their presence in the source is not an assertion that they appear in the PDF.

The schematic predicate interface now proves exactly what storage of set
instances preserves, and why proper-class information is lost. The Boolean
operational extension includes preservation, progress, normalization,
confluence, canonicity and conservativity for the original calculus.
Measurability prerequisites and quotient representative-choice assumptions
are stated explicitly. The compact-unit-ball converse now uses a finite net
and Riesz's lemma, avoiding a dependent-choice sequence construction.
Filter-base generation is proved with the author's recovered-carrier
convention and the empty-filter exception retained. Ordinal addition now
has its own recursion proof, and the identities involving omega explicitly
use Infinity. A transitive-set-hull argument supplies the bridge from
set regularity to minimal elements of nonempty classes under its stated
closure assumptions.
