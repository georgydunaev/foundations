<!-- Documentation update: opencode-go/kimi-k3.1-pro (Capability Tier 2). -->
# Foundations of Mathematics

## Approach Policy

The active proof-compiler line combines **classical two-valued MK/NBG class
theory, Dunaev Tagged Ordered Pairs, total comprehension evaluation, and
predicates/formulas-as-types with classes-as-expressions**. The uncertain
descriptor calculus, Farmer's PFOL, and conglomerate-valued semantics remain
independent preserved alternatives; they are not kernel configuration options.
See [APPROACHES_INVENTORY.md](APPROACHES_INVENTORY.md) and the reader-facing
[summary_of_approaches.tex](summary_of_approaches.tex).

## Chapter and File Map

### Core Foundations
- **000_preamble.tex**: LaTeX preamble for the Foundations of Mathematics document. *(Active Draft)*
- **001_foundations.tex**: Main book and active classical MK/NBG approach, including the front guide to all five approaches. *(Active Draft)*
- **010_logic.tex**: Logical framework including conglomerate terms of all classes. *(Active Draft)*
- **010_ordered_pairs.tex**: Short navigation summary of the active Dunaev tagged-pair convention. *(Active Draft)*
- **020_descriptors.tex**: Three-valued/uncertain descriptor calculus with `tau`, `epsilon`, and partial `varepsilon`. *(Preserved Alternative 3)*
- **025_unified_descriptors.tex**: Rejected attempt to combine descriptor systems without specifying their semantics. **[OUTDATED] Non-Normative**
- **030_alternative_semantics.tex**: Conglomerate-valued/subset assignment semantics. **[OUTDATED] Preserved Alternative 5**
- **035_unified_type_semantics.tex**: Rejected generic type/descriptor relation. **[OUTDATED] Non-Normative**
- **040_old_variant_of_iota_defs.tex**: Old variants of iota definitions for choice functions. **[OUTDATED] Historical**
- **040_partial_functions.tex**: Secondary summary of the PFOL partial-function notation. *(Preserved Alternative 4 Draft)*
- **050_descriptor_systems.tex**: Secondary descriptor and class-abstraction notes. *(Preserved Alternative Draft)*
- **050_prooftrees.tex**: Proof-tree formalism for class-theoretic deductions. *(Active Draft)*
- **050_unified_interface.tex**: Navigation between approaches; explicitly not a semantic switch. *(Active Navigation)*
- **060_axioms.tex**: Core axioms of the Morse–Kelley framework. *(Active Draft)*
- **070_ordered_pair.tex**: Ordered-pair constructions, including the active Dunaev tagged pairs. *(Active Draft)*
- **080_azriel_levi_union_thm.tex**: Proof of the Azriel–Levi union theorem. *(Active Draft)*
- **090_proving_limitation_of_size.tex**: Development of limitation-of-size results. *(Active Draft)*
- **100_class_theory.tex**: Comprehensive exposition of class-theoretic foundations. *(Active Draft)*
- **110_family_evaluation.tex**: Theory of families and evaluation maps. *(Active Draft)*
- **120_induction_recursion.tex**: Induction and recursion principles for classes. *(Active Draft)*
- **130_classes_as_types.tex**: Active predicates/formulas-as-types discipline, with older classes-as-types attempts explicitly marked outdated. *(Active Draft with Historical Sections)*
- **140_setness.tex**: Exploration of setness versus classness. *(Active Draft)*
- **150_ordinals.tex**: Development of ordinal numbers within the class framework. *(Active Draft)*
- **160_some_order_theory.tex**: Miscellaneous results in order theory. *(Active Draft)*
- **170_paradoxes.tex**: Analysis of classical paradoxes. *(Active Draft)*
- **180_many-valued.tex**: Many-valued and uncertain-value experiments accompanying Alternative 3. *(Preserved Alternative 3)*
- **190_union_intersection.tex**: Formal treatment of union and intersection operations on classes. *(Active Draft)*
- **199_languages.tex**: Formal languages and syntactic considerations in the theory. *(Active Draft)*
- **200_relations.tex**: Theory of relations between classes. *(Active Draft)*
- **200_uniqueness.tex**: Uniqueness principles and their applications. *(Active Draft)*
- **210_partial_functions_semantics.tex**: Farmer's PFOL, iota-definedness, and Kleene equality. *(Preserved Alternative 4)*
- **220_simpler_img_thms.tex**: Simpler image theorems for functions between classes. *(Active Draft)*
- **230_analysis.tex**: Foundations of real analysis within the class framework. *(Active Draft)*
- **250_topology.tex**: Basic topology built on the class framework. *(Active Draft)*
- **260_linear_algebra.tex**: Linear algebraic structures expressed via classes. *(Active Draft)*
- **270_measure_theory.tex**: Measure-theoretic concepts adapted to the foundations. *(Active Draft)*
- **280_functional_analysis.tex**: Functional analysis foundations. *(Active Draft)*
- **290_probability_theory.tex**: Probability theory within the class framework. *(Active Draft)*
- **300_category_theory.tex**: Categorical foundations compatible with Morse–Kelley theory. *(Active Draft)*
- **310_differential_geometry.tex**: Differential geometry within the class framework. *(Active Draft)*
- **320_src.tex**: Source code excerpts and utilities supporting the LaTeX documents. *(Active Draft)*
- **320_strang_thm.tex**: Formalisation of Strang's theorem. *(Active Draft)*
- **330_restricted_quantifiers.tex**: Treatment of restricted quantifiers in the class language. *(Active Draft)*
- **summary_of_approaches.tex**: Front-of-book guide separating the active mainline from the three preserved alternatives. *(Active Guide)*

### Formalizations
- **presentation.ML**: Class-theoretic foundations based on Morse–Kelley class theory and Tarski's axiom. *(Active Draft)*
- **Coq/positive_foundations.v**: Coq formalisation of positive foundations, including inductive definitions of ensembles and ordered pairs. *(Active Draft)*
- **code/IFOLD.thy**: Isabelle/HOL theory implementing the IFOLD construction. *(Active Draft)*

### Additional Resources
- **APPROACHES_INVENTORY.md**: Authoritative inventory, status, and preservation boundary for the exact five approaches.
- **COMPETING_APPROACHES.md**: Concise comparison and links to the authoritative inventory.
- **LATEX_AUDIT_REPORT.md**: Report on LaTeX documentation status.
- **MACROS_INDEX.md**: Index of custom LaTeX macros.
- **PRESENTATION_ML_GUIDE.md**: Guide for `presentation.ML`.
- **MECHANIZED_EXPERIMENTS.md**: Notes on mechanized experiments.

## Status Summary

- **Active mainline:** approaches (1) and (2), with no uncertain truth value or PFOL definedness imported implicitly.
- **Preserved alternatives:** approaches (3), (4), and (5), retained in their original source files.
- **Rejected unification drafts:** `025_unified_descriptors.tex` and `035_unified_type_semantics.tex`, retained only as `[OUTDATED]` non-normative documents.
- **Historical material:** files explicitly marked `[OUTDATED]` remain preserved rather than being silently modernised or deleted.

## Next Steps

- Keep the active semantics and alternative systems explicitly separated.
- Require precise source/target semantics and proved metatheory for any future translation.
- Expand formalizations without weakening Dunaev pairing, type uniqueness, or the preservation boundary.
