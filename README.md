<!-- Documentation update: opencode-go/kimi-k3.1-pro (Capability Tier 2). -->
# Foundations of Mathematics

## Reading the Book

Read each section in its own stated mathematical context. The manuscript
contains multiple foundational approaches, and some chapters explore more
than one. Local definitions determine the meaning of evaluation, definedness,
quantification, and types. “Active” below describes the implementation thread,
while “historical” records development status; neither judges the value of
an independent idea. The front guide explains the reading routes and changes
of context.

## Approach Policy

The active proof-compiler line combines **classical two-valued MK/NBG class
theory, Dunaev Tagged Ordered Pairs, total comprehension evaluation, and
predicates/formulas-as-types with classes-as-expressions**. The uncertain
descriptor calculus, Farmer's PFOL, and conglomerate-valued semantics remain
independent preserved alternatives; they are not kernel configuration options.
Total evaluation itself has two local defaults: the older prototype uses
the empty class, while the class-axiom section and newer Obelisk export use
`V` outside the represented domain. The guide preserves both settings; the
exported unguarded family theorem needs reconciliation with the latter.
See [APPROACHES_INVENTORY.md](APPROACHES_INVENTORY.md) and the reader-facing
[summary_of_approaches.tex](summary_of_approaches.tex).

## Chapter and File Map

### Core Foundations
- **000_preamble.tex**: LaTeX preamble for the Foundations of Mathematics document. *(Active Draft)*
- **001_foundations.tex**: Main book and active classical MK/NBG approach, including the front guide to all five approaches. *(Active Draft)*
- **010_logic.tex**: Logical framework including conglomerate terms of all classes. *(Active Draft)*
- **010_ordered_pairs.tex**: Navigation summary distinguishing the book's recursive pairing from the newer marker-tagged implementation. *(Active Draft)*
- **020_descriptors.tex**: Three-valued/uncertain descriptor calculus with `tau`, `epsilon`, and partial `varepsilon`. *(Preserved Alternative 3)*
- **025_unified_descriptors.tex**: Rejected attempt to combine descriptor systems without specifying their semantics. **[OUTDATED] Non-Normative**
- **030_alternative_semantics.tex**: Conglomerate-valued/subset assignment semantics. **[OUTDATED] Preserved Alternative 5**
- **035_unified_type_semantics.tex**: Rejected generic type/descriptor relation. **[OUTDATED] Non-Normative**
- **040_old_variant_of_iota_defs.tex**: Historical set descriptors and class-valued-family encodings, with scoped canonicalization results. **[OUTDATED] Historical**
- **040_partial_functions.tex**: Secondary summary of the PFOL partial-function notation. *(Preserved Alternative 4 Draft)*
- **050_descriptor_systems.tex**: Secondary descriptor and class-abstraction notes. *(Preserved Alternative Draft)*
- **050_prooftrees.tex**: Proof-tree formalism for class-theoretic deductions. *(Active Draft)*
- **050_unified_interface.tex**: Navigation between approaches; explicitly not a semantic switch. *(Active Navigation)*
- **060_axioms.tex**: Core axioms of the Morse–Kelley framework. *(Active Draft)*
- **070_ordered_pair.tex**: Kuratowski, recursive Dunaev, and marker-tagged pair constructions with separate scopes. *(Active Draft)*
- **080_azriel_levi_union_thm.tex**: Azriel Lévy union argument with the boundedness proof reconstructed from the author's handwritten notes, under explicit prerequisites. *(Active Draft)*
- **090_proving_limitation_of_size.tex**: Development of limitation-of-size results. *(Active Draft)*
- **100_class_theory.tex**: Finite and hereditarily finite countermodels separating minimal class axioms from stronger existence principles. *(Active Draft)*
- **110_family_evaluation.tex**: Theory of families and evaluation maps. *(Active Draft)*
- **120_induction_recursion.tex**: Induction and recursion principles for classes. *(Active Draft)*
- **130_classes_as_types.tex**: Active predicates/formulas-as-types discipline, a scoped predicate/storage interface and option models, with older classes-as-types attempts explicitly marked outdated. *(Active Draft with Historical Sections)*
- **140_setness.tex**: Exploration of setness versus classness. *(Active Draft)*
- **150_ordinals.tex**: Development of ordinal numbers within the class framework. *(Active Draft)*
- **160_some_order_theory.tex**: Bounds, extrema, complete lattices, and the Knaster–Tarski fixed-point theorem. *(Active Draft)*
- **170_paradoxes.tex**: Analysis of classical paradoxes. *(Active Draft)*
- **180_many-valued.tex**: Many-valued and uncertain-value experiments accompanying Alternative 3. *(Preserved Alternative 3)*
- **190_union_intersection.tex**: Formal treatment of union and intersection operations on classes. *(Active Draft)*
- **199_languages.tex**: Simple-type checking, denotational semantics, strong normalization, confluence, and decidable conversion, including a proved Boolean conditional extension. *(Active Draft)*
- **200_relations.tex**: Theory of relations between classes. *(Active Draft)*
- **200_uniqueness.tex**: Uniqueness principles and their applications. *(Active Draft)*
- **210_partial_functions_semantics.tex**: Farmer's PFOL, iota-definedness, and Kleene equality. *(Preserved Alternative 4)*
- **220_simpler_img_thms.tex**: Simpler image theorems for functions between classes. *(Active Draft)*
- **230_analysis.tex**: Foundations of real analysis within the class framework. *(Active Draft)*
- **250_topology.tex**: Basic topology, Alexandrov's topology–preorder correspondence, proper ultrafilters, and the ultrafilter criterion and Tychonoff theorem under Choice. *(Active Draft)*
- **260_linear_algebra.tex**: Linear algebraic structures expressed via classes. *(Active Draft)*
- **270_measure_theory.tex**: Measure construction tools, integral convergence, and completeness of function spaces. *(Active Draft)*
- **280_functional_analysis.tex**: Duality, Banach-space principles, Vitali convergence, and finite-measure Dunford–Pettis in both sequential and topological weak-compactness forms. *(Active Draft)*
- **290_probability_theory.tex**: Probability theory within the class framework. *(Active Draft)*
- **300_category_theory.tex**: Categorical foundations compatible with Morse–Kelley theory. *(Active Draft)*
- **310_differential_geometry.tex**: Local Euclidean structure, connected components, and path connectedness. *(Active Draft)*
- **320_src.tex**: Source code excerpts and utilities supporting the LaTeX documents. *(Active Draft)*
- **320_strang_thm.tex**: Unspecified Strang-theorem placeholder, retained as source but excluded from the assembled book.
- **330_restricted_quantifiers.tex**: Treatment of restricted quantifiers in the class language. *(Active Draft)*
- **summary_of_approaches.tex**: Front-of-book guide separating the active mainline from the three preserved alternatives. *(Active Guide)*

### Formalizations
- **presentation.ML**: Class-theoretic foundations based on Morse–Kelley class theory and Tarski's axiom. *(Active Draft)*
- **Coq/positive_foundations.v**: Coq formalisation of positive foundations, including inductive definitions of ensembles and ordered pairs. *(Active Draft)*
- **code/IFOLD.thy**: Isabelle/HOL theory implementing the IFOLD construction. *(Active Draft)*

### Additional Resources
- **APPROACHES_INVENTORY.md**: Inventory, implementation status, and preservation boundary for the exact five approaches.
- **COMPETING_APPROACHES.md**: Concise comparison and links to the approach inventory.
- **LATEX_AUDIT_REPORT.md**: Report on LaTeX documentation status.
- **MACROS_INDEX.md**: Index of custom LaTeX macros.
- **PRESENTATION_ML_GUIDE.md**: Guide for `presentation.ML`.
- **MECHANIZED_EXPERIMENTS.md**: Notes on mechanized experiments.

## Status Summary

- **Active mainline:** approaches (1) and (2), with no uncertain truth value or PFOL definedness imported implicitly.
- **Preserved alternatives:** approaches (3), (4), and (5), retained with their own local assumptions. Several are included in the assembled book.
- **Rejected unification drafts:** `025_unified_descriptors.tex` and `035_unified_type_semantics.tex`, retained only as `[OUTDATED]` non-normative documents.
- **Historical material:** files explicitly marked `[OUTDATED]` remain preserved rather than being silently modernised or deleted.

## Verification and Upstream Follow-Up

[The audit report](LATEX_AUDIT_REPORT.md) records the source checks and their
limits. [Mechanized experiments](MECHANIZED_EXPERIMENTS.md) distinguishes
current exported evidence from earlier reports of proof counts. The local
Obelisk website was inspected read only; concrete upstream corrections and
setting-dependent differences are recorded in `tickets/obelisk_*.md`.
Generated files must be corrected through their producing source, then
regenerated.

The manuscript still includes explicit research sketches and application
outlines. The active citations now have a local `references.bib`; its comments
record the restored sources and the replacement of an unidentified citation.
The companion Dunford–Pettis source is absent, but chapters 260–290 are now
included in the assembled book and develop the analytic prerequisites.
For real L1 on a finite positive measure space, the Dunford–Pettis
equivalence is now proved in full: uniform integrability is equivalent
to compactness of the weak closure and to the weak subsequence criterion.
The proof supplies its topological prerequisites explicitly, including
weak compactness of Hilbert balls and weakly convergent subsequences
from weakly compact subsets of normed spaces.

## Mathematical Development in This Revision

The extended mathematical pass adds proofs of membership and set-like
well-founded recursion, Mostowski collapse, Hartogs' theorem, well-ordering
from choice, and class Schroeder–Bernstein. It distinguishes the stronger
class limitation-of-size principle from an ordinal-valued cardinal default.
Explicit finite and hereditarily finite models identify what the minimal
comprehension and closure assumptions do not imply.

The descriptor chapters now contain scoped finite models, normalization,
conservativity, and selector-transport results. Ordinal-ranked class-parameter
selection supplies the proposed witness equivalence under explicit stronger
assumptions. The type chapter separates schematic predicates from class
objects: collecting set instances preserves exactly the set-valued part
of a predicate, and option storage is proved with explicit sethood guards.
A countable-syntax diagonal argument records the limits of finite closed
denotations; no uniform internal truth predicate is asserted. The chapter
also proves finite-stage W-recursion, constructs set-level
M-types by finite addresses, and obtains W-types for arbitrary set arities
from their well-founded trees. The assembled logic chapter proves transport
of quantification along syntax coding, a conservative total witness extension
for nonempty set domains (including its substitution and coincidence cases),
a diagonal construction under an explicit coding hypothesis, and Löb's theorem
under explicit derivability hypotheses. It also proves deduction for the
specified context-sensitive rules and the obstruction to unrestricted internal
truth. A normalization result for opaque constants separates termination from
Boolean canonicity, preserving the verification-only compiler setting.
Separate classical-fragment and
candidate-selection lemmas remain in a disabled historical source block;
they are not part of the assembled chapter. The language chapter proves simple-type checking,
preservation, strong normalization, confluence, and decidable conversion.
Its separate Boolean extension adds a two-point model and typed
conditionals, with the new substitution, progress, reducibility, and
confluence cases proved explicitly.
The categorical development connects recursion and coinduction to universal
properties. Independent reviewers checked these clusters and corrected
capture conditions and provability-soundness assumptions.

The analytic chapters prove completeness of the main function spaces,
monotone and dominated convergence, Hahn–Banach, Baire and uniform
boundedness, real Hilbert representation,
finite-measure L1 duality, Vitali convergence, and both directions of the
sequential Dunford–Pettis criterion. Proper ultrafilters and Tychonoff
under Choice then support a direct proof of the full weak-compactness
criterion by uniformly controlled truncations. Compact-operator approximation and
Schur's theorem provide further contrasts between weak and norm convergence.
Probability applications distinguish
weak, setwise, in-measure, L1, and total-variation convergence; the weakly
closed set of probability densities gives compactness applications. Each result
states its local setting rather than importing every assumption used elsewhere.

## Building a Reading Copy

For Texmaker with TeX Live 2024, open `001_foundations.tex` as the master
document and use **PdfLaTeX + Bib(la)tex + PdfLaTeX (x2) + View Pdf**.
The Bib(la)tex command must be **Biber**. With the matching TeX Live
executables on `PATH`, the compiler sequence is:

```sh
pdflatex -synctex=1 -interaction=nonstopmode 001_foundations.tex
biber 001_foundations
pdflatex -synctex=1 -interaction=nonstopmode 001_foundations.tex
pdflatex -synctex=1 -interaction=nonstopmode 001_foundations.tex
```

See [TEXMAKER_BUILD.md](TEXMAKER_BUILD.md) for the supplied settings,
command corrections, package requirements, and the optional LaTeX/DVI
workflow. Use Biber from the same TeX Live installation as BibLaTeX;
mixing versions can make bibliography control files incompatible.

The book also supports Tectonic 0.17.0 and Biber 2.17 (matching Tectonic's
bundled biblatex 3.17). With that pair on `PATH`, run:

```sh
tectonic --keep-logs 001_foundations.tex
```

This creates `001_foundations.pdf`, which is ignored by Git. The bibliography
is included locally. Define `\ShowLineNumbers` before the preamble to enable
margin line numbers for an editing copy. The repository checks run with
`PYTHONDONTWRITEBYTECODE=1 python3 run_tests.py`.

## Next Steps

- Keep the active semantics and alternative systems explicitly separated.
- Require precise source/target semantics and proved metatheory for any future translation.
- Retain unspecified application outlines outside the assembled book until
  their claims are fixed; the former Alexandrov placeholder now has a proved statement.
- Extend the scoped type/storage interface only with explicit soundness proofs
  for additional constructors, and check any claimed connection with implemented encodings.
