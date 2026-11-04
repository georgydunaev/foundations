# MECHANIZED_EXPERIMENTS

## Coq Positive Foundations (`Coq/positive_foundations.v`)

### Inductive `Ens` W-type Encoding

The file defines an inductive type `Ens` with a single constructor `sup` that takes a type `A` and a function `f` from `A` to `Ens`, and returns an `Ens`.

### Pair Definition

The `Pair` function is defined using the `sup` constructor. It takes two `Ens` values `A` and `B` and returns an `Ens` that represents the ordered pair of `A` and `B`.

### Equality of Sets

The `EQ` function is defined to check the extensional equality of two sets. It uses a fixpoint to recursively compare the elements of the sets.

### Membership

The `IN` function is defined to check if an element is a member of a set.

### Sound Predicates

The `SoundPred` and `SoundPredOf` functions are defined to ensure that predicates are sound with respect to the equality relation.

### Transitivity and Symmetry of Equality

The `EQ_tran` and `EQ_sym` functions are defined to prove the transitivity and symmetry of the equality relation.

## Isabelle `code/IFOLD.thy`

### Section and Theory Declaration

The file starts with a section declaration for "Intuitionistic first-order logic" and declares a theory named `IFOLD` that imports the `Pure` theory.

### Abbreviations

The file defines an abbreviation `?<` for the existential quantifier with a subscript `<`.

### ML Files

The file includes several ML files that are used for various purposes, such as `misc_legacy.ML`, `splitter.ML`, `hypsubst.ML`, etc.

### Syntax and Axiomatic Basis

The file defines the syntax and axiomatic basis for the theory, including the declaration of a type `o` and a judgment `Trueprop`.

### Equality

The file defines the equality relation with the `eq` function and provides axioms for reflexivity and substitution.

### Propositional Logic

The file defines the propositional logic operators `False`, `conj`, `disj`, and `imp` with their respective axioms and inference rules.

## Obelisk Proof Assistant Cross-Reference (`set_theory_prover`)

The active Morse–Kelley / NBG formulations in `110_family_evaluation.tex`, `130_classes_as_types.tex`, and `190_union_intersection.tex` are mechanized in both variants of `set_theory_prover` (105 exported 1st-order kernel entries in `program/types/foundations.ML`, 100/100 verified higher-order records in `program/verified_theorems.ML`, and 35/35 compiled `.nbg` theorems in `examples/nbg_verified_programs.nbg`):

| `foundations` Chapter | Mathematical Concept | Catalog Entry | 1st-Order Kernel (`foundations.ML`) | Higher-Order (`verified_theorems.ML` & `.nbg`) |
| :--- | :--- | :--- | :--- | :--- |
| `110_family_evaluation.tex` | Semi-Singleton Subsets (`isSSS`) | `3.67` | `isSSS_def_entry` (`3.35`) | `thm_81_semi_singleton_sub_char`, `semi_singleton_subset_uniqueness` |
| `110_family_evaluation.tex` | Class Family (`isFamily`) | `3.68` | `isFamily_def_entry` (`3.36`) | `thm_82_family_value_eval` |
| `110_family_evaluation.tex` | Family Evaluation (`F(x)`) | `3.69` | `family_eval_def_entry` (`3.37`) | `thm_82_family_value_eval` |
| `130_classes_as_types.tex` | Dependent Sum Model ($\Sigma B$) | `3.70` | `sigma_model_def_entry` (`3.38`) | `thm_83_sigma_model_proj`, `sigma_dependent_sum_intro` |
| `130_classes_as_types.tex` | Dependent Product Models ($\Pi B$) | `3.71` | `pi_predicate_model_def_entry` (`3.39`) | `thm_84_pi_model_elim`, `pi_dependent_product_elim` |
| `190_union_intersection.tex` | Subclass Antisymmetry | `3.72` | `A02_extensionality_axm` (`3.02`) | `thm_96_subset_antisym`, `thm_95_emptyset_subset_all` |
| `190_union_intersection.tex` | Singleton & Intersection Inclusions | `3.73` | `binary_inter_def_entry` (`3.18`) | `thm_91`–`thm_94`, `inter_sub_union`, `singleton_sub_upair_left` |
| `140_setness.tex` | Universal Subclass Criterion & $\mathcal{P}(\omega) \in \mathrm{V}$ | `3.74` | `universal_class_def_entry` (`3.05`) | `thm_97`–`thm_100`, `inter_sub_both` |

### Explicit Typed Term Interpretation ($\mu_A$ / $I$)

In `130_classes_as_types.tex` and the Obelisk kernel (`program/types/typetheory.ML`, `program/Presentation.ML`), the operator $\mu_A : A.\mathsf{Expression} \to \mathsf{Class}.\mathsf{Expression}$ (written $I(a)$ or $\mu_A(a)$ in `130_classes_as_types.tex` and `\mu_A` in SML) denotes the **explicit typed term interpretation** (valuation homomorphism; cf. Tarski 1936, Enderton 2001 §2.2, Jacobs 1999) under a fixed (unspecified) background model and a fixed (unspecified) variable valuation, rather than the collection of all models.

### Four-Theory Metatheoretic Hierarchy ($\mathcal{W}, \mathcal{E}, \mathcal{T}, \mathcal{F}$)

The metatheoretic layer (`3.72`–`3.73`, `4.03`, `5.01`–`5.03` in `program/types/foundations.ML` and `program/demo_newchecker.ML`) is stratified into four theories:

1. $\mathcal{W}$ (`\mathcal{W}`): weakest syntactic base theory.
2. $\mathcal{E} \in \{I\Sigma_1, \mathcal{T}, \mathrm{NBG}, \mathrm{MK}\}$ (`\mathcal{E}`, `sEau`): elementary metatheory extending $I\Sigma_1$ used in Löb's theorem (`5.01`) and Gödel's second incompleteness theorem (`5.02`). Robinson's arithmetic $Q$ is intentionally excluded because $Q$ lacks the $\Sigma_1$-induction needed to verify the third Hilbert–Bernays–Löb derivability condition D3 ($\vdash_{\mathcal{E}} \Box_{\mathcal{T}}\varphi \to \Box_{\mathcal{T}}\Box_{\mathcal{T}}\varphi$) and to make Gödel's second incompleteness theorem meaningful (Hájek & Pudlák 1993, *Metamathematics of First-Order Arithmetic*, Ch. I & III; Bezboruah & Shepherdson 1976, *JSL* 41(2):503–512; Boolos 1993, *The Logic of Provability*, Ch. 2).
3. $\mathcal{T}$ (`\mathcal{T}`, `sTau`): recursively enumerable (r.e.) base object theory (NBG/MK).
4. $\mathcal{F}$ (`\mathcal{F}`, `sFau`): **non-r.e.** sound Henkin-complete extension of $\mathcal{T}$ (`3.72` Completeness $(\vdash_{\mathcal{F}}\neg\varphi)\lor(\vdash_{\mathcal{F}}\varphi)$, `3.73` Soundness $(\vdash_{\mathcal{F}}\varphi)\implies\varphi$), for which the Co-Necessitation meta-inference (`4.03`, $\varphi \vdash \Box_{\mathcal{F}}\varphi$) is justified by Soundness (`3.73`).

