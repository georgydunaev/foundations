# Architecture, Axiom Systems, Formalizations, and Theorems Guide

## 1. Repository Architecture Overview

The `foundations` repository combines a multi-chapter mathematical monograph (`001_foundations.tex` and numbered chapters `000_preamble.tex` through `330_restricted_quantifiers.tex`), the standalone Schrödinger heat-kernel and dynamical-potential thesis (`thesis_schrodinger.tex`), and four mechanized/executable formalization layers:

1. **Standard ML Formalizations (`examples/mktd_foundations.ML`, `examples/debruijn.ML`, `presentation.ML`)**:
   - [`mktd_foundations.ML`](file:///botworkspace/foundations/examples/mktd_foundations.ML): Portable SML'97 formalization compatible with both CakeML and Poly/ML implementing the `MKTD1`/`MKTD2`-aligned Morse-Kelley class theory kernel, Dunaev Tagged Ordered Pairs, Kuratowski sethood guards, predicates/formulas-as-types, descriptor operators, transfinite recursion, category theory, model-theoretic truth, cumulative hierarchy reflection, ordinals, Grothendieck universes, Gödel's constructible universe $L$, forcing, independence results, and large cardinals.
   - [`debruijn.ML`](file:///botworkspace/foundations/examples/debruijn.ML): Executable de Bruijn index lambda calculus with scope checking, lifting/shifting, capture-avoiding substitution, and fuel-bounded normal-order evaluation.
   - [`presentation.ML`](file:///botworkspace/foundations/presentation.ML): Preserved SML-style mathematical design specification for Morse-Kelley class theory with Tarski's universe axiom, Dunaev tagged pairs, and `Lam` class families.
2. **Coq Formalization (`Coq/positive_foundations.v`)**:
   - [`positive_foundations.v`](file:///botworkspace/foundations/Coq/positive_foundations.v): Aczel-style inductive sets (`Ens`), extensional equality (`EQ`), membership (`IN`), stratified `EqualityType` and `ClassOf` universes (`SET`, `CLASS`, `CONGLOMERATE`, `Universe n`), conglomerate intersections, universal class `V`, and positive properties of classes (`positive`, `ppc`).
3. **Isabelle/Pure Formalization (`code/IFOLD.thy`)**:
   - [`IFOLD.thy`](file:///botworkspace/foundations/code/IFOLD.thy): Intuitionistic first-order logic with definedness (`IFOLD`), Hilbert/iota descriptors (`epsilon`, `iota`), existence predicates (`exists`, `defined`), and set-theoretic separation (`Subclass`, `is_set`, `Russell`).
4. **Python Reference Formalization (`foundations/`)**:
   - [`logic.py`](file:///botworkspace/foundations/foundations/logic.py): Sequent calculus, context freshness checking, Hilbert/Bernays quantifier abstraction rules, four-theory metatheoretic hierarchy ($\mathcal{W}, \mathcal{E}, \mathcal{T}, \mathcal{F}$), semantic completeness vs. syntactic negation-completeness, and Gödel/Löb derivability conditions.
   - [`descriptors.py`](file:///botworkspace/foundations/foundations/descriptors.py): Three-valued and classical descriptor calculi ($\tau, \epsilon, \varepsilon, \iota$).
   - [`pfol.py`](file:///botworkspace/foundations/foundations/pfol.py): Farmer's Partial First-Order Logic (PFOL) with Kleene equality ($\simeq$) and definedness ($\downarrow$).
   - [`type_semantics.py`](file:///botworkspace/foundations/foundations/type_semantics.py): Predicates/formulas-as-types and classes-as-expressions discipline, explicit typed term interpretation ($\mu_A$), and universe closure models.

---

## 2. The Five Foundational Approaches and Strict Taxonomy

As documented in [`APPROACHES_INVENTORY.md`](file:///botworkspace/foundations/APPROACHES_INVENTORY.md) and [`summary_of_approaches.tex`](file:///botworkspace/foundations/summary_of_approaches.tex), the repository preserves five distinct mathematical approaches without conflating their semantics:

| # | Approach | Primary Sources | Status |
|---|---|---|---|
| 1 | Classical Two-Valued MK/NBG + Total Comprehension Evaluation + Dunaev Tagged Ordered Pairs | [`060_axioms.tex`](file:///botworkspace/foundations/060_axioms.tex), [`070_ordered_pair.tex`](file:///botworkspace/foundations/070_ordered_pair.tex), [`presentation.ML`](file:///botworkspace/foundations/presentation.ML), [`mktd_foundations.ML`](file:///botworkspace/foundations/examples/mktd_foundations.ML) | Active mainline |
| 2 | Predicates/Formulas-as-Types, Classes-as-Expressions | [`001_foundations.tex`](file:///botworkspace/foundations/001_foundations.tex), [`130_classes_as_types.tex`](file:///botworkspace/foundations/130_classes_as_types.tex), [`type_semantics.py`](file:///botworkspace/foundations/foundations/type_semantics.py) | Active mainline (with historical drafts marked `[OUTDATED]`) |
| 3 | Three-Valued / Uncertain Descriptor Calculus ($\tau, \epsilon, \varepsilon$) | [`020_descriptors.tex`](file:///botworkspace/foundations/020_descriptors.tex), [`180_many-valued.tex`](file:///botworkspace/foundations/180_many-valued.tex), [`descriptors.py`](file:///botworkspace/foundations/foundations/descriptors.py) | Preserved alternative |
| 4 | Farmer's Partial First-Order Logic (PFOL) with $\iota$-definedness and Kleene equality | [`210_partial_functions_semantics.tex`](file:///botworkspace/foundations/210_partial_functions_semantics.tex), [`040_partial_functions.tex`](file:///botworkspace/foundations/040_partial_functions.tex), [`pfol.py`](file:///botworkspace/foundations/foundations/pfol.py) | Preserved alternative |
| 5 | Conglomerate-Valued / Subset Assignment Semantics | [`030_alternative_semantics.tex`](file:///botworkspace/foundations/030_alternative_semantics.tex) | Preserved `[OUTDATED]` alternative |

Rejected unification drafts ([`025_unified_descriptors.tex`](file:///botworkspace/foundations/025_unified_descriptors.tex) and [`035_unified_type_semantics.tex`](file:///botworkspace/foundations/035_unified_type_semantics.tex)) remain explicitly marked `[OUTDATED]` and non-normative.

---

## 3. Axiom Systems

### 3.1 Morse-Kelley (MK) and Von Neumann-Bernays-Gödel (NBG) Class Theory
Defined across [`060_axioms.tex`](file:///botworkspace/foundations/060_axioms.tex), [`100_class_theory.tex`](file:///botworkspace/foundations/100_class_theory.tex), [`100_classes.tex`](file:///botworkspace/foundations/100_classes.tex), and [`mktd_foundations.ML`](file:///botworkspace/foundations/examples/mktd_foundations.ML):
- **Class Extensionality**: $\forall A\,\forall B,\, (\forall x,\, x \in A \iff x \in B) \implies A = B$.
- **Universal Class of Sets**: $V \eqdef \{x \mid \top\}$, where $x \in V$ expresses sethood ($\mathrm{isSet}(x)$).
- **Impredicative Class Comprehension (MK)**: For any formula $\phi(x)$ (whose quantifiers may range over all classes), $\forall z,\, z \in \{x \mid \phi(x)\} \iff (z \in V \land \phi(z))$. In NBG fragments, comprehension formulas are restricted to set quantifiers.
- **Class Separation (Subsets of Sets are Sets)**: $\forall a\,\forall P,\, a \in V \implies (a \cap P) \in V$.
- **Pairing, Union, Powerset, Infinity, Regularity (Foundation), Replacement / Limitation of Size**: Formulated for sets in $V$ and generalized to class relations.
- **Dunaev Tagged Ordered Pairs (Mandatory for Classes)**:
  - Because Kuratowski pairs $\{\{A\}, \{A, B\}\}$ collapse to $\{\emptyset\}$ when $A$ or $B$ is a proper class ($A, B \notin V$), class pairing exclusively uses Dunaev Tagged Ordered Pairs:
    $$[A, B] \eqdef (\{0\} \times A) \cup (\{1\} \times B) = \{z \mid \exists x,\, (z = (0, x)_{\mathrm{Kur}} \land x \in A) \lor (z = (1, x)_{\mathrm{Kur}} \land x \in B)\}$$
    or the semi-singleton subset formulation in [`presentation.ML`](file:///botworkspace/foundations/presentation.ML).
  - First and second projections recover arbitrary (possibly proper) classes $A$ and $B$ without sethood assumptions: $\mathrm{fst}([A, B]) = A$ and $\mathrm{snd}([A, B]) = B$.
- **Tarski's Universe Axiom (`presentation.ML`, `130_classes_as_types.tex`)**: Every set belongs to a Grothendieck/Tarski universe closed under pairing, powerset, union, and replacement.

### 3.2 Logical Framework and Metatheoretic Hierarchy ($\mathcal{W}, \mathcal{E}, \mathcal{T}, \mathcal{F}$)
Defined in [`010_logic.tex`](file:///botworkspace/foundations/010_logic.tex) and [`AUDIT_REPORT.md`](file:///botworkspace/foundations/AUDIT_REPORT.md):
- **Propositional & Quantifier Rules**: Classical and intuitionistic sequent and Hilbert rules, including Bernays $\forall$-abstraction (`RulForallAbstraction`, 2.04), $\exists$-abstraction (`RulExistsAbstraction`, 2.05), empty-context `RulGeneralisation` (2.06), and context-indexed `DefMetaGeneralisation` (4.02) requiring $\neg\mathrm{Ctx.IFV}(v, \Gamma)$.
- **Four-Theory Hierarchy**:
  - $\mathcal{W}$: Arbitrary object theory parameter.
  - $\mathcal{E} \in \{\mathrm{I}\Sigma_1, \mathrm{PA}, \mathcal{T}, \mathrm{NBG}, \mathrm{MK}\}$: Elementary metatheory supporting syntax coding and Hilbert-Bernays-Löb derivability conditions.
  - $\mathcal{T}$: Recursively enumerable effective object theory subject to Gödel incompleteness.
  - $\mathcal{F}$: Ideal non-effective full theory with decoupled **Semantic Completeness / Omniscience** ($\forall \phi,\, \mathrm{eval}_M(\phi) \implies (\mathcal{F}, [] \vdash \phi)$, Entry 3.73) and **Syntactic Negation-Completeness** ($\forall \phi,\, \neg(\mathcal{F}, [] \vdash \neg\phi) \implies (\mathcal{F}, [] \vdash \phi)$, Entry 3.74).

### 3.3 Positive Foundations (`Coq/positive_foundations.v`)
- Stratified equality types `EqualityType` (`SET`, `CLASS`, `CONGLOMERATE`, `Universe n`).
- `Positivity` axiom: $\forall P : \mathrm{CONGLOMERATE},\, \mathrm{positive}(P) \implies P(V)$, where $\mathrm{positive}(P) \iff \forall \phi,\, P(\bigcap (\phi \cap P))$.

### 3.4 Intuitionistic First-Order Logic with Definedness (`code/IFOLD.thy`)
- Object truth type `o`, judgment `Trueprop`, equality `refl`/`subst`, intuitionistic connectives (`False`, `conj`, `disj`, `imp`), guarded quantifiers (`allI`, `spec`, `exI`, `exE` with `exists(x)`), descriptors (`epsI`, `eps_defined`, `iotaI`, `iota_defined`, `iota_unique`, `iota_eqI`), and class separation (`subclassI`, `subclassD`, `separation`).

---

## 4. Summary of Formalized & Proved Theorems

### 4.1 Executable SML Formalizations (`examples/mktd_foundations.ML` & `examples/debruijn.ML`)
All theorem constructors in [`mktd_foundations.ML`](file:///botworkspace/foundations/examples/mktd_foundations.ML) are verified by `MKTD_Foundations.run_self_tests ()`:
- **Core Class Theory & Pairing**: `prove_russell_is_proper_class` ($R \notin V$), `prove_separation` ($a \in V \implies a \cap P \in V$), `prove_dunaev_pair_injectivity` ($[A, B] = [C, D] \implies A = C \land B = D$), and runtime rejection of proper classes in `kuratowski_pair_checked`.
- **Descriptors & Choice**: `prove_tau_spec`, `prove_iota_spec`, `prove_iota_elim`, `prove_epsilon_empty`.
- **Transfinite Induction & Recursion**: `prove_transfinite_induction`, `prove_transfinite_recursion`, and finite-DAG evaluation `eval_transfinite_recursion`.
- **Category Theory**: `prove_categorical_product`, `prove_comprehension_equalizer`, `prove_pullback_square`, `prove_pushout_square`, `prove_equalizer_pullback_duality`, `prove_slice_product_pullback`, `prove_limit_colimit_duality`.
- **Model Theory, Reflection & Ordinals**: `prove_tarski_truth`, `prove_relativization`, `prove_reflection_schema`, `prove_hartogs`, `prove_scotts_trick`, `prove_limitation_of_size`, `prove_ord_add_zero`, `prove_ord_add_succ`, `prove_ord_mult_zero`, `prove_ord_mult_succ`, `prove_ord_exp_zero`, `prove_ord_exp_succ`, `prove_ord_addition_noncommutative`, `prove_ord_multiplication_noncommutative`.
- **Grothendieck Universes & Large Cardinals**: `prove_grothendieck_universe`, `prove_inaccessible_universe`, `prove_inaccessible_models_zfc`, `prove_level_reflection`, `prove_internalized_satisfaction`, `prove_inaccessible_definition`, `prove_mahlo_characterization`, `prove_weakly_compact_tree_property`, `prove_measurable_ultrafilter`, `prove_measurable_elementary_embedding`, `prove_ultrapower_construction`, `prove_scotts_theorem` (measurable cardinal implies $V \neq L$), `prove_relative_consistency_measurable`.
- **Constructible Universe $L$, AC, and GCH**: `prove_def_powerset`, `prove_l_zero`, `prove_l_succ`, `prove_l_limit`, `prove_is_constructible`, `prove_v_equals_l`, `prove_delta0_absoluteness`, `prove_l_models_zfc`, `prove_pairing_delta0_absolute`, `prove_union_delta0_absolute`, `prove_empty_set_delta0_absolute`, `prove_bounded_quant_delta0_absolute`, `prove_canonical_well_order`, `prove_well_ordering_l`, `prove_l_models_ac`, `prove_tarski_vaught_criterion`, `prove_mostowski_collapse`, `prove_condensation_lemma`, `prove_lowenheim_skolem_l`, `prove_rank_bounding`, `prove_powerset_l_bound`, `prove_gch_in_l`, `prove_l_satisfies_ac`, `prove_l_satisfies_gch`.
- **Inner Models, Forcing, and Independence**: `prove_inner_model`, `prove_l_is_inner_model`, `prove_delta0_inner_model_absoluteness`, `prove_relative_consistency_ac_gch`, `prove_con_zf_implies_con_zfc_gch`, `prove_poset_compatibility`, `prove_antichain`, `prove_dense_subset`, `prove_generic_filter`, `prove_forcing_truth_lemma`, `prove_generic_model_existence`, `prove_ccc_preserves_cardinals`, `prove_cohen_reals_distinct`, `prove_continuum_at_least_aleph2`, `prove_generic_extension_neg_ch`, `prove_independence_of_ch`, `prove_ma_aleph1_implies_sh`, `prove_diamond_implies_neg_sh`, `prove_independence_of_sh`, `prove_easton_powers_theorem`, `prove_levy_collapses_to_omega1`, `prove_solovay_model_lebesgue`, `prove_inner_model_relativization_criterion`, `prove_forcing_poset_preorder`, `prove_ccc_antichain_condition`, `prove_dunaev_pname_well_formed`, `prove_check_name_generic_val`, `prove_generic_extension_inner_model`.
- **Untyped de Bruijn Calculus (`examples/debruijn.ML`)**: Verified shifting (`shift`), capture-avoiding substitution (`replace`), beta-contraction (`contract`), and normal-order evaluation (`run`).

### 4.2 Coq Formalization (`Coq/positive_foundations.v` & `Coq/ppc_pos_helpers.v`)
- `EQ_tran`, `EQ_sym`, `EQ_sound_left`, `EQ_sound_right`: Equivalence and predicate-soundness properties of extensional equality on `Ens`.
- `Ens_EQ_sound_left`, `Ens_EQ_sound_right`, `A_eq_sound_left`, `A_eq_sound_right`, `ClassOf_T_eq_sound_left`, `ClassOf_T_eq_sound_right`: Soundness of equality across arbitrary levels of the `Universe n` hierarchy.
- `intersect_sound`, `V_sound`, `binter_sound`, `positive_sound`: Soundness of conglomerate intersection, the universal class $V$, binary intersection, and the positivity predicate (`Qed.`).
- `ppc_pos` (`positive (@ppc ET1)`): Self-positivity of the superconglomerate `ppc` of all positive conglomerates, constructively proved with `Qed.` in both [`positive_foundations.v`](file:///botworkspace/foundations/Coq/positive_foundations.v#L394-L435) and [`ppc_pos_helpers.v`](file:///botworkspace/foundations/Coq/ppc_pos_helpers.v) via the conglomerate absorption identity $\bigl(\psi \cap I_{\mathrm{ppc}}(\Phi)\bigr) \cap \mathcal{U} \equiv \psi \cap I_{\mathrm{ppc}}(\Phi)$ (analyzed in [`PPC_POS_PROOF_ANALYSIS.md`](file:///botworkspace/foundations/Coq/PPC_POS_PROOF_ANALYSIS.md)).

### 4.3 Monograph Chapters (`001_foundations.tex` & `thesis_schrodinger.tex`)
- **Logic, Types & Trees (`010_logic.tex`, `130_classes_as_types.tex`, `131_class_polynomial_trees.tex`, `198_debruijn_substitution.tex`, `199_languages.tex`)**: Deduction theorem with context freshness, conservative Henkin witness extensions, diagonal lemma and Löb's theorem, set-level W-types and M-types, class-valued initial algebras and final coalgebras for polynomial functors without Choice, and strong normalization and confluence of simply typed lambda calculus with Booleans.
- **Set & Class Theory (`070_ordered_pair.tex`, `080_azriel_levi_union_thm.tex`, `090_proving_limitation_of_size.tex`, `100_class_theory.tex`, `120_induction_recursion.tex`, `150_ordinals.tex`, `160_some_order_theory.tex`)**: Dunaev pair injectivity, Azriel Lévy boundedness and union theorem, finite countermodels for minimal class axioms, well-founded recursion, Mostowski collapse, Hartogs' theorem, Schroeder-Bernstein, and Knaster-Tarski fixed-point theorem.
- **Topology, Measure, Functional Analysis & Probability (`250_topology.tex` – `290_probability_theory.tex`)**: Alexandrov topology-preorder equivalence, ultrafilter lemma and Tychonoff theorem under Choice, monotone and dominated convergence, $L^p$ completeness, Hahn-Banach, Baire category, uniform boundedness, Riesz-Fréchet representation, Vitali convergence, Schur's theorem, and full sequential and topological Dunford-Pettis weak-compactness equivalence in $L^1(\mu)$.
- **Schrödinger Semigroups & Dynamical Kernels (`293_heat_equation.tex` – `296_dynamical_schrodinger_kernels.tex`)**: Gaussian heat kernel uniqueness, Simon's measure-extension kernel criterion, Dyson-Duhamel perturbation series, Gaussian upper/lower bounds, strong Trotter product formula, covariant dynamical Schrödinger kernels, exponentially weighted Lipschitz/Hölder continuity bounds, shear-torus operator-norm discontinuity counterexample, and Euclidean Beckus-Takase spectral localization.

---

## 5. Open Problems, Preserved Drafts, and Unfinished Items

1. **Self-Positivity Conjecture in Coq (`Coq/positive_foundations.v:394`, Resolved)**:
   - `Theorem ppc_pos {ET1: EqualityType} : positive (@ppc ET1).` was previously `Admitted.` and is now constructively closed with `Qed.` (zero `Admitted.` remain across `Coq/positive_foundations.v` and `Coq/ppc_pos_helpers.v`). See [`PPC_POS_PROOF_ANALYSIS.md`](file:///botworkspace/foundations/Coq/PPC_POS_PROOF_ANALYSIS.md).
2. **Upstream Obelisk Reconciliation Tickets (`tickets/obelisk_*.md`)**:
   - 24 tracked tickets document differences between the monograph's guarded/unguarded conventions and upstream generated exports (e.g., domain guards on `ThmFamilyEvaluation` when `DefValueAtArg` defaults to $V$, pointwise membership in `DefPiPredicateModel`, and fresh binders in uniqueness expansions).
3. **Preserved Historical & Commented Explorations in LaTeX Sources**:
   - `010_logic.tex`: Contains preserved `\iffalse ... \fi` historical blocks (`%TODO TAKE THE BEST`, lines 862–1518) and `[unfinished section]` notes on object-language predicate calculus encodings.
   - `060_axioms.tex:194`: Commented note on medium-type comprehension (`%\begin{constructor}[medium type comprehension]`) avoiding type ambiguity.
   - `110_family_evaluation.tex`: Preserves exploratory notes on partial/semi-equality interactions explicitly labeled as unfinished proposals rather than active axioms.
   - `320_strang_thm.tex`: Retained in repository as an unspecified placeholder excluded from the assembled book.
   - `330_restricted_quantifiers.tex:66`: Preserves the older commented-out leftmost-variable heuristic below the completed and proved parameter-context binder inference section.
   - `presentation.ML`: Retains a draft comment noting that syntactic complexity weights (`compl. = n`) have no fixed global weighting formula.
4. **Thesis Bibliographic Page Verification (`THESIS_RESEARCH_PLAN.md`)**:
   - The bounded-potential Trotter product formula is proved directly in `295_schrodinger_semigroups.tex`; checking the exact page/number of Weidmann's Theorem 7.41 and Trotter's 1959 original AMS article text remains noted as optional bibliographic follow-up.
