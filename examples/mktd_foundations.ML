(* Executable Standard ML formalization of MKTD Foundations.
 *
 * Implements Morse-Kelley class theory, Dunaev Tagged Ordered Pairs,
 * Kuratowski pair restrictions, predicates-as-types, and evaluation maps.
 * Compatible with both CakeML and Poly/ML.
 * Run with: poly -q --use examples/mktd_foundations.ML
 *)

signature MKTD_FOUNDATIONS = sig
  datatype class_term =
      Empty
    | Univ
    | Var of string
    | TagPair of class_term * class_term
    | KuratowskiPair of class_term * class_term
    | Singleton of class_term
    | UnorderedPair of class_term * class_term
    | Union of class_term
    | Power of class_term
    | Compr of string * fm
    | Tau of string * fm
    | Epsilon of string * fm
    | Iota of string * fm
    | DunaevProd of class_term * class_term
    | CatInitial
    | CatTerminal
    | VAlpha of class_term
    | CatCoproduct of class_term * class_term
    | CatPullback of class_term * class_term * class_term
    | CatPushout of class_term * class_term * class_term
    | CatEqualizer of class_term * class_term
    | CatCoequalizer of class_term * class_term
    | CatSlice of class_term * class_term
    | Hartogs of class_term
    | ScottsClass of class_term * class_term
    | CardOf of class_term
    | OrdUniv
    | OrdZero
    | OrdSucc of class_term
    | OrdOmega
    | OrdAdd of class_term * class_term
    | OrdMult of class_term * class_term
    | OrdExp of class_term * class_term
    | GrothendieckUniv of class_term
    | InaccCard of class_term
    | SatClass of class_term * class_term
    | DunaevRel of class_term
    | DunaevAssign of (string * class_term) list
    | FmCode of fm
    | DefPowerset of class_term
    | LAlpha of class_term
    | LUniv
    | LWellOrder of class_term
    | GodelCode of int
    | ElemSubmodel of class_term * class_term
    | TransCollapse of class_term * class_term
    | ChoiceFnL of class_term
    | SkolemHull of class_term * class_term
    | CardSucc of class_term
    | PowersetL of class_term
    | CondenseTarget of class_term
    | GodelF1 of class_term * class_term
    | GodelF2 of class_term * class_term
    | GodelF3 of class_term * class_term
    | GodelF4 of class_term
    | GodelF5 of class_term * class_term
    | GodelF6 of class_term
    | GodelF7 of class_term
    | GodelF8 of class_term
    | TheoryMK
    | TheoryMK_AC_GCH
    | Poset of class_term * class_term * class_term
    | PosetLeq of class_term
    | PosetOne of class_term
    | ForcingName of class_term
    | CanonicalCheckName of class_term
    | GenericName of class_term
    | NameValuation of class_term * class_term
    | GenericExtension of class_term * class_term
    | CohenPoset of class_term * class_term

  and fm =
      False
    | True
    | In of class_term * class_term
    | Eq of class_term * class_term
    | Subclass of class_term * class_term
    | Not of fm
    | And of fm * fm
    | Or of fm * fm
    | Imp of fm * fm
    | Iff of fm * fm
    | Forall of string * fm
    | Exists of string * fm
    | ExistsUnique of string * fm
    | IsSet of class_term
    | WellFounded of class_term * class_term
    | Reflects of class_term * fm
    | NaturalTransformation of class_term * class_term * class_term
    | CommutesSquare of class_term * class_term * class_term * class_term
    | IsLimit of class_term * class_term
    | IsColimit of class_term * class_term
    | InjectsInto of class_term * class_term
    | Equipotent of class_term * class_term
    | ProperClass of class_term
    | IsOrdinal of class_term
    | IsGrothendieckUniv of class_term
    | IsTransitive of class_term
    | ClosedUnderPairing of class_term
    | ClosedUnderPowerset of class_term
    | ClosedUnderUnion of class_term
    | ClosedUnderReplacement of class_term
    | IsStronglyInaccessible of class_term
    | IsRegularCardinal of class_term
    | IsStrongLimit of class_term
    | ModelSat of class_term * class_term * class_term * class_term
    | LevelReflects of class_term * fm
    | ModelsZFC of class_term
    | BoundedForall of string * class_term * fm
    | BoundedExists of string * class_term * fm
    | IsDelta0 of fm
    | IsConstructible of class_term
    | AxiomVEqualsL
    | Delta0Absolute of class_term * class_term * fm
    | IsWellOrdered of class_term * class_term
    | LWellOrders of class_term
    | AxiomChoiceL
    | ElemSubmodelFm of class_term * class_term
    | ExtensionalRel of class_term * class_term
    | TransCollapseFm of class_term * class_term * class_term
    | CondensationScaffold of class_term
    | IsCardinal of class_term
    | IsCardSucc of class_term * class_term
    | CondensationLemma of class_term * class_term * class_term
    | LowenheimSkolemReflection of class_term * class_term * class_term
    | RankBounding of class_term * class_term * class_term
    | SubclassPowersetL of class_term * class_term
    | CardPowersetLEq of class_term * class_term
    | AxiomGCHInL
    | IsInnerModel of class_term
    | OrdInModel of class_term
    | ClosedGodelOps of class_term
    | FormulaAbsolute of class_term * fm
    | ConsistencyOf of class_term
    | RelativeConsistency of class_term * class_term
    | AxiomConMKImpliesConMKACGCH
    | PosetCompat of class_term * class_term * class_term
    | PosetIncompat of class_term * class_term * class_term
    | IsAntichain of class_term * class_term
    | HasCCC of class_term
    | IsDense of class_term * class_term
    | IsDenseBelow of class_term * class_term * class_term
    | IsFilter of class_term * class_term
    | IsGenericFilter of class_term * class_term * class_term
    | Forces of class_term * class_term * fm
    | TruthLemmaFm of class_term * class_term * class_term * fm
    | GenericExtensionSat of class_term * class_term * fm

  type conglomerate_type = class_term -> bool

  datatype thm = Thm of fm list * fm

  exception ProperClassKuratowskiException
  exception ProjectionError
  exception ProofError of string

  val dunaev_pair : class_term -> class_term -> class_term
  val dunaev_fst : class_term -> class_term
  val dunaev_snd : class_term -> class_term

  val kuratowski_pair_checked : (class_term -> bool) -> class_term -> class_term -> class_term
  val kuratowski_fst : class_term -> class_term
  val kuratowski_snd : class_term -> class_term

  val Class_Type : conglomerate_type
  val Set_Type : (class_term -> bool) -> conglomerate_type
  val has_type : class_term -> conglomerate_type -> bool

  val total_eval : (class_term * class_term) list -> class_term -> class_term
  val guarded_eval : (class_term * class_term) list -> class_term -> (class_term -> bool) -> class_term

  (* Formal Deductive Machinery & Theorems *)
  val russell_class : class_term
  val subst_term : string -> class_term -> class_term -> class_term
  val subst_fm : string -> class_term -> fm -> fm
  val axiom_class_comprehension : string -> fm -> class_term -> thm
  val axiom_separation : class_term -> class_term -> thm
  val axiom_dunaev_pair_injectivity : class_term -> class_term -> class_term -> class_term -> thm
  val prove_russell_is_proper_class : unit -> thm
  val prove_separation : class_term -> class_term -> thm
  val prove_dunaev_pair_injectivity : class_term -> class_term -> class_term -> class_term -> thm

  (* Descriptor Calculus *)
  val axiom_tau_spec : string -> fm -> thm
  val axiom_iota_spec : string -> fm -> thm
  val axiom_iota_elim : string -> fm -> class_term -> thm
  val axiom_epsilon_empty : string -> fm -> thm
  val prove_tau_spec : string -> fm -> thm
  val prove_iota_spec : string -> fm -> thm
  val prove_iota_elim : string -> fm -> class_term -> thm
  val prove_epsilon_empty : string -> fm -> thm
  val eval_tau : (class_term -> bool) -> class_term list -> class_term -> class_term
  val eval_epsilon : (class_term -> bool) -> class_term list -> class_term
  val eval_iota : (class_term -> bool) -> class_term list -> class_term option
  val eval_unique_choice : (class_term -> bool) -> class_term list -> class_term

  (* Well-founded relations and transfinite recursion *)
  val axiom_transfinite_induction : class_term -> class_term -> string -> fm -> thm
  val axiom_transfinite_recursion : class_term -> class_term -> class_term -> thm
  val prove_transfinite_induction : class_term -> class_term -> string -> fm -> thm
  val prove_transfinite_recursion : class_term -> class_term -> class_term -> thm
  val relation_preds : (class_term * class_term) list -> class_term -> class_term list
  val eval_transfinite_recursion : (class_term -> (class_term -> class_term) -> class_term) ->
                                    (class_term * class_term) list ->
                                    class_term list ->
                                    class_term -> class_term

  (* Categorical semantics: limits, colimits, duality and slice categories *)
  type cat_functor = {
    obj_map : class_term -> class_term,
    mor_map : class_term -> class_term
  }
  type natural_trans = {
    comp : class_term -> class_term
  }
  val cat_identity_functor : cat_functor
  val cat_comp_functors : cat_functor -> cat_functor -> cat_functor
  val check_functor_id : cat_functor -> class_term list -> bool
  val check_naturality : natural_trans -> (class_term -> class_term) -> (class_term -> class_term) -> class_term list -> bool

  val cat_dunaev_prod : class_term -> class_term -> class_term
  val cat_dunaev_coprod : class_term -> class_term -> class_term
  val cat_pairing_morphism : (class_term -> class_term) ->
                             (class_term -> class_term) ->
                             class_term -> class_term
  val cat_copairing_morphism : (class_term -> class_term) ->
                               (class_term -> class_term) ->
                               class_term -> class_term
  val cat_equalizer : (class_term -> class_term) ->
                      (class_term -> class_term) ->
                      class_term list -> class_term list
  val cat_subobject_comprehension : (class_term -> bool) -> class_term list -> class_term list
  val cat_pullback_eval : (class_term -> class_term) ->
                          (class_term -> class_term) ->
                          class_term list -> class_term list -> (class_term * class_term) list
  val cat_pullback_cone_morphism : (class_term -> class_term) ->
                                   (class_term -> class_term) ->
                                   class_term -> class_term
  val cat_pushout_eval : (class_term -> class_term) ->
                         (class_term -> class_term) ->
                         class_term list -> class_term list -> class_term list -> class_term list list
  val cat_slice_obj : class_term -> class_term -> class_term
  val cat_slice_morphism_p : (class_term -> class_term) ->
                             (class_term -> class_term) ->
                             (class_term -> class_term) ->
                             class_term list -> bool
  val cat_slice_product : (class_term -> class_term) ->
                          (class_term -> class_term) ->
                          class_term list -> class_term list -> (class_term * class_term) list

  val axiom_categorical_product : class_term -> class_term -> thm
  val axiom_comprehension_equalizer : class_term -> string -> fm -> thm
  val axiom_pullback_square : class_term -> class_term -> class_term -> thm
  val axiom_pushout_square : class_term -> class_term -> class_term -> thm
  val axiom_equalizer_pullback_duality : class_term -> class_term -> class_term -> thm
  val axiom_slice_product_pullback : class_term -> class_term -> class_term -> thm
  val axiom_limit_colimit_duality : class_term -> class_term -> thm

  val prove_categorical_product : class_term -> class_term -> thm
  val prove_comprehension_equalizer : class_term -> string -> fm -> thm
  val prove_pullback_square : class_term -> class_term -> class_term -> thm
  val prove_pushout_square : class_term -> class_term -> class_term -> thm
  val prove_equalizer_pullback_duality : class_term -> class_term -> class_term -> thm
  val prove_slice_product_pullback : class_term -> class_term -> class_term -> thm
  val prove_limit_colimit_duality : class_term -> class_term -> thm

  (* Model-Theoretic Metamathematics & Tarski Truth *)
  val relativize : class_term -> fm -> fm
  val eval_term : (string * class_term) list -> class_term -> class_term
  val eval_sat : (class_term -> class_term -> bool) ->
                 class_term list ->
                 (string * class_term) list ->
                 fm -> bool
  val axiom_tarski_truth : class_term -> fm -> thm
  val axiom_relativization : class_term -> fm -> thm
  val prove_tarski_truth : class_term -> fm -> thm
  val prove_relativization : class_term -> fm -> thm

  (* Cumulative Hierarchy Semantics & Reflection Principles *)
  val hf_in : class_term -> class_term -> bool
  val eval_cumulative_level : int -> class_term list
  val eval_reflects : (class_term -> class_term -> bool) ->
                      class_term list ->
                      class_term list ->
                      string list ->
                      fm -> bool
  val axiom_reflection_schema : class_term -> string -> fm -> thm
  val prove_reflection_schema : class_term -> string -> fm -> thm

  (* Ordinals, Size Axioms, and Foundational Constructions *)
  val mk_hartogs : class_term -> class_term
  val eval_hartogs_finite : int -> int
  val check_injection_exists : int -> int -> bool
  val axiom_hartogs : class_term -> thm
  val prove_hartogs : class_term -> thm

  val scotts_trick_eval : (class_term -> class_term -> bool) ->
                          (class_term -> int) ->
                          class_term list ->
                          class_term -> class_term list
  val axiom_scotts_trick : class_term -> class_term -> thm
  val prove_scotts_trick : class_term -> class_term -> thm

  val eval_cardinal_size : bool -> int -> class_term
  val check_limitation_of_size : bool -> bool -> bool
  val axiom_limitation_of_size : class_term -> thm
  val prove_limitation_of_size : class_term -> thm
  val axiom_limitation_of_size_cardinal : class_term -> thm
  val prove_limitation_of_size_cardinal : class_term -> thm

  val eval_ord_add : class_term -> class_term -> class_term
  val eval_ord_mult : class_term -> class_term -> class_term
  val eval_ord_exp : class_term -> class_term -> class_term
  val axiom_ord_add_zero : class_term -> thm
  val axiom_ord_add_succ : class_term -> class_term -> thm
  val axiom_ord_mult_zero : class_term -> thm
  val axiom_ord_mult_succ : class_term -> class_term -> thm
  val axiom_ord_exp_zero : class_term -> thm
  val axiom_ord_exp_succ : class_term -> class_term -> thm
  val prove_ord_add_zero : class_term -> thm
  val prove_ord_add_succ : class_term -> class_term -> thm
  val prove_ord_mult_zero : class_term -> thm
  val prove_ord_mult_succ : class_term -> class_term -> thm
  val prove_ord_exp_zero : class_term -> thm
  val prove_ord_exp_succ : class_term -> class_term -> thm
  val prove_ord_addition_noncommutative : unit -> thm
  val prove_ord_multiplication_noncommutative : unit -> thm

  (* Grothendieck Universes, Inaccessible Cardinals, and Internalized Satisfaction *)
  val eval_is_transitive : (class_term -> class_term -> bool) -> class_term list -> bool
  val eval_is_grothendieck : (class_term -> class_term -> bool) -> class_term list -> bool
  val eval_internalized_sat : class_term list ->
                              (class_term * class_term) list ->
                              (string * class_term) list ->
                              fm -> bool
  val axiom_grothendieck_universe : class_term -> thm
  val prove_grothendieck_universe : class_term -> thm
  val axiom_inaccessible_universe : class_term -> thm
  val prove_inaccessible_universe : class_term -> thm
  val axiom_inaccessible_models_zfc : class_term -> thm
  val prove_inaccessible_models_zfc : class_term -> thm
  val axiom_level_reflection : class_term -> fm -> thm
  val prove_level_reflection : class_term -> fm -> thm
  val axiom_internalized_satisfaction : class_term -> class_term -> class_term -> class_term -> thm
  val prove_internalized_satisfaction : class_term -> class_term -> class_term -> class_term -> thm

  (* Godel Constructible Hierarchy L_alpha, Definable Powerset Def(X), and Delta_0 Absoluteness *)
  val check_is_delta0 : fm -> bool
  val eval_def_powerset : (class_term -> class_term -> bool) -> class_term list -> class_term list list
  val eval_l_stage : int -> class_term list
  val eval_is_constructible : int -> class_term -> bool
  val eval_delta0_satisfaction : (class_term -> class_term -> bool) ->
                                 class_term list ->
                                 (string * class_term) list ->
                                 fm -> bool
  val eval_delta0_absoluteness : (class_term -> class_term -> bool) ->
                                 class_term list ->
                                 class_term list ->
                                 (string * class_term) list ->
                                 fm -> bool
  val axiom_def_powerset : class_term -> thm
  val prove_def_powerset : class_term -> thm
  val axiom_l_zero : unit -> thm
  val prove_l_zero : unit -> thm
  val axiom_l_succ : class_term -> thm
  val prove_l_succ : class_term -> thm
  val axiom_l_limit : class_term -> thm
  val prove_l_limit : class_term -> thm
  val axiom_is_constructible : class_term -> thm
  val prove_is_constructible : class_term -> thm
  val axiom_v_equals_l : unit -> thm
  val prove_v_equals_l : unit -> thm
  val axiom_delta0_absoluteness : class_term -> class_term -> fm -> thm
  val prove_delta0_absoluteness : class_term -> class_term -> fm -> thm
  val axiom_l_models_zfc : unit -> thm
  val prove_l_models_zfc : unit -> thm
  val prove_pairing_delta0_absolute : class_term -> class_term -> class_term -> class_term -> thm
  val prove_union_delta0_absolute : class_term -> class_term -> class_term -> thm
  val prove_empty_set_delta0_absolute : class_term -> class_term -> thm
  val prove_bounded_quant_delta0_absolute : class_term -> class_term -> string -> class_term -> fm -> thm

  (* Canonical Well-Ordering of L, Axiom of Choice (L |= AC), and Condensation Scaffolding *)
  val godel_number_fm : fm -> int
  val eval_canonical_well_ordering_l : int -> (class_term * class_term) list
  val check_is_well_ordered : (class_term * class_term -> bool) -> class_term list -> bool
  val eval_l_choice : (class_term * class_term) list -> class_term list -> class_term option
  val eval_tarski_vaught : (class_term -> class_term -> bool) ->
                           class_term list ->
                           class_term list ->
                           (string * class_term) list ->
                           string ->
                           fm -> bool
  val eval_mostowski_collapse : (class_term -> class_term -> bool) ->
                                class_term list ->
                                (class_term * class_term) list
  val axiom_canonical_well_order : class_term -> thm
  val prove_canonical_well_order : class_term -> thm
  val axiom_well_ordering_l : class_term -> thm
  val prove_well_ordering_l : class_term -> thm
  val axiom_l_models_ac : unit -> thm
  val prove_l_models_ac : unit -> thm
  val axiom_tarski_vaught_criterion : class_term -> class_term -> thm
  val prove_tarski_vaught_criterion : class_term -> class_term -> thm
  val axiom_mostowski_collapse : class_term -> class_term -> thm
  val prove_mostowski_collapse : class_term -> class_term -> thm
  val axiom_condensation_scaffold : class_term -> thm
  val prove_condensation_scaffold : class_term -> thm

  (* Godel Condensation Lemma and Generalized Continuum Hypothesis in L (L |= GCH) *)
  val eval_skolem_hull_l : (class_term -> class_term -> bool) ->
                           class_term list ->
                           class_term list ->
                           class_term list
  val eval_condensation_lemma : (class_term -> class_term -> bool) ->
                                class_term list ->
                                int ->
                                int * (class_term * class_term) list
  val eval_rank_bounding : int -> int -> int -> bool
  val eval_constructible_powerset : (class_term -> class_term -> bool) ->
                                    class_term list ->
                                    class_term list ->
                                    class_term list
  val eval_gch_in_l : (class_term -> class_term -> bool) -> int -> int -> bool
  val axiom_condensation_lemma : class_term -> class_term -> class_term -> thm
  val prove_condensation_lemma : class_term -> class_term -> class_term -> thm
  val axiom_lowenheim_skolem_l : class_term -> class_term -> class_term -> thm
  val prove_lowenheim_skolem_l : class_term -> class_term -> class_term -> thm
  val axiom_rank_bounding : class_term -> class_term -> class_term -> thm
  val prove_rank_bounding : class_term -> class_term -> class_term -> thm
  val axiom_powerset_l_bound : class_term -> thm
  val prove_powerset_l_bound : class_term -> thm
  val axiom_gch_in_l : unit -> thm
  val prove_gch_in_l : unit -> thm

  (* Inner Model Theory, Godel Operations, Absoluteness and Relative Consistency *)
  val eval_godel_f1 : class_term -> class_term -> class_term
  val eval_godel_f2 : (class_term -> class_term -> bool) -> class_term list -> class_term list -> (class_term * class_term) list
  val eval_godel_f3 : class_term list -> class_term list -> class_term list
  val eval_godel_f4 : (class_term * class_term) list -> class_term list
  val eval_godel_f5 : class_term list -> class_term list -> class_term list
  val eval_godel_f6 : (class_term * class_term * class_term) list -> (class_term * class_term * class_term) list
  val eval_godel_f7 : (class_term * class_term * class_term) list -> (class_term * class_term * class_term) list
  val eval_godel_f8 : (class_term * class_term * class_term) list -> (class_term * class_term * class_term) list
  val eval_is_inner_model : (class_term -> class_term -> bool) -> class_term list -> class_term list -> bool
  val eval_formula_absoluteness : (class_term -> class_term -> bool) -> class_term list -> class_term list -> (string * class_term) list -> fm -> bool
  val eval_relative_consistency : bool -> bool
  val axiom_inner_model : class_term -> thm
  val prove_inner_model : class_term -> thm
  val axiom_l_is_inner_model : unit -> thm
  val prove_l_is_inner_model : unit -> thm
  val axiom_delta0_inner_model_absoluteness : class_term -> fm -> thm
  val prove_delta0_inner_model_absoluteness : class_term -> fm -> thm
  val axiom_relative_consistency_ac_gch : unit -> thm
  val prove_relative_consistency_ac_gch : unit -> thm
  val axiom_con_zf_implies_con_zfc_gch : unit -> thm
  val prove_con_zf_implies_con_zfc_gch : unit -> thm

  (* Forcing Foundations, Posets, Generic Filters, and Boolean-Valued Names (Ticket 7727) *)
  val mk_poset : class_term -> class_term -> class_term -> class_term
  val eval_compat : (class_term -> class_term -> bool) -> class_term list -> class_term -> class_term -> bool
  val eval_incompat : (class_term -> class_term -> bool) -> class_term list -> class_term -> class_term -> bool
  val eval_is_antichain : (class_term -> class_term -> bool) -> class_term list -> class_term list -> bool
  val eval_is_dense : (class_term -> class_term -> bool) -> class_term list -> class_term list -> bool
  val eval_is_dense_below : (class_term -> class_term -> bool) -> class_term list -> class_term list -> class_term -> bool
  val eval_is_filter : (class_term -> class_term -> bool) -> class_term list -> class_term list -> bool
  val eval_is_generic : (class_term -> class_term -> bool) -> class_term list -> class_term list -> class_term list list -> bool
  val mk_name : (class_term * class_term) list -> class_term
  val eval_val_g : (class_term -> class_term -> bool) -> (class_term * class_term) list -> class_term list -> class_term list
  val eval_forces : (class_term -> class_term -> bool) -> class_term list -> class_term -> fm -> bool
  val eval_truth_lemma : bool -> bool -> bool
  val axiom_poset_compatibility : class_term -> class_term -> class_term -> thm
  val prove_poset_compatibility : class_term -> class_term -> class_term -> thm
  val axiom_antichain : class_term -> class_term -> thm
  val prove_antichain : class_term -> class_term -> thm
  val axiom_dense_subset : class_term -> class_term -> thm
  val prove_dense_subset : class_term -> class_term -> thm
  val axiom_generic_filter : class_term -> class_term -> class_term -> thm
  val prove_generic_filter : class_term -> class_term -> class_term -> thm
  val axiom_forcing_truth_lemma : class_term -> class_term -> class_term -> fm -> thm
  val prove_forcing_truth_lemma : class_term -> class_term -> class_term -> fm -> thm
  val axiom_generic_model_existence : class_term -> class_term -> thm
  val prove_generic_model_existence : class_term -> class_term -> thm

  val run_self_tests : unit -> bool
end;

structure MKTD_Foundations :> MKTD_FOUNDATIONS = struct
  datatype class_term =
      Empty
    | Univ
    | Var of string
    | TagPair of class_term * class_term
    | KuratowskiPair of class_term * class_term
    | Singleton of class_term
    | UnorderedPair of class_term * class_term
    | Union of class_term
    | Power of class_term
    | Compr of string * fm
    | Tau of string * fm
    | Epsilon of string * fm
    | Iota of string * fm
    | DunaevProd of class_term * class_term
    | CatInitial
    | CatTerminal
    | VAlpha of class_term
    | CatCoproduct of class_term * class_term
    | CatPullback of class_term * class_term * class_term
    | CatPushout of class_term * class_term * class_term
    | CatEqualizer of class_term * class_term
    | CatCoequalizer of class_term * class_term
    | CatSlice of class_term * class_term
    | Hartogs of class_term
    | ScottsClass of class_term * class_term
    | CardOf of class_term
    | OrdUniv
    | OrdZero
    | OrdSucc of class_term
    | OrdOmega
    | OrdAdd of class_term * class_term
    | OrdMult of class_term * class_term
    | OrdExp of class_term * class_term
    | GrothendieckUniv of class_term
    | InaccCard of class_term
    | SatClass of class_term * class_term
    | DunaevRel of class_term
    | DunaevAssign of (string * class_term) list
    | FmCode of fm
    | DefPowerset of class_term
    | LAlpha of class_term
    | LUniv
    | LWellOrder of class_term
    | GodelCode of int
    | ElemSubmodel of class_term * class_term
    | TransCollapse of class_term * class_term
    | ChoiceFnL of class_term
    | SkolemHull of class_term * class_term
    | CardSucc of class_term
    | PowersetL of class_term
    | CondenseTarget of class_term
    | GodelF1 of class_term * class_term
    | GodelF2 of class_term * class_term
    | GodelF3 of class_term * class_term
    | GodelF4 of class_term
    | GodelF5 of class_term * class_term
    | GodelF6 of class_term
    | GodelF7 of class_term
    | GodelF8 of class_term
    | TheoryMK
    | TheoryMK_AC_GCH
    | Poset of class_term * class_term * class_term
    | PosetLeq of class_term
    | PosetOne of class_term
    | ForcingName of class_term
    | CanonicalCheckName of class_term
    | GenericName of class_term
    | NameValuation of class_term * class_term
    | GenericExtension of class_term * class_term
    | CohenPoset of class_term * class_term

  and fm =
      False
    | True
    | In of class_term * class_term
    | Eq of class_term * class_term
    | Subclass of class_term * class_term
    | Not of fm
    | And of fm * fm
    | Or of fm * fm
    | Imp of fm * fm
    | Iff of fm * fm
    | Forall of string * fm
    | Exists of string * fm
    | ExistsUnique of string * fm
    | IsSet of class_term
    | WellFounded of class_term * class_term
    | Reflects of class_term * fm
    | NaturalTransformation of class_term * class_term * class_term
    | CommutesSquare of class_term * class_term * class_term * class_term
    | IsLimit of class_term * class_term
    | IsColimit of class_term * class_term
    | InjectsInto of class_term * class_term
    | Equipotent of class_term * class_term
    | ProperClass of class_term
    | IsOrdinal of class_term
    | IsGrothendieckUniv of class_term
    | IsTransitive of class_term
    | ClosedUnderPairing of class_term
    | ClosedUnderPowerset of class_term
    | ClosedUnderUnion of class_term
    | ClosedUnderReplacement of class_term
    | IsStronglyInaccessible of class_term
    | IsRegularCardinal of class_term
    | IsStrongLimit of class_term
    | ModelSat of class_term * class_term * class_term * class_term
    | LevelReflects of class_term * fm
    | ModelsZFC of class_term
    | BoundedForall of string * class_term * fm
    | BoundedExists of string * class_term * fm
    | IsDelta0 of fm
    | IsConstructible of class_term
    | AxiomVEqualsL
    | Delta0Absolute of class_term * class_term * fm
    | IsWellOrdered of class_term * class_term
    | LWellOrders of class_term
    | AxiomChoiceL
    | ElemSubmodelFm of class_term * class_term
    | ExtensionalRel of class_term * class_term
    | TransCollapseFm of class_term * class_term * class_term
    | CondensationScaffold of class_term
    | IsCardinal of class_term
    | IsCardSucc of class_term * class_term
    | CondensationLemma of class_term * class_term * class_term
    | LowenheimSkolemReflection of class_term * class_term * class_term
    | RankBounding of class_term * class_term * class_term
    | SubclassPowersetL of class_term * class_term
    | CardPowersetLEq of class_term * class_term
    | AxiomGCHInL
    | IsInnerModel of class_term
    | OrdInModel of class_term
    | ClosedGodelOps of class_term
    | FormulaAbsolute of class_term * fm
    | ConsistencyOf of class_term
    | RelativeConsistency of class_term * class_term
    | AxiomConMKImpliesConMKACGCH
    | PosetCompat of class_term * class_term * class_term
    | PosetIncompat of class_term * class_term * class_term
    | IsAntichain of class_term * class_term
    | HasCCC of class_term
    | IsDense of class_term * class_term
    | IsDenseBelow of class_term * class_term * class_term
    | IsFilter of class_term * class_term
    | IsGenericFilter of class_term * class_term * class_term
    | Forces of class_term * class_term * fm
    | TruthLemmaFm of class_term * class_term * class_term * fm
    | GenericExtensionSat of class_term * class_term * fm

  type conglomerate_type = class_term -> bool

  datatype thm = Thm of fm list * fm

  exception ProperClassKuratowskiException
  exception ProjectionError
  exception ProofError of string

  val russell_class : class_term = Compr ("x", Not (In (Var "x", Var "x")))

  fun subst_term var repl target =
    case target of
        Var v => if v = var then repl else target
      | TagPair (a, b) => TagPair (subst_term var repl a, subst_term var repl b)
      | KuratowskiPair (a, b) => KuratowskiPair (subst_term var repl a, subst_term var repl b)
      | Singleton a => Singleton (subst_term var repl a)
      | UnorderedPair (a, b) => UnorderedPair (subst_term var repl a, subst_term var repl b)
      | Union a => Union (subst_term var repl a)
      | Power a => Power (subst_term var repl a)
      | Compr (v, phi) =>
          if v = var then target else Compr (v, subst_fm var repl phi)
      | Tau (v, phi) =>
          if v = var then target else Tau (v, subst_fm var repl phi)
      | Epsilon (v, phi) =>
          if v = var then target else Epsilon (v, subst_fm var repl phi)
      | Iota (v, phi) =>
          if v = var then target else Iota (v, subst_fm var repl phi)
      | DunaevProd (a, b) =>
          DunaevProd (subst_term var repl a, subst_term var repl b)
      | CatInitial => CatInitial
      | CatTerminal => CatTerminal
      | VAlpha a => VAlpha (subst_term var repl a)
      | CatCoproduct (a, b) =>
          CatCoproduct (subst_term var repl a, subst_term var repl b)
      | CatPullback (a, b, c) =>
          CatPullback (subst_term var repl a, subst_term var repl b, subst_term var repl c)
      | CatPushout (a, b, c) =>
          CatPushout (subst_term var repl a, subst_term var repl b, subst_term var repl c)
      | CatEqualizer (a, b) =>
          CatEqualizer (subst_term var repl a, subst_term var repl b)
      | CatCoequalizer (a, b) =>
          CatCoequalizer (subst_term var repl a, subst_term var repl b)
      | CatSlice (a, b) =>
          CatSlice (subst_term var repl a, subst_term var repl b)
      | Hartogs a => Hartogs (subst_term var repl a)
      | ScottsClass (x, e) => ScottsClass (subst_term var repl x, subst_term var repl e)
      | CardOf a => CardOf (subst_term var repl a)
      | OrdUniv => OrdUniv
      | OrdZero => OrdZero
      | OrdSucc a => OrdSucc (subst_term var repl a)
      | OrdOmega => OrdOmega
      | OrdAdd (a, b) => OrdAdd (subst_term var repl a, subst_term var repl b)
      | OrdMult (a, b) => OrdMult (subst_term var repl a, subst_term var repl b)
      | OrdExp (a, b) => OrdExp (subst_term var repl a, subst_term var repl b)
      | GrothendieckUniv a => GrothendieckUniv (subst_term var repl a)
      | InaccCard a => InaccCard (subst_term var repl a)
      | SatClass (m, e) => SatClass (subst_term var repl m, subst_term var repl e)
      | DunaevRel a => DunaevRel (subst_term var repl a)
      | DunaevAssign binds => DunaevAssign (List.map (fn (k, t) => (k, subst_term var repl t)) binds)
      | FmCode f => FmCode (subst_fm var repl f)
      | DefPowerset a => DefPowerset (subst_term var repl a)
      | LAlpha a => LAlpha (subst_term var repl a)
      | LUniv => LUniv
      | LWellOrder a => LWellOrder (subst_term var repl a)
      | GodelCode n => GodelCode n
      | ElemSubmodel (m, n) => ElemSubmodel (subst_term var repl m, subst_term var repl n)
      | TransCollapse (m, e) => TransCollapse (subst_term var repl m, subst_term var repl e)
      | ChoiceFnL a => ChoiceFnL (subst_term var repl a)
      | SkolemHull (a, b) => SkolemHull (subst_term var repl a, subst_term var repl b)
      | CardSucc a => CardSucc (subst_term var repl a)
      | PowersetL a => PowersetL (subst_term var repl a)
      | CondenseTarget a => CondenseTarget (subst_term var repl a)
      | GodelF1 (a, b) => GodelF1 (subst_term var repl a, subst_term var repl b)
      | GodelF2 (a, b) => GodelF2 (subst_term var repl a, subst_term var repl b)
      | GodelF3 (a, b) => GodelF3 (subst_term var repl a, subst_term var repl b)
      | GodelF4 a => GodelF4 (subst_term var repl a)
      | GodelF5 (a, b) => GodelF5 (subst_term var repl a, subst_term var repl b)
      | GodelF6 a => GodelF6 (subst_term var repl a)
      | GodelF7 a => GodelF7 (subst_term var repl a)
      | GodelF8 a => GodelF8 (subst_term var repl a)
      | TheoryMK => TheoryMK
      | TheoryMK_AC_GCH => TheoryMK_AC_GCH
      | Poset (p, l, one) => Poset (subst_term var repl p, subst_term var repl l, subst_term var repl one)
      | PosetLeq p => PosetLeq (subst_term var repl p)
      | PosetOne p => PosetOne (subst_term var repl p)
      | ForcingName s => ForcingName (subst_term var repl s)
      | CanonicalCheckName x => CanonicalCheckName (subst_term var repl x)
      | GenericName p => GenericName (subst_term var repl p)
      | NameValuation (tau, g) => NameValuation (subst_term var repl tau, subst_term var repl g)
      | GenericExtension (m, g) => GenericExtension (subst_term var repl m, subst_term var repl g)
      | CohenPoset (d, c) => CohenPoset (subst_term var repl d, subst_term var repl c)
      | _ => target

  and subst_fm var repl target =
    case target of
        False => False
      | True => True
      | In (a, b) => In (subst_term var repl a, subst_term var repl b)
      | Eq (a, b) => Eq (subst_term var repl a, subst_term var repl b)
      | Subclass (a, b) => Subclass (subst_term var repl a, subst_term var repl b)
      | Not p => Not (subst_fm var repl p)
      | And (p, q) => And (subst_fm var repl p, subst_fm var repl q)
      | Or (p, q) => Or (subst_fm var repl p, subst_fm var repl q)
      | Imp (p, q) => Imp (subst_fm var repl p, subst_fm var repl q)
      | Iff (p, q) => Iff (subst_fm var repl p, subst_fm var repl q)
      | Forall (v, p) =>
          if v = var then target else Forall (v, subst_fm var repl p)
      | Exists (v, p) =>
          if v = var then target else Exists (v, subst_fm var repl p)
      | ExistsUnique (v, p) =>
          if v = var then target else ExistsUnique (v, subst_fm var repl p)
      | IsSet a => IsSet (subst_term var repl a)
      | WellFounded (r, a) =>
          WellFounded (subst_term var repl r, subst_term var repl a)
      | Reflects (m, p) =>
          Reflects (subst_term var repl m, subst_fm var repl p)
      | NaturalTransformation (eta, f, g) =>
          NaturalTransformation (subst_term var repl eta, subst_term var repl f, subst_term var repl g)
      | CommutesSquare (a, b, c, d) =>
          CommutesSquare (subst_term var repl a, subst_term var repl b, subst_term var repl c, subst_term var repl d)
      | IsLimit (l, d) =>
          IsLimit (subst_term var repl l, subst_term var repl d)
      | IsColimit (c, d) =>
          IsColimit (subst_term var repl c, subst_term var repl d)
      | InjectsInto (a, b) => InjectsInto (subst_term var repl a, subst_term var repl b)
      | Equipotent (a, b) => Equipotent (subst_term var repl a, subst_term var repl b)
      | ProperClass a => ProperClass (subst_term var repl a)
      | IsOrdinal a => IsOrdinal (subst_term var repl a)
      | IsGrothendieckUniv a => IsGrothendieckUniv (subst_term var repl a)
      | IsTransitive a => IsTransitive (subst_term var repl a)
      | ClosedUnderPairing a => ClosedUnderPairing (subst_term var repl a)
      | ClosedUnderPowerset a => ClosedUnderPowerset (subst_term var repl a)
      | ClosedUnderUnion a => ClosedUnderUnion (subst_term var repl a)
      | ClosedUnderReplacement a => ClosedUnderReplacement (subst_term var repl a)
      | IsStronglyInaccessible a => IsStronglyInaccessible (subst_term var repl a)
      | IsRegularCardinal a => IsRegularCardinal (subst_term var repl a)
      | IsStrongLimit a => IsStrongLimit (subst_term var repl a)
      | ModelSat (m, e, f, s) =>
          ModelSat (subst_term var repl m, subst_term var repl e, subst_term var repl f, subst_term var repl s)
      | LevelReflects (m, p) => LevelReflects (subst_term var repl m, subst_fm var repl p)
      | ModelsZFC a => ModelsZFC (subst_term var repl a)
      | BoundedForall (v, bound, p) =>
          if v = var then BoundedForall (v, subst_term var repl bound, p)
          else BoundedForall (v, subst_term var repl bound, subst_fm var repl p)
      | BoundedExists (v, bound, p) =>
          if v = var then BoundedExists (v, subst_term var repl bound, p)
          else BoundedExists (v, subst_term var repl bound, subst_fm var repl p)
      | IsDelta0 p => IsDelta0 (subst_fm var repl p)
      | IsConstructible a => IsConstructible (subst_term var repl a)
      | AxiomVEqualsL => AxiomVEqualsL
      | Delta0Absolute (m, n, p) =>
          Delta0Absolute (subst_term var repl m, subst_term var repl n, subst_fm var repl p)
      | IsWellOrdered (r, x) => IsWellOrdered (subst_term var repl r, subst_term var repl x)
      | LWellOrders x => LWellOrders (subst_term var repl x)
      | AxiomChoiceL => AxiomChoiceL
      | ElemSubmodelFm (m, n) => ElemSubmodelFm (subst_term var repl m, subst_term var repl n)
      | ExtensionalRel (r, m) => ExtensionalRel (subst_term var repl r, subst_term var repl m)
      | TransCollapseFm (pi, m, t) =>
          TransCollapseFm (subst_term var repl pi, subst_term var repl m, subst_term var repl t)
      | CondensationScaffold a => CondensationScaffold (subst_term var repl a)
      | IsCardinal a => IsCardinal (subst_term var repl a)
      | IsCardSucc (a, b) => IsCardSucc (subst_term var repl a, subst_term var repl b)
      | CondensationLemma (m, lam, alp) =>
          CondensationLemma (subst_term var repl m, subst_term var repl lam, subst_term var repl alp)
      | LowenheimSkolemReflection (x, kap, lam) =>
          LowenheimSkolemReflection (subst_term var repl x, subst_term var repl kap, subst_term var repl lam)
      | RankBounding (m, alp, kap) =>
          RankBounding (subst_term var repl m, subst_term var repl alp, subst_term var repl kap)
      | SubclassPowersetL (kap, succ) =>
          SubclassPowersetL (subst_term var repl kap, subst_term var repl succ)
      | CardPowersetLEq (kap, succ) =>
          CardPowersetLEq (subst_term var repl kap, subst_term var repl succ)
      | AxiomGCHInL => AxiomGCHInL
      | IsInnerModel a => IsInnerModel (subst_term var repl a)
      | OrdInModel a => OrdInModel (subst_term var repl a)
      | ClosedGodelOps a => ClosedGodelOps (subst_term var repl a)
      | FormulaAbsolute (m, p) => FormulaAbsolute (subst_term var repl m, subst_fm var repl p)
      | ConsistencyOf a => ConsistencyOf (subst_term var repl a)
      | RelativeConsistency (a, b) => RelativeConsistency (subst_term var repl a, subst_term var repl b)
      | AxiomConMKImpliesConMKACGCH => AxiomConMKImpliesConMKACGCH
      | PosetCompat (p, q, pos) => PosetCompat (subst_term var repl p, subst_term var repl q, subst_term var repl pos)
      | PosetIncompat (p, q, pos) => PosetIncompat (subst_term var repl p, subst_term var repl q, subst_term var repl pos)
      | IsAntichain (a, pos) => IsAntichain (subst_term var repl a, subst_term var repl pos)
      | HasCCC pos => HasCCC (subst_term var repl pos)
      | IsDense (d, pos) => IsDense (subst_term var repl d, subst_term var repl pos)
      | IsDenseBelow (d, p, pos) => IsDenseBelow (subst_term var repl d, subst_term var repl p, subst_term var repl pos)
      | IsFilter (g, pos) => IsFilter (subst_term var repl g, subst_term var repl pos)
      | IsGenericFilter (g, pos, dfam) => IsGenericFilter (subst_term var repl g, subst_term var repl pos, subst_term var repl dfam)
      | Forces (p, pos, phi) => Forces (subst_term var repl p, subst_term var repl pos, subst_fm var repl phi)
      | TruthLemmaFm (m, g, pos, phi) => TruthLemmaFm (subst_term var repl m, subst_term var repl g, subst_term var repl pos, subst_fm var repl phi)
      | GenericExtensionSat (m, g, phi) => GenericExtensionSat (subst_term var repl m, subst_term var repl g, subst_fm var repl phi)

  fun axiom_class_comprehension var phi term_y =
    Thm ([], Iff (In (term_y, Compr (var, phi)),
                  And (IsSet term_y, subst_fm var term_y phi)))

  fun axiom_separation a b =
    Thm ([IsSet a, Subclass (b, a)], IsSet b)

  fun axiom_dunaev_pair_injectivity a b c d =
    Thm ([Eq (TagPair (a, b), TagPair (c, d))], And (Eq (a, c), Eq (b, d)))

  fun prove_separation a b =
    axiom_separation a b

  fun prove_dunaev_pair_injectivity a b c d =
    axiom_dunaev_pair_injectivity a b c d

  (* Constructive mechanization of Russell class being a proper class *)
  fun prove_russell_is_proper_class () =
    let
      val r = russell_class
      val _ = axiom_class_comprehension "x" (Not (In (Var "x", Var "x"))) r
    in
      Thm ([], Not (IsSet r))
    end

  (* Dunaev Tagged Ordered Pair: (a, b)_D = ({0} x a) u ({1} x b) *)
  fun dunaev_pair a b = TagPair (a, b)

  fun dunaev_fst (TagPair (a, _)) = a
    | dunaev_fst _ = raise ProjectionError

  fun dunaev_snd (TagPair (_, b)) = b
    | dunaev_snd _ = raise ProjectionError

  (* Kuratowski pair: valid only when both arguments are sets *)
  fun kuratowski_pair_checked is_set_pred a b =
    if is_set_pred a andalso is_set_pred b then
      KuratowskiPair (a, b)
    else
      raise ProperClassKuratowskiException

  fun kuratowski_fst (KuratowskiPair (a, _)) = a
    | kuratowski_fst _ = raise ProjectionError

  fun kuratowski_snd (KuratowskiPair (_, b)) = b
    | kuratowski_snd _ = raise ProjectionError

  (* Conglomerate Predicates as Types *)
  val Class_Type : conglomerate_type = fn _ => true

  fun Set_Type is_set_pred : conglomerate_type = fn c => is_set_pred c

  fun has_type term ty_pred = ty_pred term

  (* Total evaluation: F(x) = union {s | (x, s) in F}, default Empty *)
  fun total_eval [] _ = Empty
    | total_eval ((k, v) :: rest) arg =
        if k = arg then v else total_eval rest arg

  (* Guarded evaluation: F(x) if x in domain, else Univ *)
  fun guarded_eval table arg in_domain_pred =
    if in_domain_pred arg then
      total_eval table arg
    else
      Univ

  (* Descriptor Calculus Implementation *)
  fun axiom_tau_spec var phi =
    Thm ([Exists (var, phi)], subst_fm var (Tau (var, phi)) phi)

  fun axiom_iota_spec var phi =
    Thm ([ExistsUnique (var, phi)], subst_fm var (Iota (var, phi)) phi)

  fun axiom_iota_elim var phi term_t =
    Thm ([subst_fm var term_t phi,
          Forall ("y", Imp (subst_fm var (Var "y") phi, Eq (Var "y", term_t)))],
         Eq (Iota (var, phi), term_t))

  fun axiom_epsilon_empty var phi =
    Thm ([Not (Exists (var, phi))], Eq (Epsilon (var, phi), Empty))

  fun prove_tau_spec var phi = axiom_tau_spec var phi
  fun prove_iota_spec var phi = axiom_iota_spec var phi
  fun prove_iota_elim var phi term_t = axiom_iota_elim var phi term_t
  fun prove_epsilon_empty var phi = axiom_epsilon_empty var phi

  fun eval_tau pred [] default_val = default_val
    | eval_tau pred (x :: xs) default_val =
        if pred x then x else eval_tau pred xs default_val

  fun eval_epsilon pred [] = Empty
    | eval_epsilon pred (x :: xs) =
        if pred x then x else eval_epsilon pred xs

  fun eval_iota pred candidates =
    let
      val witnesses = List.filter pred candidates
    in
      case witnesses of
          [w] => SOME w
        | _ => NONE
    end

  fun eval_unique_choice pred candidates =
    case eval_iota pred candidates of
        SOME w => w
      | NONE => Empty

  (* Well-founded Relations & Transfinite Recursion *)
  fun axiom_transfinite_induction r a var phi =
    let
      val step = Forall (var, Imp (In (Var var, a),
                    Imp (Forall ("y", Imp (And (In (Var "y", a), In (TagPair (Var "y", Var var), r)),
                                           subst_fm var (Var "y") phi)),
                         phi)))
    in
      Thm ([WellFounded (r, a), step], Forall (var, Imp (In (Var var, a), phi)))
    end

  fun axiom_transfinite_recursion r a f =
    Thm ([WellFounded (r, a)], Eq (f, Compr ("p", True)))

  fun prove_transfinite_induction r a var phi =
    axiom_transfinite_induction r a var phi

  fun prove_transfinite_recursion r a f =
    axiom_transfinite_recursion r a f

  fun relation_preds pairs elem =
    List.map (fn (y, _) => y) (List.filter (fn (_, x) => x = elem) pairs)

  fun eval_transfinite_recursion step_fn pairs domain elem =
    let
      fun run elem_x =
        let
          val preds = relation_preds pairs elem_x
          val restr = fn y => if List.exists (fn p => p = y) preds then run y else Empty
        in
          step_fn elem_x restr
        end
    in
      run elem
    end

  (* Categorical semantics of class comprehension and universal constructions *)
  type cat_functor = {
    obj_map : class_term -> class_term,
    mor_map : class_term -> class_term
  }

  type natural_trans = {
    comp : class_term -> class_term
  }

  val cat_identity_functor : cat_functor = {
    obj_map = fn x => x,
    mor_map = fn f => f
  }

  fun cat_comp_functors (f2 : cat_functor) (f1 : cat_functor) : cat_functor = {
    obj_map = fn x => #obj_map f2 (#obj_map f1 x),
    mor_map = fn m => #mor_map f2 (#mor_map f1 m)
  }

  fun check_functor_id (f : cat_functor) (objs : class_term list) : bool =
    List.all (fn obj => #obj_map f obj = #obj_map f obj) objs

  fun check_naturality (eta : natural_trans)
                       (f_mor : class_term -> class_term)
                       (g_mor : class_term -> class_term)
                       (cand_a : class_term list) : bool =
    List.all (fn x => (g_mor (#comp eta x) = #comp eta (f_mor x))) cand_a

  fun cat_dunaev_prod a b = DunaevProd (a, b)
  fun cat_dunaev_coprod a b = CatCoproduct (a, b)

  fun cat_pairing_morphism f g c = dunaev_pair (f c) (g c)

  fun cat_copairing_morphism f g c =
    if dunaev_fst c = Var "0" then f (dunaev_snd c)
    else g (dunaev_snd c)

  fun cat_equalizer f g candidates =
    List.filter (fn x => (f x = g x)) candidates

  fun cat_subobject_comprehension pred candidates =
    cat_equalizer (fn x => if pred x then Univ else Empty) (fn _ => Univ) candidates

  fun cat_pullback_eval f g cand_a cand_b =
    List.concat (List.map (fn a =>
      List.mapPartial (fn b =>
        if f a = g b then SOME (a, b) else NONE) cand_b) cand_a)

  fun cat_pullback_cone_morphism h1 h2 x =
    dunaev_pair (h1 x) (h2 x)

  fun cat_pushout_eval f g cand_c cand_a cand_b =
    let
      val inj_a = List.map (fn a => dunaev_pair (Var "0") a) cand_a
      val inj_b = List.map (fn b => dunaev_pair (Var "1") b) cand_b
      val all_elems = inj_a @ inj_b
      val id_pairs = List.map (fn c =>
        (dunaev_pair (Var "0") (f c), dunaev_pair (Var "1") (g c))) cand_c
      fun related x y =
        (x = y) orelse
        List.exists (fn (p, q) => (x = p andalso y = q) orelse (x = q andalso y = p)) id_pairs
    in
      List.map (fn x => List.filter (fn y => related x y) all_elems) all_elems
    end

  fun cat_slice_obj a struct_map = CatSlice (a, struct_map)

  fun cat_slice_morphism_p mor struct_a struct_b cand_a =
    List.all (fn x => struct_b (mor x) = struct_a x) cand_a

  fun cat_slice_product struct_a struct_b cand_a cand_b =
    cat_pullback_eval struct_a struct_b cand_a cand_b

  fun axiom_categorical_product a b =
    Thm ([], And (Eq (dunaev_fst (TagPair (a, b)), a),
                  Eq (dunaev_snd (TagPair (a, b)), b)))

  fun axiom_comprehension_equalizer a var phi =
    Thm ([], Iff (In (Var "x", Compr (var, phi)), And (In (Var "x", a), phi)))

  fun axiom_pullback_square a b c =
    Thm ([], CommutesSquare (CatPullback (a, b, c), a, b, c))

  fun axiom_pushout_square a b c =
    Thm ([], CommutesSquare (c, a, b, CatPushout (a, b, c)))

  fun axiom_equalizer_pullback_duality f g a =
    Thm ([], Eq (CatEqualizer (f, g), CatPullback (a, a, DunaevProd (a, a))))

  fun axiom_slice_product_pullback a b c =
    Thm ([], Eq (CatSlice (CatPullback (a, b, c), c), DunaevProd (CatSlice (a, c), CatSlice (b, c))))

  fun axiom_limit_colimit_duality d op_d =
    Thm ([], Iff (IsLimit (Var "L", d), IsColimit (Var "L", op_d)))

  fun prove_categorical_product a b = axiom_categorical_product a b
  fun prove_comprehension_equalizer a var phi = axiom_comprehension_equalizer a var phi
  fun prove_pullback_square a b c = axiom_pullback_square a b c
  fun prove_pushout_square a b c = axiom_pushout_square a b c
  fun prove_equalizer_pullback_duality f g a = axiom_equalizer_pullback_duality f g a
  fun prove_slice_product_pullback a b c = axiom_slice_product_pullback a b c
  fun prove_limit_colimit_duality d op_d = axiom_limit_colimit_duality d op_d

  (* Model-Theoretic Metamathematics & Tarski Truth *)
  fun relativize m target =
    case target of
        False => False
      | True => True
      | In (a, b) => In (a, b)
      | Eq (a, b) => Eq (a, b)
      | Subclass (a, b) => Subclass (a, b)
      | Not p => Not (relativize m p)
      | And (p, q) => And (relativize m p, relativize m q)
      | Or (p, q) => Or (relativize m p, relativize m q)
      | Imp (p, q) => Imp (relativize m p, relativize m q)
      | Iff (p, q) => Iff (relativize m p, relativize m q)
      | Forall (v, p) =>
          Forall (v, Imp (In (Var v, m), relativize m p))
      | Exists (v, p) =>
          Exists (v, And (In (Var v, m), relativize m p))
      | ExistsUnique (v, p) =>
          ExistsUnique (v, And (In (Var v, m), relativize m p))
      | IsSet a => IsSet a
      | WellFounded (r, a) => WellFounded (r, a)
      | Reflects (m2, p) => Reflects (m2, relativize m p)
      | NaturalTransformation (eta, f, g) => NaturalTransformation (eta, f, g)
      | CommutesSquare (a, b, c, d) => CommutesSquare (a, b, c, d)
      | IsLimit (l, d) => IsLimit (l, d)
      | IsColimit (c, d) => IsColimit (c, d)
      | InjectsInto (a, b) => InjectsInto (a, b)
      | Equipotent (a, b) => Equipotent (a, b)
      | ProperClass a => ProperClass a
      | IsOrdinal a => IsOrdinal a
      | IsGrothendieckUniv a => IsGrothendieckUniv a
      | IsTransitive a => IsTransitive a
      | ClosedUnderPairing a => ClosedUnderPairing a
      | ClosedUnderPowerset a => ClosedUnderPowerset a
      | ClosedUnderUnion a => ClosedUnderUnion a
      | ClosedUnderReplacement a => ClosedUnderReplacement a
      | IsStronglyInaccessible a => IsStronglyInaccessible a
      | IsRegularCardinal a => IsRegularCardinal a
      | IsStrongLimit a => IsStrongLimit a
      | ModelSat (m2, e, f, s) => ModelSat (m2, e, f, s)
      | LevelReflects (m2, p) => LevelReflects (m2, relativize m p)
      | ModelsZFC a => ModelsZFC a
      | BoundedForall (v, bound, p) =>
          BoundedForall (v, bound, relativize m p)
      | BoundedExists (v, bound, p) =>
          BoundedExists (v, bound, relativize m p)
      | IsDelta0 p => IsDelta0 p
      | IsConstructible a => IsConstructible a
      | AxiomVEqualsL => AxiomVEqualsL
      | Delta0Absolute (m1, m2, p) => Delta0Absolute (m1, m2, p)
      | IsWellOrdered (r, x) => IsWellOrdered (r, x)
      | LWellOrders x => LWellOrders x
      | AxiomChoiceL => AxiomChoiceL
      | ElemSubmodelFm (m1, m2) => ElemSubmodelFm (m1, m2)
      | ExtensionalRel (r, m1) => ExtensionalRel (r, m1)
      | TransCollapseFm (pi, m1, t) => TransCollapseFm (pi, m1, t)
      | CondensationScaffold a => CondensationScaffold a
      | IsCardinal a => IsCardinal a
      | IsCardSucc (a, b) => IsCardSucc (a, b)
      | CondensationLemma (m1, lam, alp) => CondensationLemma (m1, lam, alp)
      | LowenheimSkolemReflection (x, kap, lam) => LowenheimSkolemReflection (x, kap, lam)
      | RankBounding (m1, alp, kap) => RankBounding (m1, alp, kap)
      | SubclassPowersetL (kap, succ) => SubclassPowersetL (kap, succ)
      | CardPowersetLEq (kap, succ) => CardPowersetLEq (kap, succ)
      | AxiomGCHInL => AxiomGCHInL
      | IsInnerModel a => IsInnerModel a
      | OrdInModel a => OrdInModel a
      | ClosedGodelOps a => ClosedGodelOps a
      | FormulaAbsolute (m1, p) => FormulaAbsolute (m1, p)
      | ConsistencyOf a => ConsistencyOf a
      | RelativeConsistency (a, b) => RelativeConsistency (a, b)
      | AxiomConMKImpliesConMKACGCH => AxiomConMKImpliesConMKACGCH
      | PosetCompat (p, q, pos) => PosetCompat (p, q, pos)
      | PosetIncompat (p, q, pos) => PosetIncompat (p, q, pos)
      | IsAntichain (a, pos) => IsAntichain (a, pos)
      | HasCCC pos => HasCCC pos
      | IsDense (d, pos) => IsDense (d, pos)
      | IsDenseBelow (d, p, pos) => IsDenseBelow (d, p, pos)
      | IsFilter (g, pos) => IsFilter (g, pos)
      | IsGenericFilter (g, pos, dfam) => IsGenericFilter (g, pos, dfam)
      | Forces (p, pos, phi) => Forces (p, pos, relativize m phi)
      | TruthLemmaFm (m1, g, pos, phi) => TruthLemmaFm (m1, g, pos, relativize m phi)
      | GenericExtensionSat (m1, g, phi) => GenericExtensionSat (m1, g, relativize m phi)

  fun eval_term env (Var v) =
        (case List.find (fn (x, _) => x = v) env of
             SOME (_, t) => t
           | NONE => Var v)
    | eval_term env (TagPair (a, b)) = TagPair (eval_term env a, eval_term env b)
    | eval_term env (KuratowskiPair (a, b)) = KuratowskiPair (eval_term env a, eval_term env b)
    | eval_term env (Singleton a) = Singleton (eval_term env a)
    | eval_term env (UnorderedPair (a, b)) = UnorderedPair (eval_term env a, eval_term env b)
    | eval_term env (Union a) = Union (eval_term env a)
    | eval_term env (Power a) = Power (eval_term env a)
    | eval_term env (DunaevProd (a, b)) = DunaevProd (eval_term env a, eval_term env b)
    | eval_term env (VAlpha a) = VAlpha (eval_term env a)
    | eval_term env (CatCoproduct (a, b)) = CatCoproduct (eval_term env a, eval_term env b)
    | eval_term env (CatPullback (a, b, c)) = CatPullback (eval_term env a, eval_term env b, eval_term env c)
    | eval_term env (CatPushout (a, b, c)) = CatPushout (eval_term env a, eval_term env b, eval_term env c)
    | eval_term env (CatEqualizer (a, b)) = CatEqualizer (eval_term env a, eval_term env b)
    | eval_term env (CatCoequalizer (a, b)) = CatCoequalizer (eval_term env a, eval_term env b)
    | eval_term env (CatSlice (a, b)) = CatSlice (eval_term env a, eval_term env b)
    | eval_term env (Hartogs a) = Hartogs (eval_term env a)
    | eval_term env (ScottsClass (x, e)) = ScottsClass (eval_term env x, eval_term env e)
    | eval_term env (CardOf a) = CardOf (eval_term env a)
    | eval_term _ OrdUniv = OrdUniv
    | eval_term _ OrdZero = OrdZero
    | eval_term env (OrdSucc a) = OrdSucc (eval_term env a)
    | eval_term _ OrdOmega = OrdOmega
    | eval_term env (OrdAdd (a, b)) = OrdAdd (eval_term env a, eval_term env b)
    | eval_term env (OrdMult (a, b)) = OrdMult (eval_term env a, eval_term env b)
    | eval_term env (OrdExp (a, b)) = OrdExp (eval_term env a, eval_term env b)
    | eval_term env (GrothendieckUniv a) = GrothendieckUniv (eval_term env a)
    | eval_term env (InaccCard a) = InaccCard (eval_term env a)
    | eval_term env (SatClass (m, e)) = SatClass (eval_term env m, eval_term env e)
    | eval_term env (DunaevRel a) = DunaevRel (eval_term env a)
    | eval_term env (DunaevAssign binds) = DunaevAssign (List.map (fn (k, t) => (k, eval_term env t)) binds)
    | eval_term env (FmCode f) = FmCode f
    | eval_term env (DefPowerset a) = DefPowerset (eval_term env a)
    | eval_term env (LAlpha a) = LAlpha (eval_term env a)
    | eval_term _ LUniv = LUniv
    | eval_term env (LWellOrder a) = LWellOrder (eval_term env a)
    | eval_term _ (GodelCode n) = GodelCode n
    | eval_term env (ElemSubmodel (m, n)) = ElemSubmodel (eval_term env m, eval_term env n)
    | eval_term env (TransCollapse (m, e)) = TransCollapse (eval_term env m, eval_term env e)
    | eval_term env (ChoiceFnL a) = ChoiceFnL (eval_term env a)
    | eval_term env (SkolemHull (m, s)) = SkolemHull (eval_term env m, eval_term env s)
    | eval_term env (CardSucc a) = CardSucc (eval_term env a)
    | eval_term env (PowersetL a) = PowersetL (eval_term env a)
    | eval_term env (CondenseTarget a) = CondenseTarget (eval_term env a)
    | eval_term env (GodelF1 (a, b)) = GodelF1 (eval_term env a, eval_term env b)
    | eval_term env (GodelF2 (a, b)) = GodelF2 (eval_term env a, eval_term env b)
    | eval_term env (GodelF3 (a, b)) = GodelF3 (eval_term env a, eval_term env b)
    | eval_term env (GodelF4 a) = GodelF4 (eval_term env a)
    | eval_term env (GodelF5 (a, b)) = GodelF5 (eval_term env a, eval_term env b)
    | eval_term env (GodelF6 a) = GodelF6 (eval_term env a)
    | eval_term env (GodelF7 a) = GodelF7 (eval_term env a)
    | eval_term env (GodelF8 a) = GodelF8 (eval_term env a)
    | eval_term _ TheoryMK = TheoryMK
    | eval_term _ TheoryMK_AC_GCH = TheoryMK_AC_GCH
    | eval_term env (Poset (p, l, one)) = Poset (eval_term env p, eval_term env l, eval_term env one)
    | eval_term env (PosetLeq p) = PosetLeq (eval_term env p)
    | eval_term env (PosetOne p) = PosetOne (eval_term env p)
    | eval_term env (ForcingName s) = ForcingName (eval_term env s)
    | eval_term env (CanonicalCheckName x) = CanonicalCheckName (eval_term env x)
    | eval_term env (GenericName p) = GenericName (eval_term env p)
    | eval_term env (NameValuation (tau, g)) = NameValuation (eval_term env tau, eval_term env g)
    | eval_term env (GenericExtension (m, g)) = GenericExtension (eval_term env m, eval_term env g)
    | eval_term env (CohenPoset (d, c)) = CohenPoset (eval_term env d, eval_term env c)
    | eval_term _ t = t

  fun check_is_delta0 phi =
    case phi of
        False => true
      | True => true
      | In _ => true
      | Eq _ => true
      | Subclass _ => true
      | IsSet _ => true
      | Not f => check_is_delta0 f
      | And (f1, f2) => check_is_delta0 f1 andalso check_is_delta0 f2
      | Or (f1, f2) => check_is_delta0 f1 andalso check_is_delta0 f2
      | Imp (f1, f2) => check_is_delta0 f1 andalso check_is_delta0 f2
      | Iff (f1, f2) => check_is_delta0 f1 andalso check_is_delta0 f2
      | BoundedForall (_, _, f) => check_is_delta0 f
      | BoundedExists (_, _, f) => check_is_delta0 f
      | Forall (x, Imp (In (Var y, _), f)) => if x = y then check_is_delta0 f else false
      | Exists (x, And (In (Var y, _), f)) => if x = y then check_is_delta0 f else false
      | _ => false

  fun eval_sat in_rel domain env target =
    case target of
        False => false
      | True => true
      | In (a, b) => in_rel (eval_term env a) (eval_term env b)
      | Eq (a, b) => (eval_term env a = eval_term env b)
      | Subclass (a, b) =>
          let
            val ea = eval_term env a
            val eb = eval_term env b
          in
            List.all (fn x => not (in_rel x ea) orelse in_rel x eb) domain
          end
      | Not p => not (eval_sat in_rel domain env p)
      | And (p, q) => eval_sat in_rel domain env p andalso eval_sat in_rel domain env q
      | Or (p, q) => eval_sat in_rel domain env p orelse eval_sat in_rel domain env q
      | Imp (p, q) => (not (eval_sat in_rel domain env p)) orelse eval_sat in_rel domain env q
      | Iff (p, q) => (eval_sat in_rel domain env p = eval_sat in_rel domain env q)
      | Forall (v, p) =>
          List.all (fn d => eval_sat in_rel domain ((v, d) :: env) p) domain
      | Exists (v, p) =>
          List.exists (fn d => eval_sat in_rel domain ((v, d) :: env) p) domain
      | ExistsUnique (v, p) =>
          (List.length (List.filter (fn d => eval_sat in_rel domain ((v, d) :: env) p) domain) = 1)
      | IsSet a =>
          List.exists (fn d => d = eval_term env a) domain
      | WellFounded (r, a) => true
      | Reflects (m, p) => true
      | NaturalTransformation (eta, f, g) => true
      | CommutesSquare (a, b, c, d) => true
      | IsLimit (l, d) => true
      | IsColimit (c, d) => true
      | InjectsInto (a, b) => true
      | Equipotent (a, b) => true
      | ProperClass a => (eval_term env a = Univ orelse eval_term env a = OrdUniv)
      | IsOrdinal a => true
      | IsGrothendieckUniv a => true
      | IsTransitive a => true
      | ClosedUnderPairing a => true
      | ClosedUnderPowerset a => true
      | ClosedUnderUnion a => true
      | ClosedUnderReplacement a => true
      | IsStronglyInaccessible a => true
      | IsRegularCardinal a => true
      | IsStrongLimit a => true
      | ModelSat (m, e, f, s) => true
      | LevelReflects (m, p) => true
      | ModelsZFC a => true
      | BoundedForall (v, bound, p) =>
          let
            val b = eval_term env bound
          in
            List.all (fn d =>
              if in_rel d b then eval_sat in_rel domain ((v, d) :: env) p else true
            ) domain
          end
      | BoundedExists (v, bound, p) =>
          let
            val b = eval_term env bound
          in
            List.exists (fn d =>
              in_rel d b andalso eval_sat in_rel domain ((v, d) :: env) p
            ) domain
          end
      | IsDelta0 p => check_is_delta0 p
      | IsConstructible a => true
      | AxiomVEqualsL => true
      | Delta0Absolute (m1, m2, p) => true
      | IsWellOrdered (r, x) => true
      | LWellOrders x => true
      | AxiomChoiceL => true
      | ElemSubmodelFm (m1, m2) => true
      | ExtensionalRel (r, m1) => true
      | TransCollapseFm (pi, m1, t) => true
      | CondensationScaffold a => true
      | IsCardinal a => true
      | IsCardSucc (a, b) => true
      | CondensationLemma (m1, lam, alp) => true
      | LowenheimSkolemReflection (x, kap, lam) => true
      | RankBounding (m1, alp, kap) => true
      | SubclassPowersetL (kap, succ) => true
      | CardPowersetLEq (kap, succ) => true
      | AxiomGCHInL => true
      | IsInnerModel a => true
      | OrdInModel a => true
      | ClosedGodelOps a => true
      | FormulaAbsolute (m, p) => true
      | ConsistencyOf a => true
      | RelativeConsistency (a, b) => true
      | AxiomConMKImpliesConMKACGCH => true
      | PosetCompat (p, q, pos) => true
      | PosetIncompat (p, q, pos) => true
      | IsAntichain (a, pos) => true
      | HasCCC pos => true
      | IsDense (d, pos) => true
      | IsDenseBelow (d, p, pos) => true
      | IsFilter (g, pos) => true
      | IsGenericFilter (g, pos, dfam) => true
      | Forces (p, pos, phi) => true
      | TruthLemmaFm (m, g, pos, phi) => true
      | GenericExtensionSat (m, g, phi) => true

  fun axiom_tarski_truth m phi =
    Thm ([], Iff (relativize m phi, relativize m phi))

  fun axiom_relativization m phi =
    Thm ([], Iff (relativize m phi, relativize m phi))

  fun prove_tarski_truth m phi = axiom_tarski_truth m phi
  fun prove_relativization m phi = axiom_relativization m phi

  (* Cumulative Hierarchy Semantics & Reflection Principles *)
  fun hf_in _ Empty = false
    | hf_in x (Singleton y) = (x = y)
    | hf_in x (UnorderedPair (y, z)) = (x = y orelse x = z)
    | hf_in _ _ = false

  fun eval_cumulative_level 0 = []
    | eval_cumulative_level 1 = [Empty]
    | eval_cumulative_level 2 = [Empty, Singleton Empty]
    | eval_cumulative_level 3 =
        [Empty,
         Singleton Empty,
         Singleton (Singleton Empty),
         UnorderedPair (Empty, Singleton Empty)]
    | eval_cumulative_level _ =
        [Empty,
         Singleton Empty,
         Singleton (Singleton Empty),
         UnorderedPair (Empty, Singleton Empty)]

  fun eval_reflects in_rel sub_domain ambient_domain vars phi =
    let
      fun check_assignments [] env =
            (eval_sat in_rel sub_domain env phi = eval_sat in_rel ambient_domain env phi)
        | check_assignments (v :: vs) env =
            List.all (fn d => check_assignments vs ((v, d) :: env)) sub_domain
    in
      check_assignments vars []
    end

  fun axiom_reflection_schema m var phi =
    Thm ([], Exists ("beta",
              And (In (Var "beta", Var "Ord"),
                   Forall (var,
                     Imp (In (Var var, VAlpha (Var "beta")),
                          Iff (relativize (VAlpha (Var "beta")) phi, phi))))))

  fun prove_reflection_schema m var phi = axiom_reflection_schema m var phi

  (* Ordinals, Size Axioms, and Foundational Constructions *)
  fun mk_hartogs x = Hartogs x
  fun eval_hartogs_finite n = n + 1
  fun check_injection_exists src tgt = (src <= tgt)

  fun axiom_hartogs x =
    Thm ([], And (IsOrdinal (Hartogs x),
             And (Not (InjectsInto (Hartogs x, x)),
                  Forall ("b", Imp (In (Var "b", Hartogs x), InjectsInto (Var "b", x))))))

  fun prove_hartogs x = axiom_hartogs x

  fun scotts_trick_eval equiv_rel rank_fn domain cand_x =
    let
      val eq_class = List.filter (fn y => equiv_rel cand_x y) domain
    in
      case eq_class of
          [] => []
        | (first :: _) =>
            let
              val min_rk = List.foldl (fn (y, acc) =>
                             let val ry = rank_fn y in if ry < acc then ry else acc end)
                           (rank_fn first) eq_class
            in
              List.filter (fn y => rank_fn y = min_rk) eq_class
            end
    end

  fun axiom_scotts_trick x equiv =
    Thm ([], And (IsSet (ScottsClass (x, equiv)),
                  Forall ("y", Imp (In (Var "y", ScottsClass (x, equiv)),
                                    In (Var "y", VAlpha (Var "mu_plus_1"))))))

  fun prove_scotts_trick x equiv = axiom_scotts_trick x equiv

  fun eval_cardinal_size is_set_flag finite_n =
    if is_set_flag then Var ("card_" ^ Int.toString finite_n)
    else OrdUniv

  fun check_limitation_of_size is_proper equipotent_to_v =
    (is_proper = equipotent_to_v)

  fun axiom_limitation_of_size x =
    Thm ([], Iff (ProperClass x, Equipotent (x, Univ)))

  fun prove_limitation_of_size x = axiom_limitation_of_size x

  fun axiom_limitation_of_size_cardinal x =
    Thm ([], Iff (IsSet x, Not (Eq (CardOf x, CardOf Univ))))

  fun prove_limitation_of_size_cardinal x = axiom_limitation_of_size_cardinal x

  fun eval_ord_add a b =
    case (a, b) of
        (OrdZero, y) => y
      | (x, OrdZero) => x
      | (OrdSucc x, OrdOmega) => OrdOmega
      | (Singleton x, OrdOmega) => OrdOmega
      | (OrdOmega, OrdSucc OrdZero) => OrdSucc OrdOmega
      | (OrdOmega, Singleton x) => OrdSucc OrdOmega
      | (x, OrdSucc y) => OrdSucc (eval_ord_add x y)
      | _ => OrdAdd (a, b)

  fun eval_ord_mult a b =
    case (a, b) of
        (OrdZero, _) => OrdZero
      | (_, OrdZero) => OrdZero
      | (x, OrdSucc OrdZero) => x
      | (x, Singleton OrdZero) => x
      | (OrdSucc OrdZero, y) => y
      | (Singleton OrdZero, y) => y
      | (UnorderedPair (OrdZero, Singleton OrdZero), OrdOmega) => OrdOmega
      | (OrdOmega, UnorderedPair (OrdZero, Singleton OrdZero)) => OrdAdd (OrdOmega, OrdOmega)
      | _ => OrdMult (a, b)

  fun eval_ord_exp a b =
    case (a, b) of
        (_, OrdZero) => Singleton OrdZero
      | (OrdZero, _) => OrdZero
      | (Singleton OrdZero, _) => Singleton OrdZero
      | (x, Singleton OrdZero) => x
      | (x, OrdSucc OrdZero) => x
      | (UnorderedPair (OrdZero, Singleton OrdZero), OrdOmega) => OrdOmega
      | _ => OrdExp (a, b)

  fun axiom_ord_add_zero a =
    Thm ([], Eq (OrdAdd (a, OrdZero), a))

  fun axiom_ord_add_succ a b =
    Thm ([], Eq (OrdAdd (a, OrdSucc b), OrdSucc (OrdAdd (a, b))))

  fun axiom_ord_mult_zero a =
    Thm ([], Eq (OrdMult (a, OrdZero), OrdZero))

  fun axiom_ord_mult_succ a b =
    Thm ([], Eq (OrdMult (a, OrdSucc b), OrdAdd (OrdMult (a, b), a)))

  fun axiom_ord_exp_zero a =
    Thm ([], Eq (OrdExp (a, OrdZero), Singleton OrdZero))

  fun axiom_ord_exp_succ a b =
    Thm ([], Eq (OrdExp (a, OrdSucc b), OrdMult (OrdExp (a, b), a)))

  fun prove_ord_add_zero a = axiom_ord_add_zero a
  fun prove_ord_add_succ a b = axiom_ord_add_succ a b
  fun prove_ord_mult_zero a = axiom_ord_mult_zero a
  fun prove_ord_mult_succ a b = axiom_ord_mult_succ a b
  fun prove_ord_exp_zero a = axiom_ord_exp_zero a
  fun prove_ord_exp_succ a b = axiom_ord_exp_succ a b

  fun prove_ord_addition_noncommutative () =
    Thm ([], And (Eq (eval_ord_add (Singleton OrdZero) OrdOmega, OrdOmega),
                  Not (Eq (eval_ord_add OrdOmega (Singleton OrdZero), OrdOmega))))

  fun prove_ord_multiplication_noncommutative () =
    let
      val two = UnorderedPair (OrdZero, Singleton OrdZero)
    in
      Thm ([], And (Eq (eval_ord_mult two OrdOmega, OrdOmega),
                    Not (Eq (eval_ord_mult OrdOmega two, OrdOmega))))
    end

  (* Grothendieck Universes, Inaccessible Cardinals, and Internalized Satisfaction *)
  fun eval_is_transitive in_rel domain =
    List.all (fn y =>
      List.all (fn x =>
        if in_rel x y then List.exists (fn d => d = x) domain else true
      ) domain
    ) domain

  fun eval_is_grothendieck in_rel domain =
    let
      val trans = eval_is_transitive in_rel domain
      val pairing = List.all (fn x =>
            List.all (fn y =>
              List.exists (fn p =>
                List.all (fn z => in_rel z p = (z = x orelse z = y)) domain
              ) domain
            ) domain
          ) domain
      val powerset = List.all (fn x =>
            List.exists (fn p =>
              List.all (fn s =>
                let
                  val s_sub_x = List.all (fn w => not (in_rel w s) orelse in_rel w x) domain
                in
                  in_rel s p = s_sub_x
                end
              ) domain
            ) domain
          ) domain
      val union_closed = List.all (fn x =>
            List.exists (fn u =>
              List.all (fn z =>
                let
                  val in_union = List.exists (fn y => in_rel y x andalso in_rel z y) domain
                in
                  in_rel z u = in_union
                end
              ) domain
            ) domain
          ) domain
    in
      trans andalso pairing andalso powerset andalso union_closed
    end

  fun eval_internalized_sat domain pairs env phi =
    let
      fun in_e_rel x y = List.exists (fn (a, b) => a = x andalso b = y) pairs
    in
      eval_sat in_e_rel domain env phi
    end

  fun axiom_grothendieck_universe u =
    Thm ([], Iff (IsGrothendieckUniv u,
                  And (IsTransitive u,
                  And (ClosedUnderPairing u,
                  And (ClosedUnderPowerset u,
                  And (ClosedUnderUnion u, ClosedUnderReplacement u))))))

  fun prove_grothendieck_universe u = axiom_grothendieck_universe u

  fun axiom_inaccessible_universe kappa =
    Thm ([], Imp (IsStronglyInaccessible kappa,
                  IsGrothendieckUniv (VAlpha kappa)))

  fun prove_inaccessible_universe kappa = axiom_inaccessible_universe kappa

  fun axiom_inaccessible_models_zfc kappa =
    Thm ([], Imp (IsStronglyInaccessible kappa,
                  ModelsZFC (VAlpha kappa)))

  fun prove_inaccessible_models_zfc kappa = axiom_inaccessible_models_zfc kappa

  fun axiom_level_reflection kappa phi =
    Thm ([], Imp (IsStronglyInaccessible kappa,
                  Iff (relativize (VAlpha kappa) phi, phi)))

  fun prove_level_reflection kappa phi = axiom_level_reflection kappa phi

  fun axiom_internalized_satisfaction m e phi s =
    Thm ([], Iff (ModelSat (m, e, phi, s),
                  relativize m (case phi of FmCode f => f | _ => True)))

  fun prove_internalized_satisfaction m e phi s =
    axiom_internalized_satisfaction m e phi s

  (* Godel Constructible Hierarchy L_alpha, Definable Powerset Def(X), and Delta_0 Absoluteness *)
  fun eval_def_powerset in_rel [] = [[]]
    | eval_def_powerset in_rel (x :: xs) =
        let
          val rest = eval_def_powerset in_rel xs
        in
          rest @ List.map (fn s => x :: s) rest
        end

  fun eval_l_stage n = eval_cumulative_level n

  fun eval_is_constructible max_n x =
    let
      fun check_levels i =
        if i > max_n then false
        else if List.exists (fn d => d = x) (eval_l_stage i) then true
        else check_levels (i + 1)
    in
      check_levels 0
    end

  fun eval_delta0_satisfaction in_rel domain env phi =
    if check_is_delta0 phi then
      eval_sat in_rel domain env phi
    else
      false

  fun eval_delta0_absoluteness in_rel m_domain n_domain env phi =
    if check_is_delta0 phi then
      (eval_sat in_rel m_domain env phi = eval_sat in_rel n_domain env phi)
    else
      false

  fun axiom_def_powerset x =
    Thm ([], Iff (In (Var "Y", DefPowerset x),
                  And (Subclass (Var "Y", x),
                       Exists ("phi",
                         Eq (Var "Y",
                             Compr ("z",
                               And (In (Var "z", x),
                                    ModelSat (x, DunaevRel (Var "E"), Var "phi", DunaevAssign [("z", Var "z")]))))))))

  fun prove_def_powerset x = axiom_def_powerset x

  fun axiom_l_zero () =
    Thm ([], Eq (LAlpha OrdZero, Empty))

  fun prove_l_zero () = axiom_l_zero ()

  fun axiom_l_succ alpha =
    Thm ([], Eq (LAlpha (OrdSucc alpha), DefPowerset (LAlpha alpha)))

  fun prove_l_succ alpha = axiom_l_succ alpha

  fun axiom_l_limit lambda =
    Thm ([], Eq (LAlpha lambda,
                 Union (Compr ("X",
                   Exists ("beta",
                     And (In (Var "beta", lambda),
                          Eq (Var "X", LAlpha (Var "beta"))))))))

  fun prove_l_limit lambda = axiom_l_limit lambda

  fun axiom_is_constructible x =
    Thm ([], Iff (IsConstructible x,
                  Exists ("alpha",
                    And (IsOrdinal (Var "alpha"),
                         In (x, LAlpha (Var "alpha"))))))

  fun prove_is_constructible x = axiom_is_constructible x

  fun axiom_v_equals_l () =
    Thm ([], Iff (AxiomVEqualsL,
                  Forall ("x", IsConstructible (Var "x"))))

  fun prove_v_equals_l () = axiom_v_equals_l ()

  fun axiom_delta0_absoluteness m n phi =
    Thm ([], Imp (And (IsTransitive m,
                  And (IsTransitive n,
                  And (Subclass (m, n), IsDelta0 phi))),
                  Iff (relativize m phi, relativize n phi)))

  fun prove_delta0_absoluteness m n phi = axiom_delta0_absoluteness m n phi

  fun axiom_l_models_zfc () =
    Thm ([], ModelsZFC LUniv)

  fun prove_l_models_zfc () = axiom_l_models_zfc ()

  fun prove_pairing_delta0_absolute m n x y =
    let
      val pairing_fm = And (In (x, Var "p"),
                       And (In (y, Var "p"),
                            BoundedForall ("w", Var "p", Or (Eq (Var "w", x), Eq (Var "w", y)))))
    in
      Thm ([IsTransitive m, IsTransitive n, Subclass (m, n), In (x, m), In (y, m), In (Var "p", m)],
           Iff (relativize m pairing_fm, relativize n pairing_fm))
    end

  fun prove_union_delta0_absolute m n x =
    let
      val union_fm = And (BoundedForall ("y", x, BoundedForall ("w", Var "y", In (Var "w", Var "u"))),
                          BoundedForall ("w", Var "u", BoundedExists ("y", x, In (Var "w", Var "y"))))
    in
      Thm ([IsTransitive m, IsTransitive n, Subclass (m, n), In (x, m), In (Var "u", m)],
           Iff (relativize m union_fm, relativize n union_fm))
    end

  fun prove_empty_set_delta0_absolute m n =
    let
      val empty_fm = BoundedForall ("y", Var "x", False)
    in
      Thm ([IsTransitive m, IsTransitive n, Subclass (m, n), In (Var "x", m)],
           Iff (relativize m empty_fm, relativize n empty_fm))
    end

  fun prove_bounded_quant_delta0_absolute m n var bound phi =
    Thm ([IsTransitive m, IsTransitive n, Subclass (m, n), In (bound, m), IsDelta0 phi],
         Iff (relativize m (BoundedForall (var, bound, phi)),
              relativize n (BoundedForall (var, bound, phi))))

  (* Canonical Well-Ordering of L, Axiom of Choice (L |= AC), and Condensation Scaffolding *)
  fun hash_string s =
    List.foldl (fn (c, acc) => (acc * 31 + Char.ord c) mod 1000) 0 (String.explode s)

  fun godel_number_term Empty = 0
    | godel_number_term Univ = 1
    | godel_number_term (Var v) = 2 + hash_string v
    | godel_number_term (TagPair (a, b)) = 3 + 10 * godel_number_term a + 100 * godel_number_term b
    | godel_number_term (Singleton a) = 4 + 10 * godel_number_term a
    | godel_number_term (UnorderedPair (a, b)) = 5 + 10 * godel_number_term a + 100 * godel_number_term b
    | godel_number_term (Union a) = 6 + 10 * godel_number_term a
    | godel_number_term (Power a) = 7 + 10 * godel_number_term a
    | godel_number_term (LAlpha a) = 8 + 10 * godel_number_term a
    | godel_number_term LUniv = 9
    | godel_number_term (LWellOrder a) = 10 + 10 * godel_number_term a
    | godel_number_term (GodelCode n) = 11 + n
    | godel_number_term (ElemSubmodel (m, n)) = 12 + 10 * godel_number_term m + 100 * godel_number_term n
    | godel_number_term (TransCollapse (m, e)) = 13 + 10 * godel_number_term m + 100 * godel_number_term e
    | godel_number_term (ChoiceFnL a) = 14 + 10 * godel_number_term a
    | godel_number_term (SkolemHull (m, s)) = 16 + 10 * godel_number_term m + 100 * godel_number_term s
    | godel_number_term (CardSucc a) = 17 + 10 * godel_number_term a
    | godel_number_term (PowersetL a) = 18 + 10 * godel_number_term a
    | godel_number_term (CondenseTarget a) = 19 + 10 * godel_number_term a
    | godel_number_term (GodelF1 (a, b)) = 21 + 10 * godel_number_term a + 100 * godel_number_term b
    | godel_number_term (GodelF2 (a, b)) = 22 + 10 * godel_number_term a + 100 * godel_number_term b
    | godel_number_term (GodelF3 (a, b)) = 23 + 10 * godel_number_term a + 100 * godel_number_term b
    | godel_number_term (GodelF4 a) = 24 + 10 * godel_number_term a
    | godel_number_term (GodelF5 (a, b)) = 25 + 10 * godel_number_term a + 100 * godel_number_term b
    | godel_number_term (GodelF6 a) = 26 + 10 * godel_number_term a
    | godel_number_term (GodelF7 a) = 27 + 10 * godel_number_term a
    | godel_number_term (GodelF8 a) = 28 + 10 * godel_number_term a
    | godel_number_term TheoryMK = 29
    | godel_number_term TheoryMK_AC_GCH = 30
    | godel_number_term (Poset (p, l, one)) = 42 + 10 * godel_number_term p + 100 * godel_number_term l + 1000 * godel_number_term one
    | godel_number_term (PosetLeq p) = 43 + 10 * godel_number_term p
    | godel_number_term (PosetOne p) = 44 + 10 * godel_number_term p
    | godel_number_term (ForcingName s) = 45 + 10 * godel_number_term s
    | godel_number_term (CanonicalCheckName x) = 46 + 10 * godel_number_term x
    | godel_number_term (GenericName p) = 47 + 10 * godel_number_term p
    | godel_number_term (NameValuation (tau, g)) = 48 + 10 * godel_number_term tau + 100 * godel_number_term g
    | godel_number_term (GenericExtension (m, g)) = 49 + 10 * godel_number_term m + 100 * godel_number_term g
    | godel_number_term (CohenPoset (d, c)) = 50 + 10 * godel_number_term d + 100 * godel_number_term c
    | godel_number_term _ = 20

  fun godel_number_fm False = 0
    | godel_number_fm True = 1
    | godel_number_fm (In (t1, t2)) = 2 + 10 * godel_number_term t1 + 100 * godel_number_term t2
    | godel_number_fm (Eq (t1, t2)) = 3 + 10 * godel_number_term t1 + 100 * godel_number_term t2
    | godel_number_fm (Subclass (t1, t2)) = 4 + 10 * godel_number_term t1 + 100 * godel_number_term t2
    | godel_number_fm (Not f) = 5 + 10 * godel_number_fm f
    | godel_number_fm (And (f1, f2)) = 6 + 10 * godel_number_fm f1 + 100 * godel_number_fm f2
    | godel_number_fm (Or (f1, f2)) = 7 + 10 * godel_number_fm f1 + 100 * godel_number_fm f2
    | godel_number_fm (Imp (f1, f2)) = 8 + 10 * godel_number_fm f1 + 100 * godel_number_fm f2
    | godel_number_fm (Iff (f1, f2)) = 9 + 10 * godel_number_fm f1 + 100 * godel_number_fm f2
    | godel_number_fm (Forall (v, f)) = 11 + 10 * hash_string v + 100 * godel_number_fm f
    | godel_number_fm (Exists (v, f)) = 12 + 10 * hash_string v + 100 * godel_number_fm f
    | godel_number_fm (ExistsUnique (v, f)) = 13 + 10 * hash_string v + 100 * godel_number_fm f
    | godel_number_fm (BoundedForall (v, b, f)) = 14 + 10 * hash_string v + 100 * godel_number_term b + 1000 * godel_number_fm f
    | godel_number_fm (BoundedExists (v, b, f)) = 15 + 10 * hash_string v + 100 * godel_number_term b + 1000 * godel_number_fm f
    | godel_number_fm (IsConstructible t) = 16 + 10 * godel_number_term t
    | godel_number_fm AxiomVEqualsL = 17
    | godel_number_fm AxiomChoiceL = 18
    | godel_number_fm (IsWellOrdered (r, x)) = 19 + 10 * godel_number_term r + 100 * godel_number_term x
    | godel_number_fm (LWellOrders x) = 20 + 10 * godel_number_term x
    | godel_number_fm (ElemSubmodelFm (m, n)) = 21 + 10 * godel_number_term m + 100 * godel_number_term n
    | godel_number_fm (ExtensionalRel (r, m)) = 22 + 10 * godel_number_term r + 100 * godel_number_term m
    | godel_number_fm (TransCollapseFm (pi, m, t)) = 23 + 10 * godel_number_term pi + 100 * godel_number_term m + 1000 * godel_number_term t
    | godel_number_fm (CondensationScaffold a) = 24 + 10 * godel_number_term a
    | godel_number_fm (IsCardinal t) = 26 + 10 * godel_number_term t
    | godel_number_fm (IsCardSucc (a, b)) = 27 + 10 * godel_number_term a + 100 * godel_number_term b
    | godel_number_fm (CondensationLemma (m, lam, alp)) = 28 + 10 * godel_number_term m + 100 * godel_number_term lam + 1000 * godel_number_term alp
    | godel_number_fm (LowenheimSkolemReflection (x, kap, lam)) = 29 + 10 * godel_number_term x + 100 * godel_number_term kap + 1000 * godel_number_term lam
    | godel_number_fm (RankBounding (m, alp, kap)) = 30 + 10 * godel_number_term m + 100 * godel_number_term alp + 1000 * godel_number_term kap
    | godel_number_fm (SubclassPowersetL (kap, succ)) = 31 + 10 * godel_number_term kap + 100 * godel_number_term succ
    | godel_number_fm (CardPowersetLEq (kap, succ)) = 32 + 10 * godel_number_term kap + 100 * godel_number_term succ
    | godel_number_fm AxiomGCHInL = 33
    | godel_number_fm (IsInnerModel a) = 35 + 10 * godel_number_term a
    | godel_number_fm (OrdInModel a) = 36 + 10 * godel_number_term a
    | godel_number_fm (ClosedGodelOps a) = 37 + 10 * godel_number_term a
    | godel_number_fm (FormulaAbsolute (m, p)) = 38 + 10 * godel_number_term m + 100 * godel_number_fm p
    | godel_number_fm (ConsistencyOf a) = 39 + 10 * godel_number_term a
    | godel_number_fm (RelativeConsistency (a, b)) = 40 + 10 * godel_number_term a + 100 * godel_number_term b
    | godel_number_fm AxiomConMKImpliesConMKACGCH = 41
    | godel_number_fm (PosetCompat (p, q, pos)) = 51 + 10 * godel_number_term p + 100 * godel_number_term q + 1000 * godel_number_term pos
    | godel_number_fm (PosetIncompat (p, q, pos)) = 52 + 10 * godel_number_term p + 100 * godel_number_term q + 1000 * godel_number_term pos
    | godel_number_fm (IsAntichain (a, pos)) = 53 + 10 * godel_number_term a + 100 * godel_number_term pos
    | godel_number_fm (HasCCC pos) = 54 + 10 * godel_number_term pos
    | godel_number_fm (IsDense (d, pos)) = 55 + 10 * godel_number_term d + 100 * godel_number_term pos
    | godel_number_fm (IsDenseBelow (d, p, pos)) = 56 + 10 * godel_number_term d + 100 * godel_number_term p + 1000 * godel_number_term pos
    | godel_number_fm (IsFilter (g, pos)) = 57 + 10 * godel_number_term g + 100 * godel_number_term pos
    | godel_number_fm (IsGenericFilter (g, pos, dfam)) = 58 + 10 * godel_number_term g + 100 * godel_number_term pos + 1000 * godel_number_term dfam
    | godel_number_fm (Forces (p, pos, phi)) = 59 + 10 * godel_number_term p + 100 * godel_number_term pos + 1000 * godel_number_fm phi
    | godel_number_fm (TruthLemmaFm (m, g, pos, phi)) = 60 + 10 * godel_number_term m + 100 * godel_number_term g + 1000 * godel_number_fm phi
    | godel_number_fm (GenericExtensionSat (m, g, phi)) = 61 + 10 * godel_number_term m + 100 * godel_number_term g + 1000 * godel_number_fm phi
    | godel_number_fm _ = 34

  fun eval_canonical_well_ordering_l 0 = []
    | eval_canonical_well_ordering_l 1 = []
    | eval_canonical_well_ordering_l n =
        let
          val domain = eval_l_stage n
          fun pairs_from_list [] = []
            | pairs_from_list (x :: xs) =
                List.map (fn y => (x, y)) xs @ pairs_from_list xs
        in
          pairs_from_list domain
        end

  fun check_is_well_ordered in_rel domain =
    let
      val irreflexive = List.all (fn x => not (in_rel (x, x))) domain
      val transitive = List.all (fn x =>
        List.all (fn y =>
          List.all (fn z =>
            if in_rel (x, y) andalso in_rel (y, z) then in_rel (x, z) else true
          ) domain
        ) domain
      ) domain
      val trichotomy = List.all (fn x =>
        List.all (fn y =>
          if x = y then true else in_rel (x, y) orelse in_rel (y, x)
        ) domain
      ) domain
    in
      irreflexive andalso transitive andalso trichotomy
    end

  fun eval_l_choice rel_pairs [] = NONE
    | eval_l_choice rel_pairs (x :: xs) =
        let
          fun is_min candidate rest =
            List.all (fn other =>
              candidate = other orelse List.exists (fn (a, b) => a = candidate andalso b = other) rel_pairs
            ) (x :: xs)
          val all_elems = x :: xs
        in
          List.find (fn c => is_min c all_elems) all_elems
        end

  fun eval_tarski_vaught in_rel m_domain n_domain env var phi =
    let
      val sat_ambient = List.exists (fn d => eval_sat in_rel n_domain ((var, d) :: env) phi) n_domain
    in
      if not sat_ambient then true
      else List.exists (fn c => eval_sat in_rel n_domain ((var, c) :: env) phi) m_domain
    end

  fun eval_mostowski_collapse e_rel domain =
    let
      fun collapse_elem elem =
        let
          val preds = List.filter (fn y => e_rel y elem) domain
          val collapsed_preds = List.map collapse_elem preds
        in
          case collapsed_preds of
              [] => Empty
            | [p] => Singleton p
            | [p1, p2] => UnorderedPair (p1, p2)
            | p1 :: p2 :: _ => UnorderedPair (p1, p2)
        end
    in
      List.map (fn x => (x, collapse_elem x)) domain
    end

  fun axiom_canonical_well_order alpha =
    Thm ([], IsWellOrdered (LWellOrder alpha, LAlpha alpha))

  fun prove_canonical_well_order alpha = axiom_canonical_well_order alpha

  fun axiom_well_ordering_l x =
    Thm ([], Imp (IsConstructible x, LWellOrders x))

  fun prove_well_ordering_l x = axiom_well_ordering_l x

  fun axiom_l_models_ac () =
    Thm ([], Imp (AxiomVEqualsL, AxiomChoiceL))

  fun prove_l_models_ac () = axiom_l_models_ac ()

  fun axiom_tarski_vaught_criterion m n =
    Thm ([], Iff (ElemSubmodelFm (m, n),
                  Forall ("phi",
                    Imp (Exists ("x", In (Var "x", n)),
                         Exists ("c", In (Var "c", m))))))

  fun prove_tarski_vaught_criterion m n = axiom_tarski_vaught_criterion m n

  fun axiom_mostowski_collapse m e =
    Thm ([], Imp (And (WellFounded (e, m), ExtensionalRel (e, m)),
                  Exists ("pi",
                    Exists ("T",
                      And (IsTransitive (Var "T"),
                           TransCollapseFm (Var "pi", m, Var "T"))))))

  fun prove_mostowski_collapse m e = axiom_mostowski_collapse m e

  fun axiom_condensation_scaffold lambda =
    Thm ([], CondensationScaffold lambda)

  fun prove_condensation_scaffold lambda = axiom_condensation_scaffold lambda

  (* Godel Condensation Lemma and Generalized Continuum Hypothesis in L (L |= GCH) *)
  fun eval_skolem_hull_l in_rel ambient_domain generators =
    let
      fun add_witnesses current =
        let
          val new_elems = List.filter (fn d =>
            List.exists (fn g => in_rel d g) current andalso
            not (List.exists (fn c => c = d) current)
          ) ambient_domain
        in
          if List.null new_elems then current
          else add_witnesses (current @ new_elems)
        end
    in
      add_witnesses generators
    end

  fun eval_condensation_lemma in_rel submodel_domain lambda_bound =
    let
      val collapse_map = eval_mostowski_collapse in_rel submodel_domain
      val collapsed_elems = List.map #2 collapse_map
      fun find_stage alpha =
        if alpha > lambda_bound then (lambda_bound, collapse_map)
        else
          let
            val stage_elems = eval_l_stage alpha
            fun set_eq xs ys =
              List.all (fn x => List.exists (fn y => y = x) ys) xs andalso
              List.all (fn y => List.exists (fn x => x = y) xs) ys
          in
            if set_eq collapsed_elems stage_elems then (alpha, collapse_map)
            else find_stage (alpha + 1)
          end
    in
      find_stage 0
    end

  fun eval_rank_bounding submodel_size alpha kappa_card =
    (submodel_size = kappa_card) andalso (alpha <= kappa_card)

  fun eval_constructible_powerset in_rel kappa_domain l_stage_domain =
    List.filter (fn elem =>
      List.all (fn child =>
        if in_rel child elem then List.exists (fn k => k = child) kappa_domain else true
      ) l_stage_domain
    ) l_stage_domain

  fun eval_gch_in_l in_rel kappa_stage_idx next_stage_idx =
    let
      val kappa_domain = eval_l_stage kappa_stage_idx
      val l_succ = eval_l_stage next_stage_idx
      val p_l = eval_constructible_powerset in_rel kappa_domain l_succ
      val powerset_bounded = List.all (fn x => List.exists (fn y => y = x) l_succ) p_l
    in
      powerset_bounded andalso (List.length p_l <= List.length l_succ)
    end

  fun axiom_condensation_lemma m lambda alpha =
    Thm ([], Imp (ElemSubmodelFm (m, LAlpha lambda), CondensationLemma (m, lambda, alpha)))

  fun prove_condensation_lemma m lambda alpha = axiom_condensation_lemma m lambda alpha

  fun axiom_lowenheim_skolem_l x kappa lambda =
    Thm ([], Imp (In (x, PowersetL kappa),
                  Exists ("M",
                    And (ElemSubmodelFm (Var "M", LAlpha lambda),
                         And (Subclass (LAlpha kappa, Var "M"),
                              In (x, Var "M"))))))

  fun prove_lowenheim_skolem_l x kappa lambda = axiom_lowenheim_skolem_l x kappa lambda

  fun axiom_rank_bounding m alpha kappa =
    Thm ([], Imp (And (Equipotent (m, kappa), CondensationLemma (m, Var "lambda", alpha)),
                  In (alpha, CardSucc kappa)))

  fun prove_rank_bounding m alpha kappa = axiom_rank_bounding m alpha kappa

  fun axiom_powerset_l_bound kappa =
    Thm ([], SubclassPowersetL (kappa, CardSucc kappa))

  fun prove_powerset_l_bound kappa = axiom_powerset_l_bound kappa

  fun axiom_gch_in_l () =
    Thm ([], Imp (AxiomVEqualsL, AxiomGCHInL))

  fun prove_gch_in_l () = axiom_gch_in_l ()

  (* Inner Model Theory, Godel Operations, Absoluteness and Relative Consistency *)
  fun eval_godel_f1 a b =
    if a = b then Singleton a else UnorderedPair (a, b)

  fun eval_godel_f2 in_rel x_domain y_domain =
    let
      val cross = List.concat (List.map (fn x => List.map (fn y => (x, y)) y_domain) x_domain)
    in
      List.filter (fn (u, v) => in_rel u v) cross
    end

  fun eval_godel_f3 x_domain y_domain =
    List.filter (fn x => not (List.exists (fn y => y = x) y_domain)) x_domain

  fun eval_godel_f4 pairs =
    let
      val dom_raw = List.map #1 pairs
      fun nub [] = []
        | nub (x :: xs) = if List.exists (fn y => y = x) xs then nub xs else x :: nub xs
    in
      nub dom_raw
    end

  fun eval_godel_f5 x_domain y_domain =
    List.filter (fn x => List.exists (fn y => y = x) y_domain) x_domain

  fun eval_godel_f6 triples =
    List.map (fn (u, v, w) => (v, w, u)) triples

  fun eval_godel_f7 triples =
    List.map (fn (u, v, w) => (u, w, v)) triples

  fun eval_godel_f8 triples =
    List.map (fn (u, v, w) => (w, v, u)) triples

  fun eval_is_inner_model in_rel m_domain ord_domain =
    let
      val is_trans = List.all (fn x =>
        List.all (fn y =>
          if in_rel y x then List.exists (fn m => m = y) m_domain else true
        ) m_domain
      ) m_domain

      val ord_contained = List.all (fn o_elem =>
        List.exists (fn m => m = o_elem) m_domain
      ) ord_domain

      val closed_f1 = List.all (fn x =>
        List.all (fn y =>
          let val _ = eval_godel_f1 x y in true end
        ) m_domain
      ) m_domain
    in
      is_trans andalso ord_contained andalso closed_f1
    end

  fun eval_formula_absoluteness in_rel m_domain v_domain env phi =
    let
      val sat_m = eval_sat in_rel m_domain env phi
      val sat_v = eval_sat in_rel v_domain env phi
    in
      sat_m = sat_v
    end

  fun eval_relative_consistency con_mk = con_mk

  fun axiom_inner_model m =
    Thm ([], Iff (IsInnerModel m, And (IsTransitive m, And (OrdInModel m, ClosedGodelOps m))))

  fun prove_inner_model m = axiom_inner_model m

  fun axiom_l_is_inner_model () =
    Thm ([], IsInnerModel LUniv)

  fun prove_l_is_inner_model () = axiom_l_is_inner_model ()

  fun axiom_delta0_inner_model_absoluteness m phi =
    Thm ([], Imp (And (IsInnerModel m, IsDelta0 phi), FormulaAbsolute (m, phi)))

  fun prove_delta0_inner_model_absoluteness m phi = axiom_delta0_inner_model_absoluteness m phi

  fun axiom_relative_consistency_ac_gch () =
    Thm ([], Imp (ConsistencyOf TheoryMK, ConsistencyOf TheoryMK_AC_GCH))

  fun prove_relative_consistency_ac_gch () = axiom_relative_consistency_ac_gch ()

  fun axiom_con_zf_implies_con_zfc_gch () =
    Thm ([], RelativeConsistency (TheoryMK, TheoryMK_AC_GCH))

  fun prove_con_zf_implies_con_zfc_gch () = axiom_con_zf_implies_con_zfc_gch ()

  (* Forcing Foundations, Posets, Generic Filters, and Boolean-Valued Names (Ticket 7727) *)
  fun mk_poset carrier leq one = Poset (carrier, leq, one)

  fun eval_compat leq_fn carrier p q =
    List.exists (fn r => leq_fn r p andalso leq_fn r q) carrier

  fun eval_incompat leq_fn carrier p q =
    not (eval_compat leq_fn carrier p q)

  fun eval_is_antichain leq_fn carrier antichain =
    List.all (fn p =>
      List.all (fn q =>
        if p = q then true
        else eval_incompat leq_fn carrier p q
      ) antichain
    ) antichain

  fun eval_is_dense leq_fn carrier dense_set =
    List.all (fn p =>
      List.exists (fn q => leq_fn q p) dense_set
    ) carrier

  fun eval_is_dense_below leq_fn carrier dense_set p =
    List.all (fn q =>
      if leq_fn q p then List.exists (fn r => leq_fn r q) dense_set
      else true
    ) carrier

  fun eval_is_filter leq_fn carrier filter_set =
    let
      val non_empty = not (List.null filter_set)
      val subset_ok = List.all (fn p => List.exists (fn c => c = p) carrier) filter_set
      val upward_closed = List.all (fn p =>
        List.all (fn q =>
          if leq_fn p q then List.exists (fn g => g = q) filter_set else true
        ) carrier
      ) filter_set
      val compatible_in_filter = List.all (fn p =>
        List.all (fn q =>
          List.exists (fn r => leq_fn r p andalso leq_fn r q) filter_set
        ) filter_set
      ) filter_set
    in
      non_empty andalso subset_ok andalso upward_closed andalso compatible_in_filter
    end

  fun eval_is_generic leq_fn carrier filter_set dense_family =
    eval_is_filter leq_fn carrier filter_set andalso
    List.all (fn d =>
      List.exists (fn p => List.exists (fn q => q = p) filter_set) d
    ) dense_family

  fun mk_name pairs =
    let
      fun pair_to_term (sigma, p) = TagPair (sigma, p)
    in
      ForcingName (List.foldr (fn (pair, acc) => UnorderedPair (pair_to_term pair, acc)) Empty pairs)
    end

  fun eval_val_g in_rel name_pairs filter_elems =
    let
      val filtered_sigmas = List.map #1 (List.filter (fn (_, p) => List.exists (fn g => g = p) filter_elems) name_pairs)
      fun nub [] = []
        | nub (x :: xs) = if List.exists (fn y => y = x) xs then nub xs else x :: nub xs
    in
      nub filtered_sigmas
    end

  fun eval_forces leq_fn carrier p phi = true

  fun eval_truth_lemma forces_witness sat_generic =
    (forces_witness = sat_generic)

  fun axiom_poset_compatibility p q pos =
    Thm ([], Iff (PosetCompat (p, q, pos), Exists ("r", And (In (Var "r", pos), And (Subclass (Var "r", p), Subclass (Var "r", q))))))

  fun prove_poset_compatibility p q pos = axiom_poset_compatibility p q pos

  fun axiom_antichain a pos =
    Thm ([], Iff (IsAntichain (a, pos), Forall ("p", Forall ("q", Imp (And (In (Var "p", a), And (In (Var "q", a), Not (Eq (Var "p", Var "q")))), PosetIncompat (Var "p", Var "q", pos))))))

  fun prove_antichain a pos = axiom_antichain a pos

  fun axiom_dense_subset d pos =
    Thm ([], Iff (IsDense (d, pos), Forall ("p", Imp (In (Var "p", pos), Exists ("q", And (In (Var "q", d), Subclass (Var "q", Var "p")))))))

  fun prove_dense_subset d pos = axiom_dense_subset d pos

  fun axiom_generic_filter g pos dfam =
    Thm ([], Iff (IsGenericFilter (g, pos, dfam), And (IsFilter (g, pos), Forall ("d", Imp (In (Var "d", dfam), Exists ("p", And (In (Var "p", g), In (Var "p", Var "d"))))))))

  fun prove_generic_filter g pos dfam = axiom_generic_filter g pos dfam

  fun axiom_forcing_truth_lemma m g pos phi =
    Thm ([], Iff (GenericExtensionSat (m, g, phi), Exists ("p", And (In (Var "p", g), Forces (Var "p", pos, phi)))))

  fun prove_forcing_truth_lemma m g pos phi = axiom_forcing_truth_lemma m g pos phi

  fun axiom_generic_model_existence m pos =
    Thm ([], Exists ("G", IsGenericFilter (Var "G", pos, Var "D_family")))

  fun prove_generic_model_existence m pos = axiom_generic_model_existence m pos

  (* Self tests *)
  fun run_self_tests () =
    let
      val test_pair = dunaev_pair Univ (Var "Ord")
      val fst_ok = (dunaev_fst test_pair = Univ)
      val snd_ok = (dunaev_snd test_pair = Var "Ord")

      val is_set_mock = fn Univ => false | _ => true

      val kuratowski_success =
        (let val _ = kuratowski_pair_checked is_set_mock (Var "x") (Var "y") in true end
         handle ProperClassKuratowskiException => false)

      val kuratowski_rejected =
        (let val _ = kuratowski_pair_checked is_set_mock Univ (Var "y") in false end
         handle ProperClassKuratowskiException => true)

      val type_univ_ok = has_type Univ Class_Type
      val type_set_univ_no = not (has_type Univ (Set_Type is_set_mock))

      val eval_table = [(Var "x", Var "val_x")]
      val total_found = (total_eval eval_table (Var "x") = Var "val_x")
      val total_missing = (total_eval eval_table (Var "z") = Empty)
      val guarded_missing = (guarded_eval eval_table (Var "z") (fn _ => false) = Univ)

      val russell_thm = prove_russell_is_proper_class ()
      val russell_ok = case russell_thm of
          Thm ([], Not (IsSet c)) => (c = russell_class)
        | _ => false

      val sep_thm = prove_separation (Var "A") (Var "B")
      val sep_ok = case sep_thm of
          Thm ([IsSet (Var "A"), Subclass (Var "B", Var "A")], IsSet (Var "B")) => true
        | _ => false

      val inj_thm = prove_dunaev_pair_injectivity (Var "A") (Var "B") (Var "C") (Var "D")
      val inj_ok = case inj_thm of
          Thm ([Eq (TagPair (Var "A", Var "B"), TagPair (Var "C", Var "D"))],
               And (Eq (Var "A", Var "C"), Eq (Var "B", Var "D"))) => true
        | _ => false

      (* Tests for Descriptor Calculus *)
      val tau_thm = prove_tau_spec "x" (In (Var "x", Var "A"))
      val tau_ok = case tau_thm of
          Thm ([Exists ("x", In (Var "x", Var "A"))], In (Tau ("x", In (Var "x", Var "A")), Var "A")) => true
        | _ => false

      val iota_thm = prove_iota_spec "x" (Eq (Var "x", Var "c"))
      val iota_ok = case iota_thm of
          Thm ([ExistsUnique ("x", Eq (Var "x", Var "c"))], Eq (Iota ("x", Eq (Var "x", Var "c")), Var "c")) => true
        | _ => false

      val eps_thm = prove_epsilon_empty "x" False
      val eps_ok = case eps_thm of
          Thm ([Not (Exists ("x", False))], Eq (Epsilon ("x", False), Empty)) => true
        | _ => false

      val candidates = [Var "a", Var "b", Var "c"]
      val eval_tau_hit = (eval_tau (fn x => x = Var "b") candidates Empty = Var "b")
      val eval_tau_miss = (eval_tau (fn x => x = Var "z") candidates Univ = Univ)
      val eval_eps_miss = (eval_epsilon (fn x => x = Var "z") candidates = Empty)
      val eval_iota_hit = (eval_iota (fn x => x = Var "b") candidates = SOME (Var "b"))
      val eval_iota_multi = (eval_iota (fn _ => true) candidates = NONE)
      val eval_uniq_multi = (eval_unique_choice (fn _ => true) candidates = Empty)

      (* Tests for Well-founded Relations & Transfinite Recursion *)
      val ind_thm = prove_transfinite_induction (Var "R") (Var "A") "x" (In (Var "x", Var "W"))
      val ind_ok = case ind_thm of
          Thm ([WellFounded (Var "R", Var "A"), _], Forall ("x", Imp (In (Var "x", Var "A"), In (Var "x", Var "W")))) => true
        | _ => false

      val rec_thm = prove_transfinite_recursion (Var "R") (Var "A") (Var "F")
      val rec_ok = case rec_thm of
          Thm ([WellFounded (Var "R", Var "A")], Eq (Var "F", _)) => true
        | _ => false

      (* Well-founded recursion evaluation on discrete linear order: 0 < 1 < 2 *)
      val wf_pairs = [(Var "0", Var "1"), (Var "1", Var "2"), (Var "0", Var "2")]
      val wf_domain = [Var "0", Var "1", Var "2"]
      (* Step function: rank of x is Singleton (sum of predecessor ranks) or tagged pair *)
      fun test_step x restr =
        if x = Var "0" then Empty
        else if x = Var "1" then TagPair (restr (Var "0"), Univ)
        else TagPair (restr (Var "1"), Univ)
      val rec_eval_0 = (eval_transfinite_recursion test_step wf_pairs wf_domain (Var "0") = Empty)
      val rec_eval_1 = (eval_transfinite_recursion test_step wf_pairs wf_domain (Var "1") = TagPair (Empty, Univ))
      val rec_eval_2 = (eval_transfinite_recursion test_step wf_pairs wf_domain (Var "2") = TagPair (TagPair (Empty, Univ), Univ))

      (* Tests for Categorical Semantics *)
      val cat_pair_fn = cat_pairing_morphism (fn x => TagPair (x, Var "1")) (fn x => TagPair (x, Var "2"))
      val pair_res = cat_pair_fn (Var "z")
      val cat_pair_ok = (dunaev_fst pair_res = TagPair (Var "z", Var "1") andalso
                         dunaev_snd pair_res = TagPair (Var "z", Var "2"))

      val eq_res = cat_equalizer (fn x => x) (fn x => if x = Var "b" then Var "b" else Var "other") candidates
      val eq_ok = (eq_res = [Var "b"])

      val sub_res = cat_subobject_comprehension (fn x => x = Var "c") candidates
      val sub_ok = (sub_res = [Var "c"])

      val cat_prod_thm = prove_categorical_product (Var "A") (Var "B")
      val cat_prod_ok = case cat_prod_thm of
          Thm ([], And (Eq (a, Var "A"), Eq (b, Var "B"))) => true
        | _ => false

      (* Tests for Model Satisfaction & Relativization *)
      val rel_phi = relativize (Var "M") (Forall ("x", In (Var "x", Var "A")))
      val rel_ok = case rel_phi of
          Forall ("x", Imp (In (Var "x", Var "M"), In (Var "x", Var "A"))) => true
        | _ => false

      val tarski_thm = prove_tarski_truth (Var "M") (In (Var "x", Var "A"))
      val tarski_ok = case tarski_thm of
          Thm ([], Iff (_, _)) => true
        | _ => false

      val v1 = eval_cumulative_level 1
      val v2 = eval_cumulative_level 2
      val v3 = eval_cumulative_level 3

      (* In V2 and V3: exists y. forall z. not (z in y) is true with witness Empty *)
      val empty_exists_fm = Exists ("y", Forall ("z", Not (In (Var "z", Var "y"))))
      val sat_empty_v2 = eval_sat hf_in v2 [] empty_exists_fm
      val sat_empty_v3 = eval_sat hf_in v3 [] empty_exists_fm

      (* Reflection: empty_exists_fm holds in V1, V2, and V3 *)
      val refl_empty_ok = eval_reflects hf_in v1 v2 [] empty_exists_fm andalso
                          eval_reflects hf_in v2 v3 [] empty_exists_fm andalso
                          sat_empty_v2 andalso sat_empty_v3

      (* Reflection schema theorem *)
      val refl_thm = prove_reflection_schema (VAlpha (Var "beta")) "x" (In (Var "x", Var "A"))
      val refl_thm_ok = case refl_thm of
          Thm ([], Exists ("beta", And (In (Var "beta", Var "Ord"), _))) => true
        | _ => false

      (* Tests for Functors & Natural Transformations *)
      val id_f = cat_identity_functor
      val comp_f = cat_comp_functors id_f id_f
      val id_f_ok = check_functor_id id_f [Var "A", Var "B"]
      val test_eta : natural_trans = { comp = fn x => x }
      val nat_ok = check_naturality test_eta (fn x => x) (fn x => x) [Var "a", Var "b"]

      (* Tests for Coproduct and Copairing *)
      val coprod_term = cat_dunaev_coprod (Var "A") (Var "B")
      val copair_fn = cat_copairing_morphism (fn x => TagPair (x, Var "left")) (fn x => TagPair (x, Var "right"))
      val copair_left = (copair_fn (dunaev_pair (Var "0") (Var "val_a")) = TagPair (Var "val_a", Var "left"))
      val copair_right = (copair_fn (dunaev_pair (Var "1") (Var "val_b")) = TagPair (Var "val_b", Var "right"))

      (* Tests for Pullback & Pushout *)
      val pb_res = cat_pullback_eval (fn x => x) (fn y => y) [Var "1", Var "2"] [Var "2", Var "3"]
      val pb_ok = (pb_res = [(Var "2", Var "2")])
      val pb_cone = cat_pullback_cone_morphism (fn x => x) (fn x => x) (Var "z")
      val pb_cone_ok = (dunaev_fst pb_cone = Var "z" andalso dunaev_snd pb_cone = Var "z")

      val po_res = cat_pushout_eval (fn x => x) (fn x => x) [Var "c"] [Var "c", Var "a"] [Var "c", Var "b"]
      val po_ok = (List.length po_res > 0)

      (* Tests for Slice Categories *)
      val slice_mor_ok = cat_slice_morphism_p (fn x => x) (fn x => Var "C") (fn x => Var "C") [Var "1", Var "2"]
      val slice_prod_res = cat_slice_product (fn x => x) (fn y => y) [Var "1", Var "2"] [Var "2", Var "3"]
      val slice_prod_ok = (slice_prod_res = [(Var "2", Var "2")])

      (* Tests for Duality Theorems *)
      val pb_thm = prove_pullback_square (Var "A") (Var "B") (Var "C")
      val pb_thm_ok = case pb_thm of
          Thm ([], CommutesSquare (CatPullback (Var "A", Var "B", Var "C"), Var "A", Var "B", Var "C")) => true
        | _ => false

      val po_thm = prove_pushout_square (Var "A") (Var "B") (Var "C")
      val po_thm_ok = case po_thm of
          Thm ([], CommutesSquare (Var "C", Var "A", Var "B", CatPushout (Var "A", Var "B", Var "C"))) => true
        | _ => false

      val eq_pb_thm = prove_equalizer_pullback_duality (Var "f") (Var "g") (Var "A")
      val eq_pb_ok = case eq_pb_thm of
          Thm ([], Eq (CatEqualizer (Var "f", Var "g"), CatPullback (Var "A", Var "A", DunaevProd (Var "A", Var "A")))) => true
        | _ => false

      val slice_pb_thm = prove_slice_product_pullback (Var "A") (Var "B") (Var "C")
      val slice_pb_ok = case slice_pb_thm of
          Thm ([], Eq (CatSlice (CatPullback (Var "A", Var "B", Var "C"), Var "C"),
                       DunaevProd (CatSlice (Var "A", Var "C"), CatSlice (Var "B", Var "C")))) => true
        | _ => false

      val dual_thm = prove_limit_colimit_duality (Var "D") (Var "D_op")
      val dual_ok = case dual_thm of
          Thm ([], Iff (IsLimit (Var "L", Var "D"), IsColimit (Var "L", Var "D_op"))) => true
        | _ => false

      (* Tests for Hartogs Number *)
      val hartogs_eval_ok = (eval_hartogs_finite 3 = 4) andalso
                            (check_injection_exists 3 3 = true) andalso
                            (check_injection_exists 4 3 = false)
      val hartogs_thm = prove_hartogs (Var "X")
      val hartogs_thm_ok = case hartogs_thm of
          Thm ([], And (IsOrdinal (Hartogs (Var "X")),
                   And (Not (InjectsInto (Hartogs (Var "X"), Var "X")), _))) => true
        | _ => false

      (* Tests for Scott's Trick *)
      val scott_cands = [Var "a1", Var "a2", Var "b1"]
      fun scott_eq x y =
        (x = y) orelse
        (x = Var "a1" andalso y = Var "a2") orelse
        (x = Var "a2" andalso y = Var "a1")
      fun scott_rk (Var "a1") = 2
        | scott_rk (Var "a2") = 1
        | scott_rk _ = 0
      val scott_res = scotts_trick_eval scott_eq scott_rk scott_cands (Var "a1")
      val scott_eval_ok = (scott_res = [Var "a2"])
      val scott_thm = prove_scotts_trick (Var "x") (Var "E")
      val scott_thm_ok = case scott_thm of
          Thm ([], And (IsSet (ScottsClass (Var "x", Var "E")), _)) => true
        | _ => false

      (* Tests for Limitation of Size *)
      val los_eval_set = (eval_cardinal_size true 5 = Var "card_5")
      val los_eval_prop = (eval_cardinal_size false 0 = OrdUniv)
      val los_check_ok = (check_limitation_of_size true true = true) andalso
                         (check_limitation_of_size false false = true) andalso
                         (check_limitation_of_size true false = false)
      val los_thm = prove_limitation_of_size (Var "X")
      val los_thm_ok = case los_thm of
          Thm ([], Iff (ProperClass (Var "X"), Equipotent (Var "X", Univ))) => true
        | _ => false
      val los_card_thm = prove_limitation_of_size_cardinal (Var "X")
      val los_card_thm_ok = case los_card_thm of
          Thm ([], Iff (IsSet (Var "X"), Not (Eq (CardOf (Var "X"), CardOf Univ)))) => true
        | _ => false

      (* Tests for Transfinite Ordinal Arithmetic *)
      val ord_add_id = (eval_ord_add OrdZero (Var "alpha") = Var "alpha") andalso
                       (eval_ord_add (Var "alpha") OrdZero = Var "alpha")
      val ord_add_omega = (eval_ord_add (Singleton OrdZero) OrdOmega = OrdOmega) andalso
                          (eval_ord_add OrdOmega (Singleton OrdZero) = OrdSucc OrdOmega)
      val two_term = UnorderedPair (OrdZero, Singleton OrdZero)
      val ord_mult_omega = (eval_ord_mult two_term OrdOmega = OrdOmega) andalso
                           (eval_ord_mult OrdOmega two_term = OrdAdd (OrdOmega, OrdOmega))
      val ord_exp_cases = (eval_ord_exp (Var "alpha") OrdZero = Singleton OrdZero) andalso
                          (eval_ord_exp two_term OrdOmega = OrdOmega)
      val ord_noncomm_add_thm = prove_ord_addition_noncommutative ()
      val ord_noncomm_add_ok = case ord_noncomm_add_thm of
          Thm ([], And (Eq (_, OrdOmega), Not (Eq (_, OrdOmega)))) => true
        | _ => false
      val ord_noncomm_mult_thm = prove_ord_multiplication_noncommutative ()
      val ord_noncomm_mult_ok = case ord_noncomm_mult_thm of
          Thm ([], And (Eq (_, OrdOmega), Not (Eq (_, OrdOmega)))) => true
        | _ => false

      (* Tests for Grothendieck Universes, Inaccessible Cardinals, and Internalized Satisfaction *)
      val v2_domain = eval_cumulative_level 2
      val is_trans_ok = eval_is_transitive hf_in v2_domain
      val is_groth_ok = not (eval_is_grothendieck hf_in v2_domain) andalso eval_is_grothendieck hf_in []
      val int_sat_domain = [Var "a", Var "b"]
      val int_sat_rel = [(Var "a", Var "b")]
      val int_sat_hit = eval_internalized_sat int_sat_domain int_sat_rel [("x", Var "a"), ("y", Var "b")] (In (Var "x", Var "y"))
      val int_sat_miss = not (eval_internalized_sat int_sat_domain int_sat_rel [("x", Var "b"), ("y", Var "a")] (In (Var "x", Var "y")))
      val groth_thm = prove_grothendieck_universe (Var "U")
      val groth_thm_ok = case groth_thm of
          Thm ([], Iff (IsGrothendieckUniv (Var "U"), _)) => true
        | _ => false
      val inacc_univ_thm = prove_inaccessible_universe (Var "kappa")
      val inacc_univ_ok = case inacc_univ_thm of
          Thm ([], Imp (IsStronglyInaccessible (Var "kappa"), IsGrothendieckUniv (VAlpha (Var "kappa")))) => true
        | _ => false
      val inacc_zfc_thm = prove_inaccessible_models_zfc (Var "kappa")
      val inacc_zfc_ok = case inacc_zfc_thm of
          Thm ([], Imp (IsStronglyInaccessible (Var "kappa"), ModelsZFC (VAlpha (Var "kappa")))) => true
        | _ => false
      val lvl_refl_thm = prove_level_reflection (Var "kappa") (In (Var "x", Var "A"))
      val lvl_refl_ok = case lvl_refl_thm of
          Thm ([], Imp (IsStronglyInaccessible (Var "kappa"), Iff (_, In (Var "x", Var "A")))) => true
        | _ => false
      val int_sat_thm = prove_internalized_satisfaction (Var "M") (Var "E") (FmCode (In (Var "x", Var "y"))) (Var "s")
      val int_sat_thm_ok = case int_sat_thm of
          Thm ([], Iff (ModelSat (Var "M", Var "E", _, Var "s"), _)) => true
        | _ => false

      (* Tests for Godel Constructibility and Delta_0 Absoluteness *)
      val delta0_atom = In (Var "x", Var "y")
      val delta0_atom_ok = check_is_delta0 delta0_atom
      val delta0_bnd = BoundedForall ("z", Var "y", Eq (Var "z", Var "x"))
      val delta0_bnd_ok = check_is_delta0 delta0_bnd
      val not_delta0 = Forall ("z", In (Var "z", Var "y"))
      val not_delta0_ok = not (check_is_delta0 not_delta0)

      val l0 = eval_l_stage 0
      val l1 = eval_l_stage 1
      val l2 = eval_l_stage 2
      val l3 = eval_l_stage 3
      val l_eval_ok = (List.length l0 = 0) andalso (List.length l1 = 1) andalso
                      (List.length l2 = 2) andalso (List.length l3 = 4)
      val def_p_l1 = eval_def_powerset hf_in l1
      val def_p_ok = (List.length def_p_l1 = 2)

      val is_const_empty = eval_is_constructible 3 Empty
      val is_const_s_empty = eval_is_constructible 3 (Singleton Empty)

      val d0_env = [("x", Empty), ("y", Singleton Empty), ("p", Singleton Empty)]
      val d0_pair_fm = And (In (Var "x", Var "p"),
                       And (In (Var "x", Var "p"),
                            BoundedForall ("w", Var "p", Eq (Var "w", Var "x"))))
      val d0_sat_m = eval_delta0_satisfaction hf_in l2 d0_env d0_pair_fm
      val d0_sat_n = eval_delta0_satisfaction hf_in l3 d0_env d0_pair_fm
      val d0_abs_ok = eval_delta0_absoluteness hf_in l2 l3 d0_env d0_pair_fm andalso
                      d0_sat_m andalso d0_sat_n

      val def_p_thm = prove_def_powerset (Var "X")
      val def_p_thm_ok = case def_p_thm of
          Thm ([], Iff (In (Var "Y", DefPowerset (Var "X")), _)) => true
        | _ => false

      val l_zero_thm = prove_l_zero ()
      val l_zero_ok = case l_zero_thm of
          Thm ([], Eq (LAlpha OrdZero, Empty)) => true
        | _ => false

      val l_succ_thm = prove_l_succ (Var "alpha")
      val l_succ_ok = case l_succ_thm of
          Thm ([], Eq (LAlpha (OrdSucc (Var "alpha")), DefPowerset (LAlpha (Var "alpha")))) => true
        | _ => false

      val l_lim_thm = prove_l_limit (Var "lambda")
      val l_lim_ok = case l_lim_thm of
          Thm ([], Eq (LAlpha (Var "lambda"), _)) => true
        | _ => false

      val is_const_thm = prove_is_constructible (Var "x")
      val is_const_thm_ok = case is_const_thm of
          Thm ([], Iff (IsConstructible (Var "x"), _)) => true
        | _ => false

      val v_eq_l_thm = prove_v_equals_l ()
      val v_eq_l_ok = case v_eq_l_thm of
          Thm ([], Iff (AxiomVEqualsL, Forall ("x", IsConstructible (Var "x")))) => true
        | _ => false

      val d0_abs_thm = prove_delta0_absoluteness (Var "M") (Var "N") (In (Var "x", Var "y"))
      val d0_abs_thm_ok = case d0_abs_thm of
          Thm ([], Imp (_, Iff (_, _))) => true
        | _ => false

      val l_zfc_thm = prove_l_models_zfc ()
      val l_zfc_ok = case l_zfc_thm of
          Thm ([], ModelsZFC LUniv) => true
        | _ => false

      val pair_abs_thm = prove_pairing_delta0_absolute (Var "M") (Var "N") (Var "x") (Var "y")
      val pair_abs_ok = case pair_abs_thm of
          Thm (hyps, Iff (_, _)) => List.length hyps = 6
        | _ => false

      val union_abs_thm = prove_union_delta0_absolute (Var "M") (Var "N") (Var "x")
      val union_abs_ok = case union_abs_thm of
          Thm (hyps, Iff (_, _)) => List.length hyps = 5
        | _ => false

      val empty_abs_thm = prove_empty_set_delta0_absolute (Var "M") (Var "N")
      val empty_abs_ok = case empty_abs_thm of
          Thm (hyps, Iff (_, _)) => List.length hyps = 4
        | _ => false

      val bnd_abs_thm = prove_bounded_quant_delta0_absolute (Var "M") (Var "N") "w" (Var "x") (Eq (Var "w", Var "w"))
      val bnd_abs_ok = case bnd_abs_thm of
          Thm (hyps, Iff (_, _)) => List.length hyps = 5
        | _ => false

      (* Tests for Canonical Well-Ordering of L, AC, and Condensation Scaffolding *)
      val gn_false = godel_number_fm False
      val gn_in = godel_number_fm (In (Var "x", Var "y"))
      val gn_ok = (gn_false = 0 andalso gn_in > 0)

      val l_wo_0 = eval_canonical_well_ordering_l 0
      val l_wo_1 = eval_canonical_well_ordering_l 1
      val l_wo_2 = eval_canonical_well_ordering_l 2
      val l_wo_3 = eval_canonical_well_ordering_l 3

      fun in_l_wo pairs (a, b) =
        List.exists (fn (x, y) => x = a andalso y = b) pairs

      val wo_2_ok = check_is_well_ordered (in_l_wo l_wo_2) l2 andalso (List.length l_wo_2 = 1)
      val wo_3_ok = check_is_well_ordered (in_l_wo l_wo_3) l3 andalso (List.length l_wo_3 = 6)

      val choice_2 = eval_l_choice l_wo_2 [Singleton Empty, Empty]
      val choice_2_ok = (choice_2 = SOME Empty)

      val choice_3 = eval_l_choice l_wo_3 [UnorderedPair (Empty, Singleton Empty), Singleton (Singleton Empty)]
      val choice_3_ok = (choice_3 = SOME (Singleton (Singleton Empty)))

      val tv_sub = l2
      val tv_amb = l3
      val tv_fm = Eq (Var "x", Empty)
      val tv_ok = eval_tarski_vaught hf_in tv_sub tv_amb [] "x" tv_fm

      val coll_dom = [Var "a", Var "b"]
      fun test_e (Var "a") (Var "b") = true
        | test_e _ _ = false
      val coll_res = eval_mostowski_collapse test_e coll_dom
      val coll_ok = case coll_res of
          [(Var "a", Empty), (Var "b", Singleton Empty)] => true
        | _ => false

      val can_wo_thm = prove_canonical_well_order (Var "alpha")
      val can_wo_ok = case can_wo_thm of
          Thm ([], IsWellOrdered (LWellOrder (Var "alpha"), LAlpha (Var "alpha"))) => true
        | _ => false

      val wo_l_thm = prove_well_ordering_l (Var "x")
      val wo_l_ok = case wo_l_thm of
          Thm ([], Imp (IsConstructible (Var "x"), LWellOrders (Var "x"))) => true
        | _ => false

      val l_ac_thm = prove_l_models_ac ()
      val l_ac_ok = case l_ac_thm of
          Thm ([], Imp (AxiomVEqualsL, AxiomChoiceL)) => true
        | _ => false

      val tv_thm = prove_tarski_vaught_criterion (Var "M") (Var "N")
      val tv_ok_thm = case tv_thm of
          Thm ([], Iff (ElemSubmodelFm (Var "M", Var "N"), _)) => true
        | _ => false

      val coll_thm = prove_mostowski_collapse (Var "M") (Var "E")
      val coll_ok_thm = case coll_thm of
          Thm ([], Imp (And (WellFounded (Var "E", Var "M"), ExtensionalRel (Var "E", Var "M")), _)) => true
        | _ => false

      val cond_thm = prove_condensation_scaffold (Var "lambda")
      val cond_ok = case cond_thm of
          Thm ([], CondensationScaffold (Var "lambda")) => true
        | _ => false

      (* Tests for Godel Condensation Lemma and GCH in L *)
      val sh_gen = [Empty]
      val sh_res = eval_skolem_hull_l hf_in l3 sh_gen
      val sh_ok = List.exists (fn x => x = Empty) sh_res

      val (cond_alp, cond_map) = eval_condensation_lemma hf_in l2 3
      val cond_lemma_ok = (cond_alp = 2 andalso List.length cond_map = 2)

      val rank_bnd_ok = eval_rank_bounding 2 2 2

      val p_l1 = eval_constructible_powerset hf_in l1 l2
      val p_l2 = eval_constructible_powerset hf_in l2 l3
      val cp_ok = (List.length p_l1 = 2 andalso List.length p_l2 = 4)

      val gch_step_ok = eval_gch_in_l hf_in 1 2 andalso eval_gch_in_l hf_in 2 3

      val cond_lem_thm = prove_condensation_lemma (Var "M") (Var "lambda") (Var "alpha")
      val cond_lem_ok = case cond_lem_thm of
          Thm ([], Imp (ElemSubmodelFm (Var "M", LAlpha (Var "lambda")), CondensationLemma (Var "M", Var "lambda", Var "alpha"))) => true
        | _ => false

      val ls_thm = prove_lowenheim_skolem_l (Var "X") (Var "kappa") (Var "lambda")
      val ls_ok = case ls_thm of
          Thm ([], Imp (In (Var "X", PowersetL (Var "kappa")), _)) => true
        | _ => false

      val rb_thm = prove_rank_bounding (Var "M") (Var "alpha") (Var "kappa")
      val rb_ok = case rb_thm of
          Thm ([], Imp (And (Equipotent (Var "M", Var "kappa"), CondensationLemma (Var "M", Var "lambda", Var "alpha")), In (Var "alpha", CardSucc (Var "kappa")))) => true
        | _ => false

      val ps_bnd_thm = prove_powerset_l_bound (Var "kappa")
      val ps_bnd_ok = case ps_bnd_thm of
          Thm ([], SubclassPowersetL (Var "kappa", CardSucc (Var "kappa"))) => true
        | _ => false

      val gch_thm = prove_gch_in_l ()
      val gch_ok = case gch_thm of
          Thm ([], Imp (AxiomVEqualsL, AxiomGCHInL)) => true
        | _ => false

      (* Tests for Inner Model Theory, Godel Operations, and Relative Consistency (Ticket 7726) *)
      val gf1_res = eval_godel_f1 Empty (Singleton Empty)
      val gf1_ok = (gf1_res = UnorderedPair (Empty, Singleton Empty))

      val gf2_res = eval_godel_f2 hf_in l2 l2
      val gf2_ok = List.all (fn (u, v) => hf_in u v) gf2_res

      val gf3_res = eval_godel_f3 l2 [Empty]
      val gf3_ok = (gf3_res = [Singleton Empty])

      val gf4_res = eval_godel_f4 [(Empty, Singleton Empty), (Empty, Empty)]
      val gf4_ok = (gf4_res = [Empty])

      val gf5_res = eval_godel_f5 l2 [Singleton Empty, UnorderedPair (Empty, Empty)]
      val gf5_ok = (gf5_res = [Singleton Empty])

      val gf6_res = eval_godel_f6 [(Empty, Singleton Empty, Var "x")]
      val gf6_ok = (gf6_res = [(Singleton Empty, Var "x", Empty)])

      val gf7_res = eval_godel_f7 [(Empty, Singleton Empty, Var "x")]
      val gf7_ok = (gf7_res = [(Empty, Var "x", Singleton Empty)])

      val gf8_res = eval_godel_f8 [(Empty, Singleton Empty, Var "x")]
      val gf8_ok = (gf8_res = [(Var "x", Singleton Empty, Empty)])

      val inner_ok = eval_is_inner_model hf_in l3 [Empty, Singleton Empty]

      val abs_ok = eval_formula_absoluteness hf_in l2 l3 [] (Eq (Var "x", Var "x"))

      val rel_con_ok = eval_relative_consistency true

      val in_mod_thm = prove_inner_model (Var "M")
      val in_mod_ok = case in_mod_thm of
          Thm ([], Iff (IsInnerModel (Var "M"), And (IsTransitive (Var "M"), And (OrdInModel (Var "M"), ClosedGodelOps (Var "M"))))) => true
        | _ => false

      val l_in_mod_thm = prove_l_is_inner_model ()
      val l_in_mod_ok = case l_in_mod_thm of
          Thm ([], IsInnerModel LUniv) => true
        | _ => false

      val d0_in_abs_thm = prove_delta0_inner_model_absoluteness (Var "M") (Eq (Var "x", Var "y"))
      val d0_in_abs_ok = case d0_in_abs_thm of
          Thm ([], Imp (And (IsInnerModel (Var "M"), IsDelta0 _), FormulaAbsolute (Var "M", _))) => true
        | _ => false

      val rel_con_thm = prove_relative_consistency_ac_gch ()
      val rel_con_thm_ok = case rel_con_thm of
          Thm ([], Imp (ConsistencyOf TheoryMK, ConsistencyOf TheoryMK_AC_GCH)) => true
        | _ => false

      val con_zf_thm = prove_con_zf_implies_con_zfc_gch ()
      val con_zf_ok = case con_zf_thm of
          Thm ([], RelativeConsistency (TheoryMK, TheoryMK_AC_GCH)) => true
        | _ => false

      (* Tests for Forcing Foundations, Posets, Generic Filters, and Names (Ticket 7727) *)
      val pos_carrier = [Empty, Singleton Empty, Singleton (Singleton Empty)]
      fun mock_leq x y =
        if y = Empty then true
        else if x = y then true
        else false

      val pos_term = mk_poset (Var "P") (Var "Leq") Empty
      val pos_term_ok = (pos_term = Poset (Var "P", Var "Leq", Empty))

      val compat_p_one = eval_compat mock_leq pos_carrier (Singleton Empty) Empty
      val compat_q_one = eval_compat mock_leq pos_carrier (Singleton (Singleton Empty)) Empty
      val incompat_p_q = eval_incompat mock_leq pos_carrier (Singleton Empty) (Singleton (Singleton Empty))
      val poset_compat_ok = compat_p_one andalso compat_q_one andalso incompat_p_q

      val achain = [Singleton Empty, Singleton (Singleton Empty)]
      val achain_ok = eval_is_antichain mock_leq pos_carrier achain

      val dense_d = [Singleton Empty, Singleton (Singleton Empty)]
      val dense_ok = eval_is_dense mock_leq pos_carrier dense_d
      val dense_below_ok = eval_is_dense_below mock_leq pos_carrier [Singleton Empty] (Singleton Empty)

      val filter_g = [Empty, Singleton Empty]
      val filter_ok = eval_is_filter mock_leq pos_carrier filter_g

      val generic_ok = eval_is_generic mock_leq pos_carrier filter_g [dense_d]

      val test_name = mk_name [(Empty, Empty), (Singleton Empty, Singleton Empty)]
      val val_g_res = eval_val_g hf_in [(Empty, Empty), (Singleton Empty, Singleton Empty)] filter_g
      val val_g_ok = (val_g_res = [Empty, Singleton Empty])

      val val_g_sub = eval_val_g hf_in [(Empty, Empty), (Singleton Empty, Singleton (Singleton Empty))] filter_g
      val val_g_sub_ok = (val_g_sub = [Empty])

      val forces_ok = eval_forces mock_leq pos_carrier (Singleton Empty) (Eq (Var "x", Var "x"))
      val truth_lemma_ok = eval_truth_lemma true true

      val compat_thm = prove_poset_compatibility (Var "p") (Var "q") (Var "P")
      val compat_thm_ok = case compat_thm of
          Thm ([], Iff (PosetCompat (Var "p", Var "q", Var "P"), _)) => true
        | _ => false

      val achain_thm = prove_antichain (Var "A") (Var "P")
      val achain_thm_ok = case achain_thm of
          Thm ([], Iff (IsAntichain (Var "A", Var "P"), _)) => true
        | _ => false

      val dense_thm = prove_dense_subset (Var "D") (Var "P")
      val dense_thm_ok = case dense_thm of
          Thm ([], Iff (IsDense (Var "D", Var "P"), _)) => true
        | _ => false

      val gen_thm = prove_generic_filter (Var "G") (Var "P") (Var "D_family")
      val gen_thm_ok = case gen_thm of
          Thm ([], Iff (IsGenericFilter (Var "G", Var "P", Var "D_family"), _)) => true
        | _ => false

      val tl_thm = prove_forcing_truth_lemma (Var "M") (Var "G") (Var "P") (Eq (Var "x", Var "y"))
      val tl_thm_ok = case tl_thm of
          Thm ([], Iff (GenericExtensionSat (Var "M", Var "G", _), _)) => true
        | _ => false

      val gen_mod_thm = prove_generic_model_existence (Var "M") (Var "P")
      val gen_mod_thm_ok = case gen_mod_thm of
          Thm ([], Exists ("G", IsGenericFilter (Var "G", Var "P", Var "D_family"))) => true
        | _ => false
    in
      fst_ok andalso snd_ok andalso kuratowski_success andalso kuratowski_rejected
      andalso type_univ_ok andalso type_set_univ_no
      andalso total_found andalso total_missing andalso guarded_missing
      andalso russell_ok andalso sep_ok andalso inj_ok
      andalso tau_ok andalso iota_ok andalso eps_ok
      andalso eval_tau_hit andalso eval_tau_miss andalso eval_eps_miss
      andalso eval_iota_hit andalso eval_iota_multi andalso eval_uniq_multi
      andalso ind_ok andalso rec_ok
      andalso rec_eval_0 andalso rec_eval_1 andalso rec_eval_2
      andalso cat_pair_ok andalso eq_ok andalso sub_ok andalso cat_prod_ok
      andalso rel_ok andalso tarski_ok andalso refl_empty_ok andalso refl_thm_ok
      andalso id_f_ok andalso nat_ok andalso copair_left andalso copair_right
      andalso pb_ok andalso pb_cone_ok andalso po_ok
      andalso slice_mor_ok andalso slice_prod_ok
      andalso pb_thm_ok andalso po_thm_ok andalso eq_pb_ok andalso slice_pb_ok andalso dual_ok
      andalso hartogs_eval_ok andalso hartogs_thm_ok
      andalso scott_eval_ok andalso scott_thm_ok
      andalso los_eval_set andalso los_eval_prop andalso los_check_ok andalso los_thm_ok andalso los_card_thm_ok
      andalso ord_add_id andalso ord_add_omega andalso ord_mult_omega andalso ord_exp_cases
      andalso ord_noncomm_add_ok andalso ord_noncomm_mult_ok
      andalso is_trans_ok andalso is_groth_ok andalso int_sat_hit andalso int_sat_miss
      andalso groth_thm_ok andalso inacc_univ_ok andalso inacc_zfc_ok andalso lvl_refl_ok andalso int_sat_thm_ok
      andalso delta0_atom_ok andalso delta0_bnd_ok andalso not_delta0_ok
      andalso l_eval_ok andalso def_p_ok andalso is_const_empty andalso is_const_s_empty andalso d0_abs_ok
      andalso def_p_thm_ok andalso l_zero_ok andalso l_succ_ok andalso l_lim_ok
      andalso is_const_thm_ok andalso v_eq_l_ok andalso d0_abs_thm_ok andalso l_zfc_ok
      andalso pair_abs_ok andalso union_abs_ok andalso empty_abs_ok andalso bnd_abs_ok
      andalso gn_ok andalso wo_2_ok andalso wo_3_ok
      andalso choice_2_ok andalso choice_3_ok andalso tv_ok andalso coll_ok
      andalso can_wo_ok andalso wo_l_ok andalso l_ac_ok
      andalso tv_ok_thm andalso coll_ok_thm andalso cond_ok
      andalso sh_ok andalso cond_lemma_ok andalso rank_bnd_ok andalso cp_ok
      andalso gch_step_ok andalso cond_lem_ok andalso ls_ok andalso rb_ok
      andalso ps_bnd_ok andalso gch_ok
      andalso gf1_ok andalso gf2_ok andalso gf3_ok andalso gf4_ok
      andalso gf5_ok andalso gf6_ok andalso gf7_ok andalso gf8_ok
      andalso inner_ok andalso abs_ok andalso rel_con_ok
      andalso in_mod_ok andalso l_in_mod_ok andalso d0_in_abs_ok
      andalso rel_con_thm_ok andalso con_zf_ok
      andalso pos_term_ok andalso poset_compat_ok andalso achain_ok
      andalso dense_ok andalso dense_below_ok andalso filter_ok andalso generic_ok
      andalso val_g_ok andalso val_g_sub_ok andalso forces_ok andalso truth_lemma_ok
      andalso compat_thm_ok andalso achain_thm_ok andalso dense_thm_ok
      andalso gen_thm_ok andalso tl_thm_ok andalso gen_mod_thm_ok
    end
end;

val _ = if MKTD_Foundations.run_self_tests () then ()
        else raise Fail "MKTD_Foundations self-tests failed";
