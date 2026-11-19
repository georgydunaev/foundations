# Obelisk: decouple semantic completeness (3.73) from syntactic negation-completeness (3.74)

Status: Resolved / Decoupled
Evidence: Decoupled across `set_theory_prover/program/types/foundations.ML`, `set_theory_prover/program/types/entries.ML`, `foundations/010_logic.tex`, `foundations/foundations/logic.py`, and `foundations/examples/mktd_foundations.ML`.

## Root cause and decoupling resolution

Previously, an earlier AI model attached an erroneous specification comment describing syntactic negation-completeness ($\neg(\mathcal{F}, [] \vdash \neg\phi) \implies (\mathcal{F}, [] \vdash \phi)$) onto the original semantic completeness (omniscience) entry whose AST formula was $\forall (\phi:\mathrm{Fm}),\ \operatorname{eval}_M(\phi) \implies (\mathcal{F}, [] \vdash \phi)$ (`POmnis_prf`). That discrepancy came from the previous model's comment rather than the author's mathematical formulation.

To eliminate any ambiguity or conflation, the catalog and formalization completely decouple the two principles into separate axiomatic entries with distinct identifiers, SML AST formulas, proof constructors, and specification comments:

1. **Entry 3.73 (`AxmSemanticCompletenessOfFullTheory`) — Semantic Completeness / Omniscience**:
   - **SML Definition**: `semantic_completeness_of_F_axm_entry_fm` (`semantic_completeness_of_F_axm_entry` in `program/types/entries.ML`).
   - **Formula**: $\forall (\phi:\mathrm{Fm}),\ \operatorname{eval}_M(\phi) \implies (\mathcal{F}, [] \vdash \phi)$.
   - **Constructor**: `POmnisSem_prf` (paired with the omniscience inference rule constructor `POmnis_prf`).
   - **Classification**: `Axiom`; verification: `Postulated (Kernel Axiom)`.
   - **Specification Comment**: States exclusively semantic completeness (truth-to-provability / omniscience in the background model $M$): for every sentence $\phi$, if $\phi$ evaluates to true in $M$ ($\operatorname{eval}_M(\phi)$), then $\phi$ is formally derivable in $\mathcal{F}$ from the empty context $[]$. Together with `AxmSoundnessOfFullTheory` (Entry 3.72, $(\mathcal{F}, [] \vdash \phi) \implies \operatorname{eval}_M(\phi)$), this establishes $(\mathcal{F}, [] \vdash \phi) \iff \operatorname{eval}_M(\phi)$.

2. **Entry 3.74 (`AxmNegationCompletenessOfFullTheory`) — Syntactic Negation-Completeness**:
   - **SML Definition**: `negation_completeness_of_F_axm_entry_fm` (`negation_completeness_of_F_axm_entry` in `program/types/entries.ML`).
   - **Formula**: $\forall (\phi:\mathrm{Fm}),\ \neg(\mathcal{F}, [] \vdash \neg\phi) \implies (\mathcal{F}, [] \vdash \phi)$.
   - **Constructor**: `POmnisNeg_prf`.
   - **Classification**: `Axiom`; verification: `Postulated (Kernel Axiom)`.
   - **Specification Comment**: States exclusively syntactic negation-completeness of $\mathcal{F}$: for every closed sentence $\phi$, if $\neg\phi$ is not derivable in $\mathcal{F}$ from $[]$, then $\phi$ is derivable in $\mathcal{F}$ from $[]$ (classically equivalent to $(\mathcal{F}, [] \vdash \phi) \lor (\mathcal{F}, [] \vdash \neg\phi)$).

## Mathematical stratification and conditional bridge

Semantic completeness (Entry 3.73) and syntactic negation-completeness (Entry 3.74) concern different data—truth in a model $M$ versus syntactic derivability—and are stratified across the recursively enumerable base theory $\Tau$ and the non-recursively-enumerable Henkin completion $\Fau$:

- Under soundness of $\Fau$ in a classical interpretation $M$ (`AxmSoundnessOfFullTheory`, Entry 3.72: $(\Fau, [] \vdash \psi) \implies \operatorname{eval}_M(\psi)$), syntactic negation-completeness (Entry 3.74) implies semantic completeness (Entry 3.73): if $\operatorname{eval}_M(\phi)$ holds, soundness excludes $(\Fau, [] \vdash \neg\phi)$, and syntactic negation-completeness yields $(\Fau, [] \vdash \phi)$.
- Conversely, under classical bivalence ($\operatorname{eval}_M(\phi) \lor \operatorname{eval}_M(\neg\phi)$), semantic completeness (Entry 3.73) implies syntactic negation-completeness (Entry 3.74).
- By Godel's first incompleteness theorem, the consistent recursively enumerable base theory $\Tau$ satisfies neither syntactic negation-completeness nor semantic completeness with respect to unrestricted truth $\operatorname{eval}_M$, whereas the non-recursively-enumerable Lindenbaum-Henkin completion $\Fau$ satisfies both Entry 3.73 and Entry 3.74.

## Resolution Summary (SML, Python, and LaTeX Implementations)

1. **Standard ML Formalization (`set_theory_prover/program/types/foundations.ML`, `entries.ML`, and `foundations/examples/mktd_foundations.ML`)**:
   - Decoupled `semantic_completeness_of_F_axm_entry_fm` (Entry 3.73, `AxmSemanticCompletenessOfFullTheory`, `POmnisSem_prf`) and `negation_completeness_of_F_axm_entry_fm` (Entry 3.74, `AxmNegationCompletenessOfFullTheory`, `POmnisNeg_prf`).
   - Implemented `eval_semantic_vs_negation_completeness`, `axiom_semantic_completeness_of_fau` (3.73), and `axiom_negation_completeness_of_fau` (3.74) in `examples/mktd_foundations.ML`, verified in `run_self_tests()` under `poly -q --use`.
2. **Python Formalization (`foundations/logic.py`, `foundations/__init__.py`)**:
   - Implemented `eval_semantic_vs_negation_completeness` verifying decoupled items `3.73` (`AxmSemanticCompletenessOfFullTheory`) and `3.74` (`AxmNegationCompletenessOfFullTheory`) and integrated it into `proves_foundations_logic_and_binder_hygiene`.
3. **LaTeX Exposition (`010_logic.tex`)**:
   - Documented decoupled Entries `3.73` and `3.74` in Section `Reflection and Truth` and Subsection `Decoupled Semantic Adequacy (3.73) vs. Syntactic Negation-Completeness (3.74)` (`prop:tau_vs_fau_completeness`).
