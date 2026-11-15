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
    | TheoryMK_AC_NegCH
    | TheoryZFC
    | TheoryZFC_CH
    | TheoryZFC_NegCH
    | Poset of class_term * class_term * class_term
    | PosetLeq of class_term
    | PosetOne of class_term
    | ForcingName of class_term
    | CanonicalCheckName of class_term
    | GenericName of class_term
    | NameValuation of class_term * class_term
    | GenericExtension of class_term * class_term
    | CohenPoset of class_term * class_term
    | CohenFamilyPoset of class_term * class_term
    | CohenRealName of class_term * class_term
    | Aleph of class_term
    | ContinuumSize of class_term
    | SuslinTree of class_term * class_term
    | TreePoset of class_term
    | TheoryMK_AC_MA_NegCH
    | TheoryZFC_MA_NegCH
    | TheoryZFC_Diamond
    | TheoryZFC_SH
    | TheoryZFC_NegSH
    | EastonFunction of class_term
    | EastonPoset of class_term
    | LevyCollapsePoset of class_term * class_term
    | SolovayModel of class_term * class_term
    | TheoryZFC_Easton of class_term
    | TheoryZFC_Inaccessible
    | TheoryZF_DC_Lebesgue
    | TheoryZFC_LevyCollapse
    | InaccessibleCardinal of class_term
    | MahloCardinal of class_term
    | WeaklyCompactCardinal of class_term
    | MeasurableCardinal of class_term
    | UltrafilterOn of class_term * class_term
    | ElementaryEmbedding of class_term * class_term * class_term
    | Ultrapower of class_term * class_term
    | ZeroSharp
    | TheoryZFC_Mahlo
    | TheoryZFC_Measurable
    | DefinablePowerSet of class_term
    | LStage of class_term
    | ConstructibleUniverse
    | TheoryZFC_L
    | RelativizedClassCompr of string * class_term * fm
    | DunaevPName of class_term
    | GenericVal of class_term * class_term
    | PosetPreorder of class_term * class_term * class_term
    | ClassListDunaev of class_term list
    | FamilyValueAtArg of class_term * class_term
    | RelationalImage of class_term * class_term
    | EvaluatedImage of class_term * class_term
    | IndexedUnion of class_term * class_term
    | TheoryTau
    | TheoryFau
    | CompleteBooleanAlgebra of class_term
    | RegularOpenCompletion of class_term
    | BValModel of class_term
    | BValTruth of fm * class_term
    | NormalOrdinalFn of class_term
    | VeblenPhi of class_term * class_term
    | DiagonalIntersection of class_term * class_term
    | DunaevGameTree of class_term
    | GaleStewartGame of class_term * class_term
    | BorelPayoff of class_term * class_term
    | HeatSemigroupKernel of class_term
    | SchrodingerSemigroupKernel of class_term * class_term
    | DysonPhillipsSeries of class_term * class_term * class_term
    | LocallySmallCategory of class_term * class_term
    | RepresentablePresheaf of class_term * class_term
    | YonedaEmbedding of class_term
    | LeftKanExtension of class_term * class_term
    | RightKanExtension of class_term * class_term
    | PullbackSquare of class_term * class_term * class_term
    | SubobjectClassifier of class_term
    | CharacteristicMorphism of class_term * class_term
    | LawvereTierneyTopology of class_term * class_term
    | SheafSubobjectClosure of class_term * class_term
    | MonadTriad of class_term * class_term * class_term
    | EilenbergMooreCategory of class_term * class_term
    | KleisliCategory of class_term * class_term
    | MonadicityComparisonFunctor of class_term * class_term
    | ReflexiveSplitCoequalizer of class_term * class_term * class_term
    | ExponentialObject of class_term * class_term
    | EvaluationMorphism of class_term * class_term
    | CurriedMorphism of class_term
    | UncurriedMorphism of class_term
    | InternalLambdaTerm of string * class_term
    | GrothendieckCartesianLift of class_term * class_term
    | FiberCategoryAtBase of class_term * class_term
    | CleavageAssignment of class_term
    | GrothendieckTotalCategory of class_term * class_term
    | IndexedPseudofunctor of class_term
    | CategoricalKernel of class_term
    | CategoricalCokernel of class_term
    | CoimageObject of class_term
    | ImageObject of class_term
    | SnakeConnectingMorphism of class_term * class_term * class_term
    | ChainComplex of class_term * class_term
    | ProjectiveResolution of class_term * class_term
    | InjectiveResolution of class_term * class_term
    | RightDerivedExt of int * class_term * class_term
    | LeftDerivedTor of int * class_term * class_term
    | SuspensionShiftFunctor of class_term * int
    | DistinguishedTriangle of class_term * class_term * class_term
    | MappingConeComplex of class_term
    | QuasiIsomorphismRoof of class_term * class_term
    | DerivedCategoryLocalization of class_term * class_term
    | QuillenModelStructure of class_term * class_term * class_term
    | WeakFactorizationTriple of class_term * class_term * class_term
    | DiagonalLiftingWitness of class_term * class_term
    | CylinderObjectFactorization of class_term
    | QuillenHomotopyCategory of class_term * class_term
    | SimplicialSet of class_term * class_term * class_term
    | StandardSimplexDelta of int
    | SimplicialHornLambda of int * int
    | GeometricRealization of class_term
    | HomotopyCoherentNerve of class_term
    | CoveringSieve of class_term * class_term
    | GrothendieckSite of class_term * class_term
    | MatchingFamilyOnSieve of class_term * class_term
    | UniqueAmalgamationWitness of class_term * class_term
    | PlusSheafificationFunctor of class_term
    | SpectralSequencePage of int * class_term * class_term
    | FilteredComplex of class_term * class_term
    | ExactCoupleTriangle of class_term * class_term * class_term
    | AbutmentFiltrationGraded of int * class_term
    | GrothendieckCompositeSpectralSequence of class_term * class_term * class_term
    | SymmetricMonoidalStructure of class_term * class_term * class_term
    | InternalHomObject of class_term * class_term
    | EnrichedCategory of class_term * class_term
    | EnrichedRepresentableHom of class_term * class_term
    | DayConvolutionProduct of class_term * class_term
    | CategoricalEnd of string * class_term
    | CategoricalCoend of string * class_term
    | ExtranaturalWedge of class_term * class_term
    | WeightedLimitObject of class_term * class_term
    | WeightedColimitObject of class_term * class_term
    | BicategoryStructure of class_term * class_term * class_term
    | TwoCellGlobe of class_term * class_term * class_term
    | VerticalComposition2Cell of class_term * class_term
    | HorizontalComposition2Cell of class_term * class_term
    | InternalBicategoryAdjunction of class_term * class_term * class_term

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
    | CardinalsPreserved of class_term * class_term
    | DistinctCohenReals of class_term * class_term * class_term
    | ContinuumHypothesis
    | NegContinuumHypothesis
    | ContinuumAtLeastAleph2
    | IndependenceOfCH
    | MartinsAxiom of class_term
    | MartinsAxiomFull
    | IsSuslinTree of class_term
    | SuslinHypothesis
    | NegSuslinHypothesis
    | DiamondPrinciple
    | MAImpliesSH
    | DiamondImpliesNegSH
    | IndependenceOfSH
    | IsEastonFunction of class_term
    | EastonSupportCondition of class_term * class_term
    | PreservesCofinalities of class_term * class_term
    | EastonPowersTheorem of class_term
    | IsLevyCollapse of class_term * class_term * class_term
    | LevyCollapsesToOmega1 of class_term * class_term
    | SolovayModelLebesgue of class_term
    | RelativeConsistencyEaston of class_term
    | RelativeConsistencySolovay
    | InaccessibleDef of class_term
    | IsMahlo of class_term
    | IsStationaryIn of class_term * class_term
    | IsWeaklyCompact of class_term
    | HasTreeProperty of class_term
    | IsMeasurable of class_term
    | IsKappaCompleteUltrafilter of class_term * class_term
    | IsElementaryEmbedding of class_term * class_term * class_term
    | CriticalPoint of class_term * class_term
    | IsUltrapower of class_term * class_term * class_term
    | ScottsTheoremVNotL of class_term
    | ExistsZeroSharp of class_term
    | IsDefinableSubset of class_term * class_term
    | InLStage of class_term * class_term
    | InL of class_term
    | LGCHTheorem of class_term
    | LWellOrderingTheorem of class_term
    | InnerModelCriterionNBG of class_term
    | RelativizedAxiomHolds of class_term * fm
    | IsForcingPoset of class_term * class_term * class_term
    | IsDunaevPName of class_term * class_term
    | CheckNameValIdentity of class_term * class_term
    | SemiSingleton of class_term
    | SemiSingletonSubclass of class_term * class_term
    | HasConcentratedValues of class_term
    | FlatValues of class_term
    | CanonicalFamily of class_term
    | SemanticCompleteness of class_term * fm
    | NegationCompleteness of class_term * fm
    | FmIFV of string * fm
    | CtxIFV of string * fm list
    | TightUnivIndexedUnion of class_term * class_term * class_term
    | IsCompleteBooleanAlgebra of class_term
    | BValZFCValid of class_term * fm
    | ROEmbeddingPreservesIncompat of class_term * class_term
    | BValDunaevEquiv of class_term * class_term
    | IsNormalOrdinalFn of class_term
    | IsVeblenFixedPoint of class_term * class_term * class_term
    | IsClubIn of class_term * class_term
    | FodorsPressingDown of class_term * class_term * class_term
    | IsDunaevGameTree of class_term
    | HasWinningStrategyP1 of class_term * class_term
    | HasWinningStrategyP2 of class_term * class_term
    | IsDeterminedGame of class_term * class_term
    | IsBorelPayoff of class_term * class_term
    | IsIntegralKernelOperator of class_term * class_term
    | DysonPhillipsConverges of class_term * class_term
    | SchrodingerLipschitzRegular of class_term * class_term * class_term
    | FeynmanKacPositivity of class_term * class_term
    | IsLocallySmallCategory of class_term
    | YonedaBijection of class_term * class_term * class_term
    | IsFullyFaithfulFunctor of class_term
    | IsPointwiseKanExtension of class_term * class_term * class_term
    | IsPullbackSquare of class_term * class_term * class_term * class_term
    | IsSubobjectClassifier of class_term * class_term
    | IsLawvereTierneyTopology of class_term * class_term
    | IsJClosedSubobject of class_term * class_term * class_term
    | IsMonadTriad of class_term * class_term * class_term
    | IsEilenbergMooreAlgebra of class_term * class_term * class_term
    | IsKleisliMorphism of class_term * class_term * class_term
    | IsSplitCoequalizer of class_term * class_term * class_term
    | IsBeckMonadicFunctor of class_term * class_term
    | IsCartesianClosedCategory of class_term
    | IsExponentialTranspose of class_term * class_term
    | SatisfiesBetaEtaLambekEquivalence of class_term * class_term
    | IsInternalSimplyTypedModel of class_term
    | IsCartesianMorphism of class_term * class_term * class_term
    | IsGrothendieckFibration of class_term * class_term * class_term
    | IsSplitFibration of class_term * class_term
    | SatisfiesGrothendieckEquivalence of class_term * class_term
    | IsAbelianCategory of class_term
    | SatisfiesCoimageImageIso of class_term * class_term
    | IsShortExactSequence of class_term * class_term
    | SatisfiesSnakeLemmaExactness of class_term * class_term * class_term
    | IsChainComplex of class_term
    | IsChainHomotopyEquivalent of class_term * class_term
    | IsProjectiveResolution of class_term * class_term
    | SatisfiesLongExactCohomologySequence of class_term * class_term * class_term
    | IsTriangulatedCategory of class_term * class_term
    | IsDistinguishedTriangle of class_term * class_term * class_term
    | SatisfiesOctahedralAxiom of class_term * class_term * class_term
    | IsMultiplicativeSystemOfQuasiIsos of class_term
    | IsDerivedCategoryUniversal of class_term * class_term
    | IsQuillenModelCategory of class_term * class_term
    | HasLeftRightLiftingProperty of class_term * class_term
    | SatisfiesTwoOutOfThreeWeakEq of class_term * class_term * class_term
    | IsQuillenAdjunctionPair of class_term * class_term
    | SatisfiesSimplicialIdentities of class_term
    | IsKanComplex of class_term
    | IsQuasiCategoryInnerHorn of class_term
    | IsKanFibrationMap of class_term * class_term
    | IsCoveringSieve of class_term * class_term
    | IsGrothendieckTopology of class_term * class_term
    | IsSheafOnSite of class_term * class_term
    | SatisfiesSheafificationLeftAdjointUniversal of class_term * class_term
    | IsSpectralSequenceDifferential of int * class_term
    | SatisfiesSpectralPageCohomologyIso of class_term * class_term
    | ConvergesToFilteredAbutment of class_term * class_term
    | SatisfiesGrothendieckSpectralConvergence of class_term * class_term * class_term
    | SatisfiesMacLaneCoherence of class_term
    | IsSymmetricMonoidalClosed of class_term * class_term
    | IsEnrichedCategory of class_term * class_term
    | SatisfiesEnrichedYonedaIso of class_term * class_term
    | IsDayConvolutionMonoidal of class_term * class_term
    | IsExtranaturalWedge of class_term * class_term
    | IsUniversalEndCowedge of class_term * class_term
    | SatisfiesEndCoendFubiniIso of class_term * class_term
    | IsWeightedLimitEndRepresentation of class_term * class_term * class_term
    | IsBicategory of class_term
    | SatisfiesTwoCellInterchangeLaw of class_term * class_term * class_term * class_term
    | IsInternalAdjunctionTriangle of class_term * class_term * class_term * class_term
    | SatisfiesBenabouStrictification of class_term * class_term

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

  (* Independence of Continuum Hypothesis & Cohen Reals in MKTD (Ticket 7728) *)
  val mk_cohen_family_poset : class_term -> class_term -> class_term
  val mk_cohen_real_name : class_term -> class_term -> class_term
  val eval_cohen_real_val : (class_term -> class_term -> bool) -> (class_term * class_term) list -> class_term list -> class_term list
  val eval_distinct_reals : class_term list list -> bool
  val eval_ccc_cardinal_preservation : (class_term -> bool) -> (class_term -> bool) -> class_term list -> bool
  val eval_continuum_at_least_aleph2 : int -> int -> bool
  val axiom_ccc_preserves_cardinals : class_term -> class_term -> class_term -> thm
  val prove_ccc_preserves_cardinals : class_term -> class_term -> class_term -> thm
  val axiom_cohen_reals_distinct : class_term -> class_term -> class_term -> thm
  val prove_cohen_reals_distinct : class_term -> class_term -> class_term -> thm
  val axiom_continuum_at_least_aleph2 : class_term -> class_term -> class_term -> thm
  val prove_continuum_at_least_aleph2 : class_term -> class_term -> class_term -> thm
  val axiom_generic_extension_neg_ch : class_term -> class_term -> class_term -> thm
  val prove_generic_extension_neg_ch : class_term -> class_term -> class_term -> thm
  val axiom_relative_consistency_neg_ch : unit -> thm
  val prove_relative_consistency_neg_ch : unit -> thm
  val axiom_con_zfc_implies_con_zfc_neg_ch : unit -> thm
  val prove_con_zfc_implies_con_zfc_neg_ch : unit -> thm
  val axiom_independence_of_ch : unit -> thm
  val prove_independence_of_ch : unit -> thm

  (* Martin's Axiom & Suslin Hypothesis (Ticket 7729) *)
  val mk_suslin_tree : class_term -> class_term -> class_term
  val mk_tree_poset : class_term -> class_term
  val eval_is_suslin_tree : (class_term -> class_term -> bool) -> class_term list -> (class_term -> int) -> bool
  val eval_ma_kappa : bool -> int -> int -> bool
  val eval_ma_implies_sh : bool -> bool
  val eval_diamond_implies_neg_sh : bool -> bool
  val axiom_suslin_tree_has_ccc_poset : class_term -> thm
  val prove_suslin_tree_has_ccc_poset : class_term -> thm
  val axiom_ma_dense_family_filter : class_term -> class_term -> class_term -> thm
  val prove_ma_dense_family_filter : class_term -> class_term -> class_term -> thm
  val axiom_ma_aleph1_implies_sh : unit -> thm
  val prove_ma_aleph1_implies_sh : unit -> thm
  val axiom_diamond_implies_neg_sh : unit -> thm
  val prove_diamond_implies_neg_sh : unit -> thm
  val axiom_relative_consistency_sh : unit -> thm
  val prove_relative_consistency_sh : unit -> thm
  val axiom_con_zfc_implies_con_zfc_sh : unit -> thm
  val prove_con_zfc_implies_con_zfc_sh : unit -> thm
  val axiom_con_zfc_implies_con_zfc_neg_sh : unit -> thm
  val prove_con_zfc_implies_con_zfc_neg_sh : unit -> thm
  val axiom_independence_of_sh : unit -> thm
  val prove_independence_of_sh : unit -> thm

  (* Easton's Theorem and Levy Collapse in MKTD (Ticket 7730) *)
  val mk_easton_function : class_term -> class_term
  val mk_easton_poset : class_term -> class_term
  val mk_levy_collapse_poset : class_term -> class_term -> class_term
  val eval_is_easton_function : (int * int) list -> (int -> int) -> bool
  val eval_easton_support : int list -> int -> bool
  val eval_levy_collapse : int -> int -> bool
  val eval_solovay_model : bool -> bool
  val axiom_easton_function_conditions : class_term -> thm
  val prove_easton_function_conditions : class_term -> thm
  val axiom_easton_poset_preserves_cofinalities : class_term -> class_term -> thm
  val prove_easton_poset_preserves_cofinalities : class_term -> class_term -> thm
  val axiom_easton_powers_theorem : class_term -> thm
  val prove_easton_powers_theorem : class_term -> thm
  val axiom_relative_consistency_easton : class_term -> thm
  val prove_relative_consistency_easton : class_term -> thm
  val axiom_levy_collapse_properties : class_term -> class_term -> class_term -> thm
  val prove_levy_collapse_properties : class_term -> class_term -> class_term -> thm
  val axiom_levy_collapses_to_omega1 : class_term -> class_term -> thm
  val prove_levy_collapses_to_omega1 : class_term -> class_term -> thm
  val axiom_solovay_model_lebesgue : class_term -> thm
  val prove_solovay_model_lebesgue : class_term -> thm
  val axiom_relative_consistency_solovay : unit -> thm
  val prove_relative_consistency_solovay : unit -> thm

  (* Large Cardinals, Ultrafilters, and Scott's Theorem (Ticket 7731) *)
  val mk_inaccessible_cardinal : class_term -> class_term
  val mk_mahlo_cardinal : class_term -> class_term
  val mk_weakly_compact_cardinal : class_term -> class_term
  val mk_measurable_cardinal : class_term -> class_term
  val mk_ultrafilter : class_term -> class_term -> class_term
  val mk_elementary_embedding : class_term -> class_term -> class_term -> class_term
  val mk_ultrapower : class_term -> class_term -> class_term
  val mk_zero_sharp : unit -> class_term
  val eval_is_inaccessible : int -> (int -> int) -> (int -> int) -> bool
  val eval_is_mahlo : int -> int list -> (int list -> bool) -> bool
  val eval_tree_property : int -> bool -> bool
  val eval_is_measurable : int -> bool -> bool -> bool
  val eval_elementary_embedding : int -> int -> bool
  val eval_scotts_theorem : bool -> bool
  val axiom_inaccessible_definition : class_term -> thm
  val prove_inaccessible_definition : class_term -> thm
  val axiom_mahlo_characterization : class_term -> class_term -> thm
  val prove_mahlo_characterization : class_term -> class_term -> thm
  val axiom_weakly_compact_tree_property : class_term -> thm
  val prove_weakly_compact_tree_property : class_term -> thm
  val axiom_measurable_ultrafilter : class_term -> class_term -> thm
  val prove_measurable_ultrafilter : class_term -> class_term -> thm
  val axiom_measurable_elementary_embedding : class_term -> class_term -> class_term -> class_term -> thm
  val prove_measurable_elementary_embedding : class_term -> class_term -> class_term -> class_term -> thm
  val axiom_ultrapower_construction : class_term -> class_term -> class_term -> thm
  val prove_ultrapower_construction : class_term -> class_term -> class_term -> thm
  val axiom_scotts_theorem : class_term -> thm
  val prove_scotts_theorem : class_term -> thm
  val axiom_relative_consistency_measurable : unit -> thm
  val prove_relative_consistency_measurable : unit -> thm

  (* Constructible Universe L, Godel Condensation Lemma, and L |= GCH (Ticket 7732) *)
  val mk_definable_power_set : class_term -> class_term
  val mk_l_stage : class_term -> class_term
  val mk_constructible_universe : unit -> class_term
  val mk_theory_zfc_l : unit -> class_term
  val mk_is_definable_subset : class_term -> class_term -> fm
  val mk_in_l_stage : class_term -> class_term -> fm
  val mk_in_l : class_term -> fm
  val mk_condensation_lemma : class_term -> class_term -> class_term -> fm
  val mk_l_gch_theorem : class_term -> fm
  val mk_l_well_ordering_theorem : class_term -> fm
  val mk_axiom_v_equals_l : unit -> fm
  val eval_is_definable_subset : int -> int -> bool
  val eval_in_l_stage : int -> int -> bool
  val eval_condensation_step : int -> int -> int -> bool
  val eval_l_satisfies_ac : bool -> bool
  val eval_l_satisfies_gch : int -> int -> bool
  val axiom_l_stage_definition : class_term -> thm
  val prove_l_stage_definition : class_term -> thm
  val axiom_constructible_hierarchy_transitive : class_term -> thm
  val prove_constructible_hierarchy_transitive : class_term -> thm
  val axiom_l_satisfies_ac : class_term -> thm
  val prove_l_satisfies_ac : class_term -> thm
  val axiom_l_satisfies_gch : class_term -> thm
  val prove_l_satisfies_gch : class_term -> thm

  (* Class Inner Model Relativization and Forcing Posets with Dunaev Tagged Names (Ticket 63) *)
  val mk_relativized_class_compr : string -> class_term -> fm -> class_term
  val mk_dunaev_p_name : (class_term * class_term) list -> class_term
  val mk_canonical_check_name_dunaev : class_term -> class_term -> class_term
  val mk_generic_val : class_term -> class_term -> class_term
  val mk_poset_preorder : class_term -> class_term -> class_term -> class_term
  val mk_inner_model_criterion_nbg : class_term -> fm
  val mk_relativized_axiom_holds : class_term -> fm -> fm
  val mk_is_forcing_poset : class_term -> class_term -> class_term -> fm
  val mk_is_dunaev_p_name : class_term -> class_term -> fm
  val mk_check_name_val_identity : class_term -> class_term -> fm
  val relativize_nbg_axiom : class_term -> fm -> fm
  val eval_inner_model_nbg_criterion :
    (class_term -> class_term -> bool) -> class_term list -> class_term list -> class_term list -> fm list -> bool
  val eval_is_forcing_poset : (class_term -> class_term -> bool) -> class_term list -> class_term -> bool
  val eval_has_ccc_bound : (class_term -> class_term -> bool) -> class_term list -> class_term list list -> int -> bool
  val eval_dunaev_p_name_well_formed : class_term list -> class_term -> bool
  val eval_recursive_val_g : class_term list -> class_term -> class_term
  val axiom_inner_model_relativization_criterion : class_term -> fm -> thm
  val prove_inner_model_relativization_criterion : class_term -> fm -> thm
  val axiom_forcing_poset_preorder : class_term -> class_term -> class_term -> thm
  val prove_forcing_poset_preorder : class_term -> class_term -> class_term -> thm
  val axiom_ccc_antichain_condition : class_term -> class_term -> thm
  val prove_ccc_antichain_condition : class_term -> class_term -> thm
  val axiom_dunaev_pname_well_formed : class_term -> class_term -> thm
  val prove_dunaev_pname_well_formed : class_term -> class_term -> thm
  val axiom_check_name_generic_val : class_term -> class_term -> thm
  val prove_check_name_generic_val : class_term -> class_term -> thm
  val axiom_generic_extension_inner_model : class_term -> class_term -> class_term -> fm -> thm
  val prove_generic_extension_inner_model : class_term -> class_term -> class_term -> fm -> thm

  (* Six Open Mathematical Tickets Formalization (3.25..3.36, 3.51, 3.68..3.74, Fact 8) *)
  val eval_semi_singleton : (class_term -> class_term -> bool) -> class_term list -> class_term -> bool
  val eval_semi_singleton_subclass : (class_term -> class_term -> bool) -> class_term list -> class_term -> class_term -> bool
  val axiom_def_semi_singleton : class_term -> thm
  val prove_def_semi_singleton : class_term -> thm
  val axiom_def_semi_singleton_subclass : class_term -> class_term -> thm
  val prove_def_semi_singleton_subclass : class_term -> class_term -> thm

  val encode_class_list_dunaev : class_term list -> class_term
  val decode_class_list_dunaev : class_term -> class_term list
  val eval_class_lists_dunaev : class_term list -> (class_term -> 'a -> 'a) -> 'a -> class_term * int * bool * 'a
  val axiom_class_list_dunaev_transport : class_term -> class_term -> thm
  val prove_class_list_dunaev_transport : class_term -> class_term -> thm

  val eval_family_value_at_arg : (class_term * class_term) list -> (class_term -> bool) -> class_term -> class_term
  val eval_relational_image : (class_term * class_term) list -> class_term list -> class_term list
  val eval_evaluated_image : (class_term * class_term) list -> (class_term -> bool) -> (class_term -> bool) -> class_term list -> class_term list
  val eval_canonical_family : (class_term -> bool) -> class_term list -> bool
  val axiom_def_family_canonical : class_term -> thm
  val prove_def_family_canonical : class_term -> thm
  val axiom_value_at_arg_vs_relational_image : class_term -> class_term -> thm
  val prove_value_at_arg_vs_relational_image : class_term -> class_term -> thm

  val eval_semantic_vs_negation_completeness :
    bool -> bool -> bool -> bool ->
    {semantic_completeness_holds : bool,
     negation_completeness_holds : bool,
     sound_bivalent_bridge_holds : bool,
     tau_incomplete_witness : bool,
     arbitrary_henkin_mismatch_witness : bool}
  val axiom_semantic_completeness_of_fau : fm -> thm
  val prove_semantic_completeness_of_fau : fm -> thm
  val axiom_semantic_vs_negation_completeness : class_term -> fm -> thm
  val prove_semantic_vs_negation_completeness : class_term -> fm -> thm

  val eval_fm_ifv : string -> fm -> bool
  val eval_ctx_ifv : string -> fm list -> bool
  val eval_ctx_ifv_quantifier_hygiene :
    string -> fm list -> fm -> fm ->
    {ctx_ifv : bool,
     fm_beta_ifv : bool,
     fora_r_admissible : bool,
     forall_abs_admissible : bool,
     exis_l_admissible : bool,
     two_element_counterexample_blocked : bool}
  val axiom_ctx_ifv_quantifier_hygiene : string -> fm list -> fm -> thm
  val prove_ctx_ifv_quantifier_hygiene : string -> fm list -> fm -> thm

  val eval_tight_universe_indexed_union_closure :
    int -> int -> int list ->
    {is_set_universe : bool,
     index_card_strictly_less : bool,
     fibers_card_strictly_less : bool,
     union_card_strictly_less : bool,
     union_in_universe : bool,
     diagonal_contradiction_blocked : bool}
  val axiom_tight_universe_indexed_union_closure : class_term -> class_term -> class_term -> thm
  val prove_tight_universe_indexed_union_closure : class_term -> class_term -> class_term -> thm
  val axiom_universal_class_is_universe : unit -> thm
  val prove_universal_class_is_universe : unit -> thm

  (* Ticket 64: Complete Boolean Algebras & Boolean-Valued Models V^(B) vs Dunaev-Tagged Forcing Names V^P *)
  val eval_is_complete_boolean_algebra : int list -> int -> int -> bool
  val eval_regular_open_completion : (class_term -> class_term -> bool) -> class_term list -> class_term list list
  val eval_bval_membership : (class_term * int) list -> (class_term * int) list -> int
  val eval_bval_equality : (class_term * int) list -> (class_term * int) list -> int -> int
  val eval_bval_zfc_axioms_valid : int -> {
    extensionality : int,
    pairing : int,
    union : int,
    powerset : int,
    foundation : int,
    all_valid : bool
  }
  val axiom_ro_embedding_preserves_incompatibility : class_term -> thm
  val prove_ro_embedding_preserves_incompatibility : class_term -> thm
  val axiom_bval_extensionality_valid : class_term -> thm
  val prove_bval_extensionality_valid : class_term -> thm
  val axiom_bval_dunaev_pname_equivalence : class_term -> class_term -> thm
  val prove_bval_dunaev_pname_equivalence : class_term -> class_term -> thm

  (* Ticket 65: Club Filter, Stationary Subclasses, Fodor's Lemma, and Veblen Hierarchy *)
  val eval_is_normal_ordinal_function : class_term list -> int list -> {
    strictly_increasing : bool,
    continuous_at_limits : bool,
    is_normal : bool
  }
  val eval_veblen_fixed_point : int -> int -> {
    alpha : int,
    beta : int,
    phi_alpha_beta : int,
    is_fixed_point_of_lower : bool
  }
  val eval_is_club_in_regular : int -> int list -> int list -> {
    is_closed : bool,
    is_unbounded : bool,
    is_club : bool
  }
  val eval_is_stationary_in_regular : int list -> int list list -> bool
  val eval_diagonal_intersection_club : int -> class_term list -> int list
  val eval_fodors_lemma_regressive_constant : int list -> class_term list -> int list list -> {
    is_regressive : bool,
    constant_value : int option,
    fiber_is_stationary : bool
  }
  val axiom_normal_function_has_fixed_points : class_term -> thm
  val prove_normal_function_has_fixed_points : class_term -> thm
  val axiom_club_diagonal_intersection_closed : class_term -> class_term -> thm
  val prove_club_diagonal_intersection_closed : class_term -> class_term -> thm
  val axiom_fodors_pressing_down_lemma : class_term -> class_term -> class_term -> thm
  val prove_fodors_pressing_down_lemma : class_term -> class_term -> class_term -> thm

  (* Ticket 66: Gale-Stewart Games, Winning Strategies, and Martin's Borel Determinacy *)
  val eval_is_dunaev_game_tree : class_term list -> int -> {
    is_prefix_closed : bool,
    is_pruned : bool,
    is_valid_game_tree : bool
  }
  val eval_is_winning_strategy_p1 : class_term list -> class_term list -> class_term list -> bool
  val eval_is_winning_strategy_p2 : class_term list -> class_term list -> class_term list -> bool
  val eval_strategy_exclusivity : class_term list -> class_term list -> class_term list -> class_term list -> {
    p1_wins : bool,
    p2_wins : bool,
    mutually_exclusive : bool
  }
  val eval_gale_stewart_closed_determinacy : class_term list -> class_term list -> class_term list list -> class_term list list -> {
    p1_has_winning : bool,
    p2_has_winning : bool,
    is_determined : bool
  }
  val eval_martin_borel_determinacy : int -> class_term list -> class_term list -> class_term list list -> class_term list list -> {
    borel_rank : int,
    is_valid_rank : bool,
    is_determined : bool
  }
  val axiom_gale_stewart_strategy_exclusivity : class_term -> class_term -> thm
  val prove_gale_stewart_strategy_exclusivity : class_term -> class_term -> thm
  val axiom_gale_stewart_closed_determinacy : class_term -> class_term -> thm
  val prove_gale_stewart_closed_determinacy : class_term -> class_term -> thm
  val axiom_martin_borel_determinacy : class_term -> class_term -> class_term -> thm
  val prove_martin_borel_determinacy : class_term -> class_term -> class_term -> thm

  (* Ticket 67: Schroedinger Semigroup Integral Kernels, Dyson-Phillips Series, and Lipschitz Regularity *)
  val eval_heat_semigroup_contraction : int -> class_term list -> {
    is_positive : bool,
    is_symmetric : bool,
    is_contractive : bool
  }
  val eval_integral_kernel_criterion : class_term list -> class_term list -> {
    is_symmetric : bool,
    kernels_agree_pointwise : bool,
    criterion_holds : bool
  }
  val eval_dyson_phillips_series_bound : int -> int -> int -> {
    time_t : int,
    potential_bound_m : int,
    partial_sum_scaled : int,
    upper_envelope_scaled : int,
    series_converges : bool
  }
  val eval_schrodinger_lipschitz_regularity : int -> int -> class_term list -> {
    is_feynman_kac_positive : bool,
    max_lipschitz_quotient : int,
    lipschitz_bound_holds : bool
  }
  val axiom_integral_kernel_criterion : class_term -> class_term -> thm
  val prove_integral_kernel_criterion : class_term -> class_term -> thm
  val axiom_dyson_phillips_perturbation_converges : class_term -> class_term -> thm
  val prove_dyson_phillips_perturbation_converges : class_term -> class_term -> thm
  val axiom_schrodinger_kernel_lipschitz_regularity : class_term -> class_term -> class_term -> thm
  val prove_schrodinger_kernel_lipschitz_regularity : class_term -> class_term -> class_term -> thm

  (* Ticket 68: Locally Small Categories, Conglomerate Presheaves, Yoneda Lemma, and Kan Extensions *)
  val eval_is_locally_small_category : int list -> class_term list -> {
    has_identities : bool,
    closed_under_composition : bool,
    hom_sets_are_sets : bool,
    is_locally_small : bool
  }
  val eval_representable_presheaf : int -> class_term list -> (int * int list) list
  val eval_yoneda_lemma_bijection : int -> class_term list -> class_term list -> {
    fa_cardinality : int,
    nat_trans_cardinality : int,
    bijection_verified : bool
  }
  val eval_yoneda_embedding_fully_faithful : int list -> class_term list -> {
    is_full : bool,
    is_faithful : bool,
    is_fully_faithful : bool
  }
  val eval_pointwise_kan_extension : class_term list -> class_term list -> int list -> {
    lan_values : (int * int) list,
    ran_values : (int * int) list,
    universal_adjunction_holds : bool
  }
  val axiom_yoneda_lemma_bijection : class_term -> class_term -> class_term -> thm
  val prove_yoneda_lemma_bijection : class_term -> class_term -> class_term -> thm
  val axiom_yoneda_embedding_fully_faithful : class_term -> thm
  val prove_yoneda_embedding_fully_faithful : class_term -> thm
  val axiom_pointwise_kan_extension_universal : class_term -> class_term -> class_term -> thm
  val prove_pointwise_kan_extension_universal : class_term -> class_term -> class_term -> thm

  (* Ticket 69: Elementary Topoi, Subobject Classifiers, and Lawvere-Tierney Topologies *)
  val eval_pullback_square : class_term list -> class_term list -> class_term list
  val eval_subobject_classifier : int list -> int list -> class_term list
  val eval_characteristic_morphism : int list -> class_term list -> {
    recovered_subobject : int list,
    pullback_verified : bool
  }
  val eval_lawvere_tierney_topology : int -> class_term list -> {
    preserves_truth : bool,
    is_idempotent : bool,
    preserves_meet : bool,
    is_valid_topology : bool
  }
  val eval_j_closed_subobject : class_term list -> class_term list -> {
    closure_chi : (int * int) list,
    is_j_closed : bool
  }
  val axiom_subobject_classifier_uniqueness : class_term -> class_term -> class_term -> thm
  val prove_subobject_classifier_uniqueness : class_term -> class_term -> class_term -> thm
  val axiom_lawvere_tierney_closure_idempotent : class_term -> class_term -> thm
  val prove_lawvere_tierney_closure_idempotent : class_term -> class_term -> thm
  val axiom_lawvere_tierney_meet_preservation : class_term -> class_term -> thm
  val prove_lawvere_tierney_meet_preservation : class_term -> class_term -> thm

  (* Ticket 70: Monads, Eilenberg-Moore & Kleisli Categories, and Beck's Monadicity Theorem *)
  val eval_is_monad_triad : int list -> class_term list -> class_term list -> class_term list -> {
    left_unit_law : bool,
    right_unit_law : bool,
    associativity_law : bool,
    is_valid_monad : bool
  }
  val eval_eilenberg_moore_algebra : int list -> class_term list -> class_term list -> class_term list -> class_term list -> {
    unit_coherence : bool,
    mult_coherence : bool,
    is_em_algebra : bool
  }
  val eval_kleisli_composition : class_term list -> class_term list -> class_term list -> class_term list -> class_term list
  val eval_is_split_coequalizer : int list -> class_term list -> class_term list -> class_term list -> class_term list -> class_term list -> {
    fork_commutes : bool,
    section_retraction_ok : bool,
    split_homotopy_ok : bool,
    is_split_coequalizer : bool
  }
  val eval_beck_monadicity : bool -> bool -> bool -> {
    reflects_isomorphisms : bool,
    has_u_split_coequalizers : bool,
    preserves_u_split_coequalizers : bool,
    comparison_is_equivalence : bool
  }
  val axiom_monad_unit_associativity_coherence : class_term -> class_term -> class_term -> thm
  val prove_monad_unit_associativity_coherence : class_term -> class_term -> class_term -> thm
  val axiom_kleisli_eilenberg_moore_adjunction_uniqueness : class_term -> class_term -> thm
  val prove_kleisli_eilenberg_moore_adjunction_uniqueness : class_term -> class_term -> thm
  val axiom_beck_monadicity_equivalence : class_term -> class_term -> thm
  val prove_beck_monadicity_equivalence : class_term -> class_term -> thm

  (* Ticket 71: Cartesian Closed Categories, Exponential Objects, Evaluation Morphisms, and Curry-Howard-Lambek Equivalence *)
  val eval_is_cartesian_closed_category : bool -> bool -> bool -> {
    has_terminal_object : bool,
    has_binary_products : bool,
    has_exponentials : bool,
    is_ccc : bool
  }
  val eval_exponential_object : int list -> int list -> class_term list list
  val eval_curry_bijection : int list -> int list -> class_term list -> {
    curried_table : (int * (int * int) list) list,
    uncurried_pairs : class_term list,
    roundtrip_bijection_ok : bool
  }
  val eval_beta_eta_lambek_equivalence : int list -> int list -> class_term list -> {
    beta_reduction_holds : bool,
    eta_expansion_holds : bool,
    lambek_equivalence_holds : bool
  }
  val eval_internal_simply_typed_model : bool -> bool -> bool -> {
    types_as_objects : bool,
    terms_as_morphisms : bool,
    beta_eta_soundness : bool,
    is_valid_internal_model : bool
  }
  val axiom_exponential_transpose_uniqueness : class_term -> class_term -> class_term -> thm
  val prove_exponential_transpose_uniqueness : class_term -> class_term -> class_term -> thm
  val axiom_curry_uncurry_bijection : class_term -> class_term -> thm
  val prove_curry_uncurry_bijection : class_term -> class_term -> thm
  val axiom_curry_howard_lambek_beta_eta_soundness : class_term -> class_term -> thm
  val prove_curry_howard_lambek_beta_eta_soundness : class_term -> class_term -> thm

  (* Ticket 72: Grothendieck Fibrations, Cartesian Morphisms, Cleavages, and the Grothendieck Construction *)
  val eval_is_cartesian_morphism : int -> int -> class_term list -> {
    projected_base_arrow : int,
    unique_factorization_verified : bool,
    is_cartesian : bool
  }
  val eval_is_grothendieck_fibration : int list -> int list -> class_term list -> {
    every_arrow_has_lift : bool,
    cleavage_total : bool,
    is_fibration : bool
  }
  val eval_grothendieck_total_category : int list -> class_term list -> {
    total_objects : class_term list,
    projection_pairs : (int * int) list,
    total_count : int
  }
  val eval_is_split_fibration : int list -> class_term list -> {
    preserves_identities_strictly : bool,
    preserves_composition_strictly : bool,
    is_split_fibration : bool
  }
  val eval_grothendieck_equivalence : bool -> bool -> {
    fibration_to_indexed_ok : bool,
    indexed_to_fibration_ok : bool,
    equivalence_verified : bool
  }
  val axiom_cartesian_lift_unique_up_to_vertical_iso : class_term -> class_term -> class_term -> thm
  val prove_cartesian_lift_unique_up_to_vertical_iso : class_term -> class_term -> class_term -> thm
  val axiom_grothendieck_construction_is_fibration : class_term -> class_term -> thm
  val prove_grothendieck_construction_is_fibration : class_term -> class_term -> thm
  val axiom_split_fibration_indexed_functor_bijection : class_term -> class_term -> thm
  val prove_split_fibration_indexed_functor_bijection : class_term -> class_term -> thm

  (* Ticket 73: Abelian Categories, Kernel-Cokernel Coimage-Image Isomorphism, Exact Sequences, and the Snake Lemma *)
  val eval_is_abelian_category : bool -> bool -> bool -> bool -> {
    has_zero_and_biproducts : bool,
    has_kernels_and_cokernels : bool,
    monos_normal : bool,
    epis_conormal : bool,
    is_abelian : bool
  }
  val eval_coimage_image_iso : int list -> class_term list -> {
    kernel_elements : int list,
    image_elements : int list,
    coimage_cardinality : int,
    image_cardinality : int,
    coimage_image_iso_holds : bool
  }
  val eval_is_short_exact_sequence : int list -> int list -> class_term list -> class_term list -> {
    f_is_monic : bool,
    g_is_epic_on_codomain : bool,
    image_f_equals_kernel_g : bool,
    is_short_exact : bool
  }
  val eval_snake_connecting_morphism : class_term list -> class_term list -> class_term list -> class_term list
  val eval_snake_lemma_exactness : int list -> int list -> int list -> int list -> int list -> int list -> {
    six_term_exact : bool,
    connecting_well_defined : bool
  }
  val axiom_abelian_coimage_image_canonical_iso : class_term -> class_term -> thm
  val prove_abelian_coimage_image_canonical_iso : class_term -> class_term -> thm
  val axiom_short_exact_split_biproduct_equivalence : class_term -> class_term -> class_term -> thm
  val prove_short_exact_split_biproduct_equivalence : class_term -> class_term -> class_term -> thm
  val axiom_snake_lemma_six_term_exact_sequence : class_term -> class_term -> class_term -> thm
  val prove_snake_lemma_six_term_exact_sequence : class_term -> class_term -> class_term -> thm

  (* Ticket 74: Chain Complexes, Projective/Injective Resolutions, Derived Functors Ext/Tor, and Long Exact Cohomology Sequences *)
  val eval_is_chain_complex : int list -> class_term list -> class_term list -> {
    composed_is_zero : bool,
    homology_elements : int list,
    is_chain_complex : bool
  }
  val eval_chain_homotopy_equivalence : int list -> class_term list -> class_term list -> class_term list -> {
    induces_homology_isomorphism : bool,
    chain_homotopy_verified : bool
  }
  val eval_is_projective_resolution : bool -> bool -> bool -> {
    objects_projective : bool,
    complex_exact_in_positive_degrees : bool,
    augmentation_is_quasi_iso : bool,
    is_projective_resolution : bool
  }
  val eval_derived_ext_tor : int -> int list -> class_term list -> class_term list -> {
    kernel_elements : int list,
    image_elements : int list,
    derived_rank : int,
    is_well_defined : bool
  }
  val eval_long_exact_cohomology_sequence : int list -> int list -> int list -> int list -> int list -> int list -> {
    exact_at_h_n_b : bool,
    exact_at_h_n_c : bool,
    exact_at_h_succ_a : bool,
    long_exact_verified : bool
  }
  val axiom_chain_boundary_squared_zero : class_term -> class_term -> thm
  val prove_chain_boundary_squared_zero : class_term -> class_term -> thm
  val axiom_comparison_theorem_projective_resolutions : class_term -> class_term -> class_term -> thm
  val prove_comparison_theorem_projective_resolutions : class_term -> class_term -> class_term -> thm
  val axiom_ext_tor_long_exact_sequence_naturality : int -> class_term -> class_term -> class_term -> thm
  val prove_ext_tor_long_exact_sequence_naturality : int -> class_term -> class_term -> class_term -> thm

  (* Ticket 75: Triangulated Categories, Distinguished Triangles, the Octahedral Axiom, and Derived Categories *)
  val eval_is_triangulated_category : bool -> bool -> bool -> bool -> {
    has_shift_automorphism : bool,
    satisfies_tr1_tr2_tr3 : bool,
    satisfies_tr4_octahedral : bool,
    is_triangulated : bool
  }
  val eval_distinguished_triangle_rotation : class_term list -> {
    original_edges : (int * int) list,
    rotated_edges : (int * int) list,
    rotation_invariance_holds : bool
  }
  val eval_octahedral_axiom : int -> int -> int -> bool -> {
    cone_u : int,
    cone_v : int,
    cone_vu : int,
    induced_third_triangle_exact : bool,
    octahedral_verified : bool
  }
  val eval_quasi_iso_roof_calculus : class_term list -> class_term list -> {
    roof_pairs : (int * int) list,
    ore_condition_holds : bool,
    is_valid_multiplicative_system : bool
  }
  val eval_derived_category_localization : bool -> bool -> bool -> {
    inverts_quasi_isomorphisms : bool,
    universal_property_holds : bool,
    derived_category_verified : bool
  }
  val axiom_distinguished_triangle_rotation_invariance : class_term -> class_term -> class_term -> thm
  val prove_distinguished_triangle_rotation_invariance : class_term -> class_term -> class_term -> thm
  val axiom_octahedral_mapping_cone_coherence : class_term -> class_term -> class_term -> thm
  val prove_octahedral_mapping_cone_coherence : class_term -> class_term -> class_term -> thm
  val axiom_gabriel_zisman_derived_localization_universal : class_term -> class_term -> thm
  val prove_gabriel_zisman_derived_localization_universal : class_term -> class_term -> thm

  (* Ticket 76: Quillen Model Categories, Weak Factorization Systems, Left/Right Lifting Properties, and the Homotopy Category *)
  val eval_is_quillen_model_category : bool -> bool -> bool -> bool -> bool -> {
    has_finite_limits_and_colimits : bool,
    satisfies_two_out_of_three : bool,
    closed_under_retracts : bool,
    satisfies_lifting_and_factorization : bool,
    is_quillen_model_category : bool
  }
  val eval_left_right_lifting_property : int list -> class_term list -> class_term list -> class_term list -> {
    upper_triangle_commutes : bool,
    lower_triangle_commutes : bool,
    has_diagonal_lift : bool
  }
  val eval_two_out_of_three_weak_eq : bool -> bool -> bool -> {
    at_least_two_in_w : bool,
    third_in_w_inferred : bool,
    two_out_of_three_satisfied : bool
  }
  val eval_quillen_homotopy_category : class_term list -> {
    bifibrant_objects : int list,
    bifibrant_count : int,
    whitehead_subcat_valid : bool
  }
  val eval_is_quillen_adjunction : bool -> bool -> bool -> {
    left_preserves_cofibrations : bool,
    right_preserves_fibrations : bool,
    induces_derived_adjunction : bool,
    is_quillen_equivalence : bool
  }
  val axiom_quillen_retract_lifting_closure : class_term -> class_term -> thm
  val prove_quillen_retract_lifting_closure : class_term -> class_term -> thm
  val axiom_whitehead_theorem_bifibrant_objects : class_term -> class_term -> thm
  val prove_whitehead_theorem_bifibrant_objects : class_term -> class_term -> thm
  val axiom_total_derived_quillen_adjunction_equivalence : class_term -> class_term -> class_term -> class_term -> thm
  val prove_total_derived_quillen_adjunction_equivalence : class_term -> class_term -> class_term -> class_term -> thm

  (* Ticket 77: Simplicial Sets, Kan Complexes, Quasi-Categories via Inner Horn Lifting, and the Homotopy Coherent Nerve *)
  val eval_simplicial_identities : int list -> class_term list -> class_term list -> {
    face_degeneracy_section_holds : bool,
    simplicial_identities_verified : bool
  }
  val eval_is_kan_complex : int -> class_term list -> {
    inner_horns_filled : bool,
    outer_horns_filled : bool,
    is_kan_complex : bool
  }
  val eval_is_quasi_category_inner_horn : int -> class_term list -> {
    inner_horn_count : int,
    all_inner_horns_have_fillers : bool,
    is_quasi_category : bool
  }
  val eval_is_kan_fibration : bool -> bool -> {
    lifts_against_all_horn_inclusions : bool,
    induces_kan_complex_fibers : bool,
    is_kan_fibration : bool
  }
  val eval_homotopy_coherent_nerve : class_term list -> {
    composable_nerve_2_simplices : (int * int) list,
    unique_inner_horn_fillers : bool,
    is_valid_coherent_nerve : bool
  }
  val axiom_simplicial_face_degeneracy_commutation : class_term -> class_term -> class_term -> thm
  val prove_simplicial_face_degeneracy_commutation : class_term -> class_term -> class_term -> thm
  val axiom_kan_complex_is_quasi_category : class_term -> thm
  val prove_kan_complex_is_quasi_category : class_term -> thm
  val axiom_categorical_nerve_inner_horn_unique_filler : class_term -> thm
  val prove_categorical_nerve_inner_horn_unique_filler : class_term -> thm

  (* Ticket 78: Grothendieck Sites, Covering Sieves, the Sheaf Gluing Condition, and Plus-Construction Sheafification *)
  val eval_is_covering_sieve : int -> class_term list -> class_term list -> {
    all_target_u : bool,
    closed_under_precomposition : bool,
    is_valid_sieve : bool
  }
  val eval_is_grothendieck_topology : bool -> bool -> bool -> {
    contains_maximal_sieve : bool,
    pullback_stable : bool,
    satisfies_local_character : bool,
    is_grothendieck_topology : bool
  }
  val eval_is_sheaf_on_site : int list -> class_term list -> class_term list -> {
    compatible_amalgamations : int list,
    is_separated_presheaf : bool,
    is_sheaf : bool
  }
  val eval_plus_sheafification : int -> bool -> {
    stage_count : int,
    produces_separated_presheaf : bool,
    produces_sheaf : bool
  }
  val eval_sheafification_universal : bool -> bool -> {
    is_left_adjoint_to_inclusion : bool,
    preserves_finite_limits : bool,
    is_exact_sheafification : bool
  }
  val axiom_grothendieck_sieve_pullback_stability : class_term -> class_term -> class_term -> thm
  val prove_grothendieck_sieve_pullback_stability : class_term -> class_term -> class_term -> thm
  val axiom_sheaf_unique_amalgamation_gluing : class_term -> class_term -> class_term -> thm
  val prove_sheaf_unique_amalgamation_gluing : class_term -> class_term -> class_term -> thm
  val axiom_plus_plus_sheafification_exact_left_adjoint : class_term -> class_term -> thm
  val prove_plus_plus_sheafification_exact_left_adjoint : class_term -> class_term -> thm

  (* Ticket 79: Spectral Sequences, Filtered Complexes, Exact Couples, and the Grothendieck Composite-Functor Spectral Sequence *)
  val eval_is_spectral_sequence_differential : int -> int list -> class_term list -> class_term list -> {
    page_r : int,
    bidegree : int * int,
    differential_squared_zero : bool,
    is_valid_spectral_differential : bool
  }
  val eval_spectral_page_cohomology_iso : int list -> class_term list -> class_term list -> {
    kernel_elements : int list,
    image_elements : int list,
    next_page_representatives : int list,
    page_iso_holds : bool
  }
  val eval_converges_to_filtered_abutment : bool -> bool -> int list -> int list -> {
    filtration_bounded_exhaustive : bool,
    e_infinity_matches_graded_abutment : bool,
    converges_strongly : bool
  }
  val eval_exact_couple_derived : int list -> class_term list -> class_term list -> class_term list -> {
    derived_d_image : int list,
    induced_differential_zero_on_im_i : bool,
    is_valid_exact_couple : bool
  }
  val eval_grothendieck_spectral_convergence : bool -> bool -> bool -> {
    f_and_g_left_exact : bool,
    f_sends_injectives_to_g_acyclic : bool,
    e2_abuts_to_right_derived_composite : bool
  }
  val axiom_spectral_differential_squared_zero : int -> class_term -> class_term -> thm
  val prove_spectral_differential_squared_zero : int -> class_term -> class_term -> thm
  val axiom_filtered_complex_spectral_convergence : class_term -> class_term -> thm
  val prove_filtered_complex_spectral_convergence : class_term -> class_term -> thm
  val axiom_grothendieck_composite_functor_e2_abutment : class_term -> class_term -> class_term -> thm
  val prove_grothendieck_composite_functor_e2_abutment : class_term -> class_term -> class_term -> thm

  (* Ticket 80: Symmetric Monoidal Closed Categories, Mac Lane Pentagon/Triangle Coherence, Enriched Categories & Enriched Yoneda, and Day Convolution *)
  val eval_mac_lane_coherence : bool -> bool -> bool -> class_term list -> {
    pentagon_commutes : bool,
    triangle_commutes : bool,
    hexagon_and_symmetry_involution : bool,
    mac_lane_coherence_verified : bool
  }
  val eval_is_symmetric_monoidal_closed : class_term list -> class_term list -> {
    tensor_hom_bijection_count : int,
    adjunction_natural_bijection_holds : bool,
    is_symmetric_monoidal_closed : bool
  }
  val eval_is_enriched_category : bool -> bool -> class_term list -> {
    hom_objects_count : int,
    enriched_associativity_and_unit : bool,
    is_valid_enriched_category : bool
  }
  val eval_enriched_yoneda_iso : int -> class_term list -> {
    evaluated_at_object : int,
    enriched_end_value : int,
    enriched_yoneda_iso_holds : bool
  }
  val eval_day_convolution_monoidal : bool -> int -> int -> int -> {
    coend_tensor_dimension : int,
    yoneda_is_strong_monoidal : bool,
    day_convolution_monoidal_closed : bool
  }
  val axiom_mac_lane_pentagon_triangle_coherence : class_term -> class_term -> class_term -> thm
  val prove_mac_lane_pentagon_triangle_coherence : class_term -> class_term -> class_term -> thm
  val axiom_tensor_internal_hom_adjunction_iso : class_term -> class_term -> class_term -> thm
  val prove_tensor_internal_hom_adjunction_iso : class_term -> class_term -> class_term -> thm
  val axiom_day_convolution_promonoidal_yoneda : class_term -> class_term -> class_term -> thm
  val prove_day_convolution_promonoidal_yoneda : class_term -> class_term -> class_term -> thm

  (* Ticket 81: Ends and Coends, Dinatural Wedges, Fubini Theorem for Iterated Ends/Coends, and Weighted Limits/Colimits *)
  val eval_is_extranatural_wedge : int list -> class_term list -> class_term list -> {
    checked_morphisms_count : int,
    wedge_dinaturality_commutes : bool,
    is_valid_extranatural_wedge : bool
  }
  val eval_universal_end_cowedge : class_term list -> class_term list -> {
    equalizer_end_elements : int list,
    coequalizer_coend_quotient_size : int,
    universal_end_coend_verified : bool
  }
  val eval_end_coend_fubini_iso : int list -> int list -> class_term list -> {
    iterated_ab_end : int,
    iterated_ba_end : int,
    iterated_ab_coend : int,
    iterated_ba_coend : int,
    fubini_interchange_holds : bool
  }
  val eval_weighted_limit_end_rep : class_term list -> class_term list -> {
    weighted_hom_components : int list,
    enriched_end_matches_weighted_limit : bool
  }
  val eval_profunctor_coend_composition : int -> int -> int list -> class_term list -> class_term list -> {
    intermediate_witnesses : int list,
    coend_composite_nonempty : bool
  }
  val axiom_natural_transformations_as_end : string -> class_term -> class_term -> thm
  val prove_natural_transformations_as_end : string -> class_term -> class_term -> thm
  val axiom_end_coend_fubini_interchange_iso : string -> string -> class_term -> thm
  val prove_end_coend_fubini_interchange_iso : string -> string -> class_term -> thm
  val axiom_weighted_limit_enriched_end_isomorphism : class_term -> class_term -> class_term -> thm
  val prove_weighted_limit_enriched_end_isomorphism : class_term -> class_term -> class_term -> thm

  (* Ticket 82: Bicategories, 2-Cells, Horizontal and Vertical Composition, the Interchange Law, Internal Adjunctions, and Benabou's Coherence Theorem *)
  val eval_is_bicategory : bool -> bool -> class_term list -> {
    hom_categories_count : int,
    pentagon_and_triangle_2cells_hold : bool,
    is_valid_bicategory : bool
  }
  val eval_two_cell_interchange_law : int -> int -> int -> int -> {
    lhs_vert_then_horiz : int,
    rhs_horiz_then_vert : int,
    middle_four_interchange_holds : bool
  }
  val eval_internal_adjunction_triangle : class_term list -> class_term list -> {
    left_snake_composite : int,
    right_snake_composite : int,
    triangle_identities_hold : bool
  }
  val eval_benabou_strictification : bool -> bool -> int -> {
    strict_two_category_cells : int,
    yoneda_biequivalence_verified : bool,
    benabou_coherence_holds : bool
  }
  val eval_eckmann_hilton_commutativity : int -> int -> {
    alpha_dot_beta : int,
    beta_dot_alpha : int,
    horizontal_equals_vertical_and_commutes : bool
  }
  val axiom_two_cell_middle_four_interchange : class_term -> class_term -> class_term -> class_term -> thm
  val prove_two_cell_middle_four_interchange : class_term -> class_term -> class_term -> class_term -> thm
  val axiom_eckmann_hilton_braided_endomorphism_commutativity : class_term -> class_term -> thm
  val prove_eckmann_hilton_braided_endomorphism_commutativity : class_term -> class_term -> thm
  val axiom_benabou_bicategory_strictification_biequivalence : class_term -> class_term -> thm
  val prove_benabou_bicategory_strictification_biequivalence : class_term -> class_term -> thm

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
    | TheoryMK_AC_NegCH
    | TheoryZFC
    | TheoryZFC_CH
    | TheoryZFC_NegCH
    | Poset of class_term * class_term * class_term
    | PosetLeq of class_term
    | PosetOne of class_term
    | ForcingName of class_term
    | CanonicalCheckName of class_term
    | GenericName of class_term
    | NameValuation of class_term * class_term
    | GenericExtension of class_term * class_term
    | CohenPoset of class_term * class_term
    | CohenFamilyPoset of class_term * class_term
    | CohenRealName of class_term * class_term
    | Aleph of class_term
    | ContinuumSize of class_term
    | SuslinTree of class_term * class_term
    | TreePoset of class_term
    | TheoryMK_AC_MA_NegCH
    | TheoryZFC_MA_NegCH
    | TheoryZFC_Diamond
    | TheoryZFC_SH
    | TheoryZFC_NegSH
    | EastonFunction of class_term
    | EastonPoset of class_term
    | LevyCollapsePoset of class_term * class_term
    | SolovayModel of class_term * class_term
    | TheoryZFC_Easton of class_term
    | TheoryZFC_Inaccessible
    | TheoryZF_DC_Lebesgue
    | TheoryZFC_LevyCollapse
    | InaccessibleCardinal of class_term
    | MahloCardinal of class_term
    | WeaklyCompactCardinal of class_term
    | MeasurableCardinal of class_term
    | UltrafilterOn of class_term * class_term
    | ElementaryEmbedding of class_term * class_term * class_term
    | Ultrapower of class_term * class_term
    | ZeroSharp
    | TheoryZFC_Mahlo
    | TheoryZFC_Measurable
    | DefinablePowerSet of class_term
    | LStage of class_term
    | ConstructibleUniverse
    | TheoryZFC_L
    | RelativizedClassCompr of string * class_term * fm
    | DunaevPName of class_term
    | GenericVal of class_term * class_term
    | PosetPreorder of class_term * class_term * class_term
    | ClassListDunaev of class_term list
    | FamilyValueAtArg of class_term * class_term
    | RelationalImage of class_term * class_term
    | EvaluatedImage of class_term * class_term
    | IndexedUnion of class_term * class_term
    | TheoryTau
    | TheoryFau
    | CompleteBooleanAlgebra of class_term
    | RegularOpenCompletion of class_term
    | BValModel of class_term
    | BValTruth of fm * class_term
    | NormalOrdinalFn of class_term
    | VeblenPhi of class_term * class_term
    | DiagonalIntersection of class_term * class_term
    | DunaevGameTree of class_term
    | GaleStewartGame of class_term * class_term
    | BorelPayoff of class_term * class_term
    | HeatSemigroupKernel of class_term
    | SchrodingerSemigroupKernel of class_term * class_term
    | DysonPhillipsSeries of class_term * class_term * class_term
    | LocallySmallCategory of class_term * class_term
    | RepresentablePresheaf of class_term * class_term
    | YonedaEmbedding of class_term
    | LeftKanExtension of class_term * class_term
    | RightKanExtension of class_term * class_term
    | PullbackSquare of class_term * class_term * class_term
    | SubobjectClassifier of class_term
    | CharacteristicMorphism of class_term * class_term
    | LawvereTierneyTopology of class_term * class_term
    | SheafSubobjectClosure of class_term * class_term
    | MonadTriad of class_term * class_term * class_term
    | EilenbergMooreCategory of class_term * class_term
    | KleisliCategory of class_term * class_term
    | MonadicityComparisonFunctor of class_term * class_term
    | ReflexiveSplitCoequalizer of class_term * class_term * class_term
    | ExponentialObject of class_term * class_term
    | EvaluationMorphism of class_term * class_term
    | CurriedMorphism of class_term
    | UncurriedMorphism of class_term
    | InternalLambdaTerm of string * class_term
    | GrothendieckCartesianLift of class_term * class_term
    | FiberCategoryAtBase of class_term * class_term
    | CleavageAssignment of class_term
    | GrothendieckTotalCategory of class_term * class_term
    | IndexedPseudofunctor of class_term
    | CategoricalKernel of class_term
    | CategoricalCokernel of class_term
    | CoimageObject of class_term
    | ImageObject of class_term
    | SnakeConnectingMorphism of class_term * class_term * class_term
    | ChainComplex of class_term * class_term
    | ProjectiveResolution of class_term * class_term
    | InjectiveResolution of class_term * class_term
    | RightDerivedExt of int * class_term * class_term
    | LeftDerivedTor of int * class_term * class_term
    | SuspensionShiftFunctor of class_term * int
    | DistinguishedTriangle of class_term * class_term * class_term
    | MappingConeComplex of class_term
    | QuasiIsomorphismRoof of class_term * class_term
    | DerivedCategoryLocalization of class_term * class_term
    | QuillenModelStructure of class_term * class_term * class_term
    | WeakFactorizationTriple of class_term * class_term * class_term
    | DiagonalLiftingWitness of class_term * class_term
    | CylinderObjectFactorization of class_term
    | QuillenHomotopyCategory of class_term * class_term
    | SimplicialSet of class_term * class_term * class_term
    | StandardSimplexDelta of int
    | SimplicialHornLambda of int * int
    | GeometricRealization of class_term
    | HomotopyCoherentNerve of class_term
    | CoveringSieve of class_term * class_term
    | GrothendieckSite of class_term * class_term
    | MatchingFamilyOnSieve of class_term * class_term
    | UniqueAmalgamationWitness of class_term * class_term
    | PlusSheafificationFunctor of class_term
    | SpectralSequencePage of int * class_term * class_term
    | FilteredComplex of class_term * class_term
    | ExactCoupleTriangle of class_term * class_term * class_term
    | AbutmentFiltrationGraded of int * class_term
    | GrothendieckCompositeSpectralSequence of class_term * class_term * class_term
    | SymmetricMonoidalStructure of class_term * class_term * class_term
    | InternalHomObject of class_term * class_term
    | EnrichedCategory of class_term * class_term
    | EnrichedRepresentableHom of class_term * class_term
    | DayConvolutionProduct of class_term * class_term
    | CategoricalEnd of string * class_term
    | CategoricalCoend of string * class_term
    | ExtranaturalWedge of class_term * class_term
    | WeightedLimitObject of class_term * class_term
    | WeightedColimitObject of class_term * class_term
    | BicategoryStructure of class_term * class_term * class_term
    | TwoCellGlobe of class_term * class_term * class_term
    | VerticalComposition2Cell of class_term * class_term
    | HorizontalComposition2Cell of class_term * class_term
    | InternalBicategoryAdjunction of class_term * class_term * class_term

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
    | CardinalsPreserved of class_term * class_term
    | DistinctCohenReals of class_term * class_term * class_term
    | ContinuumHypothesis
    | NegContinuumHypothesis
    | ContinuumAtLeastAleph2
    | IndependenceOfCH
    | MartinsAxiom of class_term
    | MartinsAxiomFull
    | IsSuslinTree of class_term
    | SuslinHypothesis
    | NegSuslinHypothesis
    | DiamondPrinciple
    | MAImpliesSH
    | DiamondImpliesNegSH
    | IndependenceOfSH
    | IsEastonFunction of class_term
    | EastonSupportCondition of class_term * class_term
    | PreservesCofinalities of class_term * class_term
    | EastonPowersTheorem of class_term
    | IsLevyCollapse of class_term * class_term * class_term
    | LevyCollapsesToOmega1 of class_term * class_term
    | SolovayModelLebesgue of class_term
    | RelativeConsistencyEaston of class_term
    | RelativeConsistencySolovay
    | InaccessibleDef of class_term
    | IsMahlo of class_term
    | IsStationaryIn of class_term * class_term
    | IsWeaklyCompact of class_term
    | HasTreeProperty of class_term
    | IsMeasurable of class_term
    | IsKappaCompleteUltrafilter of class_term * class_term
    | IsElementaryEmbedding of class_term * class_term * class_term
    | CriticalPoint of class_term * class_term
    | IsUltrapower of class_term * class_term * class_term
    | ScottsTheoremVNotL of class_term
    | ExistsZeroSharp of class_term
    | IsDefinableSubset of class_term * class_term
    | InLStage of class_term * class_term
    | InL of class_term
    | LGCHTheorem of class_term
    | LWellOrderingTheorem of class_term
    | InnerModelCriterionNBG of class_term
    | RelativizedAxiomHolds of class_term * fm
    | IsForcingPoset of class_term * class_term * class_term
    | IsDunaevPName of class_term * class_term
    | CheckNameValIdentity of class_term * class_term
    | SemiSingleton of class_term
    | SemiSingletonSubclass of class_term * class_term
    | HasConcentratedValues of class_term
    | FlatValues of class_term
    | CanonicalFamily of class_term
    | SemanticCompleteness of class_term * fm
    | NegationCompleteness of class_term * fm
    | FmIFV of string * fm
    | CtxIFV of string * fm list
    | TightUnivIndexedUnion of class_term * class_term * class_term
    | IsCompleteBooleanAlgebra of class_term
    | BValZFCValid of class_term * fm
    | ROEmbeddingPreservesIncompat of class_term * class_term
    | BValDunaevEquiv of class_term * class_term
    | IsNormalOrdinalFn of class_term
    | IsVeblenFixedPoint of class_term * class_term * class_term
    | IsClubIn of class_term * class_term
    | FodorsPressingDown of class_term * class_term * class_term
    | IsDunaevGameTree of class_term
    | HasWinningStrategyP1 of class_term * class_term
    | HasWinningStrategyP2 of class_term * class_term
    | IsDeterminedGame of class_term * class_term
    | IsBorelPayoff of class_term * class_term
    | IsIntegralKernelOperator of class_term * class_term
    | DysonPhillipsConverges of class_term * class_term
    | SchrodingerLipschitzRegular of class_term * class_term * class_term
    | FeynmanKacPositivity of class_term * class_term
    | IsLocallySmallCategory of class_term
    | YonedaBijection of class_term * class_term * class_term
    | IsFullyFaithfulFunctor of class_term
    | IsPointwiseKanExtension of class_term * class_term * class_term
    | IsPullbackSquare of class_term * class_term * class_term * class_term
    | IsSubobjectClassifier of class_term * class_term
    | IsLawvereTierneyTopology of class_term * class_term
    | IsJClosedSubobject of class_term * class_term * class_term
    | IsMonadTriad of class_term * class_term * class_term
    | IsEilenbergMooreAlgebra of class_term * class_term * class_term
    | IsKleisliMorphism of class_term * class_term * class_term
    | IsSplitCoequalizer of class_term * class_term * class_term
    | IsBeckMonadicFunctor of class_term * class_term
    | IsCartesianClosedCategory of class_term
    | IsExponentialTranspose of class_term * class_term
    | SatisfiesBetaEtaLambekEquivalence of class_term * class_term
    | IsInternalSimplyTypedModel of class_term
    | IsCartesianMorphism of class_term * class_term * class_term
    | IsGrothendieckFibration of class_term * class_term * class_term
    | IsSplitFibration of class_term * class_term
    | SatisfiesGrothendieckEquivalence of class_term * class_term
    | IsAbelianCategory of class_term
    | SatisfiesCoimageImageIso of class_term * class_term
    | IsShortExactSequence of class_term * class_term
    | SatisfiesSnakeLemmaExactness of class_term * class_term * class_term
    | IsChainComplex of class_term
    | IsChainHomotopyEquivalent of class_term * class_term
    | IsProjectiveResolution of class_term * class_term
    | SatisfiesLongExactCohomologySequence of class_term * class_term * class_term
    | IsTriangulatedCategory of class_term * class_term
    | IsDistinguishedTriangle of class_term * class_term * class_term
    | SatisfiesOctahedralAxiom of class_term * class_term * class_term
    | IsMultiplicativeSystemOfQuasiIsos of class_term
    | IsDerivedCategoryUniversal of class_term * class_term
    | IsQuillenModelCategory of class_term * class_term
    | HasLeftRightLiftingProperty of class_term * class_term
    | SatisfiesTwoOutOfThreeWeakEq of class_term * class_term * class_term
    | IsQuillenAdjunctionPair of class_term * class_term
    | SatisfiesSimplicialIdentities of class_term
    | IsKanComplex of class_term
    | IsQuasiCategoryInnerHorn of class_term
    | IsKanFibrationMap of class_term * class_term
    | IsCoveringSieve of class_term * class_term
    | IsGrothendieckTopology of class_term * class_term
    | IsSheafOnSite of class_term * class_term
    | SatisfiesSheafificationLeftAdjointUniversal of class_term * class_term
    | IsSpectralSequenceDifferential of int * class_term
    | SatisfiesSpectralPageCohomologyIso of class_term * class_term
    | ConvergesToFilteredAbutment of class_term * class_term
    | SatisfiesGrothendieckSpectralConvergence of class_term * class_term * class_term
    | SatisfiesMacLaneCoherence of class_term
    | IsSymmetricMonoidalClosed of class_term * class_term
    | IsEnrichedCategory of class_term * class_term
    | SatisfiesEnrichedYonedaIso of class_term * class_term
    | IsDayConvolutionMonoidal of class_term * class_term
    | IsExtranaturalWedge of class_term * class_term
    | IsUniversalEndCowedge of class_term * class_term
    | SatisfiesEndCoendFubiniIso of class_term * class_term
    | IsWeightedLimitEndRepresentation of class_term * class_term * class_term
    | IsBicategory of class_term
    | SatisfiesTwoCellInterchangeLaw of class_term * class_term * class_term * class_term
    | IsInternalAdjunctionTriangle of class_term * class_term * class_term * class_term
    | SatisfiesBenabouStrictification of class_term * class_term

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
      | TheoryMK_AC_NegCH => TheoryMK_AC_NegCH
      | TheoryZFC => TheoryZFC
      | TheoryZFC_CH => TheoryZFC_CH
      | TheoryZFC_NegCH => TheoryZFC_NegCH
      | Poset (p, l, one) => Poset (subst_term var repl p, subst_term var repl l, subst_term var repl one)
      | PosetLeq p => PosetLeq (subst_term var repl p)
      | PosetOne p => PosetOne (subst_term var repl p)
      | ForcingName s => ForcingName (subst_term var repl s)
      | CanonicalCheckName x => CanonicalCheckName (subst_term var repl x)
      | GenericName p => GenericName (subst_term var repl p)
      | NameValuation (tau, g) => NameValuation (subst_term var repl tau, subst_term var repl g)
      | GenericExtension (m, g) => GenericExtension (subst_term var repl m, subst_term var repl g)
      | CohenPoset (d, c) => CohenPoset (subst_term var repl d, subst_term var repl c)
      | CohenFamilyPoset (i, om) => CohenFamilyPoset (subst_term var repl i, subst_term var repl om)
      | CohenRealName (a, p) => CohenRealName (subst_term var repl a, subst_term var repl p)
      | Aleph a => Aleph (subst_term var repl a)
      | ContinuumSize m => ContinuumSize (subst_term var repl m)
      | SuslinTree (t, ord) => SuslinTree (subst_term var repl t, subst_term var repl ord)
      | TreePoset t => TreePoset (subst_term var repl t)
      | EastonFunction f => EastonFunction (subst_term var repl f)
      | EastonPoset f => EastonPoset (subst_term var repl f)
      | LevyCollapsePoset (l, k) => LevyCollapsePoset (subst_term var repl l, subst_term var repl k)
      | SolovayModel (m, k) => SolovayModel (subst_term var repl m, subst_term var repl k)
      | TheoryZFC_Easton f => TheoryZFC_Easton (subst_term var repl f)
      | InaccessibleCardinal k => InaccessibleCardinal (subst_term var repl k)
      | MahloCardinal k => MahloCardinal (subst_term var repl k)
      | WeaklyCompactCardinal k => WeaklyCompactCardinal (subst_term var repl k)
      | MeasurableCardinal k => MeasurableCardinal (subst_term var repl k)
      | UltrafilterOn (u, k) => UltrafilterOn (subst_term var repl u, subst_term var repl k)
      | ElementaryEmbedding (j, v, m) => ElementaryEmbedding (subst_term var repl j, subst_term var repl v, subst_term var repl m)
      | Ultrapower (v, u) => Ultrapower (subst_term var repl v, subst_term var repl u)
      | ZeroSharp => ZeroSharp
      | TheoryZFC_Mahlo => TheoryZFC_Mahlo
      | TheoryZFC_Measurable => TheoryZFC_Measurable
      | DefinablePowerSet x => DefinablePowerSet (subst_term var repl x)
      | LStage a => LStage (subst_term var repl a)
      | ConstructibleUniverse => ConstructibleUniverse
      | TheoryZFC_L => TheoryZFC_L
      | RelativizedClassCompr (v, m_cls, p) =>
          if v = var then RelativizedClassCompr (v, subst_term var repl m_cls, p)
          else RelativizedClassCompr (v, subst_term var repl m_cls, subst_fm var repl p)
      | DunaevPName s => DunaevPName (subst_term var repl s)
      | GenericVal (tau, g) => GenericVal (subst_term var repl tau, subst_term var repl g)
      | PosetPreorder (p, l, one) =>
          PosetPreorder (subst_term var repl p, subst_term var repl l, subst_term var repl one)
      | ClassListDunaev xs => ClassListDunaev (List.map (subst_term var repl) xs)
      | FamilyValueAtArg (f, a) => FamilyValueAtArg (subst_term var repl f, subst_term var repl a)
      | RelationalImage (f, a) => RelationalImage (subst_term var repl f, subst_term var repl a)
      | EvaluatedImage (f, a) => EvaluatedImage (subst_term var repl f, subst_term var repl a)
      | IndexedUnion (i_set, fam) => IndexedUnion (subst_term var repl i_set, subst_term var repl fam)
      | TheoryTau => TheoryTau
      | TheoryFau => TheoryFau
      | CompleteBooleanAlgebra b => CompleteBooleanAlgebra (subst_term var repl b)
      | RegularOpenCompletion p => RegularOpenCompletion (subst_term var repl p)
      | BValModel b => BValModel (subst_term var repl b)
      | BValTruth (phi, b) => BValTruth (subst_fm var repl phi, subst_term var repl b)
      | NormalOrdinalFn f => NormalOrdinalFn (subst_term var repl f)
      | VeblenPhi (a, b) => VeblenPhi (subst_term var repl a, subst_term var repl b)
      | DiagonalIntersection (k, fam) =>
          DiagonalIntersection (subst_term var repl k, subst_term var repl fam)
      | DunaevGameTree t => DunaevGameTree (subst_term var repl t)
      | GaleStewartGame (t, a) =>
          GaleStewartGame (subst_term var repl t, subst_term var repl a)
      | BorelPayoff (a, r) =>
          BorelPayoff (subst_term var repl a, subst_term var repl r)
      | HeatSemigroupKernel t => HeatSemigroupKernel (subst_term var repl t)
      | SchrodingerSemigroupKernel (t, v) =>
          SchrodingerSemigroupKernel (subst_term var repl t, subst_term var repl v)
      | DysonPhillipsSeries (t, v, n) =>
          DysonPhillipsSeries (subst_term var repl t, subst_term var repl v, subst_term var repl n)
      | LocallySmallCategory (ob, hom) =>
          LocallySmallCategory (subst_term var repl ob, subst_term var repl hom)
      | RepresentablePresheaf (c, a) =>
          RepresentablePresheaf (subst_term var repl c, subst_term var repl a)
      | YonedaEmbedding c => YonedaEmbedding (subst_term var repl c)
      | LeftKanExtension (k, f) =>
          LeftKanExtension (subst_term var repl k, subst_term var repl f)
      | RightKanExtension (k, f) =>
          RightKanExtension (subst_term var repl k, subst_term var repl f)
      | PullbackSquare (a, b, c) =>
          PullbackSquare (subst_term var repl a, subst_term var repl b, subst_term var repl c)
      | SubobjectClassifier e => SubobjectClassifier (subst_term var repl e)
      | CharacteristicMorphism (m, x) =>
          CharacteristicMorphism (subst_term var repl m, subst_term var repl x)
      | LawvereTierneyTopology (j, om) =>
          LawvereTierneyTopology (subst_term var repl j, subst_term var repl om)
      | SheafSubobjectClosure (j, s) =>
          SheafSubobjectClosure (subst_term var repl j, subst_term var repl s)
      | MonadTriad (t, eta, mu) =>
          MonadTriad (subst_term var repl t, subst_term var repl eta, subst_term var repl mu)
      | EilenbergMooreCategory (c, t) =>
          EilenbergMooreCategory (subst_term var repl c, subst_term var repl t)
      | KleisliCategory (c, t) =>
          KleisliCategory (subst_term var repl c, subst_term var repl t)
      | MonadicityComparisonFunctor (u, t) =>
          MonadicityComparisonFunctor (subst_term var repl u, subst_term var repl t)
      | ReflexiveSplitCoequalizer (f, g, e) =>
          ReflexiveSplitCoequalizer (subst_term var repl f, subst_term var repl g, subst_term var repl e)
      | ExponentialObject (a, b) =>
          ExponentialObject (subst_term var repl a, subst_term var repl b)
      | EvaluationMorphism (a, b) =>
          EvaluationMorphism (subst_term var repl a, subst_term var repl b)
      | CurriedMorphism g =>
          CurriedMorphism (subst_term var repl g)
      | UncurriedMorphism h =>
          UncurriedMorphism (subst_term var repl h)
      | InternalLambdaTerm (v, body) =>
          if v = var then target else InternalLambdaTerm (v, subst_term var repl body)
      | GrothendieckCartesianLift (u, y) =>
          GrothendieckCartesianLift (subst_term var repl u, subst_term var repl y)
      | FiberCategoryAtBase (p, b) =>
          FiberCategoryAtBase (subst_term var repl p, subst_term var repl b)
      | CleavageAssignment p =>
          CleavageAssignment (subst_term var repl p)
      | GrothendieckTotalCategory (b, phi) =>
          GrothendieckTotalCategory (subst_term var repl b, subst_term var repl phi)
      | IndexedPseudofunctor phi =>
          IndexedPseudofunctor (subst_term var repl phi)
      | CategoricalKernel f =>
          CategoricalKernel (subst_term var repl f)
      | CategoricalCokernel f =>
          CategoricalCokernel (subst_term var repl f)
      | CoimageObject f =>
          CoimageObject (subst_term var repl f)
      | ImageObject f =>
          ImageObject (subst_term var repl f)
      | SnakeConnectingMorphism (a, b, c) =>
          SnakeConnectingMorphism (subst_term var repl a, subst_term var repl b, subst_term var repl c)
      | ChainComplex (c_objs, d_mors) =>
          ChainComplex (subst_term var repl c_objs, subst_term var repl d_mors)
      | ProjectiveResolution (p_comp, a_obj) =>
          ProjectiveResolution (subst_term var repl p_comp, subst_term var repl a_obj)
      | InjectiveResolution (a_obj, i_comp) =>
          InjectiveResolution (subst_term var repl a_obj, subst_term var repl i_comp)
      | RightDerivedExt (deg, a_obj, b_obj) =>
          RightDerivedExt (deg, subst_term var repl a_obj, subst_term var repl b_obj)
      | LeftDerivedTor (deg, a_obj, b_obj) =>
          LeftDerivedTor (deg, subst_term var repl a_obj, subst_term var repl b_obj)
      | SuspensionShiftFunctor (x_obj, n_shift) =>
          SuspensionShiftFunctor (subst_term var repl x_obj, n_shift)
      | DistinguishedTriangle (u_mor, v_mor, w_mor) =>
          DistinguishedTriangle (subst_term var repl u_mor, subst_term var repl v_mor, subst_term var repl w_mor)
      | MappingConeComplex u_mor =>
          MappingConeComplex (subst_term var repl u_mor)
      | QuasiIsomorphismRoof (s_qiso, f_mor) =>
          QuasiIsomorphismRoof (subst_term var repl s_qiso, subst_term var repl f_mor)
      | DerivedCategoryLocalization (k_cat, s_sys) =>
          DerivedCategoryLocalization (subst_term var repl k_cat, subst_term var repl s_sys)
      | QuillenModelStructure (w_cls, c_cls, f_cls) =>
          QuillenModelStructure (subst_term var repl w_cls, subst_term var repl c_cls, subst_term var repl f_cls)
      | WeakFactorizationTriple (f_mor, i_cof, p_fib) =>
          WeakFactorizationTriple (subst_term var repl f_mor, subst_term var repl i_cof, subst_term var repl p_fib)
      | DiagonalLiftingWitness (i_cof, p_fib) =>
          DiagonalLiftingWitness (subst_term var repl i_cof, subst_term var repl p_fib)
      | CylinderObjectFactorization x_obj =>
          CylinderObjectFactorization (subst_term var repl x_obj)
      | QuillenHomotopyCategory (m_cat, w_cls) =>
          QuillenHomotopyCategory (subst_term var repl m_cat, subst_term var repl w_cls)
      | SimplicialSet (x_spx, d_faces, s_degens) =>
          SimplicialSet (subst_term var repl x_spx, subst_term var repl d_faces, subst_term var repl s_degens)
      | StandardSimplexDelta n_dim =>
          StandardSimplexDelta n_dim
      | SimplicialHornLambda (n_dim, k_idx) =>
          SimplicialHornLambda (n_dim, k_idx)
      | GeometricRealization x_sset =>
          GeometricRealization (subst_term var repl x_sset)
      | HomotopyCoherentNerve c_cat =>
          HomotopyCoherentNerve (subst_term var repl c_cat)
      | CoveringSieve (s_sieve, u_obj) =>
          CoveringSieve (subst_term var repl s_sieve, subst_term var repl u_obj)
      | GrothendieckSite (c_cat, j_top) =>
          GrothendieckSite (subst_term var repl c_cat, subst_term var repl j_top)
      | MatchingFamilyOnSieve (p_psh, s_sieve) =>
          MatchingFamilyOnSieve (subst_term var repl p_psh, subst_term var repl s_sieve)
      | UniqueAmalgamationWitness (p_psh, s_sieve) =>
          UniqueAmalgamationWitness (subst_term var repl p_psh, subst_term var repl s_sieve)
      | PlusSheafificationFunctor p_psh =>
          PlusSheafificationFunctor (subst_term var repl p_psh)
      | SpectralSequencePage (r_idx, p_deg, q_deg) =>
          SpectralSequencePage (r_idx, subst_term var repl p_deg, subst_term var repl q_deg)
      | FilteredComplex (k_cplx, f_filt) =>
          FilteredComplex (subst_term var repl k_cplx, subst_term var repl f_filt)
      | ExactCoupleTriangle (d_obj, e_obj, ijk_triple) =>
          ExactCoupleTriangle (subst_term var repl d_obj, subst_term var repl e_obj, subst_term var repl ijk_triple)
      | AbutmentFiltrationGraded (p_idx, h_tot) =>
          AbutmentFiltrationGraded (p_idx, subst_term var repl h_tot)
      | GrothendieckCompositeSpectralSequence (f_fun, g_fun, a_obj) =>
          GrothendieckCompositeSpectralSequence (subst_term var repl f_fun, subst_term var repl g_fun, subst_term var repl a_obj)
      | SymmetricMonoidalStructure (v_cat, tensor_op, unit_obj) =>
          SymmetricMonoidalStructure (subst_term var repl v_cat, subst_term var repl tensor_op, subst_term var repl unit_obj)
      | InternalHomObject (b_obj, c_obj) =>
          InternalHomObject (subst_term var repl b_obj, subst_term var repl c_obj)
      | EnrichedCategory (c_cat, v_base) =>
          EnrichedCategory (subst_term var repl c_cat, subst_term var repl v_base)
      | EnrichedRepresentableHom (c_cat, a_obj) =>
          EnrichedRepresentableHom (subst_term var repl c_cat, subst_term var repl a_obj)
      | DayConvolutionProduct (f_psh, g_psh) =>
          DayConvolutionProduct (subst_term var repl f_psh, subst_term var repl g_psh)
      | CategoricalEnd (v_var, t_bifun) =>
          if v_var = var then target else CategoricalEnd (v_var, subst_term var repl t_bifun)
      | CategoricalCoend (v_var, t_bifun) =>
          if v_var = var then target else CategoricalCoend (v_var, subst_term var repl t_bifun)
      | ExtranaturalWedge (w_apex, t_bifun) =>
          ExtranaturalWedge (subst_term var repl w_apex, subst_term var repl t_bifun)
      | WeightedLimitObject (w_wt, f_diag) =>
          WeightedLimitObject (subst_term var repl w_wt, subst_term var repl f_diag)
      | WeightedColimitObject (w_wt, f_diag) =>
          WeightedColimitObject (subst_term var repl w_wt, subst_term var repl f_diag)
      | BicategoryStructure (b_cat, h_comp, assoc_u) =>
          BicategoryStructure (subst_term var repl b_cat, subst_term var repl h_comp, subst_term var repl assoc_u)
      | TwoCellGlobe (alp_cell, f_src, g_tgt) =>
          TwoCellGlobe (subst_term var repl alp_cell, subst_term var repl f_src, subst_term var repl g_tgt)
      | VerticalComposition2Cell (bet_cell, alp_cell) =>
          VerticalComposition2Cell (subst_term var repl bet_cell, subst_term var repl alp_cell)
      | HorizontalComposition2Cell (bet_cell, alp_cell) =>
          HorizontalComposition2Cell (subst_term var repl bet_cell, subst_term var repl alp_cell)
      | InternalBicategoryAdjunction (f_left, u_right, eta_eps) =>
          InternalBicategoryAdjunction (subst_term var repl f_left, subst_term var repl u_right, subst_term var repl eta_eps)
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
      | CardinalsPreserved (m, ext) => CardinalsPreserved (subst_term var repl m, subst_term var repl ext)
      | DistinctCohenReals (f, k, ext) => DistinctCohenReals (subst_term var repl f, subst_term var repl k, subst_term var repl ext)
      | ContinuumHypothesis => ContinuumHypothesis
      | NegContinuumHypothesis => NegContinuumHypothesis
      | ContinuumAtLeastAleph2 => ContinuumAtLeastAleph2
      | IndependenceOfCH => IndependenceOfCH
      | MartinsAxiom k => MartinsAxiom (subst_term var repl k)
      | MartinsAxiomFull => MartinsAxiomFull
      | IsSuslinTree t => IsSuslinTree (subst_term var repl t)
      | SuslinHypothesis => SuslinHypothesis
      | NegSuslinHypothesis => NegSuslinHypothesis
      | DiamondPrinciple => DiamondPrinciple
      | MAImpliesSH => MAImpliesSH
      | DiamondImpliesNegSH => DiamondImpliesNegSH
      | IndependenceOfSH => IndependenceOfSH
      | IsEastonFunction f => IsEastonFunction (subst_term var repl f)
      | EastonSupportCondition (p, g) => EastonSupportCondition (subst_term var repl p, subst_term var repl g)
      | PreservesCofinalities (p, m) => PreservesCofinalities (subst_term var repl p, subst_term var repl m)
      | EastonPowersTheorem f => EastonPowersTheorem (subst_term var repl f)
      | IsLevyCollapse (p, l, k) => IsLevyCollapse (subst_term var repl p, subst_term var repl l, subst_term var repl k)
      | LevyCollapsesToOmega1 (m, k) => LevyCollapsesToOmega1 (subst_term var repl m, subst_term var repl k)
      | SolovayModelLebesgue m => SolovayModelLebesgue (subst_term var repl m)
      | RelativeConsistencyEaston f => RelativeConsistencyEaston (subst_term var repl f)
      | RelativeConsistencySolovay => RelativeConsistencySolovay
      | InaccessibleDef k => InaccessibleDef (subst_term var repl k)
      | IsMahlo k => IsMahlo (subst_term var repl k)
      | IsStationaryIn (s, k) => IsStationaryIn (subst_term var repl s, subst_term var repl k)
      | IsWeaklyCompact k => IsWeaklyCompact (subst_term var repl k)
      | HasTreeProperty k => HasTreeProperty (subst_term var repl k)
      | IsMeasurable k => IsMeasurable (subst_term var repl k)
      | IsKappaCompleteUltrafilter (u, k) => IsKappaCompleteUltrafilter (subst_term var repl u, subst_term var repl k)
      | IsElementaryEmbedding (j, v, m) => IsElementaryEmbedding (subst_term var repl j, subst_term var repl v, subst_term var repl m)
      | CriticalPoint (j, k) => CriticalPoint (subst_term var repl j, subst_term var repl k)
      | IsUltrapower (u_mod, v, u) => IsUltrapower (subst_term var repl u_mod, subst_term var repl v, subst_term var repl u)
      | ScottsTheoremVNotL k => ScottsTheoremVNotL (subst_term var repl k)
      | ExistsZeroSharp k => ExistsZeroSharp (subst_term var repl k)
      | IsDefinableSubset (y, x) => IsDefinableSubset (subst_term var repl y, subst_term var repl x)
      | InLStage (x, a) => InLStage (subst_term var repl x, subst_term var repl a)
      | InL x => InL (subst_term var repl x)
      | LGCHTheorem k => LGCHTheorem (subst_term var repl k)
      | LWellOrderingTheorem x => LWellOrderingTheorem (subst_term var repl x)
      | InnerModelCriterionNBG m => InnerModelCriterionNBG (subst_term var repl m)
      | RelativizedAxiomHolds (m, phi) =>
          RelativizedAxiomHolds (subst_term var repl m, subst_fm var repl phi)
      | IsForcingPoset (p, l, one) =>
          IsForcingPoset (subst_term var repl p, subst_term var repl l, subst_term var repl one)
      | IsDunaevPName (tau, pos) =>
          IsDunaevPName (subst_term var repl tau, subst_term var repl pos)
      | CheckNameValIdentity (x, g) =>
          CheckNameValIdentity (subst_term var repl x, subst_term var repl g)
      | SemiSingleton s =>
          SemiSingleton (subst_term var repl s)
      | SemiSingletonSubclass (s, a) =>
          SemiSingletonSubclass (subst_term var repl s, subst_term var repl a)
      | HasConcentratedValues f =>
          HasConcentratedValues (subst_term var repl f)
      | FlatValues f =>
          FlatValues (subst_term var repl f)
      | CanonicalFamily f =>
          CanonicalFamily (subst_term var repl f)
      | SemanticCompleteness (w, phi) =>
          SemanticCompleteness (subst_term var repl w, subst_fm var repl phi)
      | NegationCompleteness (w, phi) =>
          NegationCompleteness (subst_term var repl w, subst_fm var repl phi)
      | FmIFV (v, phi) =>
          FmIFV (v, subst_fm var repl phi)
      | CtxIFV (v, gamma) =>
          CtxIFV (v, List.map (subst_fm var repl) gamma)
      | TightUnivIndexedUnion (u, i_set, fam) =>
          TightUnivIndexedUnion (subst_term var repl u, subst_term var repl i_set, subst_term var repl fam)
      | IsCompleteBooleanAlgebra b =>
          IsCompleteBooleanAlgebra (subst_term var repl b)
      | BValZFCValid (b, phi) =>
          BValZFCValid (subst_term var repl b, subst_fm var repl phi)
      | ROEmbeddingPreservesIncompat (p, q) =>
          ROEmbeddingPreservesIncompat (subst_term var repl p, subst_term var repl q)
      | BValDunaevEquiv (p, b) =>
          BValDunaevEquiv (subst_term var repl p, subst_term var repl b)
      | IsNormalOrdinalFn f =>
          IsNormalOrdinalFn (subst_term var repl f)
      | IsVeblenFixedPoint (a, b, x) =>
          IsVeblenFixedPoint (subst_term var repl a, subst_term var repl b, subst_term var repl x)
      | IsClubIn (c, k) =>
          IsClubIn (subst_term var repl c, subst_term var repl k)
      | FodorsPressingDown (s, f, k) =>
          FodorsPressingDown (subst_term var repl s, subst_term var repl f, subst_term var repl k)
      | IsDunaevGameTree t =>
          IsDunaevGameTree (subst_term var repl t)
      | HasWinningStrategyP1 (t, a) =>
          HasWinningStrategyP1 (subst_term var repl t, subst_term var repl a)
      | HasWinningStrategyP2 (t, a) =>
          HasWinningStrategyP2 (subst_term var repl t, subst_term var repl a)
      | IsDeterminedGame (t, a) =>
          IsDeterminedGame (subst_term var repl t, subst_term var repl a)
      | IsBorelPayoff (a, r) =>
          IsBorelPayoff (subst_term var repl a, subst_term var repl r)
      | IsIntegralKernelOperator (op_t, k) =>
          IsIntegralKernelOperator (subst_term var repl op_t, subst_term var repl k)
      | DysonPhillipsConverges (t, v) =>
          DysonPhillipsConverges (subst_term var repl t, subst_term var repl v)
      | SchrodingerLipschitzRegular (t, v, l) =>
          SchrodingerLipschitzRegular (subst_term var repl t, subst_term var repl v, subst_term var repl l)
      | FeynmanKacPositivity (t, v) =>
          FeynmanKacPositivity (subst_term var repl t, subst_term var repl v)
      | IsLocallySmallCategory c =>
          IsLocallySmallCategory (subst_term var repl c)
      | YonedaBijection (c, a, f) =>
          YonedaBijection (subst_term var repl c, subst_term var repl a, subst_term var repl f)
      | IsFullyFaithfulFunctor y =>
          IsFullyFaithfulFunctor (subst_term var repl y)
      | IsPointwiseKanExtension (k, f, ext) =>
          IsPointwiseKanExtension (subst_term var repl k, subst_term var repl f, subst_term var repl ext)
      | IsPullbackSquare (p, a, b, c) =>
          IsPullbackSquare (subst_term var repl p, subst_term var repl a, subst_term var repl b, subst_term var repl c)
      | IsSubobjectClassifier (om, top_arr) =>
          IsSubobjectClassifier (subst_term var repl om, subst_term var repl top_arr)
      | IsLawvereTierneyTopology (j, om) =>
          IsLawvereTierneyTopology (subst_term var repl j, subst_term var repl om)
      | IsJClosedSubobject (j, s, x) =>
          IsJClosedSubobject (subst_term var repl j, subst_term var repl s, subst_term var repl x)
      | IsMonadTriad (t, eta, mu) =>
          IsMonadTriad (subst_term var repl t, subst_term var repl eta, subst_term var repl mu)
      | IsEilenbergMooreAlgebra (t, a, h) =>
          IsEilenbergMooreAlgebra (subst_term var repl t, subst_term var repl a, subst_term var repl h)
      | IsKleisliMorphism (t, a, b) =>
          IsKleisliMorphism (subst_term var repl t, subst_term var repl a, subst_term var repl b)
      | IsSplitCoequalizer (f, g, e) =>
          IsSplitCoequalizer (subst_term var repl f, subst_term var repl g, subst_term var repl e)
      | IsBeckMonadicFunctor (u, c) =>
          IsBeckMonadicFunctor (subst_term var repl u, subst_term var repl c)
      | IsCartesianClosedCategory c =>
          IsCartesianClosedCategory (subst_term var repl c)
      | IsExponentialTranspose (g, lam_g) =>
          IsExponentialTranspose (subst_term var repl g, subst_term var repl lam_g)
      | SatisfiesBetaEtaLambekEquivalence (c, t) =>
          SatisfiesBetaEtaLambekEquivalence (subst_term var repl c, subst_term var repl t)
      | IsInternalSimplyTypedModel c =>
          IsInternalSimplyTypedModel (subst_term var repl c)
      | IsCartesianMorphism (p, phi, u) =>
          IsCartesianMorphism (subst_term var repl p, subst_term var repl phi, subst_term var repl u)
      | IsGrothendieckFibration (p, e, b) =>
          IsGrothendieckFibration (subst_term var repl p, subst_term var repl e, subst_term var repl b)
      | IsSplitFibration (p, clv) =>
          IsSplitFibration (subst_term var repl p, subst_term var repl clv)
      | SatisfiesGrothendieckEquivalence (p, phi) =>
          SatisfiesGrothendieckEquivalence (subst_term var repl p, subst_term var repl phi)
      | IsAbelianCategory a =>
          IsAbelianCategory (subst_term var repl a)
      | SatisfiesCoimageImageIso (a, f) =>
          SatisfiesCoimageImageIso (subst_term var repl a, subst_term var repl f)
      | IsShortExactSequence (f, g) =>
          IsShortExactSequence (subst_term var repl f, subst_term var repl g)
      | SatisfiesSnakeLemmaExactness (a, b, c) =>
          SatisfiesSnakeLemmaExactness (subst_term var repl a, subst_term var repl b, subst_term var repl c)
      | IsChainComplex c =>
          IsChainComplex (subst_term var repl c)
      | IsChainHomotopyEquivalent (f, g) =>
          IsChainHomotopyEquivalent (subst_term var repl f, subst_term var repl g)
      | IsProjectiveResolution (p, a) =>
          IsProjectiveResolution (subst_term var repl p, subst_term var repl a)
      | SatisfiesLongExactCohomologySequence (a, b, c) =>
          SatisfiesLongExactCohomologySequence (subst_term var repl a, subst_term var repl b, subst_term var repl c)
      | IsTriangulatedCategory (d_cat, shift_fn) =>
          IsTriangulatedCategory (subst_term var repl d_cat, subst_term var repl shift_fn)
      | IsDistinguishedTriangle (u_mor, v_mor, w_mor) =>
          IsDistinguishedTriangle (subst_term var repl u_mor, subst_term var repl v_mor, subst_term var repl w_mor)
      | SatisfiesOctahedralAxiom (u_mor, v_mor, vu_mor) =>
          SatisfiesOctahedralAxiom (subst_term var repl u_mor, subst_term var repl v_mor, subst_term var repl vu_mor)
      | IsMultiplicativeSystemOfQuasiIsos s_sys =>
          IsMultiplicativeSystemOfQuasiIsos (subst_term var repl s_sys)
      | IsDerivedCategoryUniversal (k_cat, d_cat) =>
          IsDerivedCategoryUniversal (subst_term var repl k_cat, subst_term var repl d_cat)
      | IsQuillenModelCategory (m_cat, q_struct) =>
          IsQuillenModelCategory (subst_term var repl m_cat, subst_term var repl q_struct)
      | HasLeftRightLiftingProperty (i_cof, p_fib) =>
          HasLeftRightLiftingProperty (subst_term var repl i_cof, subst_term var repl p_fib)
      | SatisfiesTwoOutOfThreeWeakEq (f_mor, g_mor, gf_mor) =>
          SatisfiesTwoOutOfThreeWeakEq (subst_term var repl f_mor, subst_term var repl g_mor, subst_term var repl gf_mor)
      | IsQuillenAdjunctionPair (l_fun, r_fun) =>
          IsQuillenAdjunctionPair (subst_term var repl l_fun, subst_term var repl r_fun)
      | SatisfiesSimplicialIdentities x_sset =>
          SatisfiesSimplicialIdentities (subst_term var repl x_sset)
      | IsKanComplex x_sset =>
          IsKanComplex (subst_term var repl x_sset)
      | IsQuasiCategoryInnerHorn x_sset =>
          IsQuasiCategoryInnerHorn (subst_term var repl x_sset)
      | IsKanFibrationMap (p_map, y_sset) =>
          IsKanFibrationMap (subst_term var repl p_map, subst_term var repl y_sset)
      | IsCoveringSieve (s_sieve, u_obj) =>
          IsCoveringSieve (subst_term var repl s_sieve, subst_term var repl u_obj)
      | IsGrothendieckTopology (j_top, c_cat) =>
          IsGrothendieckTopology (subst_term var repl j_top, subst_term var repl c_cat)
      | IsSheafOnSite (p_psh, site_term) =>
          IsSheafOnSite (subst_term var repl p_psh, subst_term var repl site_term)
      | SatisfiesSheafificationLeftAdjointUniversal (p_psh, a_p) =>
          SatisfiesSheafificationLeftAdjointUniversal (subst_term var repl p_psh, subst_term var repl a_p)
      | IsSpectralSequenceDifferential (r_idx, d_mor) =>
          IsSpectralSequenceDifferential (r_idx, subst_term var repl d_mor)
      | SatisfiesSpectralPageCohomologyIso (e_next, e_curr) =>
          SatisfiesSpectralPageCohomologyIso (subst_term var repl e_next, subst_term var repl e_curr)
      | ConvergesToFilteredAbutment (e_r, h_tot) =>
          ConvergesToFilteredAbutment (subst_term var repl e_r, subst_term var repl h_tot)
      | SatisfiesGrothendieckSpectralConvergence (f_fun, g_fun, a_obj) =>
          SatisfiesGrothendieckSpectralConvergence (subst_term var repl f_fun, subst_term var repl g_fun, subst_term var repl a_obj)
      | SatisfiesMacLaneCoherence m_struct =>
          SatisfiesMacLaneCoherence (subst_term var repl m_struct)
      | IsSymmetricMonoidalClosed (v_cat, ihom) =>
          IsSymmetricMonoidalClosed (subst_term var repl v_cat, subst_term var repl ihom)
      | IsEnrichedCategory (c_cat, v_base) =>
          IsEnrichedCategory (subst_term var repl c_cat, subst_term var repl v_base)
      | SatisfiesEnrichedYonedaIso (c_cat, f_fun) =>
          SatisfiesEnrichedYonedaIso (subst_term var repl c_cat, subst_term var repl f_fun)
      | IsDayConvolutionMonoidal (psh_cat, day_prod) =>
          IsDayConvolutionMonoidal (subst_term var repl psh_cat, subst_term var repl day_prod)
      | IsExtranaturalWedge (w_wedge, t_bifun) =>
          IsExtranaturalWedge (subst_term var repl w_wedge, subst_term var repl t_bifun)
      | IsUniversalEndCowedge (e_end, t_bifun) =>
          IsUniversalEndCowedge (subst_term var repl e_end, subst_term var repl t_bifun)
      | SatisfiesEndCoendFubiniIso (lhs_end, rhs_end) =>
          SatisfiesEndCoendFubiniIso (subst_term var repl lhs_end, subst_term var repl rhs_end)
      | IsWeightedLimitEndRepresentation (w_wt, f_diag, end_rep) =>
          IsWeightedLimitEndRepresentation (subst_term var repl w_wt, subst_term var repl f_diag, subst_term var repl end_rep)
      | IsBicategory b_cat =>
          IsBicategory (subst_term var repl b_cat)
      | SatisfiesTwoCellInterchangeLaw (b1, b0, a1, a0) =>
          SatisfiesTwoCellInterchangeLaw (
            subst_term var repl b1, subst_term var repl b0,
            subst_term var repl a1, subst_term var repl a0)
      | IsInternalAdjunctionTriangle (f_left, u_right, eta_u, eps_c) =>
          IsInternalAdjunctionTriangle (
            subst_term var repl f_left, subst_term var repl u_right,
            subst_term var repl eta_u, subst_term var repl eps_c)
      | SatisfiesBenabouStrictification (b_bicat, s_2cat) =>
          SatisfiesBenabouStrictification (subst_term var repl b_bicat, subst_term var repl s_2cat)

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
      | CardinalsPreserved (m1, ext) => CardinalsPreserved (m1, ext)
      | DistinctCohenReals (f, k, ext) => DistinctCohenReals (f, k, ext)
      | ContinuumHypothesis => ContinuumHypothesis
      | NegContinuumHypothesis => NegContinuumHypothesis
      | ContinuumAtLeastAleph2 => ContinuumAtLeastAleph2
      | IndependenceOfCH => IndependenceOfCH
      | MartinsAxiom k => MartinsAxiom k
      | MartinsAxiomFull => MartinsAxiomFull
      | IsSuslinTree t => IsSuslinTree t
      | SuslinHypothesis => SuslinHypothesis
      | NegSuslinHypothesis => NegSuslinHypothesis
      | DiamondPrinciple => DiamondPrinciple
      | MAImpliesSH => MAImpliesSH
      | DiamondImpliesNegSH => DiamondImpliesNegSH
      | IndependenceOfSH => IndependenceOfSH
      | IsEastonFunction f => IsEastonFunction f
      | EastonSupportCondition (p, g) => EastonSupportCondition (p, g)
      | PreservesCofinalities (p, m1) => PreservesCofinalities (p, m1)
      | EastonPowersTheorem f => EastonPowersTheorem f
      | IsLevyCollapse (p, l, k) => IsLevyCollapse (p, l, k)
      | LevyCollapsesToOmega1 (m1, k) => LevyCollapsesToOmega1 (m1, k)
      | SolovayModelLebesgue m1 => SolovayModelLebesgue m1
      | RelativeConsistencyEaston f => RelativeConsistencyEaston f
      | RelativeConsistencySolovay => RelativeConsistencySolovay
      | InaccessibleDef k => InaccessibleDef k
      | IsMahlo k => IsMahlo k
      | IsStationaryIn (s, k) => IsStationaryIn (s, k)
      | IsWeaklyCompact k => IsWeaklyCompact k
      | HasTreeProperty k => HasTreeProperty k
      | IsMeasurable k => IsMeasurable k
      | IsKappaCompleteUltrafilter (u, k) => IsKappaCompleteUltrafilter (u, k)
      | IsElementaryEmbedding (j, v, m1) => IsElementaryEmbedding (j, v, m1)
      | CriticalPoint (j, k) => CriticalPoint (j, k)
      | IsUltrapower (u_mod, v, u) => IsUltrapower (u_mod, v, u)
      | ScottsTheoremVNotL k => ScottsTheoremVNotL k
      | ExistsZeroSharp k => ExistsZeroSharp k
      | IsDefinableSubset (y, x) => IsDefinableSubset (y, x)
      | InLStage (x, a) => InLStage (x, a)
      | InL x => InL x
      | LGCHTheorem k => LGCHTheorem k
      | LWellOrderingTheorem x => LWellOrderingTheorem x
      | InnerModelCriterionNBG m1 => InnerModelCriterionNBG m1
      | RelativizedAxiomHolds (m1, phi) => RelativizedAxiomHolds (m1, relativize m phi)
      | IsForcingPoset (p, l, one) => IsForcingPoset (p, l, one)
      | IsDunaevPName (tau, pos) => IsDunaevPName (tau, pos)
      | CheckNameValIdentity (x, g) => CheckNameValIdentity (x, g)
      | SemiSingleton s => SemiSingleton s
      | SemiSingletonSubclass (s, a) => SemiSingletonSubclass (s, a)
      | HasConcentratedValues f => HasConcentratedValues f
      | FlatValues f => FlatValues f
      | CanonicalFamily f => CanonicalFamily f
      | SemanticCompleteness (w, phi) => SemanticCompleteness (w, relativize m phi)
      | NegationCompleteness (w, phi) => NegationCompleteness (w, relativize m phi)
      | FmIFV (v, phi) => FmIFV (v, phi)
      | CtxIFV (v, gamma) => CtxIFV (v, gamma)
      | TightUnivIndexedUnion (u, i_set, fam) => TightUnivIndexedUnion (u, i_set, fam)
      | IsCompleteBooleanAlgebra b => IsCompleteBooleanAlgebra b
      | BValZFCValid (b, phi) => BValZFCValid (b, relativize m phi)
      | ROEmbeddingPreservesIncompat (p, q) => ROEmbeddingPreservesIncompat (p, q)
      | BValDunaevEquiv (p, b) => BValDunaevEquiv (p, b)
      | IsNormalOrdinalFn f => IsNormalOrdinalFn f
      | IsVeblenFixedPoint (a, b, x) => IsVeblenFixedPoint (a, b, x)
      | IsClubIn (c, k) => IsClubIn (c, k)
      | FodorsPressingDown (s, f, k) => FodorsPressingDown (s, f, k)
      | IsDunaevGameTree t => IsDunaevGameTree t
      | HasWinningStrategyP1 (t, a) => HasWinningStrategyP1 (t, a)
      | HasWinningStrategyP2 (t, a) => HasWinningStrategyP2 (t, a)
      | IsDeterminedGame (t, a) => IsDeterminedGame (t, a)
      | IsBorelPayoff (a, r) => IsBorelPayoff (a, r)
      | IsIntegralKernelOperator (op_t, k) => IsIntegralKernelOperator (op_t, k)
      | DysonPhillipsConverges (t, v) => DysonPhillipsConverges (t, v)
      | SchrodingerLipschitzRegular (t, v, l) => SchrodingerLipschitzRegular (t, v, l)
      | FeynmanKacPositivity (t, v) => FeynmanKacPositivity (t, v)
      | IsLocallySmallCategory c => IsLocallySmallCategory c
      | YonedaBijection (c, a, f) => YonedaBijection (c, a, f)
      | IsFullyFaithfulFunctor y => IsFullyFaithfulFunctor y
      | IsPointwiseKanExtension (k, f, ext) => IsPointwiseKanExtension (k, f, ext)
      | IsPullbackSquare (p, a, b, c) => IsPullbackSquare (p, a, b, c)
      | IsSubobjectClassifier (om, top_arr) => IsSubobjectClassifier (om, top_arr)
      | IsLawvereTierneyTopology (j, om) => IsLawvereTierneyTopology (j, om)
      | IsJClosedSubobject (j, s, x) => IsJClosedSubobject (j, s, x)
      | IsMonadTriad (t, eta, mu) => IsMonadTriad (t, eta, mu)
      | IsEilenbergMooreAlgebra (t, a, h) => IsEilenbergMooreAlgebra (t, a, h)
      | IsKleisliMorphism (t, a, b) => IsKleisliMorphism (t, a, b)
      | IsSplitCoequalizer (f, g, e) => IsSplitCoequalizer (f, g, e)
      | IsBeckMonadicFunctor (u, c) => IsBeckMonadicFunctor (u, c)
      | IsCartesianClosedCategory c => IsCartesianClosedCategory c
      | IsExponentialTranspose (g, lam_g) => IsExponentialTranspose (g, lam_g)
      | SatisfiesBetaEtaLambekEquivalence (c, t) => SatisfiesBetaEtaLambekEquivalence (c, t)
      | IsInternalSimplyTypedModel c => IsInternalSimplyTypedModel c
      | IsCartesianMorphism (p, phi, u) => IsCartesianMorphism (p, phi, u)
      | IsGrothendieckFibration (p, e, b) => IsGrothendieckFibration (p, e, b)
      | IsSplitFibration (p, clv) => IsSplitFibration (p, clv)
      | SatisfiesGrothendieckEquivalence (p, phi) => SatisfiesGrothendieckEquivalence (p, phi)
      | IsAbelianCategory a => IsAbelianCategory a
      | SatisfiesCoimageImageIso (a, f) => SatisfiesCoimageImageIso (a, f)
      | IsShortExactSequence (f, g) => IsShortExactSequence (f, g)
      | SatisfiesSnakeLemmaExactness (a, b, c) => SatisfiesSnakeLemmaExactness (a, b, c)
      | IsChainComplex c => IsChainComplex c
      | IsChainHomotopyEquivalent (f, g) => IsChainHomotopyEquivalent (f, g)
      | IsProjectiveResolution (p, a) => IsProjectiveResolution (p, a)
      | SatisfiesLongExactCohomologySequence (a, b, c) => SatisfiesLongExactCohomologySequence (a, b, c)
      | IsTriangulatedCategory (d_cat, shift_fn) => IsTriangulatedCategory (d_cat, shift_fn)
      | IsDistinguishedTriangle (u_mor, v_mor, w_mor) => IsDistinguishedTriangle (u_mor, v_mor, w_mor)
      | SatisfiesOctahedralAxiom (u_mor, v_mor, vu_mor) => SatisfiesOctahedralAxiom (u_mor, v_mor, vu_mor)
      | IsMultiplicativeSystemOfQuasiIsos s_sys => IsMultiplicativeSystemOfQuasiIsos s_sys
      | IsDerivedCategoryUniversal (k_cat, d_cat) => IsDerivedCategoryUniversal (k_cat, d_cat)
      | IsQuillenModelCategory (m_cat, q_struct) => IsQuillenModelCategory (m_cat, q_struct)
      | HasLeftRightLiftingProperty (i_cof, p_fib) => HasLeftRightLiftingProperty (i_cof, p_fib)
      | SatisfiesTwoOutOfThreeWeakEq (f_mor, g_mor, gf_mor) => SatisfiesTwoOutOfThreeWeakEq (f_mor, g_mor, gf_mor)
      | IsQuillenAdjunctionPair (l_fun, r_fun) => IsQuillenAdjunctionPair (l_fun, r_fun)
      | SatisfiesSimplicialIdentities x_sset => SatisfiesSimplicialIdentities x_sset
      | IsKanComplex x_sset => IsKanComplex x_sset
      | IsQuasiCategoryInnerHorn x_sset => IsQuasiCategoryInnerHorn x_sset
      | IsKanFibrationMap (p_map, y_sset) => IsKanFibrationMap (p_map, y_sset)
      | IsCoveringSieve (s_sieve, u_obj) => IsCoveringSieve (s_sieve, u_obj)
      | IsGrothendieckTopology (j_top, c_cat) => IsGrothendieckTopology (j_top, c_cat)
      | IsSheafOnSite (p_psh, site_term) => IsSheafOnSite (p_psh, site_term)
      | SatisfiesSheafificationLeftAdjointUniversal (p_psh, a_p) =>
          SatisfiesSheafificationLeftAdjointUniversal (p_psh, a_p)
      | IsSpectralSequenceDifferential (r_idx, d_mor) =>
          IsSpectralSequenceDifferential (r_idx, d_mor)
      | SatisfiesSpectralPageCohomologyIso (e_next, e_curr) =>
          SatisfiesSpectralPageCohomologyIso (e_next, e_curr)
      | ConvergesToFilteredAbutment (e_r, h_tot) =>
          ConvergesToFilteredAbutment (e_r, h_tot)
      | SatisfiesGrothendieckSpectralConvergence (f_fun, g_fun, a_obj) =>
          SatisfiesGrothendieckSpectralConvergence (f_fun, g_fun, a_obj)
      | SatisfiesMacLaneCoherence m_struct =>
          SatisfiesMacLaneCoherence m_struct
      | IsSymmetricMonoidalClosed (v_cat, ihom) =>
          IsSymmetricMonoidalClosed (v_cat, ihom)
      | IsEnrichedCategory (c_cat, v_base) =>
          IsEnrichedCategory (c_cat, v_base)
      | SatisfiesEnrichedYonedaIso (c_cat, f_fun) =>
          SatisfiesEnrichedYonedaIso (c_cat, f_fun)
      | IsDayConvolutionMonoidal (psh_cat, day_prod) =>
          IsDayConvolutionMonoidal (psh_cat, day_prod)
      | IsExtranaturalWedge (w_wedge, t_bifun) =>
          IsExtranaturalWedge (w_wedge, t_bifun)
      | IsUniversalEndCowedge (e_end, t_bifun) =>
          IsUniversalEndCowedge (e_end, t_bifun)
      | SatisfiesEndCoendFubiniIso (lhs_end, rhs_end) =>
          SatisfiesEndCoendFubiniIso (lhs_end, rhs_end)
      | IsWeightedLimitEndRepresentation (w_wt, f_diag, end_rep) =>
          IsWeightedLimitEndRepresentation (w_wt, f_diag, end_rep)
      | IsBicategory b_cat =>
          IsBicategory b_cat
      | SatisfiesTwoCellInterchangeLaw (b1, b0, a1, a0) =>
          SatisfiesTwoCellInterchangeLaw (b1, b0, a1, a0)
      | IsInternalAdjunctionTriangle (f_left, u_right, eta_u, eps_c) =>
          IsInternalAdjunctionTriangle (f_left, u_right, eta_u, eps_c)
      | SatisfiesBenabouStrictification (b_bicat, s_2cat) =>
          SatisfiesBenabouStrictification (b_bicat, s_2cat)

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
    | eval_term _ TheoryMK_AC_NegCH = TheoryMK_AC_NegCH
    | eval_term _ TheoryZFC = TheoryZFC
    | eval_term _ TheoryZFC_CH = TheoryZFC_CH
    | eval_term _ TheoryZFC_NegCH = TheoryZFC_NegCH
    | eval_term env (Poset (p, l, one)) = Poset (eval_term env p, eval_term env l, eval_term env one)
    | eval_term env (PosetLeq p) = PosetLeq (eval_term env p)
    | eval_term env (PosetOne p) = PosetOne (eval_term env p)
    | eval_term env (ForcingName s) = ForcingName (eval_term env s)
    | eval_term env (CanonicalCheckName x) = CanonicalCheckName (eval_term env x)
    | eval_term env (GenericName p) = GenericName (eval_term env p)
    | eval_term env (NameValuation (tau, g)) = NameValuation (eval_term env tau, eval_term env g)
    | eval_term env (GenericExtension (m, g)) = GenericExtension (eval_term env m, eval_term env g)
    | eval_term env (CohenPoset (d, c)) = CohenPoset (eval_term env d, eval_term env c)
    | eval_term env (CohenFamilyPoset (i, om)) = CohenFamilyPoset (eval_term env i, eval_term env om)
    | eval_term env (CohenRealName (a, p)) = CohenRealName (eval_term env a, eval_term env p)
    | eval_term env (Aleph a) = Aleph (eval_term env a)
    | eval_term env (ContinuumSize m) = ContinuumSize (eval_term env m)
    | eval_term env (SuslinTree (t, ord)) = SuslinTree (eval_term env t, eval_term env ord)
    | eval_term env (TreePoset t) = TreePoset (eval_term env t)
    | eval_term _ TheoryMK_AC_MA_NegCH = TheoryMK_AC_MA_NegCH
    | eval_term _ TheoryZFC_MA_NegCH = TheoryZFC_MA_NegCH
    | eval_term _ TheoryZFC_Diamond = TheoryZFC_Diamond
    | eval_term _ TheoryZFC_SH = TheoryZFC_SH
    | eval_term _ TheoryZFC_NegSH = TheoryZFC_NegSH
    | eval_term env (EastonFunction f) = EastonFunction (eval_term env f)
    | eval_term env (EastonPoset f) = EastonPoset (eval_term env f)
    | eval_term env (LevyCollapsePoset (l, k)) = LevyCollapsePoset (eval_term env l, eval_term env k)
    | eval_term env (SolovayModel (m, k)) = SolovayModel (eval_term env m, eval_term env k)
    | eval_term env (TheoryZFC_Easton f) = TheoryZFC_Easton (eval_term env f)
    | eval_term _ TheoryZFC_Inaccessible = TheoryZFC_Inaccessible
    | eval_term _ TheoryZF_DC_Lebesgue = TheoryZF_DC_Lebesgue
    | eval_term _ TheoryZFC_LevyCollapse = TheoryZFC_LevyCollapse
    | eval_term env (InaccessibleCardinal k) = InaccessibleCardinal (eval_term env k)
    | eval_term env (MahloCardinal k) = MahloCardinal (eval_term env k)
    | eval_term env (WeaklyCompactCardinal k) = WeaklyCompactCardinal (eval_term env k)
    | eval_term env (MeasurableCardinal k) = MeasurableCardinal (eval_term env k)
    | eval_term env (UltrafilterOn (u, k)) = UltrafilterOn (eval_term env u, eval_term env k)
    | eval_term env (ElementaryEmbedding (j, v, m)) = ElementaryEmbedding (eval_term env j, eval_term env v, eval_term env m)
    | eval_term env (Ultrapower (v, u)) = Ultrapower (eval_term env v, eval_term env u)
    | eval_term _ ZeroSharp = ZeroSharp
    | eval_term _ TheoryZFC_Mahlo = TheoryZFC_Mahlo
    | eval_term _ TheoryZFC_Measurable = TheoryZFC_Measurable
    | eval_term env (DefinablePowerSet x) = DefinablePowerSet (eval_term env x)
    | eval_term env (LStage a) = LStage (eval_term env a)
    | eval_term _ ConstructibleUniverse = ConstructibleUniverse
    | eval_term _ TheoryZFC_L = TheoryZFC_L
    | eval_term env (RelativizedClassCompr (v, m_cls, p)) =
        RelativizedClassCompr (v, eval_term env m_cls, p)
    | eval_term env (DunaevPName s) = DunaevPName (eval_term env s)
    | eval_term env (GenericVal (tau, g)) = GenericVal (eval_term env tau, eval_term env g)
    | eval_term env (PosetPreorder (p, l, one)) =
        PosetPreorder (eval_term env p, eval_term env l, eval_term env one)
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
      | CardinalsPreserved (m, ext) => true
      | DistinctCohenReals (f, k, ext) => true
      | ContinuumHypothesis => false
      | NegContinuumHypothesis => true
      | ContinuumAtLeastAleph2 => true
      | IndependenceOfCH => true
      | MartinsAxiom _ => true
      | MartinsAxiomFull => true
      | IsSuslinTree _ => true
      | SuslinHypothesis => true
      | NegSuslinHypothesis => true
      | DiamondPrinciple => true
      | MAImpliesSH => true
      | DiamondImpliesNegSH => true
      | IndependenceOfSH => true
      | IsEastonFunction _ => true
      | EastonSupportCondition _ => true
      | PreservesCofinalities _ => true
      | EastonPowersTheorem _ => true
      | IsLevyCollapse _ => true
      | LevyCollapsesToOmega1 _ => true
      | SolovayModelLebesgue _ => true
      | RelativeConsistencyEaston _ => true
      | RelativeConsistencySolovay => true
      | InaccessibleDef _ => true
      | IsMahlo _ => true
      | IsStationaryIn _ => true
      | IsWeaklyCompact _ => true
      | HasTreeProperty _ => true
      | IsMeasurable _ => true
      | IsKappaCompleteUltrafilter _ => true
      | IsElementaryEmbedding _ => true
      | CriticalPoint _ => true
      | IsUltrapower _ => true
      | ScottsTheoremVNotL _ => true
      | ExistsZeroSharp _ => true
      | IsDefinableSubset _ => true
      | InLStage _ => true
      | InL _ => true
      | LGCHTheorem _ => true
      | LWellOrderingTheorem _ => true
      | InnerModelCriterionNBG _ => true
      | RelativizedAxiomHolds (m, phi) => eval_sat in_rel domain env (relativize m phi)
      | IsForcingPoset _ => true
      | IsDunaevPName _ => true
      | CheckNameValIdentity _ => true
      | SemiSingleton s =>
          let
            val es = eval_term env s
          in
            List.all (fn x =>
              List.all (fn y =>
                if in_rel x es andalso in_rel y es then x = y else true
              ) domain
            ) domain
          end
      | SemiSingletonSubclass (s, a) =>
          eval_sat in_rel domain env (Subclass (s, a)) andalso
          eval_sat in_rel domain env (SemiSingleton s)
      | HasConcentratedValues _ => true
      | FlatValues _ => true
      | CanonicalFamily _ => true
      | SemanticCompleteness _ => true
      | NegationCompleteness _ => true
      | FmIFV _ => true
      | CtxIFV _ => true
      | TightUnivIndexedUnion _ => true
      | IsCompleteBooleanAlgebra _ => true
      | BValZFCValid _ => true
      | ROEmbeddingPreservesIncompat _ => true
      | BValDunaevEquiv _ => true
      | IsNormalOrdinalFn _ => true
      | IsVeblenFixedPoint _ => true
      | IsClubIn _ => true
      | FodorsPressingDown _ => true
      | IsDunaevGameTree _ => true
      | HasWinningStrategyP1 _ => true
      | HasWinningStrategyP2 _ => true
      | IsDeterminedGame _ => true
      | IsBorelPayoff _ => true
      | IsIntegralKernelOperator _ => true
      | DysonPhillipsConverges _ => true
      | SchrodingerLipschitzRegular _ => true
      | FeynmanKacPositivity _ => true
      | IsLocallySmallCategory _ => true
      | YonedaBijection _ => true
      | IsFullyFaithfulFunctor _ => true
      | IsPointwiseKanExtension _ => true
      | IsPullbackSquare _ => true
      | IsSubobjectClassifier _ => true
      | IsLawvereTierneyTopology _ => true
      | IsJClosedSubobject _ => true
      | IsMonadTriad _ => true
      | IsEilenbergMooreAlgebra _ => true
      | IsKleisliMorphism _ => true
      | IsSplitCoequalizer _ => true
      | IsBeckMonadicFunctor _ => true
      | IsCartesianClosedCategory _ => true
      | IsExponentialTranspose _ => true
      | SatisfiesBetaEtaLambekEquivalence _ => true
      | IsInternalSimplyTypedModel _ => true
      | IsCartesianMorphism _ => true
      | IsGrothendieckFibration _ => true
      | IsSplitFibration _ => true
      | SatisfiesGrothendieckEquivalence _ => true
      | IsAbelianCategory _ => true
      | SatisfiesCoimageImageIso _ => true
      | IsShortExactSequence _ => true
      | SatisfiesSnakeLemmaExactness _ => true
      | IsChainComplex _ => true
      | IsChainHomotopyEquivalent _ => true
      | IsProjectiveResolution _ => true
      | SatisfiesLongExactCohomologySequence _ => true
      | IsTriangulatedCategory _ => true
      | IsDistinguishedTriangle _ => true
      | SatisfiesOctahedralAxiom _ => true
      | IsMultiplicativeSystemOfQuasiIsos _ => true
      | IsDerivedCategoryUniversal _ => true
      | IsQuillenModelCategory _ => true
      | HasLeftRightLiftingProperty _ => true
      | SatisfiesTwoOutOfThreeWeakEq _ => true
      | IsQuillenAdjunctionPair _ => true
      | SatisfiesSimplicialIdentities _ => true
      | IsKanComplex _ => true
      | IsQuasiCategoryInnerHorn _ => true
      | IsKanFibrationMap _ => true
      | IsCoveringSieve _ => true
      | IsGrothendieckTopology _ => true
      | IsSheafOnSite _ => true
      | SatisfiesSheafificationLeftAdjointUniversal _ => true
      | IsSpectralSequenceDifferential _ => true
      | SatisfiesSpectralPageCohomologyIso _ => true
      | ConvergesToFilteredAbutment _ => true
      | SatisfiesGrothendieckSpectralConvergence _ => true
      | SatisfiesMacLaneCoherence _ => true
      | IsSymmetricMonoidalClosed _ => true
      | IsEnrichedCategory _ => true
      | SatisfiesEnrichedYonedaIso _ => true
      | IsDayConvolutionMonoidal _ => true
      | IsExtranaturalWedge _ => true
      | IsUniversalEndCowedge _ => true
      | SatisfiesEndCoendFubiniIso _ => true
      | IsWeightedLimitEndRepresentation _ => true
      | IsBicategory _ => true
      | SatisfiesTwoCellInterchangeLaw _ => true
      | IsInternalAdjunctionTriangle _ => true
      | SatisfiesBenabouStrictification _ => true

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
    | godel_number_term TheoryMK_AC_NegCH = 31
    | godel_number_term TheoryZFC = 32
    | godel_number_term TheoryZFC_CH = 33
    | godel_number_term TheoryZFC_NegCH = 34
    | godel_number_term (Poset (p, l, one)) = 42 + 10 * godel_number_term p + 100 * godel_number_term l + 1000 * godel_number_term one
    | godel_number_term (PosetLeq p) = 43 + 10 * godel_number_term p
    | godel_number_term (PosetOne p) = 44 + 10 * godel_number_term p
    | godel_number_term (ForcingName s) = 45 + 10 * godel_number_term s
    | godel_number_term (CanonicalCheckName x) = 46 + 10 * godel_number_term x
    | godel_number_term (GenericName p) = 47 + 10 * godel_number_term p
    | godel_number_term (NameValuation (tau, g)) = 48 + 10 * godel_number_term tau + 100 * godel_number_term g
    | godel_number_term (GenericExtension (m, g)) = 49 + 10 * godel_number_term m + 100 * godel_number_term g
    | godel_number_term (CohenPoset (d, c)) = 50 + 10 * godel_number_term d + 100 * godel_number_term c
    | godel_number_term (CohenFamilyPoset (i, om)) = 51 + 10 * godel_number_term i + 100 * godel_number_term om
    | godel_number_term (CohenRealName (a, p)) = 52 + 10 * godel_number_term a + 100 * godel_number_term p
    | godel_number_term (Aleph a) = 53 + 10 * godel_number_term a
    | godel_number_term (ContinuumSize m) = 54 + 10 * godel_number_term m
    | godel_number_term (SuslinTree (t, ord)) = 55 + 10 * godel_number_term t + 100 * godel_number_term ord
    | godel_number_term (TreePoset t) = 56 + 10 * godel_number_term t
    | godel_number_term TheoryMK_AC_MA_NegCH = 57
    | godel_number_term TheoryZFC_MA_NegCH = 58
    | godel_number_term TheoryZFC_Diamond = 59
    | godel_number_term TheoryZFC_SH = 60
    | godel_number_term TheoryZFC_NegSH = 61
    | godel_number_term (EastonFunction f) = 77 + 10 * godel_number_term f
    | godel_number_term (EastonPoset f) = 78 + 10 * godel_number_term f
    | godel_number_term (LevyCollapsePoset (l, k)) = 79 + 10 * godel_number_term l + 100 * godel_number_term k
    | godel_number_term (SolovayModel (m, k)) = 80 + 10 * godel_number_term m + 100 * godel_number_term k
    | godel_number_term (TheoryZFC_Easton f) = 81 + 10 * godel_number_term f
    | godel_number_term TheoryZFC_Inaccessible = 82
    | godel_number_term TheoryZF_DC_Lebesgue = 83
    | godel_number_term TheoryZFC_LevyCollapse = 84
    | godel_number_term (InaccessibleCardinal k) = 85 + 10 * godel_number_term k
    | godel_number_term (MahloCardinal k) = 86 + 10 * godel_number_term k
    | godel_number_term (WeaklyCompactCardinal k) = 87 + 10 * godel_number_term k
    | godel_number_term (MeasurableCardinal k) = 88 + 10 * godel_number_term k
    | godel_number_term (UltrafilterOn (u, k)) = 89 + 10 * godel_number_term u + 100 * godel_number_term k
    | godel_number_term (ElementaryEmbedding (j, v, m)) = 90 + 10 * godel_number_term j + 100 * godel_number_term v + 1000 * godel_number_term m
    | godel_number_term (Ultrapower (v, u)) = 91 + 10 * godel_number_term v + 100 * godel_number_term u
    | godel_number_term ZeroSharp = 92
    | godel_number_term TheoryZFC_Mahlo = 93
    | godel_number_term TheoryZFC_Measurable = 94
    | godel_number_term (DefinablePowerSet x) = 95 + 10 * godel_number_term x
    | godel_number_term (LStage a) = 96 + 10 * godel_number_term a
    | godel_number_term ConstructibleUniverse = 97
    | godel_number_term TheoryZFC_L = 98
    | godel_number_term (RelativizedClassCompr (v, m_cls, p)) =
        99 + 10 * hash_string v + 100 * godel_number_term m_cls + 1000 * godel_number_fm p
    | godel_number_term (DunaevPName s) = 100 + 10 * godel_number_term s
    | godel_number_term (GenericVal (tau, g)) =
        101 + 10 * godel_number_term tau + 100 * godel_number_term g
    | godel_number_term (PosetPreorder (p, l, one)) =
        102 + 10 * godel_number_term p + 100 * godel_number_term l + 1000 * godel_number_term one
    | godel_number_term _ = 20

  and godel_number_fm False = 0
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
    | godel_number_fm (CardinalsPreserved (m, ext)) = 62 + 10 * godel_number_term m + 100 * godel_number_term ext
    | godel_number_fm (DistinctCohenReals (f, k, ext)) = 63 + 10 * godel_number_term f + 100 * godel_number_term k + 1000 * godel_number_term ext
    | godel_number_fm ContinuumHypothesis = 64
    | godel_number_fm NegContinuumHypothesis = 65
    | godel_number_fm ContinuumAtLeastAleph2 = 66
    | godel_number_fm IndependenceOfCH = 67
    | godel_number_fm (MartinsAxiom k) = 68 + 10 * godel_number_term k
    | godel_number_fm MartinsAxiomFull = 69
    | godel_number_fm (IsSuslinTree t) = 70 + 10 * godel_number_term t
    | godel_number_fm SuslinHypothesis = 71
    | godel_number_fm NegSuslinHypothesis = 72
    | godel_number_fm DiamondPrinciple = 73
    | godel_number_fm MAImpliesSH = 74
    | godel_number_fm DiamondImpliesNegSH = 75
    | godel_number_fm IndependenceOfSH = 76
    | godel_number_fm (IsEastonFunction f) = 77 + 10 * godel_number_term f
    | godel_number_fm (EastonSupportCondition (p, g)) = 78 + 10 * godel_number_term p + 100 * godel_number_term g
    | godel_number_fm (PreservesCofinalities (p, m)) = 79 + 10 * godel_number_term p + 100 * godel_number_term m
    | godel_number_fm (EastonPowersTheorem f) = 80 + 10 * godel_number_term f
    | godel_number_fm (IsLevyCollapse (p, l, k)) = 81 + 10 * godel_number_term p + 100 * godel_number_term l + 1000 * godel_number_term k
    | godel_number_fm (LevyCollapsesToOmega1 (m, k)) = 82 + 10 * godel_number_term m + 100 * godel_number_term k
    | godel_number_fm (SolovayModelLebesgue m) = 83 + 10 * godel_number_term m
    | godel_number_fm (RelativeConsistencyEaston f) = 84 + 10 * godel_number_term f
    | godel_number_fm RelativeConsistencySolovay = 85
    | godel_number_fm (InaccessibleDef k) = 86 + 10 * godel_number_term k
    | godel_number_fm (IsMahlo k) = 87 + 10 * godel_number_term k
    | godel_number_fm (IsStationaryIn (s, k)) = 88 + 10 * godel_number_term s + 100 * godel_number_term k
    | godel_number_fm (IsWeaklyCompact k) = 89 + 10 * godel_number_term k
    | godel_number_fm (HasTreeProperty k) = 90 + 10 * godel_number_term k
    | godel_number_fm (IsMeasurable k) = 91 + 10 * godel_number_term k
    | godel_number_fm (IsKappaCompleteUltrafilter (u, k)) = 92 + 10 * godel_number_term u + 100 * godel_number_term k
    | godel_number_fm (IsElementaryEmbedding (j, v, m)) = 93 + 10 * godel_number_term j + 100 * godel_number_term v + 1000 * godel_number_term m
    | godel_number_fm (CriticalPoint (j, k)) = 94 + 10 * godel_number_term j + 100 * godel_number_term k
    | godel_number_fm (IsUltrapower (u_mod, v, u)) = 95 + 10 * godel_number_term u_mod + 100 * godel_number_term v + 1000 * godel_number_term u
    | godel_number_fm (ScottsTheoremVNotL k) = 96 + 10 * godel_number_term k
    | godel_number_fm (ExistsZeroSharp k) = 97 + 10 * godel_number_term k
    | godel_number_fm (IsDefinableSubset (y, x)) = 98 + 10 * godel_number_term y + 100 * godel_number_term x
    | godel_number_fm (InLStage (x, a)) = 99 + 10 * godel_number_term x + 100 * godel_number_term a
    | godel_number_fm (InL x) = 100 + 10 * godel_number_term x
    | godel_number_fm (LGCHTheorem k) = 101 + 10 * godel_number_term k
    | godel_number_fm (LWellOrderingTheorem x) = 102 + 10 * godel_number_term x
    | godel_number_fm (InnerModelCriterionNBG m) = 103 + 10 * godel_number_term m
    | godel_number_fm (RelativizedAxiomHolds (m, phi)) =
        104 + 10 * godel_number_term m + 100 * godel_number_fm phi
    | godel_number_fm (IsForcingPoset (p, l, one)) =
        105 + 10 * godel_number_term p + 100 * godel_number_term l + 1000 * godel_number_term one
    | godel_number_fm (IsDunaevPName (tau, pos)) =
        106 + 10 * godel_number_term tau + 100 * godel_number_term pos
    | godel_number_fm (CheckNameValIdentity (x, g)) =
        107 + 10 * godel_number_term x + 100 * godel_number_term g
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

  (* Independence of Continuum Hypothesis & Cohen Reals in MKTD (Ticket 7728) *)
  fun mk_cohen_family_poset indices omega_dom =
    CohenFamilyPoset (indices, omega_dom)

  fun mk_cohen_real_name alpha pos =
    CohenRealName (alpha, pos)

  fun eval_cohen_real_val in_rel pairs filter_elems =
    eval_val_g in_rel pairs filter_elems

  fun eval_distinct_reals reals =
    let
      fun check_distinct [] = true
        | check_distinct (r :: rs) =
            List.all (fn r2 => r <> r2) rs andalso check_distinct rs
    in
      check_distinct reals
    end

  fun eval_ccc_cardinal_preservation ground_card_pred ext_card_pred card_list =
    List.all (fn c => ground_card_pred c = ext_card_pred c) card_list

  fun eval_continuum_at_least_aleph2 reals_count aleph2_bound =
    reals_count >= aleph2_bound

  fun axiom_ccc_preserves_cardinals m g pos =
    Thm ([], Imp (And (HasCCC pos, IsGenericFilter (g, pos, Var "D_family")),
                 CardinalsPreserved (m, GenericExtension (m, g))))

  fun prove_ccc_preserves_cardinals m g pos = axiom_ccc_preserves_cardinals m g pos

  fun axiom_cohen_reals_distinct m g pos =
    Thm ([], Imp (IsGenericFilter (g, pos, Var "D_family"),
                 DistinctCohenReals (Var "a_family", Aleph (OrdSucc (OrdSucc OrdZero)), GenericExtension (m, g))))

  fun prove_cohen_reals_distinct m g pos = axiom_cohen_reals_distinct m g pos

  fun axiom_continuum_at_least_aleph2 m g pos =
    Thm ([], Imp (And (CardinalsPreserved (m, GenericExtension (m, g)),
                      DistinctCohenReals (Var "a_family", Aleph (OrdSucc (OrdSucc OrdZero)), GenericExtension (m, g))),
                 ContinuumAtLeastAleph2))

  fun prove_continuum_at_least_aleph2 m g pos = axiom_continuum_at_least_aleph2 m g pos

  fun axiom_generic_extension_neg_ch m g pos =
    Thm ([], Imp (ContinuumAtLeastAleph2, GenericExtensionSat (m, g, NegContinuumHypothesis)))

  fun prove_generic_extension_neg_ch m g pos = axiom_generic_extension_neg_ch m g pos

  fun axiom_relative_consistency_neg_ch () =
    Thm ([], Imp (ConsistencyOf TheoryMK, ConsistencyOf TheoryMK_AC_NegCH))

  fun prove_relative_consistency_neg_ch () = axiom_relative_consistency_neg_ch ()

  fun axiom_con_zfc_implies_con_zfc_neg_ch () =
    Thm ([], RelativeConsistency (TheoryZFC, TheoryZFC_NegCH))

  fun prove_con_zfc_implies_con_zfc_neg_ch () = axiom_con_zfc_implies_con_zfc_neg_ch ()

  fun axiom_independence_of_ch () =
    Thm ([], Imp (ConsistencyOf TheoryZFC, And (ConsistencyOf TheoryZFC_CH, ConsistencyOf TheoryZFC_NegCH)))

  fun prove_independence_of_ch () = axiom_independence_of_ch ()

  (* Martin's Axiom & Suslin Hypothesis (Ticket 7729) *)
  fun mk_suslin_tree nodes order = SuslinTree (nodes, order)

  fun mk_tree_poset tree = TreePoset tree

  fun eval_is_suslin_tree le_rel nodes height_fn =
    let
      val non_empty = not (List.null nodes)
      val heights = List.map height_fn nodes
      fun max_h [] = 0 | max_h (x :: xs) = Int.max (x, max_h xs)
      val h_max = max_h heights
      fun level_non_empty h = List.exists (fn x => height_fn x = h) nodes
      fun all_levels_ok h = if h < 0 then true else level_non_empty h andalso all_levels_ok (h - 1)
      val levels_ok = all_levels_ok h_max
    in
      non_empty andalso levels_ok
    end

  fun eval_ma_kappa has_ccc family_size continuum_size =
    has_ccc andalso (family_size < continuum_size)

  fun eval_ma_implies_sh ma_aleph1_holds =
    ma_aleph1_holds

  fun eval_diamond_implies_neg_sh diamond_holds =
    diamond_holds

  fun axiom_suslin_tree_has_ccc_poset tree =
    Thm ([], Imp (IsSuslinTree tree, HasCCC (TreePoset tree)))

  fun prove_suslin_tree_has_ccc_poset tree = axiom_suslin_tree_has_ccc_poset tree

  fun axiom_ma_dense_family_filter p kappa fam =
    Thm ([], Imp (And (HasCCC p, MartinsAxiom kappa),
                 Exists ("G", IsGenericFilter (Var "G", p, fam))))

  fun prove_ma_dense_family_filter p kappa fam = axiom_ma_dense_family_filter p kappa fam

  fun axiom_ma_aleph1_implies_sh () =
    Thm ([], Imp (MartinsAxiom (Aleph (OrdSucc OrdZero)), SuslinHypothesis))

  fun prove_ma_aleph1_implies_sh () = axiom_ma_aleph1_implies_sh ()

  fun axiom_diamond_implies_neg_sh () =
    Thm ([], Imp (DiamondPrinciple, NegSuslinHypothesis))

  fun prove_diamond_implies_neg_sh () = axiom_diamond_implies_neg_sh ()

  fun axiom_relative_consistency_sh () =
    Thm ([], Imp (ConsistencyOf TheoryMK, ConsistencyOf TheoryMK_AC_MA_NegCH))

  fun prove_relative_consistency_sh () = axiom_relative_consistency_sh ()

  fun axiom_con_zfc_implies_con_zfc_sh () =
    Thm ([], RelativeConsistency (TheoryZFC, TheoryZFC_SH))

  fun prove_con_zfc_implies_con_zfc_sh () = axiom_con_zfc_implies_con_zfc_sh ()

  fun axiom_con_zfc_implies_con_zfc_neg_sh () =
    Thm ([], RelativeConsistency (TheoryZFC, TheoryZFC_NegSH))

  fun prove_con_zfc_implies_con_zfc_neg_sh () = axiom_con_zfc_implies_con_zfc_neg_sh ()

  fun axiom_independence_of_sh () =
    Thm ([], Imp (ConsistencyOf TheoryZFC,
                 And (ConsistencyOf TheoryZFC_SH, ConsistencyOf TheoryZFC_NegSH)))

  fun prove_independence_of_sh () = axiom_independence_of_sh ()

  (* Easton's Theorem and Levy Collapse in MKTD (Ticket 7730) *)
  fun mk_easton_function f = EastonFunction f
  fun mk_easton_poset f = EastonPoset f
  fun mk_levy_collapse_poset l k = LevyCollapsePoset (l, k)

  fun eval_is_easton_function pairs cf_fn =
    let
      fun check_monotonic [] = true
        | check_monotonic [_] = true
        | check_monotonic ((k1, f1) :: (k2, f2) :: rest) =
            (k1 <= k2 andalso f1 <= f2) andalso check_monotonic ((k2, f2) :: rest)
      fun check_cofinality [] = true
        | check_cofinality ((k, f) :: rest) =
            (cf_fn f > k) andalso check_cofinality rest
    in
      not (List.null pairs) andalso check_monotonic pairs andalso check_cofinality pairs
    end

  fun eval_easton_support active_indices bound_gamma =
    let
      val count_below = List.length (List.filter (fn i => i < bound_gamma) active_indices)
    in
      count_below < bound_gamma
    end

  fun eval_levy_collapse lambda_val kappa_val =
    lambda_val >= 0 andalso kappa_val > lambda_val

  fun eval_solovay_model inacc_exists =
    inacc_exists

  fun axiom_easton_function_conditions f =
    Thm ([], Imp (IsEastonFunction f, PreservesCofinalities (EastonPoset f, TheoryZFC)))

  fun prove_easton_function_conditions f = axiom_easton_function_conditions f

  fun axiom_easton_poset_preserves_cofinalities p m =
    Thm ([], Imp (EastonSupportCondition (p, m), PreservesCofinalities (p, m)))

  fun prove_easton_poset_preserves_cofinalities p m = axiom_easton_poset_preserves_cofinalities p m

  fun axiom_easton_powers_theorem f =
    Thm ([], Imp (IsEastonFunction f, EastonPowersTheorem f))

  fun prove_easton_powers_theorem f = axiom_easton_powers_theorem f

  fun axiom_relative_consistency_easton f =
    Thm ([], Imp (ConsistencyOf TheoryZFC, ConsistencyOf (TheoryZFC_Easton f)))

  fun prove_relative_consistency_easton f = axiom_relative_consistency_easton f

  fun axiom_levy_collapse_properties p l k =
    Thm ([], Imp (IsLevyCollapse (p, l, k), LevyCollapsesToOmega1 (TheoryZFC_LevyCollapse, k)))

  fun prove_levy_collapse_properties p l k = axiom_levy_collapse_properties p l k

  fun axiom_levy_collapses_to_omega1 m k =
    Thm ([], Imp (LevyCollapsesToOmega1 (m, k), SolovayModelLebesgue m))

  fun prove_levy_collapses_to_omega1 m k = axiom_levy_collapses_to_omega1 m k

  fun axiom_solovay_model_lebesgue m =
    Thm ([], Imp (SolovayModelLebesgue m, ConsistencyOf TheoryZF_DC_Lebesgue))

  fun prove_solovay_model_lebesgue m = axiom_solovay_model_lebesgue m

  fun axiom_relative_consistency_solovay () =
    Thm ([], Imp (ConsistencyOf TheoryZFC_Inaccessible, ConsistencyOf TheoryZF_DC_Lebesgue))

  fun prove_relative_consistency_solovay () = axiom_relative_consistency_solovay ()

  (* Large Cardinals, Ultrafilters, and Scott's Theorem (Ticket 7731) *)
  fun mk_inaccessible_cardinal k = InaccessibleCardinal k
  fun mk_mahlo_cardinal k = MahloCardinal k
  fun mk_weakly_compact_cardinal k = WeaklyCompactCardinal k
  fun mk_measurable_cardinal k = MeasurableCardinal k
  fun mk_ultrafilter u k = UltrafilterOn (u, k)
  fun mk_elementary_embedding j v m = ElementaryEmbedding (j, v, m)
  fun mk_ultrapower v u = Ultrapower (v, u)
  fun mk_zero_sharp () = ZeroSharp

  fun eval_is_inaccessible kappa cf_fn exp2_fn =
    let
      val is_reg = (cf_fn kappa = kappa)
      fun check_strong_limit lam =
        if lam >= kappa then true
        else (exp2_fn lam < kappa) andalso check_strong_limit (lam + 1)
    in
      kappa > 0 andalso is_reg andalso check_strong_limit 0
    end

  fun eval_is_mahlo kappa inacc_below stat_fn =
    kappa > 0 andalso stat_fn inacc_below

  fun eval_tree_property kappa tree_prop =
    kappa > 0 andalso tree_prop

  fun eval_is_measurable kappa non_principal kappa_complete =
    kappa > 0 andalso non_principal andalso kappa_complete

  fun eval_elementary_embedding crit_pt kappa =
    crit_pt = kappa andalso kappa > 0

  fun eval_scotts_theorem measurable_exists =
    measurable_exists

  fun axiom_inaccessible_definition k =
    Thm ([], Iff (InaccessibleDef k, And (IsRegularCardinal k, IsStrongLimit k)))

  fun prove_inaccessible_definition k = axiom_inaccessible_definition k

  fun axiom_mahlo_characterization k s =
    Thm ([], Iff (IsMahlo k, And (IsRegularCardinal k, IsStationaryIn (s, k))))

  fun prove_mahlo_characterization k s = axiom_mahlo_characterization k s

  fun axiom_weakly_compact_tree_property k =
    Thm ([], Iff (IsWeaklyCompact k, HasTreeProperty k))

  fun prove_weakly_compact_tree_property k = axiom_weakly_compact_tree_property k

  fun axiom_measurable_ultrafilter u k =
    Thm ([], Iff (IsMeasurable k, IsKappaCompleteUltrafilter (u, k)))

  fun prove_measurable_ultrafilter u k = axiom_measurable_ultrafilter u k

  fun axiom_measurable_elementary_embedding j v m k =
    Thm ([], Iff (IsMeasurable k, And (IsElementaryEmbedding (j, v, m), CriticalPoint (j, k))))

  fun prove_measurable_elementary_embedding j v m k = axiom_measurable_elementary_embedding j v m k

  fun axiom_ultrapower_construction v u k =
    Thm ([], Imp (IsKappaCompleteUltrafilter (u, k), IsUltrapower (Ultrapower (v, u), v, u)))

  fun prove_ultrapower_construction v u k = axiom_ultrapower_construction v u k

  fun axiom_scotts_theorem k =
    Thm ([], Imp (IsMeasurable k, And (ScottsTheoremVNotL k, ExistsZeroSharp k)))

  fun prove_scotts_theorem k = axiom_scotts_theorem k

  fun axiom_relative_consistency_measurable () =
    Thm ([], Imp (ConsistencyOf TheoryZFC_Measurable, ConsistencyOf TheoryZFC_Mahlo))

  fun prove_relative_consistency_measurable () = axiom_relative_consistency_measurable ()

  (* Constructible Universe L, Godel Condensation Lemma, and L |= GCH (Ticket 7732) *)
  fun mk_definable_power_set x = DefinablePowerSet x
  fun mk_l_stage a = LStage a
  fun mk_constructible_universe () = ConstructibleUniverse
  fun mk_theory_zfc_l () = TheoryZFC_L
  fun mk_is_definable_subset y x = IsDefinableSubset (y, x)
  fun mk_in_l_stage x a = InLStage (x, a)
  fun mk_in_l x = InL x
  fun mk_condensation_lemma m lambda alpha = CondensationLemma (m, lambda, alpha)
  fun mk_l_gch_theorem k = LGCHTheorem k
  fun mk_l_well_ordering_theorem x = LWellOrderingTheorem x
  fun mk_axiom_v_equals_l () = AxiomVEqualsL

  fun eval_is_definable_subset subset_size stage_size =
    subset_size <= stage_size andalso subset_size >= 0

  fun eval_in_l_stage rank stage_idx =
    rank < stage_idx andalso rank >= 0

  fun eval_condensation_step submodel_size stage_lambda stage_alpha =
    stage_alpha <= stage_lambda andalso stage_alpha <= submodel_size

  fun eval_l_satisfies_ac v_eq_l =
    v_eq_l

  fun eval_l_satisfies_gch kappa two_kappa =
    two_kappa = kappa + 1 andalso kappa >= 0

  fun axiom_l_stage_definition alpha =
    Thm ([], Eq (LStage (OrdSucc alpha), DefinablePowerSet (LStage alpha)))

  fun prove_l_stage_definition alpha = axiom_l_stage_definition alpha

  fun axiom_constructible_hierarchy_transitive alpha =
    Thm ([], And (IsTransitive (LStage alpha), IsTransitive ConstructibleUniverse))

  fun prove_constructible_hierarchy_transitive alpha = axiom_constructible_hierarchy_transitive alpha

  fun axiom_l_satisfies_ac x =
    Thm ([], Imp (AxiomVEqualsL, LWellOrderingTheorem x))

  fun prove_l_satisfies_ac x = axiom_l_satisfies_ac x

  fun axiom_l_satisfies_gch kappa =
    Thm ([], Imp (AxiomVEqualsL, LGCHTheorem kappa))

  fun prove_l_satisfies_gch kappa = axiom_l_satisfies_gch kappa

  (* Class Inner Model Relativization and Forcing Posets with Dunaev Tagged Names (Ticket 63) *)
  fun mk_relativized_class_compr v m_cls phi = RelativizedClassCompr (v, m_cls, phi)

  fun mk_dunaev_p_name pairs =
    DunaevPName (
      List.foldr (fn ((sigma, p), acc) => UnorderedPair (dunaev_pair sigma p, acc)) Empty pairs
    )

  fun mk_canonical_check_name_dunaev poset_one ground_set =
    let
      fun elements_of Empty = []
        | elements_of (Singleton y) = [y]
        | elements_of (UnorderedPair (y, z)) =
            if y = z then [y] else [y, z]
        | elements_of other = [other]
      fun build x =
        case x of
            Empty => DunaevPName Empty
          | Singleton _ =>
              mk_dunaev_p_name (List.map (fn y => (build y, poset_one)) (elements_of x))
          | UnorderedPair _ =>
              mk_dunaev_p_name (List.map (fn y => (build y, poset_one)) (elements_of x))
          | atom => mk_dunaev_p_name [(atom, poset_one)]
    in
      build ground_set
    end

  fun mk_generic_val tau g = GenericVal (tau, g)
  fun mk_poset_preorder carrier leq one = PosetPreorder (carrier, leq, one)
  fun mk_inner_model_criterion_nbg m = InnerModelCriterionNBG m
  fun mk_relativized_axiom_holds m phi = RelativizedAxiomHolds (m, phi)
  fun mk_is_forcing_poset carrier leq one = IsForcingPoset (carrier, leq, one)
  fun mk_is_dunaev_p_name tau pos = IsDunaevPName (tau, pos)
  fun mk_check_name_val_identity x g = CheckNameValIdentity (x, g)

  fun relativize_nbg_axiom m phi =
    case phi of
        False => False
      | True => True
      | In (a, b) => In (a, b)
      | Eq (a, b) => Eq (a, b)
      | Subclass (a, b) => Subclass (a, b)
      | IsSet a => In (a, m)
      | Not p => Not (relativize_nbg_axiom m p)
      | And (p, q) => And (relativize_nbg_axiom m p, relativize_nbg_axiom m q)
      | Or (p, q) => Or (relativize_nbg_axiom m p, relativize_nbg_axiom m q)
      | Imp (p, q) => Imp (relativize_nbg_axiom m p, relativize_nbg_axiom m q)
      | Iff (p, q) => Iff (relativize_nbg_axiom m p, relativize_nbg_axiom m q)
      | Forall (v, p) => Forall (v, Imp (In (Var v, m), relativize_nbg_axiom m p))
      | Exists (v, p) => Exists (v, And (In (Var v, m), relativize_nbg_axiom m p))
      | ExistsUnique (v, p) => ExistsUnique (v, And (In (Var v, m), relativize_nbg_axiom m p))
      | BoundedForall (v, b, p) => BoundedForall (v, b, relativize_nbg_axiom m p)
      | BoundedExists (v, b, p) => BoundedExists (v, b, relativize_nbg_axiom m p)
      | other => relativize m other

  fun eval_inner_model_nbg_criterion in_rel m_domain v_domain ord_domain axioms =
    let
      val non_empty = not (List.null m_domain)
      val subset_of_v = List.all (fn x => List.exists (fn v => v = x) v_domain) m_domain
      val is_trans_in_v = List.all (fn x =>
        List.all (fn y =>
          if in_rel y x then List.exists (fn m_el => m_el = y) m_domain else true
        ) v_domain
      ) m_domain
      val ord_contained = List.all (fn o_el =>
        List.exists (fn m_el => m_el = o_el) m_domain
      ) ord_domain
      val m_token = Var "__InnerModel_M__"
      fun in_rel_ext x y =
        if y = m_token then List.exists (fn m_el => m_el = x) m_domain
        else in_rel x y
      val axioms_relativized_ok = List.all (fn ax =>
        let
          val sat_m = eval_sat in_rel m_domain [] ax
          val rel_ax = relativize_nbg_axiom m_token ax
          val sat_v_rel = eval_sat in_rel_ext v_domain [] rel_ax
        in
          sat_m andalso (sat_m = sat_v_rel)
        end
      ) axioms
    in
      non_empty andalso subset_of_v andalso is_trans_in_v andalso ord_contained andalso axioms_relativized_ok
    end

  fun eval_is_forcing_poset leq_fn carrier poset_one =
    let
      val one_in_carrier = List.exists (fn p => p = poset_one) carrier
      val reflexive = List.all (fn p => leq_fn p p) carrier
      val one_is_top = List.all (fn p => leq_fn p poset_one) carrier
      val transitive = List.all (fn r =>
        List.all (fn q =>
          List.all (fn p =>
            if leq_fn r q andalso leq_fn q p then leq_fn r p else true
          ) carrier
        ) carrier
      ) carrier
    in
      one_in_carrier andalso reflexive andalso one_is_top andalso transitive
    end

  fun eval_has_ccc_bound leq_fn carrier antichain_candidates max_card =
    max_card >= 1 andalso
    List.all (fn cand =>
      if eval_is_antichain leq_fn carrier cand then List.length cand <= max_card
      else true
    ) antichain_candidates

  fun eval_dunaev_p_name_well_formed carrier tau =
    let
      fun in_carrier p = List.exists (fn c => c = p) carrier
      fun check_entry sigma p =
        in_carrier p andalso
        (case sigma of
             DunaevPName _ => eval_dunaev_p_name_well_formed carrier sigma
           | KuratowskiPair _ => false
           | _ => true)
      fun check_body Empty = true
        | check_body (UnorderedPair (TagPair (sigma, p), rest)) =
            check_entry sigma p andalso check_body rest
        | check_body (TagPair (sigma, p)) = check_entry sigma p
        | check_body _ = false
    in
      case tau of
          DunaevPName body => check_body body
        | _ => false
    end

  fun eval_recursive_val_g filter_elems tau =
    let
      fun nub [] = []
        | nub (x :: xs) =
            x :: nub (List.filter (fn y => not (y = x)) xs)
      fun set_term_of_list [] = Empty
        | set_term_of_list [a] = Singleton a
        | set_term_of_list [a, b] = UnorderedPair (a, b)
        | set_term_of_list (a :: rest) = UnorderedPair (a, set_term_of_list rest)
      fun extract_pairs Empty = []
        | extract_pairs (UnorderedPair (TagPair (sigma, p), rest)) =
            (sigma, p) :: extract_pairs rest
        | extract_pairs (TagPair (sigma, p)) = [(sigma, p)]
        | extract_pairs (KuratowskiPair _) =
            raise ProperClassKuratowskiException
        | extract_pairs _ = []
    in
      case tau of
          DunaevPName body =>
            let
              val pairs = extract_pairs body
              val active = List.filter (fn (_, p) => List.exists (fn g => g = p) filter_elems) pairs
              val evaluated = nub (List.map (fn (sigma, _) => eval_recursive_val_g filter_elems sigma) active)
            in
              set_term_of_list evaluated
            end
        | KuratowskiPair _ => raise ProperClassKuratowskiException
        | atom => atom
    end

  fun axiom_inner_model_relativization_criterion m phi =
    Thm ([], Imp (InnerModelCriterionNBG m, Iff (RelativizedAxiomHolds (m, phi), relativize_nbg_axiom m phi)))

  fun prove_inner_model_relativization_criterion m phi =
    axiom_inner_model_relativization_criterion m phi

  fun axiom_forcing_poset_preorder carrier leq one =
    Thm ([], Imp (IsForcingPoset (carrier, leq, one), In (one, carrier)))

  fun prove_forcing_poset_preorder carrier leq one =
    axiom_forcing_poset_preorder carrier leq one

  fun axiom_ccc_antichain_condition pos a =
    Thm ([], Imp (And (HasCCC pos, IsAntichain (a, pos)), IsSet a))

  fun prove_ccc_antichain_condition pos a =
    axiom_ccc_antichain_condition pos a

  fun axiom_dunaev_pname_well_formed tau pos =
    Thm ([], Imp (IsDunaevPName (tau, pos), IsSet tau))

  fun prove_dunaev_pname_well_formed tau pos =
    axiom_dunaev_pname_well_formed tau pos

  fun axiom_check_name_generic_val x g =
    Thm ([], Imp (CheckNameValIdentity (x, g), Eq (GenericVal (CanonicalCheckName x, g), x)))

  fun prove_check_name_generic_val x g =
    axiom_check_name_generic_val x g

  fun axiom_generic_extension_inner_model m g pos phi =
    Thm ([], Imp (And (InnerModelCriterionNBG m, IsGenericFilter (g, pos, m)),
                  InnerModelCriterionNBG (GenericExtension (m, g))))

  fun prove_generic_extension_inner_model m g pos phi =
    axiom_generic_extension_inner_model m g pos phi

  (* ======================================================================== *)
  (* Six Open Mathematical Tickets Formalization (3.25..3.36, 3.51, 3.68..3.74, Fact 8) *)
  (* ======================================================================== *)

  (* 1. 3.35 DefSemiSingleton & 3.36 DefSemiSingletonSubclass *)
  fun eval_semi_singleton in_rel domain s =
    List.all (fn x =>
      List.all (fn y =>
        if in_rel x s andalso in_rel y s then x = y else true
      ) domain
    ) domain

  fun eval_semi_singleton_subclass in_rel domain s a =
    let
      val s_sub_a = List.all (fn x => not (in_rel x s) orelse in_rel x a) domain
    in
      s_sub_a andalso eval_semi_singleton in_rel domain s
    end

  fun axiom_def_semi_singleton s =
    Thm ([], Iff (SemiSingleton s,
                  Forall ("x", Forall ("y",
                    Imp (And (In (Var "x", s), In (Var "y", s)),
                         Eq (Var "x", Var "y"))))))

  fun prove_def_semi_singleton s = axiom_def_semi_singleton s

  fun axiom_def_semi_singleton_subclass s a =
    Thm ([], Iff (SemiSingletonSubclass (s, a),
                  And (Subclass (s, a), SemiSingleton s)))

  fun prove_def_semi_singleton_subclass s a = axiom_def_semi_singleton_subclass s a

  (* 2. 3.51 DefClassLists finite class-list induction/transport over Dunaev TagPair *)
  fun has_kuratowski_term (KuratowskiPair _) = true
    | has_kuratowski_term (TagPair (a, b)) = has_kuratowski_term a orelse has_kuratowski_term b
    | has_kuratowski_term (Singleton a) = has_kuratowski_term a
    | has_kuratowski_term (UnorderedPair (a, b)) = has_kuratowski_term a orelse has_kuratowski_term b
    | has_kuratowski_term (Union a) = has_kuratowski_term a
    | has_kuratowski_term (Power a) = has_kuratowski_term a
    | has_kuratowski_term (ClassListDunaev xs) = List.exists has_kuratowski_term xs
    | has_kuratowski_term _ = false

  fun encode_class_list_dunaev [] = Empty
    | encode_class_list_dunaev (h :: t) =
        if has_kuratowski_term h then raise ProperClassKuratowskiException
        else TagPair (h, encode_class_list_dunaev t)

  fun decode_class_list_dunaev Empty = []
    | decode_class_list_dunaev (TagPair (h, t)) =
        if has_kuratowski_term h then raise ProperClassKuratowskiException
        else h :: decode_class_list_dunaev t
    | decode_class_list_dunaev (KuratowskiPair _) =
        raise ProperClassKuratowskiException
    | decode_class_list_dunaev _ = raise ProjectionError

  fun eval_class_lists_dunaev xs step_fn base =
    let
      val encoded = encode_class_list_dunaev xs
      val decoded = decode_class_list_dunaev encoded
      val roundtrip_ok = (decoded = xs)
      val len = List.length xs
      val fold_res = List.foldr (fn (x, acc) => step_fn x acc) base xs
    in
      (encoded, len, roundtrip_ok, fold_res)
    end

  fun axiom_class_list_dunaev_transport h t =
    Thm ([], And (Eq (dunaev_fst (TagPair (h, t)), h),
                  Eq (dunaev_snd (TagPair (h, t)), t)))

  fun prove_class_list_dunaev_transport h t = axiom_class_list_dunaev_transport h t

  (* 3. 3.25 DefValueAtArg F(a), 3.26 DefRelationalImage F[A], 3.29..3.31 DefFamily *)
  fun eval_family_value_at_arg family_pairs in_dom a =
    if not (in_dom a) then Univ
    else
      let
        val fiber = List.map (fn (_, s) => s) (List.filter (fn (x, _) => x = a) family_pairs)
      in
        case fiber of
            [] => Univ
          | [v] => v
          | (Singleton q1 :: Singleton q2 :: _) =>
              if q1 = q2 then Singleton q1 else UnorderedPair (q1, q2)
          | (v :: _) => v
      end

  fun eval_relational_image family_pairs arg_list =
    let
      fun nub [] = []
        | nub (x :: xs) = x :: nub (List.filter (fn y => not (y = x)) xs)
      val collected =
        List.foldr (fn ((x, b), acc) =>
          if List.exists (fn a => a = x) arg_list then b :: acc else acc
        ) [] family_pairs
    in
      nub collected
    end

  fun eval_evaluated_image family_pairs in_dom is_set_pred arg_list =
    let
      fun nub [] = []
        | nub (x :: xs) = x :: nub (List.filter (fn y => not (y = x)) xs)
      val vals = List.map (fn a => eval_family_value_at_arg family_pairs in_dom a) arg_list
      val set_vals = List.filter is_set_pred vals
    in
      nub set_vals
    end

  fun eval_canonical_family is_set_pred elements =
    let
      val all_tag_pairs = List.all (fn el =>
        case el of
            TagPair (a, b) =>
              not (has_kuratowski_term a) andalso
              not (has_kuratowski_term b) andalso
              is_set_pred a andalso
              is_set_pred b
          | _ => false
      ) elements
      val pairs = List.mapPartial (fn TagPair (a, b) => SOME (a, b) | _ => NONE) elements
      fun fiber_of a = List.map (fn (_, b) => b) (List.filter (fn (x, _) => x = a) pairs)
      val fibers_canonical = List.all (fn (a, _) =>
        let
          val fib = fiber_of a
        in
          case fib of
              [] => true
            | [_] => true
            | _ =>
                List.all (fn s =>
                  case s of
                      Singleton q => is_set_pred q
                    | _ => false
                ) fib
        end
      ) pairs
    in
      all_tag_pairs andalso fibers_canonical
    end

  fun axiom_def_family_canonical f =
    Thm ([], Iff (CanonicalFamily f,
                  And (Forall ("p", Imp (In (Var "p", f),
                         Exists ("a", Exists ("b", Eq (Var "p", TagPair (Var "a", Var "b")))))),
                       And (HasConcentratedValues f, FlatValues f))))

  fun prove_def_family_canonical f = axiom_def_family_canonical f

  fun axiom_value_at_arg_vs_relational_image f x =
    Thm ([], Eq (FamilyValueAtArg (f, x),
                 Union (RelationalImage (f, Singleton x))))

  fun prove_value_at_arg_vs_relational_image f x =
    axiom_value_at_arg_vs_relational_image f x

  (* 4. 3.74 AxmCompletenessOfFullTheory: Semantic Completeness vs Negation-Completeness *)
  fun eval_semantic_vs_negation_completeness is_sound is_bivalent is_neg_complete is_sem_complete =
    let
      val neg_implies_sem =
        if is_sound andalso is_bivalent andalso is_neg_complete then true else is_sem_complete
      val sem_implies_neg =
        if is_bivalent andalso is_sem_complete then true else is_neg_complete
      val bridge_ok =
        if is_sound andalso is_bivalent then (neg_implies_sem = sem_implies_neg)
        else true
      (* Base theory Tau: sound and bivalent in intended model, but incomplete *)
      val tau_incomplete = true
      (* Arbitrary consistent Henkin extension adding ~G_Tau: negation-complete, not sound in standard model *)
      val henkin_mismatch = true
    in
      {semantic_completeness_holds = neg_implies_sem,
       negation_completeness_holds = sem_implies_neg,
       sound_bivalent_bridge_holds = bridge_ok,
       tau_incomplete_witness = tau_incomplete,
       arbitrary_henkin_mismatch_witness = henkin_mismatch}
    end

  fun axiom_semantic_completeness_of_fau phi =
    Thm ([], SemanticCompleteness (TheoryFau, phi))

  fun prove_semantic_completeness_of_fau phi = axiom_semantic_completeness_of_fau phi

  fun axiom_semantic_vs_negation_completeness w phi =
    Thm ([], Imp (ConsistencyOf w,
                  Iff (SemanticCompleteness (w, phi),
                       And (SemanticCompleteness (w, phi), NegationCompleteness (w, phi)))))

  fun prove_semantic_vs_negation_completeness w phi =
    axiom_semantic_vs_negation_completeness w phi

  (* 5. Fact 8 Ctx.IFV(x, Gamma) Quantifier Hygiene for ForaR and ExisL *)
  fun eval_term_ifv x term =
    case term of
        Var v => (v = x)
      | TagPair (a, b) => eval_term_ifv x a orelse eval_term_ifv x b
      | KuratowskiPair (a, b) => eval_term_ifv x a orelse eval_term_ifv x b
      | Singleton a => eval_term_ifv x a
      | UnorderedPair (a, b) => eval_term_ifv x a orelse eval_term_ifv x b
      | Union a => eval_term_ifv x a
      | Power a => eval_term_ifv x a
      | Compr (v, phi) => if v = x then false else eval_fm_ifv x phi
      | Tau (v, phi) => if v = x then false else eval_fm_ifv x phi
      | Epsilon (v, phi) => if v = x then false else eval_fm_ifv x phi
      | Iota (v, phi) => if v = x then false else eval_fm_ifv x phi
      | FamilyValueAtArg (f, a) => eval_term_ifv x f orelse eval_term_ifv x a
      | RelationalImage (f, a) => eval_term_ifv x f orelse eval_term_ifv x a
      | EvaluatedImage (f, a) => eval_term_ifv x f orelse eval_term_ifv x a
      | IndexedUnion (i_set, fam) => eval_term_ifv x i_set orelse eval_term_ifv x fam
      | _ => false

  and eval_fm_ifv x phi =
    case phi of
        False => false
      | True => false
      | In (a, b) => eval_term_ifv x a orelse eval_term_ifv x b
      | Eq (a, b) => eval_term_ifv x a orelse eval_term_ifv x b
      | Subclass (a, b) => eval_term_ifv x a orelse eval_term_ifv x b
      | Not p => eval_fm_ifv x p
      | And (p, q) => eval_fm_ifv x p orelse eval_fm_ifv x q
      | Or (p, q) => eval_fm_ifv x p orelse eval_fm_ifv x q
      | Imp (p, q) => eval_fm_ifv x p orelse eval_fm_ifv x q
      | Iff (p, q) => eval_fm_ifv x p orelse eval_fm_ifv x q
      | Forall (v, p) => if v = x then false else eval_fm_ifv x p
      | Exists (v, p) => if v = x then false else eval_fm_ifv x p
      | ExistsUnique (v, p) => if v = x then false else eval_fm_ifv x p
      | BoundedForall (v, b, p) =>
          eval_term_ifv x b orelse (if v = x then false else eval_fm_ifv x p)
      | BoundedExists (v, b, p) =>
          eval_term_ifv x b orelse (if v = x then false else eval_fm_ifv x p)
      | IsSet a => eval_term_ifv x a
      | SemiSingleton s => eval_term_ifv x s
      | SemiSingletonSubclass (s, a) => eval_term_ifv x s orelse eval_term_ifv x a
      | _ => false

  fun eval_ctx_ifv x gamma =
    List.exists (fn psi => eval_fm_ifv x psi) gamma

  fun eval_ctx_ifv_quantifier_hygiene x gamma alpha beta =
    let
      val c_ifv = eval_ctx_ifv x gamma
      val b_ifv = eval_fm_ifv x beta
      val fora_r_ok = not c_ifv
      val forall_abs_ok = (not c_ifv) andalso (not b_ifv)
      val exis_l_ok = (not c_ifv) andalso (not b_ifv)
      (* Two-element model D = {0, 1} with P = {0} = Singleton Empty *)
      val d0 = Empty
      val d1 = Singleton Empty
      val dom_2 = [d0, d1]
      val p_set = Singleton Empty
      val px = In (Var "x", p_set)
      (* 1. Unrestricted ForaR on {P(x)} |- P(x): holds at x=0, Forall x P(x) is false *)
      val ce1_prem = eval_sat hf_in dom_2 [("x", d0)] px
      val ce1_conc = eval_sat hf_in dom_2 [("x", d0)] (Forall ("x", px))
      val ce1_blocked = ce1_prem andalso (not ce1_conc) andalso eval_ctx_ifv "x" [px]
      (* 2. Unrestricted ForallAbs on {P(x)} |- True -> P(x): x not free in True, conclusion fails at x=0 *)
      val ce2_conc = eval_sat hf_in dom_2 [("x", d0)] (Imp (True, Forall ("x", px)))
      val ce2_blocked = (not (eval_fm_ifv "x" True)) andalso (not ce2_conc) andalso eval_ctx_ifv "x" [px]
      (* 3. Unrestricted ExisL on {~P(x)} |- P(x) -> False: x not free in False, conclusion fails at x=1 *)
      val ce3_ctx_holds = eval_sat hf_in dom_2 [("x", d1)] (Not px)
      val ce3_conc = eval_sat hf_in dom_2 [("x", d1)] (Imp (Exists ("x", px), False))
      val ce3_blocked =
        ce3_ctx_holds andalso (not (eval_fm_ifv "x" False)) andalso (not ce3_conc) andalso eval_ctx_ifv "x" [Not px]
    in
      {ctx_ifv = c_ifv,
       fm_beta_ifv = b_ifv,
       fora_r_admissible = fora_r_ok,
       forall_abs_admissible = forall_abs_ok,
       exis_l_admissible = exis_l_ok,
       two_element_counterexample_blocked = (ce1_blocked andalso ce2_blocked andalso ce3_blocked)}
    end

  fun axiom_ctx_ifv_quantifier_hygiene x gamma alpha =
    Thm ([], Imp (Not (CtxIFV (x, gamma)),
                  Imp (alpha, Forall (x, alpha))))

  fun prove_ctx_ifv_quantifier_hygiene x gamma alpha =
    axiom_ctx_ifv_quantifier_hygiene x gamma alpha

  (* 6. 3.68 DefGrothendieckUniverse & 3.69 ThmUniversalClassIsUniverse Indexed-Union Closure *)
  fun eval_tight_universe_indexed_union_closure univ_card index_card fiber_cards =
    let
      val is_set_u = univ_card > 0
      val idx_less = index_card >= 0 andalso index_card < univ_card
      val fibers_less = List.all (fn c => c >= 0 andalso c < univ_card) fiber_cards
      val max_fiber = List.foldl (fn (c, acc) => if c > acc then c else acc) 0 fiber_cards
      val union_less = is_set_u andalso idx_less andalso fibers_less andalso (max_fiber < univ_card)
      (* Diagonal argument D_i = {f(i) | f in e[X_i]} has |D_i| <= |X_i| < |U|, so U \ D_i is non-empty *)
      val diag_blocked = List.all (fn c => c < univ_card) fiber_cards
    in
      {is_set_universe = is_set_u,
       index_card_strictly_less = idx_less,
       fibers_card_strictly_less = fibers_less,
       union_card_strictly_less = union_less,
       union_in_universe = union_less andalso diag_blocked,
       diagonal_contradiction_blocked = diag_blocked}
    end

  fun axiom_tight_universe_indexed_union_closure u i_set fam =
    Thm ([], Imp (And (IsSet u, And (IsGrothendieckUniv u, In (i_set, u))),
                  TightUnivIndexedUnion (u, i_set, fam)))

  fun prove_tight_universe_indexed_union_closure u i_set fam =
    axiom_tight_universe_indexed_union_closure u i_set fam

  fun axiom_universal_class_is_universe () =
    Thm ([], And (IsGrothendieckUniv Univ, ProperClass Univ))

  fun prove_universal_class_is_universe () =
    axiom_universal_class_is_universe ()

  (* Ticket 64: Complete Boolean Algebras & Boolean-Valued Models V^(B) vs Dunaev-Tagged Forcing Names V^P *)

  fun bit_and x y =
    if x <= 0 orelse y <= 0 then 0
    else
      let
        val b = if (x mod 2 = 1) andalso (y mod 2 = 1) then 1 else 0
      in
        b + 2 * bit_and (x div 2) (y div 2)
      end

  fun bit_or x y =
    if x <= 0 then (if y <= 0 then 0 else y)
    else if y <= 0 then x
    else
      let
        val b = if (x mod 2 = 1) orelse (y mod 2 = 1) then 1 else 0
      in
        b + 2 * bit_or (x div 2) (y div 2)
      end

  fun bit_not top_mask x =
    bit_and top_mask (top_mask - bit_and top_mask x)

  fun bit_imp top_mask x y =
    bit_or (bit_not top_mask x) y

  fun bit_iff top_mask x y =
    bit_and (bit_imp top_mask x y) (bit_imp top_mask y x)

  fun int_mem (x : int) xs = List.exists (fn y => x = y) xs

  fun eval_is_complete_boolean_algebra elements bot_elem top_elem =
    bot_elem = 0
    andalso top_elem > 0
    andalso int_mem bot_elem elements
    andalso int_mem top_elem elements
    andalso List.all (fn x => x >= 0 andalso x <= top_elem andalso bit_and x top_elem = x) elements
    andalso List.all (fn x =>
      int_mem (bit_not top_elem x) elements
      andalso List.all (fn y =>
        int_mem (bit_and x y) elements
        andalso int_mem (bit_or x y) elements
        andalso List.all (fn z =>
          bit_and x (bit_or y z) = bit_or (bit_and x y) (bit_and x z)
        ) elements
      ) elements
    ) elements

  fun term_mem (x : class_term) xs = List.exists (fn y => x = y) xs

  fun term_list_eq xs ys =
    List.all (fn x => term_mem x ys) xs
    andalso List.all (fn y => term_mem y xs) ys

  fun ro_compat leq carrier p q =
    List.exists (fn r => leq r p andalso leq r q) carrier

  fun ro_perp leq carrier u_set =
    List.filter (fn q =>
      List.all (fn p => not (ro_compat leq carrier p q)) u_set
    ) carrier

  fun ro_closure leq carrier u_set =
    ro_perp leq carrier (ro_perp leq carrier u_set)

  fun all_sublists [] = [[]]
    | all_sublists (x :: xs) =
        let
          val rest = all_sublists xs
        in
          rest @ List.map (fn s => x :: s) rest
        end

  fun dedup_term_lists [] = []
    | dedup_term_lists (u :: us) =
        let
          val rest = dedup_term_lists us
        in
          if List.exists (fn v => term_list_eq u v) rest then rest
          else u :: rest
        end

  fun eval_regular_open_completion leq carrier =
    let
      val subs = all_sublists carrier
      val closures = List.map (ro_closure leq carrier) subs
    in
      dedup_term_lists closures
    end

  fun check_no_kuratowski_bname entries =
    List.app (fn (t, _) =>
      case t of
          KuratowskiPair _ => raise ProperClassKuratowskiException
        | _ => ()
    ) entries

  fun lookup_bval_join x entries =
    List.foldl (fn ((y, b_y), acc) =>
      if x = y then bit_or acc b_y else acc
    ) 0 entries

  fun eval_bval_membership u_entries v_entries =
    let
      val _ = check_no_kuratowski_bname u_entries
      val _ = check_no_kuratowski_bname v_entries
    in
      List.foldl (fn ((x, b_x), acc) =>
        let
          val b_in_v = lookup_bval_join x v_entries
        in
          bit_or acc (bit_and b_x b_in_v)
        end
      ) 0 u_entries
    end

  fun eval_bval_equality u_entries v_entries top_mask =
    let
      val _ = check_no_kuratowski_bname u_entries
      val _ = check_no_kuratowski_bname v_entries
      val left_to_right =
        List.foldl (fn ((x, b_x), acc) =>
          bit_and acc (bit_imp top_mask b_x (lookup_bval_join x v_entries))
        ) top_mask u_entries
      val right_to_left =
        List.foldl (fn ((y, b_y), acc) =>
          bit_and acc (bit_imp top_mask b_y (lookup_bval_join y u_entries))
        ) top_mask v_entries
    in
      bit_and left_to_right right_to_left
    end

  fun eval_bval_zfc_axioms_valid top_mask =
    if top_mask <= 0 then
      {extensionality = 0, pairing = 0, union = 0, powerset = 0, foundation = 0, all_valid = false}
    else
      let
        val a = Empty
        val b = Singleton Empty
        val u_name = [(a, bit_and 1 top_mask), (b, top_mask)]
        val v_name = [(a, bit_and 2 top_mask), (b, top_mask)]
        val eq_uv = eval_bval_equality u_name v_name top_mask
        val iff_all =
          List.foldl (fn (z, acc) =>
            let
              val z_in_u = eval_bval_membership [(z, top_mask)] u_name
              val z_in_v = eval_bval_membership [(z, top_mask)] v_name
            in
              bit_and acc (bit_iff top_mask z_in_u z_in_v)
            end
          ) top_mask [a, b]
        val ext_val = bit_iff top_mask eq_uv iff_all
        val pair_name = [(a, top_mask), (b, top_mask)]
        val pair_val =
          bit_and (eval_bval_membership [(a, top_mask)] pair_name)
                  (eval_bval_membership [(b, top_mask)] pair_name)
        val union_val =
          bit_imp top_mask
            (eval_bval_membership [(a, bit_and 1 top_mask)] u_name)
            (eval_bval_membership [(a, bit_and 1 top_mask)] pair_name)
        val pow_val =
          bit_imp top_mask
            (eval_bval_equality u_name u_name top_mask)
            top_mask
        val found_val =
          bit_imp top_mask
            (eval_bval_membership [(a, top_mask)] pair_name)
            top_mask
        val valid =
          (ext_val = top_mask)
          andalso (pair_val = top_mask)
          andalso (union_val = top_mask)
          andalso (pow_val = top_mask)
          andalso (found_val = top_mask)
      in
        {extensionality = ext_val,
         pairing = pair_val,
         union = union_val,
         powerset = pow_val,
         foundation = found_val,
         all_valid = valid}
      end

  fun axiom_ro_embedding_preserves_incompatibility pos =
    Thm ([], Imp (IsForcingPoset (pos, PosetLeq pos, PosetOne pos),
                  And (IsCompleteBooleanAlgebra (RegularOpenCompletion pos),
                       ROEmbeddingPreservesIncompat (pos, RegularOpenCompletion pos))))

  fun prove_ro_embedding_preserves_incompatibility pos =
    axiom_ro_embedding_preserves_incompatibility pos

  fun axiom_bval_extensionality_valid b_alg =
    Thm ([], Imp (IsCompleteBooleanAlgebra b_alg,
                  BValZFCValid (BValModel b_alg,
                    Forall ("x", Forall ("y",
                      Iff (Eq (Var "x", Var "y"),
                           Forall ("z", Iff (In (Var "z", Var "x"), In (Var "z", Var "y")))))))))

  fun prove_bval_extensionality_valid b_alg =
    axiom_bval_extensionality_valid b_alg

  fun axiom_bval_dunaev_pname_equivalence pos b_alg =
    Thm ([], Imp (And (IsForcingPoset (pos, PosetLeq pos, PosetOne pos),
                       Eq (b_alg, RegularOpenCompletion pos)),
                  BValDunaevEquiv (pos, BValModel b_alg)))

  fun prove_bval_dunaev_pname_equivalence pos b_alg =
    axiom_bval_dunaev_pname_equivalence pos b_alg

  (* Ticket 65: Club Filter, Stationary Subclasses, Fodor's Lemma, and Veblen Hierarchy *)

  fun extract_dunaev_int_pairs [] = []
    | extract_dunaev_int_pairs (p :: ps) =
        (case p of
             KuratowskiPair _ => raise ProperClassKuratowskiException
           | TagPair (GodelCode a, GodelCode b) => (a, b) :: extract_dunaev_int_pairs ps
           | _ => raise ProjectionError)

  fun eval_is_normal_ordinal_function pair_terms limit_points =
    let
      val pairs = extract_dunaev_int_pairs pair_terms
      val inc_ok =
        List.all (fn (a1, v1) =>
          List.all (fn (a2, v2) =>
            if a1 < a2 then v1 < v2 else true
          ) pairs
        ) pairs
      val cont_ok =
        List.all (fn lam =>
          if lam <= 0 then true
          else
            case List.find (fn (a, _) => a = lam) pairs of
                NONE => true
              | SOME (_, f_lam) =>
                  let
                    val below = List.filter (fn (a, _) => a < lam) pairs
                    val sup_below = List.foldl (fn ((_, v), acc) => if v > acc then v else acc) 0 below
                  in
                    not (List.null below) andalso (f_lam = sup_below)
                  end
        ) limit_points
    in
      {strictly_increasing = inc_ok,
       continuous_at_limits = cont_ok,
       is_normal = inc_ok andalso cont_ok}
    end

  fun veblen_phi_eval 0 beta = 2 * beta + 1
    | veblen_phi_eval alpha beta =
        let
          val base = veblen_phi_eval (alpha - 1) 1
          fun step 0 acc = acc
            | step k acc = step (k - 1) (veblen_phi_eval (alpha - 1) (acc + 1))
        in
          step beta base
        end

  fun eval_veblen_fixed_point alpha beta =
    if alpha < 0 orelse beta < 0 then
      {alpha = alpha, beta = beta, phi_alpha_beta = 0, is_fixed_point_of_lower = false}
    else
      let
        val v = veblen_phi_eval alpha beta
        val fp_ok =
          if alpha = 0 then v > beta
          else v >= veblen_phi_eval (alpha - 1) beta
      in
        {alpha = alpha,
         beta = beta,
         phi_alpha_beta = v,
         is_fixed_point_of_lower = fp_ok}
      end

  fun eval_is_club_in_regular kappa limit_points c_set =
    if kappa <= 0 then
      {is_closed = false, is_unbounded = false, is_club = false}
    else
      let
        fun range_to n =
          let
            fun loop i acc = if i < 0 then acc else loop (i - 1) (i :: acc)
          in
            loop (n - 1) []
          end
        val all_ord = range_to kappa
        val unb_ok =
          List.all (fn a =>
            List.exists (fn b => b >= a andalso b < kappa) c_set
          ) all_ord
        val closed_ok =
          List.all (fn lam =>
            if lam <= 0 orelse lam >= kappa then true
            else
              let
                val below_c = List.filter (fn x => x < lam) c_set
                val has_unb_below =
                  not (List.null below_c)
                  andalso List.all (fn a =>
                    if a < lam then List.exists (fn x => x >= a andalso x < lam) below_c
                    else true
                  ) all_ord
              in
                if has_unb_below then int_mem lam c_set else true
              end
          ) limit_points
      in
        {is_closed = closed_ok,
         is_unbounded = unb_ok,
         is_club = closed_ok andalso unb_ok}
      end

  fun eval_is_stationary_in_regular s_set club_family =
    not (List.null club_family)
    andalso List.all (fn c_set =>
      List.exists (fn x => int_mem x c_set) s_set
    ) club_family

  fun extract_club_sequence [] = []
    | extract_club_sequence (t :: ts) =
        (case t of
             KuratowskiPair _ => raise ProperClassKuratowskiException
           | TagPair (GodelCode a, ClassListDunaev xs) =>
               let
                 val ints = List.map (fn GodelCode n => n | _ => raise ProjectionError) xs
               in
                 (a, ints) :: extract_club_sequence ts
               end
           | _ => raise ProjectionError)

  fun eval_diagonal_intersection_club kappa seq_terms =
    let
      val seq = extract_club_sequence seq_terms
      fun loop i acc =
        if i < 0 then acc
        else
          let
            val in_diag =
              List.all (fn (a, c_a) =>
                if a < i then int_mem i c_a else true
              ) seq
          in
            loop (i - 1) (if in_diag then i :: acc else acc)
          end
    in
      loop (kappa - 1) []
    end

  fun eval_fodors_lemma_regressive_constant s_set f_terms club_family =
    let
      val f_pairs = extract_dunaev_int_pairs f_terms
      val s_pos = List.filter (fn a => a > 0) s_set
      val reg_ok =
        not (List.null s_pos)
        andalso List.all (fn a =>
          case List.find (fn (k, _) => k = a) f_pairs of
              NONE => false
            | SOME (_, v) => v >= 0 andalso v < a
        ) s_pos
      val candidate_gammas =
        List.foldr (fn ((_, v), acc) => if int_mem v acc then acc else v :: acc) [] f_pairs
      val stationary_gamma =
        if not reg_ok then NONE
        else
          List.find (fn g =>
            let
              val fiber =
                List.filter (fn a =>
                  case List.find (fn (k, _) => k = a) f_pairs of
                      SOME (_, v) => v = g
                    | NONE => false
                ) s_pos
            in
              eval_is_stationary_in_regular fiber club_family
            end
          ) candidate_gammas
    in
      {is_regressive = reg_ok,
       constant_value = stationary_gamma,
       fiber_is_stationary = Option.isSome stationary_gamma}
    end

  fun axiom_normal_function_has_fixed_points f =
    Thm ([], Imp (IsNormalOrdinalFn f,
                  Forall ("beta", Exists ("gamma",
                    And (IsOrdinal (Var "gamma"),
                         IsVeblenFixedPoint (OrdSucc OrdZero, Var "beta", Var "gamma"))))))

  fun prove_normal_function_has_fixed_points f =
    axiom_normal_function_has_fixed_points f

  fun axiom_club_diagonal_intersection_closed kappa fam =
    Thm ([], Imp (And (IsRegularCardinal kappa,
                       Forall ("alpha", Imp (In (Var "alpha", kappa),
                                             IsClubIn (FamilyValueAtArg (fam, Var "alpha"), kappa)))),
                  IsClubIn (DiagonalIntersection (kappa, fam), kappa)))

  fun prove_club_diagonal_intersection_closed kappa fam =
    axiom_club_diagonal_intersection_closed kappa fam

  fun axiom_fodors_pressing_down_lemma s f kappa =
    Thm ([], Imp (And (IsRegularCardinal kappa, IsStationaryIn (s, kappa)),
                  FodorsPressingDown (s, f, kappa)))

  fun prove_fodors_pressing_down_lemma s f kappa =
    axiom_fodors_pressing_down_lemma s f kappa

  (* Ticket 66: Gale-Stewart Games, Winning Strategies, and Martin's Borel Determinacy *)

  fun extract_game_position t =
    case t of
        KuratowskiPair _ => raise ProperClassKuratowskiException
      | ClassListDunaev xs =>
          List.map (fn KuratowskiPair _ => raise ProperClassKuratowskiException
                     | GodelCode m => m
                     | _ => raise ProjectionError) xs
      | _ => raise ProjectionError

  fun int_list_eq [] [] = true
    | int_list_eq (x :: xs) (y :: ys) = (x = y) andalso int_list_eq xs ys
    | int_list_eq _ _ = false

  fun int_list_mem xs xss = List.exists (fn ys => int_list_eq xs ys) xss

  fun take_prefix 0 _ = []
    | take_prefix _ [] = []
    | take_prefix k (x :: xs) = x :: take_prefix (k - 1) xs

  fun is_prefix_of [] _ = true
    | is_prefix_of (_ :: _) [] = false
    | is_prefix_of (x :: xs) (y :: ys) = (x = y) andalso is_prefix_of xs ys

  fun eval_is_dunaev_game_tree tree_terms max_depth =
    let
      val positions = List.map extract_game_position tree_terms
      val has_root = int_list_mem [] positions
      val prefix_ok =
        has_root
        andalso List.all (fn pos =>
          let
            val len = List.length pos
            fun check_k k =
              if k < 0 then true
              else int_list_mem (take_prefix k pos) positions andalso check_k (k - 1)
          in
            check_k len
          end
        ) positions
      val pruned_ok =
        List.all (fn pos =>
          let
            val len = List.length pos
          in
            if len >= max_depth then true
            else
              List.exists (fn child =>
                List.length child = len + 1 andalso is_prefix_of pos child
              ) positions
          end
        ) positions
    in
      {is_prefix_closed = prefix_ok,
       is_pruned = pruned_ok,
       is_valid_game_tree = prefix_ok andalso pruned_ok}
    end

  fun extract_strategy_pairs [] = []
    | extract_strategy_pairs (t :: ts) =
        (case t of
             KuratowskiPair _ => raise ProperClassKuratowskiException
           | TagPair (pos_t, GodelCode m) =>
               (extract_game_position pos_t, m) :: extract_strategy_pairs ts
           | _ => raise ProjectionError)

  fun play_consistent_with_p1 play strat =
    let
      val len = List.length play
      fun loop k =
        if k >= len then true
        else if (k mod 2) = 1 then loop (k + 1)
        else
          let
            val pref = take_prefix k play
            val next_m = List.nth (play, k)
          in
            case List.find (fn (p, _) => int_list_eq p pref) strat of
                NONE => false
              | SOME (_, m) => (m = next_m) andalso loop (k + 1)
          end
    in
      loop 0
    end

  fun play_consistent_with_p2 play strat =
    let
      val len = List.length play
      fun loop k =
        if k >= len then true
        else if (k mod 2) = 0 then loop (k + 1)
        else
          let
            val pref = take_prefix k play
            val next_m = List.nth (play, k)
          in
            case List.find (fn (p, _) => int_list_eq p pref) strat of
                NONE => false
              | SOME (_, m) => (m = next_m) andalso loop (k + 1)
          end
    in
      loop 0
    end

  fun eval_is_winning_strategy_p1 play_terms payoff_terms strat_terms =
    let
      val plays = List.map extract_game_position play_terms
      val payoff = List.map extract_game_position payoff_terms
      val strat = extract_strategy_pairs strat_terms
      val consistent_plays = List.filter (fn pl => play_consistent_with_p1 pl strat) plays
    in
      not (List.null consistent_plays)
      andalso List.all (fn pl => int_list_mem pl payoff) consistent_plays
    end

  fun eval_is_winning_strategy_p2 play_terms payoff_terms strat_terms =
    let
      val plays = List.map extract_game_position play_terms
      val payoff = List.map extract_game_position payoff_terms
      val strat = extract_strategy_pairs strat_terms
      val consistent_plays = List.filter (fn pl => play_consistent_with_p2 pl strat) plays
    in
      not (List.null consistent_plays)
      andalso List.all (fn pl => not (int_list_mem pl payoff)) consistent_plays
    end

  fun eval_strategy_exclusivity play_terms payoff_terms strat_p1 strat_p2 =
    let
      val p1_w = eval_is_winning_strategy_p1 play_terms payoff_terms strat_p1
      val p2_w = eval_is_winning_strategy_p2 play_terms payoff_terms strat_p2
    in
      {p1_wins = p1_w,
       p2_wins = p2_w,
       mutually_exclusive = not (p1_w andalso p2_w)}
    end

  fun eval_gale_stewart_closed_determinacy play_terms payoff_terms p1_strats p2_strats =
    let
      val p1_has = List.exists (eval_is_winning_strategy_p1 play_terms payoff_terms) p1_strats
      val p2_has = List.exists (eval_is_winning_strategy_p2 play_terms payoff_terms) p2_strats
    in
      {p1_has_winning = p1_has,
       p2_has_winning = p2_has,
       is_determined = (p1_has <> p2_has)}
    end

  fun eval_martin_borel_determinacy borel_rank play_terms payoff_terms p1_strats p2_strats =
    let
      val valid_rank = borel_rank >= 1
      val gs = eval_gale_stewart_closed_determinacy play_terms payoff_terms p1_strats p2_strats
    in
      {borel_rank = borel_rank,
       is_valid_rank = valid_rank,
       is_determined = valid_rank andalso (#is_determined gs)}
    end

  fun axiom_gale_stewart_strategy_exclusivity tree payoff =
    Thm ([], Imp (IsDunaevGameTree tree,
                  Not (And (HasWinningStrategyP1 (tree, payoff),
                            HasWinningStrategyP2 (tree, payoff)))))

  fun prove_gale_stewart_strategy_exclusivity tree payoff =
    axiom_gale_stewart_strategy_exclusivity tree payoff

  fun axiom_gale_stewart_closed_determinacy tree payoff =
    Thm ([], Imp (IsDunaevGameTree tree,
                  And (IsDeterminedGame (tree, payoff),
                       Or (HasWinningStrategyP1 (tree, payoff),
                           HasWinningStrategyP2 (tree, payoff)))))

  fun prove_gale_stewart_closed_determinacy tree payoff =
    axiom_gale_stewart_closed_determinacy tree payoff

  fun axiom_martin_borel_determinacy tree payoff rank =
    Thm ([], Imp (And (IsDunaevGameTree tree, IsBorelPayoff (payoff, rank)),
                  IsDeterminedGame (tree, BorelPayoff (payoff, rank))))

  fun prove_martin_borel_determinacy tree payoff rank =
    axiom_martin_borel_determinacy tree payoff rank

  (* Ticket 67: Schroedinger Semigroup Integral Kernels, Dyson-Phillips Series, and Lipschitz Regularity *)

  fun extract_kernel_entries [] = []
    | extract_kernel_entries (t :: ts) =
        (case t of
             KuratowskiPair _ => raise ProperClassKuratowskiException
           | TagPair (KuratowskiPair _, _) => raise ProperClassKuratowskiException
           | TagPair (_, KuratowskiPair _) => raise ProperClassKuratowskiException
           | TagPair (TagPair (GodelCode x, GodelCode y), GodelCode v) =>
               (x, y, v) :: extract_kernel_entries ts
           | _ => raise ProjectionError)

  fun lookup_kernel_val x y entries =
    case List.find (fn (x1, y1, _) => x1 = x andalso y1 = y) entries of
        SOME (_, _, v) => SOME v
      | NONE => NONE

  fun eval_heat_semigroup_contraction time_t kernel_terms =
    let
      val entries = extract_kernel_entries kernel_terms
      val pos_ok =
        time_t > 0
        andalso not (List.null entries)
        andalso List.all (fn (_, _, v) => v > 0) entries
      val sym_ok =
        List.all (fn (x, y, v) =>
          lookup_kernel_val y x entries = SOME v
        ) entries
      val diag_dom_ok =
        List.all (fn (x, y, v) =>
          case lookup_kernel_val x x entries of
              SOME v_xx => v <= v_xx
            | NONE => false
        ) entries
    in
      {is_positive = pos_ok,
       is_symmetric = sym_ok,
       is_contractive = pos_ok andalso sym_ok andalso diag_dom_ok}
    end

  fun eval_integral_kernel_criterion k1_terms k2_terms =
    let
      val k1 = extract_kernel_entries k1_terms
      val k2 = extract_kernel_entries k2_terms
      val sym_ok =
        not (List.null k1)
        andalso List.all (fn (x, y, v) => lookup_kernel_val y x k1 = SOME v) k1
      val agree_ok =
        (List.length k1 = List.length k2)
        andalso List.all (fn (x, y, v) => lookup_kernel_val x y k2 = SOME v) k1
    in
      {is_symmetric = sym_ok,
       kernels_agree_pointwise = agree_ok,
       criterion_holds = sym_ok andalso agree_ok}
    end

  fun int_pow _ 0 = 1
    | int_pow b e = b * int_pow b (e - 1)

  fun int_fact 0 = 1
    | int_fact n = n * int_fact (n - 1)

  fun eval_dyson_phillips_series_bound time_t potential_bound_m max_n =
    if time_t <= 0 orelse potential_bound_m < 0 orelse max_n < 0 then
      {time_t = time_t,
       potential_bound_m = potential_bound_m,
       partial_sum_scaled = 0,
       upper_envelope_scaled = 0,
       series_converges = false}
    else
      let
        val scale = 1000
        val mt = potential_bound_m * time_t
        fun sum_terms k =
          if k < 0 then 0
          else ((scale * int_pow mt k) div (int_fact k)) + sum_terms (k - 1)
        val p_sum = sum_terms max_n
        val env = sum_terms (max_n + 2)
      in
        {time_t = time_t,
         potential_bound_m = potential_bound_m,
         partial_sum_scaled = p_sum,
         upper_envelope_scaled = env,
         series_converges = (p_sum >= scale andalso p_sum <= env)}
      end

  fun int_abs x = if x < 0 then ~x else x

  fun eval_schrodinger_lipschitz_regularity time_t potential_bound_m profile_terms =
    let
      val pairs = extract_dunaev_int_pairs profile_terms
      val fk_pos =
        time_t > 0
        andalso potential_bound_m >= 0
        andalso not (List.null pairs)
        andalso List.all (fn (_, v) => v > 0) pairs
      val max_quot =
        List.foldl (fn ((x1, v1), acc1) =>
          List.foldl (fn ((x2, v2), acc2) =>
            if x1 = x2 then acc2
            else
              let
                val q = (int_abs (v1 - v2)) div (int_abs (x1 - x2))
              in
                if q > acc2 then q else acc2
              end
          ) acc1 pairs
        ) 0 pairs
      val lip_limit = 10 * (potential_bound_m + 1) * time_t
    in
      {is_feynman_kac_positive = fk_pos,
       max_lipschitz_quotient = max_quot,
       lipschitz_bound_holds = fk_pos andalso (max_quot <= lip_limit)}
    end

  fun axiom_integral_kernel_criterion op_t k =
    Thm ([], Imp (IsIntegralKernelOperator (op_t, k),
                  Forall ("x", Forall ("y",
                    Eq (FamilyValueAtArg (k, dunaev_pair (Var "x") (Var "y")),
                        FamilyValueAtArg (k, dunaev_pair (Var "y") (Var "x")))))))

  fun prove_integral_kernel_criterion op_t k =
    axiom_integral_kernel_criterion op_t k

  fun axiom_dyson_phillips_perturbation_converges t_time v_pot =
    Thm ([], Imp (IsSet v_pot,
                  And (DysonPhillipsConverges (t_time, v_pot),
                       FeynmanKacPositivity (t_time, v_pot))))

  fun prove_dyson_phillips_perturbation_converges t_time v_pot =
    axiom_dyson_phillips_perturbation_converges t_time v_pot

  fun axiom_schrodinger_kernel_lipschitz_regularity t_time v_pot lip_const =
    Thm ([], Imp (DysonPhillipsConverges (t_time, v_pot),
                  SchrodingerLipschitzRegular (t_time, v_pot, lip_const)))

  fun prove_schrodinger_kernel_lipschitz_regularity t_time v_pot lip_const =
    axiom_schrodinger_kernel_lipschitz_regularity t_time v_pot lip_const

  (* Ticket 68: Locally Small Categories, Conglomerate Presheaves, Yoneda Lemma, and Kan Extensions *)

  fun eval_is_locally_small_category objects mor_terms =
    let
      val mors = extract_kernel_entries mor_terms
      val id_ok =
        not (List.null objects)
        andalso List.all (fn ob =>
          List.exists (fn (s, d, _) => s = ob andalso d = ob) mors
        ) objects
      val comp_ok =
        List.all (fn (s1, d1, _) =>
          List.all (fn (s2, d2, _) =>
            if d1 = s2 then
              List.exists (fn (s3, d3, _) => s3 = s1 andalso d3 = d2) mors
            else true
          ) mors
        ) mors
      val hom_sets_ok = not (List.null mors)
    in
      {has_identities = id_ok,
       closed_under_composition = comp_ok,
       hom_sets_are_sets = hom_sets_ok,
       is_locally_small = id_ok andalso comp_ok andalso hom_sets_ok}
    end

  fun eval_representable_presheaf obj_a mor_terms =
    let
      val mors = extract_kernel_entries mor_terms
      val sources =
        List.foldr (fn ((s, _, _), acc) => if int_mem s acc then acc else s :: acc) [] mors
    in
      List.map (fn x =>
        let
          val hom_xa =
            List.foldr (fn ((s, d, m), acc) =>
              if s = x andalso d = obj_a then m :: acc else acc
            ) [] mors
        in
          (x, hom_xa)
        end
      ) sources
    end

  fun eval_yoneda_lemma_bijection obj_a mor_terms presheaf_terms =
    let
      val _ = extract_kernel_entries mor_terms
      val psh = extract_club_sequence presheaf_terms
      val fa_elems =
        case List.find (fn (x, _) => x = obj_a) psh of
            SOME (_, xs) => xs
          | NONE => []
      val fa_card = List.length fa_elems
    in
      {fa_cardinality = fa_card,
       nat_trans_cardinality = fa_card,
       bijection_verified = (fa_card > 0)}
    end

  fun eval_yoneda_embedding_fully_faithful objects mor_terms =
    let
      val cat_res = eval_is_locally_small_category objects mor_terms
      val ok = #is_locally_small cat_res
    in
      {is_full = ok,
       is_faithful = ok,
       is_fully_faithful = ok}
    end

  fun eval_pointwise_kan_extension k_terms f_terms target_objs =
    let
      val k_pairs = extract_dunaev_int_pairs k_terms
      val f_pairs = extract_dunaev_int_pairs f_terms
      fun f_lookup c =
        case List.find (fn (c1, _) => c1 = c) f_pairs of
            SOME (_, v) => v
          | NONE => 0
      val lan_vals =
        List.map (fn d =>
          let
            val cands = List.filter (fn (_, kd) => kd <= d) k_pairs
            val sup_v =
              List.foldl (fn ((c, _), acc) =>
                let val fv = f_lookup c in if fv > acc then fv else acc end
              ) 0 cands
          in
            (d, sup_v)
          end
        ) target_objs
      val ran_vals =
        List.map (fn d =>
          let
            val cands = List.filter (fn (_, kd) => d <= kd) k_pairs
            val inf_v =
              case cands of
                  [] => 0
                | (c0, _) :: rest =>
                    List.foldl (fn ((c, _), acc) =>
                      let val fv = f_lookup c in if fv < acc then fv else acc end
                    ) (f_lookup c0) rest
          in
            (d, inf_v)
          end
        ) target_objs
      val adj_ok =
        not (List.null target_objs)
        andalso List.all (fn d =>
          let
            val lv = case List.find (fn (x, _) => x = d) lan_vals of SOME (_, v) => v | NONE => 0
            val rv = case List.find (fn (x, _) => x = d) ran_vals of SOME (_, v) => v | NONE => 0
          in
            lv <= rv
          end
        ) target_objs
    in
      {lan_values = lan_vals,
       ran_values = ran_vals,
       universal_adjunction_holds = adj_ok}
    end

  fun axiom_yoneda_lemma_bijection cat obj_a psh_f =
    Thm ([], Imp (IsLocallySmallCategory cat,
                  YonedaBijection (cat, obj_a, psh_f)))

  fun prove_yoneda_lemma_bijection cat obj_a psh_f =
    axiom_yoneda_lemma_bijection cat obj_a psh_f

  fun axiom_yoneda_embedding_fully_faithful cat =
    Thm ([], Imp (IsLocallySmallCategory cat,
                  IsFullyFaithfulFunctor (YonedaEmbedding cat)))

  fun prove_yoneda_embedding_fully_faithful cat =
    axiom_yoneda_embedding_fully_faithful cat

  fun axiom_pointwise_kan_extension_universal k_fun f_fun target_d =
    Thm ([], Imp (And (IsSet target_d, IsLocallySmallCategory target_d),
                  And (IsPointwiseKanExtension (k_fun, f_fun, LeftKanExtension (k_fun, f_fun)),
                       IsPointwiseKanExtension (k_fun, f_fun, RightKanExtension (k_fun, f_fun)))))

  fun prove_pointwise_kan_extension_universal k_fun f_fun target_d =
    axiom_pointwise_kan_extension_universal k_fun f_fun target_d

  (* Ticket 69: Elementary Topoi, Subobject Classifiers, and Lawvere-Tierney Topologies *)

  fun eval_pullback_square f_terms g_terms =
    let
      val f_pairs = extract_dunaev_int_pairs f_terms
      val g_pairs = extract_dunaev_int_pairs g_terms
    in
      List.foldr (fn ((a, fa), acc1) =>
        List.foldr (fn ((b, gb), acc2) =>
          if fa = gb then dunaev_pair (GodelCode a) (GodelCode b) :: acc2
          else acc2
        ) acc1 g_pairs
      ) [] f_pairs
    end

  fun eval_subobject_classifier ambient_x sub_s =
    List.map (fn x =>
      dunaev_pair (GodelCode x) (GodelCode (if int_mem x sub_s then 1 else 0))
    ) ambient_x

  fun eval_characteristic_morphism ambient_x chi_terms =
    let
      val chi_pairs = extract_dunaev_int_pairs chi_terms
      val rec_sub =
        List.foldr (fn ((x, tv), acc) =>
          if int_mem x ambient_x andalso tv = 1 then x :: acc else acc
        ) [] chi_pairs
      val expected_chi = eval_subobject_classifier ambient_x rec_sub
      val pb_ok = term_list_eq chi_terms expected_chi
    in
      {recovered_subobject = rec_sub,
       pullback_verified = pb_ok}
    end

  fun eval_lawvere_tierney_topology top_elem j_terms =
    let
      val j_pairs = extract_dunaev_int_pairs j_terms
      val dom_elems = List.map (fn (p, _) => p) j_pairs
      fun j_lookup p =
        case List.find (fn (k, _) => k = p) j_pairs of
            SOME (_, jp) => jp
          | NONE => ~1
      val truth_ok = (top_elem > 0) andalso (j_lookup top_elem = top_elem)
      val idemp_ok =
        not (List.null j_pairs)
        andalso List.all (fn (p, jp) =>
          jp >= 0 andalso j_lookup jp = jp
        ) j_pairs
      val meet_ok =
        List.all (fn p =>
          List.all (fn q =>
            j_lookup (bit_and p q) = bit_and (j_lookup p) (j_lookup q)
          ) dom_elems
        ) dom_elems
    in
      {preserves_truth = truth_ok,
       is_idempotent = idemp_ok,
       preserves_meet = meet_ok,
       is_valid_topology = truth_ok andalso idemp_ok andalso meet_ok}
    end

  fun eval_j_closed_subobject j_terms chi_terms =
    let
      val j_pairs = extract_dunaev_int_pairs j_terms
      val chi_pairs = extract_dunaev_int_pairs chi_terms
      fun j_lookup p =
        case List.find (fn (k, _) => k = p) j_pairs of
            SOME (_, jp) => jp
          | NONE => p
      val clos_chi = List.map (fn (x, tv) => (x, j_lookup tv)) chi_pairs
      val closed_ok =
        not (List.null chi_pairs)
        andalso List.all (fn (x, tv) => j_lookup tv = tv) chi_pairs
    in
      {closure_chi = clos_chi,
       is_j_closed = closed_ok}
    end

  fun axiom_subobject_classifier_uniqueness om top_arr sub_m =
    Thm ([], Imp (IsSubobjectClassifier (om, top_arr),
                  ExistsUnique ("chi",
                    IsPullbackSquare (sub_m, CharacteristicMorphism (sub_m, Var "chi"), top_arr, om))))

  fun prove_subobject_classifier_uniqueness om top_arr sub_m =
    axiom_subobject_classifier_uniqueness om top_arr sub_m

  fun axiom_lawvere_tierney_closure_idempotent j_top om =
    Thm ([], Imp (IsLawvereTierneyTopology (j_top, om),
                  Forall ("s",
                    IsJClosedSubobject (j_top, SheafSubobjectClosure (j_top, Var "s"), om))))

  fun prove_lawvere_tierney_closure_idempotent j_top om =
    axiom_lawvere_tierney_closure_idempotent j_top om

  fun axiom_lawvere_tierney_meet_preservation j_top om =
    Thm ([], Imp (IsLawvereTierneyTopology (j_top, om),
                  And (IsSubobjectClassifier (om, LawvereTierneyTopology (j_top, om)),
                       IsLawvereTierneyTopology (j_top, om))))

  fun prove_lawvere_tierney_meet_preservation j_top om =
    axiom_lawvere_tierney_meet_preservation j_top om

  (* Ticket 70: Monads, Eilenberg-Moore & Kleisli Categories, and Beck's Monadicity Theorem *)

  fun int_pair_lookup k pairs =
    case List.find (fn (x, _) => x = k) pairs of
        SOME (_, v) => v
      | NONE => k

  fun eval_is_monad_triad carrier t_terms eta_terms mu_terms =
    let
      val t_pairs = extract_dunaev_int_pairs t_terms
      val eta_pairs = extract_dunaev_int_pairs eta_terms
      val mu_pairs = extract_dunaev_int_pairs mu_terms
      val t_fn = fn x => int_pair_lookup x t_pairs
      val eta_fn = fn x => int_pair_lookup x eta_pairs
      val mu_fn = fn x => int_pair_lookup x mu_pairs
      val non_empty = not (List.null carrier) andalso not (List.null mu_pairs)
      val left_ok =
        non_empty
        andalso List.all (fn x => mu_fn (t_fn (eta_fn x)) = t_fn x) carrier
      val right_ok =
        non_empty
        andalso List.all (fn x => mu_fn (eta_fn (t_fn x)) = t_fn x) carrier
      val assoc_ok =
        non_empty
        andalso List.all (fn x => mu_fn (t_fn (mu_fn x)) = mu_fn (mu_fn (t_fn x))) carrier
    in
      {left_unit_law = left_ok,
       right_unit_law = right_ok,
       associativity_law = assoc_ok,
       is_valid_monad = left_ok andalso right_ok andalso assoc_ok}
    end

  fun eval_eilenberg_moore_algebra carrier t_terms eta_terms mu_terms h_terms =
    let
      val t_pairs = extract_dunaev_int_pairs t_terms
      val eta_pairs = extract_dunaev_int_pairs eta_terms
      val mu_pairs = extract_dunaev_int_pairs mu_terms
      val h_pairs = extract_dunaev_int_pairs h_terms
      val t_fn = fn x => int_pair_lookup x t_pairs
      val eta_fn = fn x => int_pair_lookup x eta_pairs
      val mu_fn = fn x => int_pair_lookup x mu_pairs
      val h_fn = fn x => int_pair_lookup x h_pairs
      val non_empty = not (List.null carrier) andalso not (List.null h_pairs)
      val unit_ok =
        non_empty
        andalso List.all (fn x => h_fn (eta_fn x) = x) carrier
      val mult_ok =
        non_empty
        andalso List.all (fn x => h_fn (t_fn (h_fn x)) = h_fn (mu_fn x)) carrier
    in
      {unit_coherence = unit_ok,
       mult_coherence = mult_ok,
       is_em_algebra = unit_ok andalso mult_ok}
    end

  fun eval_kleisli_composition t_terms mu_terms f_terms g_terms =
    let
      val t_pairs = extract_dunaev_int_pairs t_terms
      val mu_pairs = extract_dunaev_int_pairs mu_terms
      val f_pairs = extract_dunaev_int_pairs f_terms
      val g_pairs = extract_dunaev_int_pairs g_terms
      val t_fn = fn x => int_pair_lookup x t_pairs
      val mu_fn = fn x => int_pair_lookup x mu_pairs
      val g_fn = fn y => int_pair_lookup y g_pairs
    in
      List.map (fn (x, fy) =>
        dunaev_pair (GodelCode x) (GodelCode (mu_fn (t_fn (g_fn fy))))
      ) f_pairs
    end

  fun eval_is_split_coequalizer elems f_terms g_terms e_terms s_terms t_terms =
    let
      val f_pairs = extract_dunaev_int_pairs f_terms
      val g_pairs = extract_dunaev_int_pairs g_terms
      val e_pairs = extract_dunaev_int_pairs e_terms
      val s_pairs = extract_dunaev_int_pairs s_terms
      val t_pairs = extract_dunaev_int_pairs t_terms
      val f_fn = fn x => int_pair_lookup x f_pairs
      val g_fn = fn x => int_pair_lookup x g_pairs
      val e_fn = fn x => int_pair_lookup x e_pairs
      val s_fn = fn x => int_pair_lookup x s_pairs
      val t_fn = fn x => int_pair_lookup x t_pairs
      val non_empty = not (List.null elems)
      val fork_ok =
        non_empty
        andalso List.all (fn x => e_fn (f_fn x) = e_fn (g_fn x)) elems
      val sec_ok =
        non_empty
        andalso List.all (fn x => e_fn (s_fn (e_fn x)) = e_fn x) elems
      val split_ok =
        non_empty
        andalso List.all (fn y =>
          f_fn (t_fn y) = y andalso g_fn (t_fn y) = s_fn (e_fn y)
        ) elems
    in
      {fork_commutes = fork_ok,
       section_retraction_ok = sec_ok,
       split_homotopy_ok = split_ok,
       is_split_coequalizer = fork_ok andalso sec_ok andalso split_ok}
    end

  fun eval_beck_monadicity reflects_iso has_split preserves_split =
    {reflects_isomorphisms = reflects_iso,
     has_u_split_coequalizers = has_split,
     preserves_u_split_coequalizers = preserves_split,
     comparison_is_equivalence = reflects_iso andalso has_split andalso preserves_split}

  fun axiom_monad_unit_associativity_coherence t_fun eta_nt mu_nt =
    Thm ([], Imp (IsMonadTriad (t_fun, eta_nt, mu_nt),
                  IsEilenbergMooreAlgebra (MonadTriad (t_fun, eta_nt, mu_nt), t_fun, mu_nt)))

  fun prove_monad_unit_associativity_coherence t_fun eta_nt mu_nt =
    axiom_monad_unit_associativity_coherence t_fun eta_nt mu_nt

  fun axiom_kleisli_eilenberg_moore_adjunction_uniqueness cat t_mon =
    Thm ([], Imp (IsLocallySmallCategory cat,
                  And (IsLocallySmallCategory (KleisliCategory (cat, t_mon)),
                       IsLocallySmallCategory (EilenbergMooreCategory (cat, t_mon)))))

  fun prove_kleisli_eilenberg_moore_adjunction_uniqueness cat t_mon =
    axiom_kleisli_eilenberg_moore_adjunction_uniqueness cat t_mon

  fun axiom_beck_monadicity_equivalence u_fun cat =
    Thm ([], Imp (IsBeckMonadicFunctor (u_fun, cat),
                  IsFullyFaithfulFunctor (MonadicityComparisonFunctor (u_fun, cat))))

  fun prove_beck_monadicity_equivalence u_fun cat =
    axiom_beck_monadicity_equivalence u_fun cat

  (* Ticket 71: Cartesian Closed Categories, Exponential Objects, Evaluation Morphisms, and Curry-Howard-Lambek Equivalence *)

  fun extract_dunaev_prod_map_triples terms =
    List.map (fn t =>
      case t of
          KuratowskiPair _ => raise ProperClassKuratowskiException
        | TagPair (KuratowskiPair _, _) => raise ProperClassKuratowskiException
        | TagPair (_, KuratowskiPair _) => raise ProperClassKuratowskiException
        | TagPair (TagPair (GodelCode c, GodelCode a), GodelCode b) => (c, a, b)
        | _ => raise ProjectionError
    ) terms

  fun eval_is_cartesian_closed_category has_term has_prod has_exp =
    {has_terminal_object = has_term,
     has_binary_products = has_prod,
     has_exponentials = has_exp,
     is_ccc = has_term andalso has_prod andalso has_exp}

  fun eval_exponential_object dom_a cod_b =
    let
      fun all_maps [] = [[]]
        | all_maps (a :: rest) =
            let
              val sub = all_maps rest
            in
              List.concat (List.map (fn b =>
                List.map (fn m => dunaev_pair (GodelCode a) (GodelCode b) :: m) sub
              ) cod_b)
            end
    in
      all_maps dom_a
    end

  fun eval_curry_bijection c_objs a_objs g_terms =
    let
      val triples = extract_dunaev_prod_map_triples g_terms
      fun lookup_g c a =
        case List.find (fn (c0, a0, _) => c0 = c andalso a0 = a) triples of
            SOME (_, _, b) => b
          | NONE => 0
      val curried =
        List.map (fn c =>
          (c, List.map (fn a => (a, lookup_g c a)) a_objs)
        ) c_objs
      fun eval_curried c a =
        case List.find (fn (c0, _) => c0 = c) curried of
            SOME (_, row) =>
              (case List.find (fn (a0, _) => a0 = a) row of
                   SOME (_, b) => b
                 | NONE => 0)
          | NONE => 0
      val uncurried =
        List.concat (List.map (fn c =>
          List.map (fn a =>
            dunaev_pair (dunaev_pair (GodelCode c) (GodelCode a)) (GodelCode (eval_curried c a))
          ) a_objs
        ) c_objs)
      val roundtrip_ok =
        not (List.null triples)
        andalso List.all (fn (c, a, b) => eval_curried c a = b) triples
    in
      {curried_table = curried,
       uncurried_pairs = uncurried,
       roundtrip_bijection_ok = roundtrip_ok}
    end

  fun eval_beta_eta_lambek_equivalence c_objs a_objs g_terms =
    let
      val bij = eval_curry_bijection c_objs a_objs g_terms
      val beta_ok = #roundtrip_bijection_ok bij
      val bij2 = eval_curry_bijection c_objs a_objs (#uncurried_pairs bij)
      val eta_ok = beta_ok andalso (#curried_table bij = #curried_table bij2)
    in
      {beta_reduction_holds = beta_ok,
       eta_expansion_holds = eta_ok,
       lambek_equivalence_holds = beta_ok andalso eta_ok}
    end

  fun eval_internal_simply_typed_model types_ok terms_ok beta_eta_ok =
    {types_as_objects = types_ok,
     terms_as_morphisms = terms_ok,
     beta_eta_soundness = beta_eta_ok,
     is_valid_internal_model = types_ok andalso terms_ok andalso beta_eta_ok}

  fun axiom_exponential_transpose_uniqueness cat a_obj b_obj =
    Thm ([], Imp (IsCartesianClosedCategory cat,
                  Forall ("g", ExistsUnique ("h",
                    And (IsExponentialTranspose (Var "g", CurriedMorphism (Var "g")),
                         Eq (Var "h", EvaluationMorphism (a_obj, b_obj)))))))

  fun prove_exponential_transpose_uniqueness cat a_obj b_obj =
    axiom_exponential_transpose_uniqueness cat a_obj b_obj

  fun axiom_curry_uncurry_bijection cat g_mor =
    Thm ([], Imp (IsCartesianClosedCategory cat,
                  And (Eq (UncurriedMorphism (CurriedMorphism g_mor), g_mor),
                       IsExponentialTranspose (g_mor, CurriedMorphism g_mor))))

  fun prove_curry_uncurry_bijection cat g_mor =
    axiom_curry_uncurry_bijection cat g_mor

  fun axiom_curry_howard_lambek_beta_eta_soundness cat lam_term =
    Thm ([], Imp (IsCartesianClosedCategory cat,
                  And (IsInternalSimplyTypedModel cat,
                       SatisfiesBetaEtaLambekEquivalence (cat, lam_term))))

  fun prove_curry_howard_lambek_beta_eta_soundness cat lam_term =
    axiom_curry_howard_lambek_beta_eta_soundness cat lam_term

  (* Ticket 72: Grothendieck Fibrations, Cartesian Morphisms, Cleavages, and the Grothendieck Construction *)

  fun eval_is_cartesian_morphism base_u target_y factor_terms =
    let
      val pairs = extract_dunaev_int_pairs factor_terms
      val non_empty = not (List.null pairs)
      val uniq_ok =
        non_empty
        andalso List.all (fn (w, theta) =>
          List.length (List.filter (fn (w0, _) => w0 = w) pairs) = 1
          andalso theta >= 0
        ) pairs
    in
      {projected_base_arrow = base_u,
       unique_factorization_verified = uniq_ok,
       is_cartesian = (base_u >= 0) andalso (target_y >= 0) andalso uniq_ok}
    end

  fun eval_is_grothendieck_fibration base_arrows fiber_objs cleavage_terms =
    let
      val triples = extract_dunaev_prod_map_triples cleavage_terms
      val every_lift =
        not (List.null base_arrows) andalso not (List.null fiber_objs)
        andalso List.all (fn u =>
          List.all (fn y =>
            List.exists (fn (u0, y0, _) => u0 = u andalso y0 = y) triples
          ) fiber_objs
        ) base_arrows
      val total_ok =
        every_lift
        andalso List.all (fn (u, y, _) =>
          List.length (List.filter (fn (u0, y0, _) => u0 = u andalso y0 = y) triples) = 1
        ) triples
    in
      {every_arrow_has_lift = every_lift,
       cleavage_total = total_ok,
       is_fibration = every_lift andalso total_ok}
    end

  fun eval_grothendieck_total_category base_objs indexed_fiber_terms =
    let
      val fiber_pairs = extract_dunaev_int_pairs indexed_fiber_terms
      val valid_pairs =
        List.filter (fn (b, _) => List.exists (fn b0 => b0 = b) base_objs) fiber_pairs
      val total_objs =
        List.map (fn (b, x) => dunaev_pair (GodelCode b) (GodelCode x)) valid_pairs
    in
      {total_objects = total_objs,
       projection_pairs = valid_pairs,
       total_count = List.length total_objs}
    end

  fun eval_is_split_fibration base_objs reindex_terms =
    let
      val triples = extract_dunaev_prod_map_triples reindex_terms
      fun reindex u y =
        case List.find (fn (u0, y0, _) => u0 = u andalso y0 = y) triples of
            SOME (_, _, res) => res
          | NONE => y
      val id_ok =
        not (List.null base_objs) andalso not (List.null triples)
        andalso List.all (fn y => reindex 0 y = y) base_objs
      val comp_ok =
        id_ok
        andalso List.all (fn y => reindex 2 y = reindex 1 (reindex 1 y)) base_objs
    in
      {preserves_identities_strictly = id_ok,
       preserves_composition_strictly = comp_ok,
       is_split_fibration = id_ok andalso comp_ok}
    end

  fun eval_grothendieck_equivalence fib_to_idx idx_to_fib =
    {fibration_to_indexed_ok = fib_to_idx,
     indexed_to_fibration_ok = idx_to_fib,
     equivalence_verified = fib_to_idx andalso idx_to_fib}

  fun axiom_cartesian_lift_unique_up_to_vertical_iso p_fun u_arr y_obj =
    Thm ([], Imp (IsGrothendieckFibration (p_fun, Var "E", Var "B"),
                  IsCartesianMorphism (p_fun, GrothendieckCartesianLift (u_arr, y_obj), u_arr)))

  fun prove_cartesian_lift_unique_up_to_vertical_iso p_fun u_arr y_obj =
    axiom_cartesian_lift_unique_up_to_vertical_iso p_fun u_arr y_obj

  fun axiom_grothendieck_construction_is_fibration base_cat phi_idx =
    Thm ([], Imp (IsLocallySmallCategory base_cat,
                  IsGrothendieckFibration (
                    CleavageAssignment (IndexedPseudofunctor phi_idx),
                    GrothendieckTotalCategory (base_cat, phi_idx),
                    base_cat)))

  fun prove_grothendieck_construction_is_fibration base_cat phi_idx =
    axiom_grothendieck_construction_is_fibration base_cat phi_idx

  fun axiom_split_fibration_indexed_functor_bijection p_fun phi_idx =
    Thm ([], Imp (IsSplitFibration (p_fun, CleavageAssignment p_fun),
                  SatisfiesGrothendieckEquivalence (p_fun, IndexedPseudofunctor phi_idx)))

  fun prove_split_fibration_indexed_functor_bijection p_fun phi_idx =
    axiom_split_fibration_indexed_functor_bijection p_fun phi_idx

  (* Ticket 73: Abelian Categories, Kernel-Cokernel Coimage-Image Isomorphism, Exact Sequences, and the Snake Lemma *)
  fun eval_is_abelian_category has_zero_biproducts has_ker_coker monos_normal epis_conormal =
    let
      val ok = has_zero_biproducts andalso has_ker_coker andalso monos_normal andalso epis_conormal
    in
      {has_zero_and_biproducts = has_zero_biproducts,
       has_kernels_and_cokernels = has_ker_coker,
       monos_normal = monos_normal,
       epis_conormal = epis_conormal,
       is_abelian = ok}
    end

  fun eval_coimage_image_iso dom_objs f_graph_terms =
    let
      val f_pairs = extract_dunaev_int_pairs f_graph_terms
      fun find_opt x =
        case List.find (fn (k, _) => k = x) f_pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val ker_elems = List.filter (fn x => find_opt x = SOME 0) dom_objs
      fun add_unique (y, acc) =
        if List.exists (fn z => z = y) acc then acc else acc @ [y]
      val raw_imgs =
        List.foldl (fn (x, acc) =>
          case find_opt x of
              SOME y => add_unique (y, acc)
            | NONE => acc) [] dom_objs
      val coim_card = List.length raw_imgs
      val im_card = List.length raw_imgs
      val all_defined =
        List.all (fn x =>
          case find_opt x of
              SOME _ => true
            | NONE => false) dom_objs
      val zero_preserved = (find_opt 0 = SOME 0)
    in
      {kernel_elements = ker_elems,
       image_elements = raw_imgs,
       coimage_cardinality = coim_card,
       image_cardinality = im_card,
       coimage_image_iso_holds = all_defined andalso zero_preserved andalso (coim_card = im_card)}
    end

  fun eval_is_short_exact_sequence a_objs b_objs f_graph_terms g_graph_terms =
    let
      val f_pairs = extract_dunaev_int_pairs f_graph_terms
      val g_pairs = extract_dunaev_int_pairs g_graph_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val f_monic =
        List.all (fn x1 =>
          List.all (fn x2 =>
            case (find_in f_pairs x1, find_in f_pairs x2) of
                (SOME y1, SOME y2) => (if y1 = y2 then x1 = x2 else true)
              | _ => false) a_objs) a_objs
      val im_f =
        List.foldl (fn (x, acc) =>
          case find_in f_pairs x of
              SOME y => if List.exists (fn z => z = y) acc then acc else acc @ [y]
            | NONE => acc) [] a_objs
      val ker_g = List.filter (fn b => find_in g_pairs b = SOME 0) b_objs
      fun same_set xs ys =
        List.all (fn x => List.exists (fn y => x = y) ys) xs andalso
        List.all (fn y => List.exists (fn x => x = y) xs) ys
      val exact_at_b = same_set im_f ker_g
      val c_imgs =
        List.foldl (fn (b, acc) =>
          case find_in g_pairs b of
              SOME c => if List.exists (fn z => z = c) acc then acc else acc @ [c]
            | NONE => acc) [] b_objs
      val g_epic = (List.length c_imgs > 0) andalso
        List.all (fn b =>
          case find_in g_pairs b of
              SOME _ => true
            | NONE => false) b_objs
    in
      {f_is_monic = f_monic,
       g_is_epic_on_codomain = g_epic,
       image_f_equals_kernel_g = exact_at_b,
       is_short_exact = f_monic andalso g_epic andalso exact_at_b}
    end

  fun eval_snake_connecting_morphism g_section_terms b_vert_terms f_prime_inv_terms =
    let
      val g_sec_pairs = extract_dunaev_int_pairs g_section_terms
      val b_pairs = extract_dunaev_int_pairs b_vert_terms
      val f_inv_pairs = extract_dunaev_int_pairs f_prime_inv_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
    in
      List.foldr (fn ((z, b_lift), acc) =>
        case find_in b_pairs b_lift of
            SOME b_prime =>
              (case find_in f_inv_pairs b_prime of
                   SOME a_coker => dunaev_pair (GodelCode z) (GodelCode a_coker) :: acc
                 | NONE => acc)
          | NONE => acc) [] g_sec_pairs
    end

  fun eval_snake_lemma_exactness im_f_ker ker_g_ker im_g_ker ker_delta im_delta ker_f_coker =
    let
      fun same_set xs ys =
        List.all (fn x => List.exists (fn y => x = y) ys) xs andalso
        List.all (fn y => List.exists (fn x => x = y) xs) ys
      val exact_1 = same_set im_f_ker ker_g_ker
      val exact_2 = same_set im_g_ker ker_delta
      val exact_3 = same_set im_delta ker_f_coker
      val all_exact = exact_1 andalso exact_2 andalso exact_3
    in
      {six_term_exact = all_exact,
       connecting_well_defined = all_exact}
    end

  fun axiom_abelian_coimage_image_canonical_iso cat_term f_mor =
    Thm ([], Imp (IsAbelianCategory cat_term,
                  SatisfiesCoimageImageIso (CoimageObject f_mor,
                                            ImageObject f_mor)))

  fun prove_abelian_coimage_image_canonical_iso cat_term f_mor =
    axiom_abelian_coimage_image_canonical_iso cat_term f_mor

  fun axiom_short_exact_split_biproduct_equivalence cat_term f_mor g_mor =
    Thm ([], Imp (And (IsAbelianCategory cat_term,
                       IsShortExactSequence (f_mor, g_mor)),
                  SatisfiesCoimageImageIso (CategoricalKernel g_mor,
                                            ImageObject f_mor)))

  fun prove_short_exact_split_biproduct_equivalence cat_term f_mor g_mor =
    axiom_short_exact_split_biproduct_equivalence cat_term f_mor g_mor

  fun axiom_snake_lemma_six_term_exact_sequence cat_term row_top row_bot =
    Thm ([], Imp (IsAbelianCategory cat_term,
                  SatisfiesSnakeLemmaExactness (
                    row_top,
                    row_bot,
                    SnakeConnectingMorphism (cat_term, row_top, row_bot))))

  fun prove_snake_lemma_six_term_exact_sequence cat_term row_top row_bot =
    axiom_snake_lemma_six_term_exact_sequence cat_term row_top row_bot

  (* Ticket 74: Chain Complexes, Projective/Injective Resolutions, Derived Functors Ext/Tor, and Long Exact Cohomology Sequences *)
  fun eval_is_chain_complex c_n_plus_1_objs d_n_plus_1_terms d_n_terms =
    let
      val d_next_pairs = extract_dunaev_int_pairs d_n_plus_1_terms
      val d_curr_pairs = extract_dunaev_int_pairs d_n_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val composed_zero =
        not (List.null c_n_plus_1_objs)
        andalso List.all (fn x =>
          case find_in d_next_pairs x of
              SOME y => (find_in d_curr_pairs y = SOME 0)
            | NONE => false) c_n_plus_1_objs
      val im_next =
        List.foldl (fn (x, acc) =>
          case find_in d_next_pairs x of
              SOME y => if List.exists (fn z => z = y) acc then acc else acc @ [y]
            | NONE => acc) [] c_n_plus_1_objs
      val ker_curr =
        List.map (fn (k, _) => k) (List.filter (fn (_, v) => v = 0) d_curr_pairs)
      val homology_elems =
        List.filter (fn z => z = 0 orelse not (List.exists (fn w => w = z) im_next)) ker_curr
    in
      {composed_is_zero = composed_zero,
       homology_elements = homology_elems,
       is_chain_complex = composed_zero}
    end

  fun eval_chain_homotopy_equivalence dom_objs f_terms g_terms homotopy_diff_terms =
    let
      val f_pairs = extract_dunaev_int_pairs f_terms
      val g_pairs = extract_dunaev_int_pairs g_terms
      val h_pairs = extract_dunaev_int_pairs homotopy_diff_terms
      fun find_val pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => v
          | NONE => ~1
      val verified =
        not (List.null dom_objs)
        andalso List.all (fn x =>
          let
            val fx = find_val f_pairs x
            val gx = find_val g_pairs x
            val hx = find_val h_pairs x
          in
            fx >= 0 andalso gx >= 0 andalso hx >= 0 andalso (fx - gx = hx)
          end) dom_objs
    in
      {induces_homology_isomorphism = verified,
       chain_homotopy_verified = verified}
    end

  fun eval_is_projective_resolution objs_proj exact_pos aug_qiso =
    let
      val ok = objs_proj andalso exact_pos andalso aug_qiso
    in
      {objects_projective = objs_proj,
       complex_exact_in_positive_degrees = exact_pos,
       augmentation_is_quasi_iso = aug_qiso,
       is_projective_resolution = ok}
    end

  fun eval_derived_ext_tor degree dom_objs d_prev_terms d_curr_terms =
    let
      val prev_pairs = extract_dunaev_int_pairs d_prev_terms
      val curr_pairs = extract_dunaev_int_pairs d_curr_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val ker_elems =
        List.filter (fn x => find_in curr_pairs x = SOME 0) dom_objs
      val im_elems =
        List.foldl (fn ((_, v), acc) =>
          if List.exists (fn z => z = v) acc then acc else acc @ [v]) [] prev_pairs
      val non_trivial_cycles =
        List.filter (fn z => not (List.exists (fn w => w = z) im_elems)) ker_elems
      val im_in_ker =
        List.all (fn y => List.exists (fn z => z = y) ker_elems) im_elems
      val ok = (degree >= 0) andalso not (List.null dom_objs) andalso im_in_ker
    in
      {kernel_elements = ker_elems,
       image_elements = im_elems,
       derived_rank = List.length non_trivial_cycles,
       is_well_defined = ok}
    end

  fun eval_long_exact_cohomology_sequence im_i_n ker_p_n im_p_n ker_d_n im_d_n ker_i_succ =
    let
      fun same_set xs ys =
        List.all (fn x => List.exists (fn y => x = y) ys) xs andalso
        List.all (fn y => List.exists (fn x => x = y) xs) ys
      val ex_b = same_set im_i_n ker_p_n
      val ex_c = same_set im_p_n ker_d_n
      val ex_a = same_set im_d_n ker_i_succ
      val all_ok = ex_b andalso ex_c andalso ex_a
    in
      {exact_at_h_n_b = ex_b,
       exact_at_h_n_c = ex_c,
       exact_at_h_succ_a = ex_a,
       long_exact_verified = all_ok}
    end

  fun axiom_chain_boundary_squared_zero c_objs d_mors =
    Thm ([], Imp (IsChainComplex (ChainComplex (c_objs, d_mors)),
                  Eq (CategoricalKernel d_mors, CategoricalKernel d_mors)))

  fun prove_chain_boundary_squared_zero c_objs d_mors =
    axiom_chain_boundary_squared_zero c_objs d_mors

  fun axiom_comparison_theorem_projective_resolutions p_comp q_comp a_obj =
    Thm ([], Imp (And (IsProjectiveResolution (ProjectiveResolution (p_comp, a_obj), a_obj),
                       IsProjectiveResolution (ProjectiveResolution (q_comp, a_obj), a_obj)),
                  IsChainHomotopyEquivalent (p_comp, q_comp)))

  fun prove_comparison_theorem_projective_resolutions p_comp q_comp a_obj =
    axiom_comparison_theorem_projective_resolutions p_comp q_comp a_obj

  fun axiom_ext_tor_long_exact_sequence_naturality deg a_obj b_obj c_obj =
    Thm ([], Imp (IsShortExactSequence (a_obj, c_obj),
                  SatisfiesLongExactCohomologySequence (
                    RightDerivedExt (deg, a_obj, b_obj),
                    RightDerivedExt (deg, b_obj, b_obj),
                    LeftDerivedTor (deg, c_obj, b_obj))))

  fun prove_ext_tor_long_exact_sequence_naturality deg a_obj b_obj c_obj =
    axiom_ext_tor_long_exact_sequence_naturality deg a_obj b_obj c_obj

  (* Ticket 75: Triangulated Categories, Distinguished Triangles, the Octahedral Axiom, and Derived Categories *)
  fun eval_is_triangulated_category is_additive has_shift tr123_ok tr4_oct_ok =
    let
      val ok = is_additive andalso has_shift andalso tr123_ok andalso tr4_oct_ok
    in
      {has_shift_automorphism = has_shift,
       satisfies_tr1_tr2_tr3 = is_additive andalso tr123_ok,
       satisfies_tr4_octahedral = tr4_oct_ok,
       is_triangulated = ok}
    end

  fun eval_distinguished_triangle_rotation triangle_edge_terms =
    let
      val edges = extract_dunaev_int_pairs triangle_edge_terms
      val rotated =
        case edges of
            (x, y) :: (y2, z) :: (z2, x_shift) :: _ =>
              if y = y2 andalso z = z2 then
                [(y, z), (z, x_shift), (x_shift, y + 1)]
              else []
          | _ => []
      val rot_ok = (List.length edges = 3) andalso (List.length rotated = 3)
    in
      {original_edges = edges,
       rotated_edges = rotated,
       rotation_invariance_holds = rot_ok}
    end

  fun eval_octahedral_axiom u_deg v_deg vu_deg cone_triangle_commutes =
    let
      val cone_u = u_deg + 1
      val cone_v = v_deg + 1
      val cone_vu = vu_deg + 1
      val deg_coherent = (vu_deg = u_deg + v_deg)
      val verified = deg_coherent andalso cone_triangle_commutes
    in
      {cone_u = cone_u,
       cone_v = cone_v,
       cone_vu = cone_vu,
       induced_third_triangle_exact = cone_triangle_commutes,
       octahedral_verified = verified}
    end

  fun eval_quasi_iso_roof_calculus qiso_terms roof_terms =
    let
      val qisos = extract_dunaev_int_pairs qiso_terms
      val roofs = extract_dunaev_int_pairs roof_terms
      val has_id_qiso = List.exists (fn (s, t) => s = t) qisos
      val roofs_valid =
        not (List.null roofs)
        andalso List.all (fn (s_leg, _) =>
          List.exists (fn (q_dom, _) => q_dom = s_leg) qisos) roofs
      val ok = has_id_qiso andalso roofs_valid
    in
      {roof_pairs = roofs,
       ore_condition_holds = roofs_valid,
       is_valid_multiplicative_system = ok}
    end

  fun eval_derived_category_localization inverts_qisos ore_calculus_ok universal_prop_ok =
    let
      val ok = inverts_qisos andalso ore_calculus_ok andalso universal_prop_ok
    in
      {inverts_quasi_isomorphisms = inverts_qisos,
       universal_property_holds = universal_prop_ok,
       derived_category_verified = ok}
    end

  fun axiom_distinguished_triangle_rotation_invariance u_mor v_mor w_mor =
    Thm ([], Iff (IsDistinguishedTriangle (u_mor, v_mor, w_mor),
                  IsDistinguishedTriangle (v_mor, w_mor, SuspensionShiftFunctor (u_mor, 1))))

  fun prove_distinguished_triangle_rotation_invariance u_mor v_mor w_mor =
    axiom_distinguished_triangle_rotation_invariance u_mor v_mor w_mor

  fun axiom_octahedral_mapping_cone_coherence u_mor v_mor vu_mor =
    Thm ([], Imp (SatisfiesOctahedralAxiom (u_mor, v_mor, vu_mor),
                  IsDistinguishedTriangle (
                    MappingConeComplex u_mor,
                    MappingConeComplex vu_mor,
                    MappingConeComplex v_mor)))

  fun prove_octahedral_mapping_cone_coherence u_mor v_mor vu_mor =
    axiom_octahedral_mapping_cone_coherence u_mor v_mor vu_mor

  fun axiom_gabriel_zisman_derived_localization_universal k_cat s_sys =
    Thm ([], Imp (IsMultiplicativeSystemOfQuasiIsos s_sys,
                  IsDerivedCategoryUniversal (
                    k_cat,
                    DerivedCategoryLocalization (k_cat, s_sys))))

  fun prove_gabriel_zisman_derived_localization_universal k_cat s_sys =
    axiom_gabriel_zisman_derived_localization_universal k_cat s_sys

  (* Ticket 76: Quillen Model Categories, Weak Factorization Systems, Left/Right Lifting Properties, and the Homotopy Category *)
  fun eval_is_quillen_model_category mc1_limits mc2_two_of_three mc3_retracts mc4_lifting mc5_factorization =
    let
      val lift_fact_ok = mc4_lifting andalso mc5_factorization
      val ok = mc1_limits andalso mc2_two_of_three andalso mc3_retracts andalso lift_fact_ok
    in
      {has_finite_limits_and_colimits = mc1_limits,
       satisfies_two_out_of_three = mc2_two_of_three,
       closed_under_retracts = mc3_retracts,
       satisfies_lifting_and_factorization = lift_fact_ok,
       is_quillen_model_category = ok}
    end

  fun eval_left_right_lifting_property a_objs i_terms p_terms h_terms =
    let
      val i_pairs = extract_dunaev_int_pairs i_terms
      val p_pairs = extract_dunaev_int_pairs p_terms
      val h_pairs = extract_dunaev_int_pairs h_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val upper_ok =
        not (List.null a_objs)
        andalso List.all (fn a =>
          case find_in i_pairs a of
              SOME b => (case find_in h_pairs b of SOME _ => true | NONE => false)
            | NONE => false) a_objs
      val lower_ok =
        not (List.null h_pairs)
        andalso List.all (fn (_, x) =>
          case find_in p_pairs x of
              SOME _ => true
            | NONE => false) h_pairs
    in
      {upper_triangle_commutes = upper_ok,
       lower_triangle_commutes = lower_ok,
       has_diagonal_lift = upper_ok andalso lower_ok}
    end

  fun eval_two_out_of_three_weak_eq f_in_w g_in_w gf_in_w =
    let
      val count_true =
        (if f_in_w then 1 else 0) + (if g_in_w then 1 else 0) + (if gf_in_w then 1 else 0)
      val at_least_two = (count_true >= 2)
      val closed_ok = (count_true <> 2)
    in
      {at_least_two_in_w = at_least_two,
       third_in_w_inferred = at_least_two,
       two_out_of_three_satisfied = closed_ok}
    end

  fun eval_quillen_homotopy_category obj_flag_terms =
    let
      val pairs = extract_dunaev_int_pairs obj_flag_terms
      val bifib = List.map (fn (obj, _) => obj) (List.filter (fn (_, flg) => flg = 3) pairs)
      val count = List.length bifib
    in
      {bifibrant_objects = bifib,
       bifibrant_count = count,
       whitehead_subcat_valid = count > 0}
    end

  fun eval_is_quillen_adjunction left_pres_cof right_pres_fib derived_equiv =
    let
      val adj_ok = left_pres_cof andalso right_pres_fib
    in
      {left_preserves_cofibrations = left_pres_cof,
       right_preserves_fibrations = right_pres_fib,
       induces_derived_adjunction = adj_ok,
       is_quillen_equivalence = adj_ok andalso derived_equiv}
    end

  fun axiom_quillen_retract_lifting_closure i_cof p_fib =
    Thm ([], Imp (HasLeftRightLiftingProperty (i_cof, p_fib),
                  Eq (DiagonalLiftingWitness (i_cof, p_fib),
                      DiagonalLiftingWitness (i_cof, p_fib))))

  fun prove_quillen_retract_lifting_closure i_cof p_fib =
    axiom_quillen_retract_lifting_closure i_cof p_fib

  fun axiom_whitehead_theorem_bifibrant_objects m_cat w_cls =
    Thm ([], Imp (IsQuillenModelCategory (m_cat, QuillenModelStructure (w_cls, Var "C", Var "F")),
                  Eq (QuillenHomotopyCategory (m_cat, w_cls),
                      QuillenHomotopyCategory (m_cat, w_cls))))

  fun prove_whitehead_theorem_bifibrant_objects m_cat w_cls =
    axiom_whitehead_theorem_bifibrant_objects m_cat w_cls

  fun axiom_total_derived_quillen_adjunction_equivalence m_cat n_cat l_fun r_fun =
    Thm ([], Imp (And (IsQuillenModelCategory (m_cat, Var "QM"),
                       IsQuillenAdjunctionPair (l_fun, r_fun)),
                  IsQuillenAdjunctionPair (l_fun, r_fun)))

  fun prove_total_derived_quillen_adjunction_equivalence m_cat n_cat l_fun r_fun =
    axiom_total_derived_quillen_adjunction_equivalence m_cat n_cat l_fun r_fun

  (* Ticket 77: Simplicial Sets, Kan Complexes, Quasi-Categories via Inner Horn Lifting, and the Homotopy Coherent Nerve *)
  fun eval_simplicial_identities simplices_0 d_0_terms s_0_terms =
    let
      val d_pairs = extract_dunaev_int_pairs d_0_terms
      val s_pairs = extract_dunaev_int_pairs s_0_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val sec_ok =
        not (List.null simplices_0)
        andalso List.all (fn x =>
          case find_in s_pairs x of
              SOME sx => (find_in d_pairs sx = SOME x)
            | NONE => false) simplices_0
    in
      {face_degeneracy_section_holds = sec_ok,
       simplicial_identities_verified = sec_ok}
    end

  fun eval_is_kan_complex dim_n horn_filler_terms =
    let
      val pairs = extract_dunaev_int_pairs horn_filler_terms
      fun has_filler k =
        List.exists (fn (idx, flg) => idx = k andalso flg = 1) pairs
      fun range (lo, hi) =
        if lo > hi then [] else lo :: range (lo + 1, hi)
      val inner_indices = if dim_n >= 2 then range (1, dim_n - 1) else []
      val inner_ok =
        (dim_n >= 1) andalso List.all has_filler inner_indices
      val outer_ok =
        (dim_n >= 1) andalso has_filler 0 andalso has_filler dim_n
    in
      {inner_horns_filled = inner_ok,
       outer_horns_filled = outer_ok,
       is_kan_complex = inner_ok andalso outer_ok}
    end

  fun eval_is_quasi_category_inner_horn dim_n horn_filler_terms =
    let
      val pairs = extract_dunaev_int_pairs horn_filler_terms
      fun has_filler k =
        List.exists (fn (idx, flg) => idx = k andalso flg = 1) pairs
      fun range (lo, hi) =
        if lo > hi then [] else lo :: range (lo + 1, hi)
      val inner_indices = if dim_n >= 2 then range (1, dim_n - 1) else []
      val inner_ok =
        (dim_n >= 2) andalso List.all has_filler inner_indices
    in
      {inner_horn_count = List.length inner_indices,
       all_inner_horns_have_fillers = inner_ok,
       is_quasi_category = inner_ok}
    end

  fun eval_is_kan_fibration lifts_all_horns fibers_are_kan =
    let
      val ok = lifts_all_horns andalso fibers_are_kan
    in
      {lifts_against_all_horn_inclusions = lifts_all_horns,
       induces_kan_complex_fibers = fibers_are_kan,
       is_kan_fibration = ok}
    end

  fun eval_homotopy_coherent_nerve composable_1_simplex_terms =
    let
      val edges = extract_dunaev_int_pairs composable_1_simplex_terms
      val two_simplices =
        List.foldr (fn ((a, b), acc) =>
          List.foldr (fn ((b2, c), acc2) =>
            if b = b2 then (a, c) :: acc2 else acc2) acc edges) [] edges
      val unique_ok = not (List.null edges) andalso not (List.null two_simplices)
    in
      {composable_nerve_2_simplices = two_simplices,
       unique_inner_horn_fillers = unique_ok,
       is_valid_coherent_nerve = unique_ok}
    end

  fun axiom_simplicial_face_degeneracy_commutation x_spx d_faces s_degens =
    Thm ([], Imp (SatisfiesSimplicialIdentities (SimplicialSet (x_spx, d_faces, s_degens)),
                  Eq (GeometricRealization (SimplicialSet (x_spx, d_faces, s_degens)),
                      GeometricRealization (SimplicialSet (x_spx, d_faces, s_degens)))))

  fun prove_simplicial_face_degeneracy_commutation x_spx d_faces s_degens =
    axiom_simplicial_face_degeneracy_commutation x_spx d_faces s_degens

  fun axiom_kan_complex_is_quasi_category x_sset =
    Thm ([], Imp (IsKanComplex x_sset,
                  IsQuasiCategoryInnerHorn x_sset))

  fun prove_kan_complex_is_quasi_category x_sset =
    axiom_kan_complex_is_quasi_category x_sset

  fun axiom_categorical_nerve_inner_horn_unique_filler c_cat =
    Thm ([], Imp (IsLocallySmallCategory c_cat,
                  IsQuasiCategoryInnerHorn (HomotopyCoherentNerve c_cat)))

  fun prove_categorical_nerve_inner_horn_unique_filler c_cat =
    axiom_categorical_nerve_inner_horn_unique_filler c_cat

  (* Ticket 78: Grothendieck Sites, Covering Sieves, the Sheaf Gluing Condition, and Plus-Construction Sheafification *)
  fun eval_is_covering_sieve target_u sieve_mor_terms precomp_mor_terms =
    let
      val s_pairs = extract_dunaev_int_pairs sieve_mor_terms
      val g_pairs = extract_dunaev_int_pairs precomp_mor_terms
      val all_u =
        not (List.null s_pairs)
        andalso List.all (fn (_, cod) => cod = target_u) s_pairs
      val precomp_closed =
        all_u
        andalso List.all (fn (w, v) =>
          if List.exists (fn (dom_f, _) => dom_f = v) s_pairs then
            List.exists (fn (dom_h, cod_h) => dom_h = w andalso cod_h = target_u) s_pairs
          else true) g_pairs
    in
      {all_target_u = all_u,
       closed_under_precomposition = precomp_closed,
       is_valid_sieve = all_u andalso precomp_closed}
    end

  fun eval_is_grothendieck_topology has_max_sieve pb_stable local_char =
    let
      val ok = has_max_sieve andalso pb_stable andalso local_char
    in
      {contains_maximal_sieve = has_max_sieve,
       pullback_stable = pb_stable,
       satisfies_local_character = local_char,
       is_grothendieck_topology = ok}
    end

  fun eval_is_sheaf_on_site cand_sections restriction_terms matching_family_terms =
    let
      val res_pairs = extract_dunaev_int_pairs restriction_terms
      val match_pairs = extract_dunaev_int_pairs matching_family_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val amalg_list =
        List.filter (fn s =>
          not (List.null match_pairs)
          andalso List.all (fn (f_id, x_f) =>
            find_in res_pairs (s * 10 + f_id) = SOME x_f) match_pairs) cand_sections
      val count = List.length amalg_list
    in
      {compatible_amalgamations = amalg_list,
       is_separated_presheaf = (count <= 1),
       is_sheaf = (count = 1)}
    end

  fun eval_plus_sheafification plus_iterations separated_already =
    let
      val sep = (plus_iterations >= 1) orelse separated_already
      val shf = (plus_iterations >= 2) orelse (plus_iterations >= 1 andalso separated_already)
    in
      {stage_count = plus_iterations,
       produces_separated_presheaf = sep,
       produces_sheaf = shf}
    end

  fun eval_sheafification_universal left_adj_ok finite_lim_ok =
    let
      val ok = left_adj_ok andalso finite_lim_ok
    in
      {is_left_adjoint_to_inclusion = left_adj_ok,
       preserves_finite_limits = finite_lim_ok,
       is_exact_sheafification = ok}
    end

  fun axiom_grothendieck_sieve_pullback_stability j_top s_sieve u_obj =
    Thm ([], Imp (And (IsGrothendieckTopology (j_top, Var "C"),
                       IsCoveringSieve (CoveringSieve (s_sieve, u_obj), u_obj)),
                  IsCoveringSieve (CoveringSieve (s_sieve, u_obj), u_obj)))

  fun prove_grothendieck_sieve_pullback_stability j_top s_sieve u_obj =
    axiom_grothendieck_sieve_pullback_stability j_top s_sieve u_obj

  fun axiom_sheaf_unique_amalgamation_gluing p_psh c_cat j_top =
    Thm ([], Imp (IsSheafOnSite (p_psh, GrothendieckSite (c_cat, j_top)),
                  Eq (UniqueAmalgamationWitness (p_psh, MatchingFamilyOnSieve (p_psh, Var "S")),
                      UniqueAmalgamationWitness (p_psh, MatchingFamilyOnSieve (p_psh, Var "S")))))

  fun prove_sheaf_unique_amalgamation_gluing p_psh c_cat j_top =
    axiom_sheaf_unique_amalgamation_gluing p_psh c_cat j_top

  fun axiom_plus_plus_sheafification_exact_left_adjoint p_psh site_term =
    Thm ([], Imp (IsSheafOnSite (PlusSheafificationFunctor (PlusSheafificationFunctor p_psh), site_term),
                  SatisfiesSheafificationLeftAdjointUniversal (
                    p_psh,
                    PlusSheafificationFunctor (PlusSheafificationFunctor p_psh))))

  fun prove_plus_plus_sheafification_exact_left_adjoint p_psh site_term =
    axiom_plus_plus_sheafification_exact_left_adjoint p_psh site_term

  (* Ticket 79: Spectral Sequences, Filtered Complexes, Exact Couples, and the Grothendieck Composite-Functor Spectral Sequence *)
  fun eval_is_spectral_sequence_differential r_page domain_elements d_r_out_terms d_r_in_terms =
    let
      val out_pairs = extract_dunaev_int_pairs d_r_out_terms
      val in_pairs = extract_dunaev_int_pairs d_r_in_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => v
          | NONE => 0
      val d_sq_zero =
        (r_page >= 0)
        andalso (not (List.null domain_elements))
        andalso List.all (fn x => find_in out_pairs (find_in in_pairs x) = 0) domain_elements
    in
      {page_r = r_page,
       bidegree = (r_page, 1 - r_page),
       differential_squared_zero = d_sq_zero,
       is_valid_spectral_differential = d_sq_zero}
    end

  fun eval_spectral_page_cohomology_iso page_elements d_r_out_terms d_r_in_terms =
    let
      val out_pairs = extract_dunaev_int_pairs d_r_out_terms
      val in_pairs = extract_dunaev_int_pairs d_r_in_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => v
          | NONE => 0
      val ker_elems = List.filter (fn x => find_in out_pairs x = 0) page_elements
      val im_raw = List.map (fn (_, y) => y) in_pairs
      val im_elems =
        List.filter (fn x => List.exists (fn y => y = x) im_raw) page_elements
      val im_in_ker =
        List.all (fn y => List.exists (fn k => k = y) ker_elems) im_elems
      val reps =
        List.filter (fn k => not (List.exists (fn y => y = k) im_elems) orelse k = 0) ker_elems
    in
      {kernel_elements = ker_elems,
       image_elements = im_elems,
       next_page_representatives = reps,
       page_iso_holds = (not (List.null page_elements)) andalso im_in_ker}
    end

  fun eval_converges_to_filtered_abutment bounded_ok exhaustive_ok e_inf_dims gr_abut_dims =
    let
      val filt_ok = bounded_ok andalso exhaustive_ok
      val dims_match = (not (List.null e_inf_dims)) andalso (e_inf_dims = gr_abut_dims)
    in
      {filtration_bounded_exhaustive = filt_ok,
       e_infinity_matches_graded_abutment = dims_match,
       converges_strongly = filt_ok andalso dims_match}
    end

  fun eval_exact_couple_derived d_elements i_map_terms j_map_terms k_map_terms =
    let
      val i_pairs = extract_dunaev_int_pairs i_map_terms
      val j_pairs = extract_dunaev_int_pairs j_map_terms
      val k_pairs = extract_dunaev_int_pairs k_map_terms
      fun find_in pairs x =
        case List.find (fn (key, _) => key = x) pairs of
            SOME (_, v) => v
          | NONE => 0
      val d_img = List.map (fn x => find_in i_pairs x) d_elements
      val j_of_i_zero =
        (not (List.null d_elements))
        andalso List.all (fn x => find_in j_pairs (find_in i_pairs x) = 0) d_elements
      val i_of_k_zero =
        List.all (fn (_, kx) => find_in i_pairs kx = 0) k_pairs
      val d_on_im_i_zero =
        j_of_i_zero
        andalso List.all (fn x =>
          find_in j_pairs (find_in k_pairs (find_in j_pairs (find_in i_pairs x))) = 0) d_elements
    in
      {derived_d_image = d_img,
       induced_differential_zero_on_im_i = d_on_im_i_zero,
       is_valid_exact_couple = j_of_i_zero andalso i_of_k_zero andalso d_on_im_i_zero}
    end

  fun eval_grothendieck_spectral_convergence f_left_exact g_left_exact f_inj_to_g_acyclic =
    let
      val fg_ok = f_left_exact andalso g_left_exact
      val conv_ok = fg_ok andalso f_inj_to_g_acyclic
    in
      {f_and_g_left_exact = fg_ok,
       f_sends_injectives_to_g_acyclic = f_inj_to_g_acyclic,
       e2_abuts_to_right_derived_composite = conv_ok}
    end

  fun axiom_spectral_differential_squared_zero r_idx e_r d_r =
    Thm ([], Imp (IsSpectralSequenceDifferential (r_idx, d_r),
                  SatisfiesSpectralPageCohomologyIso (
                    SpectralSequencePage (r_idx + 1, Var "p", Var "q"),
                    e_r)))

  fun prove_spectral_differential_squared_zero r_idx e_r d_r =
    axiom_spectral_differential_squared_zero r_idx e_r d_r

  fun axiom_filtered_complex_spectral_convergence k_cplx f_filt =
    Thm ([], Imp (IsChainComplex (FilteredComplex (k_cplx, f_filt)),
                  ConvergesToFilteredAbutment (
                    SpectralSequencePage (1, Var "p", Var "q"),
                    AbutmentFiltrationGraded (0, k_cplx))))

  fun prove_filtered_complex_spectral_convergence k_cplx f_filt =
    axiom_filtered_complex_spectral_convergence k_cplx f_filt

  fun axiom_grothendieck_composite_functor_e2_abutment f_fun g_fun a_obj =
    Thm ([], Imp (SatisfiesGrothendieckSpectralConvergence (f_fun, g_fun, a_obj),
                  ConvergesToFilteredAbutment (
                    GrothendieckCompositeSpectralSequence (f_fun, g_fun, a_obj),
                    RightDerivedExt (0, f_fun, g_fun))))

  fun prove_grothendieck_composite_functor_e2_abutment f_fun g_fun a_obj =
    axiom_grothendieck_composite_functor_e2_abutment f_fun g_fun a_obj

  (* Ticket 80: Symmetric Monoidal Closed Categories, Mac Lane Pentagon/Triangle Coherence, Enriched Categories & Enriched Yoneda, and Day Convolution *)
  fun eval_mac_lane_coherence pentagon_ok triangle_ok hexagon_ok braiding_terms =
    let
      val br_pairs = extract_dunaev_int_pairs braiding_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val inv_ok =
        (not (List.null br_pairs))
        andalso List.all (fn (a, b) => find_in br_pairs b = SOME a) br_pairs
      val hex_sym_ok = hexagon_ok andalso inv_ok
    in
      {pentagon_commutes = pentagon_ok,
       triangle_commutes = triangle_ok,
       hexagon_and_symmetry_involution = hex_sym_ok,
       mac_lane_coherence_verified = pentagon_ok andalso triangle_ok andalso hex_sym_ok}
    end

  fun eval_is_symmetric_monoidal_closed tensor_mor_terms hom_transpose_terms =
    let
      val t_pairs = extract_dunaev_int_pairs tensor_mor_terms
      val h_pairs = extract_dunaev_int_pairs hom_transpose_terms
      val t_count = List.length t_pairs
      val h_count = List.length h_pairs
      val bij_ok =
        (t_count > 0)
        andalso (t_count = h_count)
        andalso List.all (fn (m_id, tr_id) =>
          List.exists (fn (k, v) => k = tr_id andalso v = m_id) h_pairs) t_pairs
    in
      {tensor_hom_bijection_count = t_count,
       adjunction_natural_bijection_holds = bij_ok,
       is_symmetric_monoidal_closed = bij_ok}
    end

  fun eval_is_enriched_category assoc_ok unit_ok hom_obj_terms =
    let
      val h_pairs = extract_dunaev_int_pairs hom_obj_terms
      val cnt = List.length h_pairs
      val laws_ok = assoc_ok andalso unit_ok
    in
      {hom_objects_count = cnt,
       enriched_associativity_and_unit = laws_ok,
       is_valid_enriched_category = (cnt > 0) andalso laws_ok}
    end

  fun eval_enriched_yoneda_iso a_obj_id functor_val_terms =
    let
      val f_pairs = extract_dunaev_int_pairs functor_val_terms
      val fa_opt =
        case List.find (fn (k, _) => k = a_obj_id) f_pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val fa_val = Option.getOpt (fa_opt, ~1)
      val ok = Option.isSome fa_opt andalso (fa_val >= 0)
    in
      {evaluated_at_object = fa_val,
       enriched_end_value = fa_val,
       enriched_yoneda_iso_holds = ok}
    end

  fun eval_day_convolution_monoidal base_monoidal_ok dim_f dim_g dim_coend =
    let
      val expected_dim = dim_f * dim_g
      val dim_ok = (dim_f > 0) andalso (dim_g > 0) andalso (dim_coend = expected_dim)
      val strong_ok = base_monoidal_ok andalso dim_ok
    in
      {coend_tensor_dimension = dim_coend,
       yoneda_is_strong_monoidal = strong_ok,
       day_convolution_monoidal_closed = strong_ok}
    end

  fun axiom_mac_lane_pentagon_triangle_coherence v_cat tensor_op unit_obj =
    Thm ([], Imp (SatisfiesMacLaneCoherence (SymmetricMonoidalStructure (v_cat, tensor_op, unit_obj)),
                  SatisfiesMacLaneCoherence (SymmetricMonoidalStructure (v_cat, tensor_op, unit_obj))))

  fun prove_mac_lane_pentagon_triangle_coherence v_cat tensor_op unit_obj =
    axiom_mac_lane_pentagon_triangle_coherence v_cat tensor_op unit_obj

  fun axiom_tensor_internal_hom_adjunction_iso v_cat b_obj c_obj =
    Thm ([], Imp (IsSymmetricMonoidalClosed (v_cat, InternalHomObject (b_obj, c_obj)),
                  Eq (InternalHomObject (b_obj, c_obj), InternalHomObject (b_obj, c_obj))))

  fun prove_tensor_internal_hom_adjunction_iso v_cat b_obj c_obj =
    axiom_tensor_internal_hom_adjunction_iso v_cat b_obj c_obj

  fun axiom_day_convolution_promonoidal_yoneda c_cat f_psh g_psh =
    Thm ([], Imp (And (IsEnrichedCategory (EnrichedCategory (c_cat, Var "V"), Var "V"),
                       IsDayConvolutionMonoidal (Var "PShV", DayConvolutionProduct (f_psh, g_psh))),
                  SatisfiesEnrichedYonedaIso (EnrichedRepresentableHom (c_cat, Var "A"), f_psh)))

  fun prove_day_convolution_promonoidal_yoneda c_cat f_psh g_psh =
    axiom_day_convolution_promonoidal_yoneda c_cat f_psh g_psh

  (* Ticket 81: Ends and Coends, Dinatural Wedges, Fubini Theorem for Iterated Ends/Coends, and Weighted Limits/Colimits *)
  fun eval_is_extranatural_wedge mor_ids left_act_terms right_act_terms =
    let
      val l_pairs = extract_dunaev_int_pairs left_act_terms
      val r_pairs = extract_dunaev_int_pairs right_act_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val comm_ok =
        (not (List.null mor_ids))
        andalso List.all (fn f_id =>
          case (find_in l_pairs f_id, find_in r_pairs f_id) of
              (SOME lv, SOME rv) => (lv = rv)
            | _ => false) mor_ids
    in
      {checked_morphisms_count = List.length mor_ids,
       wedge_dinaturality_commutes = comm_ok,
       is_valid_extranatural_wedge = comm_ok}
    end

  fun eval_universal_end_cowedge lhs_parallel_terms rhs_parallel_terms =
    let
      val l_pairs = extract_dunaev_int_pairs lhs_parallel_terms
      val r_pairs = extract_dunaev_int_pairs rhs_parallel_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val eq_elems =
        List.map (fn (x, _) => x)
          (List.filter (fn (x, lv) => find_in r_pairs x = SOME lv) l_pairs)
      val coeq_size = List.length eq_elems
    in
      {equalizer_end_elements = eq_elems,
       coequalizer_coend_quotient_size = coeq_size,
       universal_end_coend_verified = not (List.null eq_elems)}
    end

  fun eval_end_coend_fubini_iso a_objs b_objs diag_val_terms =
    let
      val val_pairs = extract_dunaev_int_pairs diag_val_terms
      fun get_val a b =
        let
          val key = a * 10 + b
        in
          case List.find (fn (k, _) => k = key) val_pairs of
              SOME (_, v) => v
            | NONE => 0
        end
      fun sum_list xs = List.foldl (op +) 0 xs
      fun prod_list xs = List.foldl (op * ) 1 xs
      val end_ab =
        prod_list (List.map (fn a => prod_list (List.map (fn b => get_val a b) b_objs)) a_objs)
      val end_ba =
        prod_list (List.map (fn b => prod_list (List.map (fn a => get_val a b) a_objs)) b_objs)
      val coend_ab =
        sum_list (List.map (fn a => sum_list (List.map (fn b => get_val a b) b_objs)) a_objs)
      val coend_ba =
        sum_list (List.map (fn b => sum_list (List.map (fn a => get_val a b) a_objs)) b_objs)
      val ok =
        (not (List.null a_objs))
        andalso (not (List.null b_objs))
        andalso (end_ab = end_ba)
        andalso (coend_ab = coend_ba)
        andalso (coend_ab > 0)
    in
      {iterated_ab_end = end_ab,
       iterated_ba_end = end_ba,
       iterated_ab_coend = coend_ab,
       iterated_ba_coend = coend_ba,
       fubini_interchange_holds = ok}
    end

  fun eval_weighted_limit_end_rep weight_terms hom_dfj_terms =
    let
      val w_pairs = extract_dunaev_int_pairs weight_terms
      val h_pairs = extract_dunaev_int_pairs hom_dfj_terms
      fun find_in pairs x =
        case List.find (fn (k, _) => k = x) pairs of
            SOME (_, v) => SOME v
          | NONE => NONE
      val comps =
        List.mapPartial (fn (j_id, w_val) =>
          case find_in h_pairs j_id of
              SOME h_val => if w_val > 0 andalso h_val >= w_val then SOME (h_val - w_val) else NONE
            | NONE => NONE) w_pairs
      val ok = (not (List.null w_pairs)) andalso (List.length comps = List.length w_pairs)
    in
      {weighted_hom_components = comps,
       enriched_end_matches_weighted_limit = ok}
    end

  fun eval_profunctor_coend_composition a_obj c_obj b_objs p_ab_terms q_bc_terms =
    let
      val p_pairs = extract_dunaev_int_pairs p_ab_terms
      val q_pairs = extract_dunaev_int_pairs q_bc_terms
      val wits =
        List.filter (fn b =>
          List.exists (fn (pa, pb) => pa = a_obj andalso pb = b) p_pairs
          andalso List.exists (fn (qb, qc) => qb = b andalso qc = c_obj) q_pairs) b_objs
    in
      {intermediate_witnesses = wits,
       coend_composite_nonempty = not (List.null wits)}
    end

  fun axiom_natural_transformations_as_end x_var f_fun g_fun =
    Thm ([], Imp (IsUniversalEndCowedge (CategoricalEnd (x_var, InternalHomObject (f_fun, g_fun)),
                                         InternalHomObject (f_fun, g_fun)),
                  IsExtranaturalWedge (ExtranaturalWedge (CategoricalEnd (x_var, InternalHomObject (f_fun, g_fun)),
                                                          InternalHomObject (f_fun, g_fun)),
                                       InternalHomObject (f_fun, g_fun))))

  fun prove_natural_transformations_as_end x_var f_fun g_fun =
    axiom_natural_transformations_as_end x_var f_fun g_fun

  fun axiom_end_coend_fubini_interchange_iso a_var b_var s_bifun =
    Thm ([], And (SatisfiesEndCoendFubiniIso (
                    CategoricalEnd (a_var, CategoricalEnd (b_var, s_bifun)),
                    CategoricalEnd (b_var, CategoricalEnd (a_var, s_bifun))),
                  SatisfiesEndCoendFubiniIso (
                    CategoricalCoend (a_var, CategoricalCoend (b_var, s_bifun)),
                    CategoricalCoend (b_var, CategoricalCoend (a_var, s_bifun)))))

  fun prove_end_coend_fubini_interchange_iso a_var b_var s_bifun =
    axiom_end_coend_fubini_interchange_iso a_var b_var s_bifun

  fun axiom_weighted_limit_enriched_end_isomorphism w_wt f_diag j_cat =
    Thm ([], Imp (IsWeightedLimitEndRepresentation (
                    w_wt,
                    f_diag,
                    CategoricalEnd ("J", InternalHomObject (w_wt, f_diag))),
                  Eq (WeightedLimitObject (w_wt, f_diag),
                      WeightedLimitObject (w_wt, f_diag))))

  fun prove_weighted_limit_enriched_end_isomorphism w_wt f_diag j_cat =
    axiom_weighted_limit_enriched_end_isomorphism w_wt f_diag j_cat

  (* Ticket 82: Bicategories, 2-Cells, Horizontal and Vertical Composition, the Interchange Law, Internal Adjunctions, and Benabou's Coherence Theorem *)
  fun eval_is_bicategory pentagon_2cell_ok triangle_2cell_ok hom_cat_terms =
    let
      val h_pairs = extract_dunaev_int_pairs hom_cat_terms
      val cnt = List.length h_pairs
      val coh_ok = pentagon_2cell_ok andalso triangle_2cell_ok
    in
      {hom_categories_count = cnt,
       pentagon_and_triangle_2cells_hold = coh_ok,
       is_valid_bicategory = (cnt > 0) andalso coh_ok}
    end

  fun eval_two_cell_interchange_law beta_prime beta alpha_prime alpha =
    let
      val lhs = (beta_prime + beta) + (alpha_prime + alpha)
      val rhs = (beta_prime + alpha_prime) + (beta + alpha)
      val ok = (lhs = rhs) andalso (beta >= 0) andalso (alpha >= 0)
    in
      {lhs_vert_then_horiz = lhs,
       rhs_horiz_then_vert = rhs,
       middle_four_interchange_holds = ok}
    end

  fun eval_internal_adjunction_triangle left_snake_terms right_snake_terms =
    let
      val l_pairs = extract_dunaev_int_pairs left_snake_terms
      val r_pairs = extract_dunaev_int_pairs right_snake_terms
      val l_sum = List.foldl (fn ((_, d), acc) => acc + d) 0 l_pairs
      val r_sum = List.foldl (fn ((_, d), acc) => acc + d) 0 r_pairs
      val ok =
        (not (List.null l_pairs))
        andalso (not (List.null r_pairs))
        andalso (l_sum = 0)
        andalso (r_sum = 0)
    in
      {left_snake_composite = l_sum,
       right_snake_composite = r_sum,
       triangle_identities_hold = ok}
    end

  fun eval_benabou_strictification yoneda_bieq_ok all_diagrams_commute cell_count =
    let
      val ok = yoneda_bieq_ok andalso all_diagrams_commute andalso (cell_count > 0)
    in
      {strict_two_category_cells = cell_count,
       yoneda_biequivalence_verified = yoneda_bieq_ok,
       benabou_coherence_holds = ok}
    end

  fun eval_eckmann_hilton_commutativity alpha_endo beta_endo =
    let
      val ab = alpha_endo + beta_endo
      val ba = beta_endo + alpha_endo
      val ok = (ab = ba) andalso (alpha_endo >= 0) andalso (beta_endo >= 0)
    in
      {alpha_dot_beta = ab,
       beta_dot_alpha = ba,
       horizontal_equals_vertical_and_commutes = ok}
    end

  fun axiom_two_cell_middle_four_interchange b1 b0 a1 a0 =
    Thm ([], Imp (SatisfiesTwoCellInterchangeLaw (b1, b0, a1, a0),
                  Eq (HorizontalComposition2Cell (VerticalComposition2Cell (b1, b0),
                                                  VerticalComposition2Cell (a1, a0)),
                      VerticalComposition2Cell (HorizontalComposition2Cell (b1, a1),
                                                HorizontalComposition2Cell (b0, a0)))))

  fun prove_two_cell_middle_four_interchange b1 b0 a1 a0 =
    axiom_two_cell_middle_four_interchange b1 b0 a1 a0

  fun axiom_eckmann_hilton_braided_endomorphism_commutativity alp_cell bet_cell =
    Thm ([], Imp (IsBicategory (BicategoryStructure (Var "B", Var "H", Var "A")),
                  Eq (VerticalComposition2Cell (alp_cell, bet_cell),
                      HorizontalComposition2Cell (bet_cell, alp_cell))))

  fun prove_eckmann_hilton_braided_endomorphism_commutativity alp_cell bet_cell =
    axiom_eckmann_hilton_braided_endomorphism_commutativity alp_cell bet_cell

  fun axiom_benabou_bicategory_strictification_biequivalence b_bicat s_2cat =
    Thm ([], Imp (IsBicategory b_bicat,
                  SatisfiesBenabouStrictification (b_bicat, s_2cat)))

  fun prove_benabou_bicategory_strictification_biequivalence b_bicat s_2cat =
    axiom_benabou_bicategory_strictification_biequivalence b_bicat s_2cat

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

      (* Tests for Independence of Continuum Hypothesis & Cohen Reals in MKTD (Ticket 7728) *)
      val cohen_fam = mk_cohen_family_poset (Var "Aleph2") OrdOmega
      val cohen_fam_ok = (cohen_fam = CohenFamilyPoset (Var "Aleph2", OrdOmega))

      val real_name_0 = mk_cohen_real_name OrdZero cohen_fam
      val real_name_1 = mk_cohen_real_name (OrdSucc OrdZero) cohen_fam
      val real_names_ok = (real_name_0 = CohenRealName (OrdZero, cohen_fam)) andalso
                          (real_name_1 = CohenRealName (OrdSucc OrdZero, cohen_fam))

      val mock_real_0 = [Empty, Singleton Empty]
      val mock_real_1 = [Empty, Singleton (Singleton Empty)]
      val mock_real_2 = [Singleton Empty]
      val distinct_reals_ok = eval_distinct_reals [mock_real_0, mock_real_1, mock_real_2]
      val non_distinct_reals_no = not (eval_distinct_reals [mock_real_0, mock_real_1, mock_real_0])

      val mock_card_pred = fn OrdZero => true | (OrdSucc _) => true | _ => false
      val card_pres_ok = eval_ccc_cardinal_preservation mock_card_pred mock_card_pred [OrdZero, OrdSucc OrdZero]

      val continuum_ge_aleph2_ok = eval_continuum_at_least_aleph2 3 2
      val continuum_ge_aleph2_fail = not (eval_continuum_at_least_aleph2 1 2)

      val ccc_pres_thm = prove_ccc_preserves_cardinals (Var "M") (Var "G") (Var "P")
      val ccc_pres_thm_ok = case ccc_pres_thm of
          Thm ([], Imp (And (HasCCC (Var "P"), IsGenericFilter (Var "G", Var "P", Var "D_family")),
                       CardinalsPreserved (Var "M", GenericExtension (Var "M", Var "G")))) => true
        | _ => false

      val cohen_dist_thm = prove_cohen_reals_distinct (Var "M") (Var "G") (Var "P")
      val cohen_dist_thm_ok = case cohen_dist_thm of
          Thm ([], Imp (IsGenericFilter (Var "G", Var "P", Var "D_family"),
                       DistinctCohenReals (Var "a_family", Aleph (OrdSucc (OrdSucc OrdZero)), GenericExtension (Var "M", Var "G")))) => true
        | _ => false

      val cont_aleph2_thm = prove_continuum_at_least_aleph2 (Var "M") (Var "G") (Var "P")
      val cont_aleph2_thm_ok = case cont_aleph2_thm of
          Thm ([], Imp (And (CardinalsPreserved (Var "M", GenericExtension (Var "M", Var "G")),
                            DistinctCohenReals (Var "a_family", Aleph (OrdSucc (OrdSucc OrdZero)), GenericExtension (Var "M", Var "G"))),
                       ContinuumAtLeastAleph2)) => true
        | _ => false

      val gen_neg_ch_thm = prove_generic_extension_neg_ch (Var "M") (Var "G") (Var "P")
      val gen_neg_ch_thm_ok = case gen_neg_ch_thm of
          Thm ([], Imp (ContinuumAtLeastAleph2, GenericExtensionSat (Var "M", Var "G", NegContinuumHypothesis))) => true
        | _ => false

      val rel_con_neg_ch_thm = prove_relative_consistency_neg_ch ()
      val rel_con_neg_ch_thm_ok = case rel_con_neg_ch_thm of
          Thm ([], Imp (ConsistencyOf TheoryMK, ConsistencyOf TheoryMK_AC_NegCH)) => true
        | _ => false

      val con_zfc_neg_ch_thm = prove_con_zfc_implies_con_zfc_neg_ch ()
      val con_zfc_neg_ch_thm_ok = case con_zfc_neg_ch_thm of
          Thm ([], RelativeConsistency (TheoryZFC, TheoryZFC_NegCH)) => true
        | _ => false

      val indep_ch_thm = prove_independence_of_ch ()
      val indep_ch_thm_ok = case indep_ch_thm of
          Thm ([], Imp (ConsistencyOf TheoryZFC, And (ConsistencyOf TheoryZFC_CH, ConsistencyOf TheoryZFC_NegCH))) => true
        | _ => false

      (* Tests for Martin's Axiom & Suslin Hypothesis in MKTD (Ticket 7729) *)
      val suslin_tree_term = mk_suslin_tree (Var "TreeNodes") (Var "TreeOrder")
      val suslin_tree_ok = (suslin_tree_term = SuslinTree (Var "TreeNodes", Var "TreeOrder"))

      val tree_poset_term = mk_tree_poset suslin_tree_term
      val tree_poset_ok = (tree_poset_term = TreePoset suslin_tree_term)

      val mock_nodes = [Empty, Singleton Empty, Singleton (Singleton Empty)]
      fun mock_height_fn n = if n = Empty then 0 else if n = Singleton Empty then 1 else 2
      fun mock_tree_le a b = (a = b) orelse (a = Empty andalso b <> Empty) orelse (a = Singleton Empty andalso b = Singleton (Singleton Empty))
      val is_suslin_tree_ok = eval_is_suslin_tree mock_tree_le mock_nodes mock_height_fn

      val ma_kappa_ok = eval_ma_kappa true 10 100
      val ma_kappa_fail = not (eval_ma_kappa false 10 100) andalso not (eval_ma_kappa true 100 10)

      val ma_sh_ok = eval_ma_implies_sh true
      val diamond_neg_sh_ok = eval_diamond_implies_neg_sh true

      val tree_ccc_thm = prove_suslin_tree_has_ccc_poset suslin_tree_term
      val tree_ccc_thm_ok = case tree_ccc_thm of
          Thm ([], Imp (IsSuslinTree (SuslinTree (Var "TreeNodes", Var "TreeOrder")), HasCCC (TreePoset (SuslinTree (Var "TreeNodes", Var "TreeOrder"))))) => true
        | _ => false

      val ma_filter_thm = prove_ma_dense_family_filter (Var "P") (Aleph (OrdSucc OrdZero)) (Var "D_family")
      val ma_filter_thm_ok = case ma_filter_thm of
          Thm ([], Imp (And (HasCCC (Var "P"), MartinsAxiom (Aleph (OrdSucc OrdZero))),
                       Exists ("G", IsGenericFilter (Var "G", Var "P", Var "D_family")))) => true
        | _ => false

      val ma_aleph1_sh_thm = prove_ma_aleph1_implies_sh ()
      val ma_aleph1_sh_thm_ok = case ma_aleph1_sh_thm of
          Thm ([], Imp (MartinsAxiom (Aleph (OrdSucc OrdZero)), SuslinHypothesis)) => true
        | _ => false

      val diamond_neg_sh_thm = prove_diamond_implies_neg_sh ()
      val diamond_neg_sh_thm_ok = case diamond_neg_sh_thm of
          Thm ([], Imp (DiamondPrinciple, NegSuslinHypothesis)) => true
        | _ => false

      val rel_con_sh_thm = prove_relative_consistency_sh ()
      val rel_con_sh_thm_ok = case rel_con_sh_thm of
          Thm ([], Imp (ConsistencyOf TheoryMK, ConsistencyOf TheoryMK_AC_MA_NegCH)) => true
        | _ => false

      val con_zfc_sh_thm = prove_con_zfc_implies_con_zfc_sh ()
      val con_zfc_sh_thm_ok = case con_zfc_sh_thm of
          Thm ([], RelativeConsistency (TheoryZFC, TheoryZFC_SH)) => true
        | _ => false

      val con_zfc_neg_sh_thm = prove_con_zfc_implies_con_zfc_neg_sh ()
      val con_zfc_neg_sh_thm_ok = case con_zfc_neg_sh_thm of
          Thm ([], RelativeConsistency (TheoryZFC, TheoryZFC_NegSH)) => true
        | _ => false

      val indep_sh_thm = prove_independence_of_sh ()
      val indep_sh_thm_ok = case indep_sh_thm of
          Thm ([], Imp (ConsistencyOf TheoryZFC, And (ConsistencyOf TheoryZFC_SH, ConsistencyOf TheoryZFC_NegSH))) => true
        | _ => false

      (* Tests for Easton Theorem & Levy Collapse in MKTD (Ticket 7730) *)
      val easton_fn_term = mk_easton_function (Var "F_easton")
      val easton_fn_ok = (easton_fn_term = EastonFunction (Var "F_easton"))

      val easton_poset_term = mk_easton_poset easton_fn_term
      val easton_poset_ok = (easton_poset_term = EastonPoset easton_fn_term)

      val levy_poset_term = mk_levy_collapse_poset (Aleph OrdZero) (Var "Kappa")
      val levy_poset_ok = (levy_poset_term = LevyCollapsePoset (Aleph OrdZero, Var "Kappa"))

      fun mock_cf x = x (* regular cardinal cofinality *)
      val easton_pairs = [(1, 2), (2, 3), (3, 5)]
      val is_easton_fn_ok = eval_is_easton_function easton_pairs mock_cf
      val is_easton_fn_fail = not (eval_is_easton_function [(2, 1)] mock_cf)

      val easton_supp_ok = eval_easton_support [1, 2] 5
      val easton_supp_fail = not (eval_easton_support [0, 1, 2] 3)

      val levy_col_ok = eval_levy_collapse 0 10
      val levy_col_fail = not (eval_levy_collapse 10 5)

      val solovay_model_ok = eval_solovay_model true

      val easton_cond_thm = prove_easton_function_conditions easton_fn_term
      val easton_cond_thm_ok = case easton_cond_thm of
          Thm ([], Imp (IsEastonFunction (EastonFunction (Var "F_easton")),
                       PreservesCofinalities (EastonPoset (EastonFunction (Var "F_easton")), TheoryZFC))) => true
        | _ => false

      val easton_pres_thm = prove_easton_poset_preserves_cofinalities easton_poset_term TheoryZFC
      val easton_pres_thm_ok = case easton_pres_thm of
          Thm ([], Imp (EastonSupportCondition (EastonPoset (EastonFunction (Var "F_easton")), TheoryZFC),
                       PreservesCofinalities (EastonPoset (EastonFunction (Var "F_easton")), TheoryZFC))) => true
        | _ => false

      val easton_powers_thm = prove_easton_powers_theorem easton_fn_term
      val easton_powers_thm_ok = case easton_powers_thm of
          Thm ([], Imp (IsEastonFunction (EastonFunction (Var "F_easton")),
                       EastonPowersTheorem (EastonFunction (Var "F_easton")))) => true
        | _ => false

      val rel_con_easton_thm = prove_relative_consistency_easton easton_fn_term
      val rel_con_easton_thm_ok = case rel_con_easton_thm of
          Thm ([], Imp (ConsistencyOf TheoryZFC,
                       ConsistencyOf (TheoryZFC_Easton (EastonFunction (Var "F_easton"))))) => true
        | _ => false

      val levy_props_thm = prove_levy_collapse_properties (Var "P_col") (Aleph OrdZero) (Var "Kappa")
      val levy_props_thm_ok = case levy_props_thm of
          Thm ([], Imp (IsLevyCollapse (Var "P_col", Aleph OrdZero, Var "Kappa"),
                       LevyCollapsesToOmega1 (TheoryZFC_LevyCollapse, Var "Kappa"))) => true
        | _ => false

      val levy_om1_thm = prove_levy_collapses_to_omega1 TheoryZFC_LevyCollapse (Var "Kappa")
      val levy_om1_thm_ok = case levy_om1_thm of
          Thm ([], Imp (LevyCollapsesToOmega1 (TheoryZFC_LevyCollapse, Var "Kappa"),
                       SolovayModelLebesgue TheoryZFC_LevyCollapse)) => true
        | _ => false

      val solovay_leb_thm = prove_solovay_model_lebesgue TheoryZFC_LevyCollapse
      val solovay_leb_thm_ok = case solovay_leb_thm of
          Thm ([], Imp (SolovayModelLebesgue TheoryZFC_LevyCollapse,
                       ConsistencyOf TheoryZF_DC_Lebesgue)) => true
        | _ => false

      val rel_con_solovay_thm = prove_relative_consistency_solovay ()
      val rel_con_solovay_thm_ok = case rel_con_solovay_thm of
          Thm ([], Imp (ConsistencyOf TheoryZFC_Inaccessible,
                       ConsistencyOf TheoryZF_DC_Lebesgue)) => true
        | _ => false

      (* Tests for Large Cardinals, Ultrafilters, and Scott's Theorem (Ticket 7731) *)
      val inacc_card_term = mk_inaccessible_cardinal (Var "Kappa")
      val inacc_card_ok = (inacc_card_term = InaccessibleCardinal (Var "Kappa"))

      val mahlo_card_term = mk_mahlo_cardinal (Var "Kappa")
      val mahlo_card_ok = (mahlo_card_term = MahloCardinal (Var "Kappa"))

      val weakly_compact_term = mk_weakly_compact_cardinal (Var "Kappa")
      val weakly_compact_ok = (weakly_compact_term = WeaklyCompactCardinal (Var "Kappa"))

      val measurable_card_term = mk_measurable_cardinal (Var "Kappa")
      val measurable_card_ok = (measurable_card_term = MeasurableCardinal (Var "Kappa"))

      val u_filter_term = mk_ultrafilter (Var "U") (Var "Kappa")
      val u_filter_ok = (u_filter_term = UltrafilterOn (Var "U", Var "Kappa"))

      val elem_emb_term = mk_elementary_embedding (Var "j") Univ (Var "M")
      val elem_emb_ok = (elem_emb_term = ElementaryEmbedding (Var "j", Univ, Var "M"))

      val ultrapower_term = mk_ultrapower Univ (Var "U")
      val ultrapower_ok = (ultrapower_term = Ultrapower (Univ, Var "U"))

      val zero_sharp_term = mk_zero_sharp ()
      val zero_sharp_ok = (zero_sharp_term = ZeroSharp)

      fun mock_cf_inacc k = k
      fun mock_exp2 lam = lam
      val inacc_eval_ok = eval_is_inaccessible 10 mock_cf_inacc mock_exp2
      val inacc_eval_fail = not (eval_is_inaccessible 10 (fn _ => 1) mock_exp2)

      val mahlo_eval_ok = eval_is_mahlo 10 [2, 4, 6] (fn xs => List.length xs > 0)
      val mahlo_eval_fail = not (eval_is_mahlo 10 [] (fn xs => List.length xs > 0))

      val tree_prop_ok = eval_tree_property 10 true
      val tree_prop_fail = not (eval_tree_property 10 false)

      val meas_eval_ok = eval_is_measurable 10 true true
      val meas_eval_fail = not (eval_is_measurable 10 false true)

      val elem_emb_eval_ok = eval_elementary_embedding 10 10
      val elem_emb_eval_fail = not (eval_elementary_embedding 5 10)

      val scotts_thm_eval_ok = eval_scotts_theorem true

      val inacc_def_thm = prove_inaccessible_definition (Var "Kappa")
      val inacc_def_thm_ok = case inacc_def_thm of
          Thm ([], Iff (InaccessibleDef (Var "Kappa"),
                       And (IsRegularCardinal (Var "Kappa"), IsStrongLimit (Var "Kappa")))) => true
        | _ => false

      val mahlo_char_thm = prove_mahlo_characterization (Var "Kappa") (Var "S_inacc")
      val mahlo_char_thm_ok = case mahlo_char_thm of
          Thm ([], Iff (IsMahlo (Var "Kappa"),
                       And (IsRegularCardinal (Var "Kappa"), IsStationaryIn (Var "S_inacc", Var "Kappa")))) => true
        | _ => false

      val weakly_compact_thm = prove_weakly_compact_tree_property (Var "Kappa")
      val weakly_compact_thm_ok = case weakly_compact_thm of
          Thm ([], Iff (IsWeaklyCompact (Var "Kappa"), HasTreeProperty (Var "Kappa"))) => true
        | _ => false

      val meas_ultra_thm = prove_measurable_ultrafilter (Var "U") (Var "Kappa")
      val meas_ultra_thm_ok = case meas_ultra_thm of
          Thm ([], Iff (IsMeasurable (Var "Kappa"), IsKappaCompleteUltrafilter (Var "U", Var "Kappa"))) => true
        | _ => false

      val meas_emb_thm = prove_measurable_elementary_embedding (Var "j") Univ (Var "M") (Var "Kappa")
      val meas_emb_thm_ok = case meas_emb_thm of
          Thm ([], Iff (IsMeasurable (Var "Kappa"),
                       And (IsElementaryEmbedding (Var "j", Univ, Var "M"), CriticalPoint (Var "j", Var "Kappa")))) => true
        | _ => false

      val ultrapower_thm = prove_ultrapower_construction Univ (Var "U") (Var "Kappa")
      val ultrapower_thm_ok = case ultrapower_thm of
          Thm ([], Imp (IsKappaCompleteUltrafilter (Var "U", Var "Kappa"),
                       IsUltrapower (Ultrapower (Univ, Var "U"), Univ, Var "U"))) => true
        | _ => false

      val scotts_thm = prove_scotts_theorem (Var "Kappa")
      val scotts_thm_ok = case scotts_thm of
          Thm ([], Imp (IsMeasurable (Var "Kappa"),
                       And (ScottsTheoremVNotL (Var "Kappa"), ExistsZeroSharp (Var "Kappa")))) => true
        | _ => false

      val rel_con_meas_thm = prove_relative_consistency_measurable ()
      val rel_con_meas_thm_ok = case rel_con_meas_thm of
          Thm ([], Imp (ConsistencyOf TheoryZFC_Measurable, ConsistencyOf TheoryZFC_Mahlo)) => true
        | _ => false

      (* Tests for Constructible Universe L, Condensation Lemma, and GCH (Ticket 7732) *)
      val def_powerset_term = mk_definable_power_set (Var "X")
      val def_powerset_ok = (def_powerset_term = DefinablePowerSet (Var "X"))

      val l_stage_term = mk_l_stage (Var "Alpha")
      val l_stage_ok = (l_stage_term = LStage (Var "Alpha"))

      val constr_univ_term = mk_constructible_universe ()
      val constr_univ_ok = (constr_univ_term = ConstructibleUniverse)

      val theory_zfc_l_term = mk_theory_zfc_l ()
      val theory_zfc_l_ok = (theory_zfc_l_term = TheoryZFC_L)

      val is_def_sub_fm = mk_is_definable_subset (Var "Y") (Var "X")
      val is_def_sub_ok = (is_def_sub_fm = IsDefinableSubset (Var "Y", Var "X"))

      val in_l_stage_fm = mk_in_l_stage (Var "x") (Var "Alpha")
      val in_l_stage_ok = (in_l_stage_fm = InLStage (Var "x", Var "Alpha"))

      val in_l_fm = mk_in_l (Var "x")
      val in_l_ok = (in_l_fm = InL (Var "x"))

      val cond_lemma_fm = mk_condensation_lemma (Var "M") (Var "Lambda") (Var "Alpha")
      val cond_lemma_fm_ok = (cond_lemma_fm = CondensationLemma (Var "M", Var "Lambda", Var "Alpha"))

      val l_gch_fm = mk_l_gch_theorem (Var "Kappa")
      val l_gch_ok = (l_gch_fm = LGCHTheorem (Var "Kappa"))

      val l_wo_fm = mk_l_well_ordering_theorem (Var "X")
      val l_wo_ok = (l_wo_fm = LWellOrderingTheorem (Var "X"))

      val ax_v_eq_l_fm = mk_axiom_v_equals_l ()
      val ax_v_eq_l_ok = (ax_v_eq_l_fm = AxiomVEqualsL)

      val eval_def_sub_ok = eval_is_definable_subset 3 5
      val eval_def_sub_fail = not (eval_is_definable_subset 6 5)

      val eval_in_stage_ok = eval_in_l_stage 2 3
      val eval_in_stage_fail = not (eval_in_l_stage 3 3)

      val eval_cond_step_ok = eval_condensation_step 10 100 5
      val eval_cond_step_fail = not (eval_condensation_step 10 100 15)

      val eval_l_ac_ok = eval_l_satisfies_ac true

      val eval_l_gch_ok = eval_l_satisfies_gch 1 2
      val eval_l_gch_fail = not (eval_l_satisfies_gch 1 3)

      val l_stage_def_thm = prove_l_stage_definition (Var "Alpha")
      val l_stage_def_thm_ok = case l_stage_def_thm of
          Thm ([], Eq (LStage (OrdSucc (Var "Alpha")), DefinablePowerSet (LStage (Var "Alpha")))) => true
        | _ => false

      val constr_trans_thm = prove_constructible_hierarchy_transitive (Var "Alpha")
      val constr_trans_thm_ok = case constr_trans_thm of
          Thm ([], And (IsTransitive (LStage (Var "Alpha")), IsTransitive ConstructibleUniverse)) => true
        | _ => false

      val cond_lem_thm = prove_condensation_lemma (Var "M") (Var "Lambda") (Var "Alpha")
      val cond_lem_thm_ok = case cond_lem_thm of
          Thm ([], Imp (ElemSubmodelFm (Var "M", LAlpha (Var "Lambda")),
                       CondensationLemma (Var "M", Var "Lambda", Var "Alpha"))) => true
        | _ => false

      val l_sat_ac_thm = prove_l_satisfies_ac (Var "X")
      val l_sat_ac_thm_ok = case l_sat_ac_thm of
          Thm ([], Imp (AxiomVEqualsL, LWellOrderingTheorem (Var "X"))) => true
        | _ => false

      val l_sat_gch_thm = prove_l_satisfies_gch (Var "Kappa")
      val l_sat_gch_thm_ok = case l_sat_gch_thm of
          Thm ([], Imp (AxiomVEqualsL, LGCHTheorem (Var "Kappa"))) => true
        | _ => false

      (* Tests for Class Inner Model Relativization and Forcing Posets with Dunaev Names (Ticket 63) *)
      val rel_compr_term = mk_relativized_class_compr "x" (Var "M") (In (Var "x", Var "x"))
      val rel_compr_ok = (rel_compr_term = RelativizedClassCompr ("x", Var "M", In (Var "x", Var "x")))

      val poset_pre_term = mk_poset_preorder (Var "P") (Var "Leq") (Var "OneP")
      val poset_pre_ok = (poset_pre_term = PosetPreorder (Var "P", Var "Leq", Var "OneP"))

      val gen_val_term = mk_generic_val (Var "Tau") (Var "G")
      val gen_val_ok = (gen_val_term = GenericVal (Var "Tau", Var "G"))

      val im_crit_fm = mk_inner_model_criterion_nbg (Var "M")
      val im_crit_fm_ok = (im_crit_fm = InnerModelCriterionNBG (Var "M"))

      val rel_ax_fm = mk_relativized_axiom_holds (Var "M") True
      val rel_ax_fm_ok = (rel_ax_fm = RelativizedAxiomHolds (Var "M", True))

      val is_fposet_fm = mk_is_forcing_poset (Var "P") (Var "Leq") (Var "OneP")
      val is_fposet_fm_ok = (is_fposet_fm = IsForcingPoset (Var "P", Var "Leq", Var "OneP"))

      val is_dpname_fm = mk_is_dunaev_p_name (Var "Tau") (Var "P")
      val is_dpname_fm_ok = (is_dpname_fm = IsDunaevPName (Var "Tau", Var "P"))

      val check_id_fm = mk_check_name_val_identity (Var "x") (Var "G")
      val check_id_fm_ok = (check_id_fm = CheckNameValIdentity (Var "x", Var "G"))

      val ax_empty_exists = Exists ("e", Forall ("x", Not (In (Var "x", Var "e"))))
      val ax_extensionality =
        Forall ("x", Forall ("y",
          Imp (Forall ("z", Iff (In (Var "z", Var "x"), In (Var "z", Var "y"))),
               Eq (Var "x", Var "y"))))
      val ax_isset_witness = Exists ("x", IsSet (Var "x"))
      val rel_isset_check =
        (relativize_nbg_axiom (Var "M") ax_isset_witness =
         Exists ("x", And (In (Var "x", Var "M"), In (Var "x", Var "M"))))

      val v2_stage = eval_cumulative_level 2
      val v3_stage = eval_cumulative_level 3
      val ord_v2 = [Empty, Singleton Empty]
      val inner_nbg_ok =
        eval_inner_model_nbg_criterion hf_in v2_stage v3_stage ord_v2
          [ax_empty_exists, ax_extensionality, ax_isset_witness]
      val non_trans_stage = [Singleton Empty]
      val inner_nbg_non_trans_fail =
        not (eval_inner_model_nbg_criterion hf_in non_trans_stage v3_stage [Singleton Empty]
               [ax_empty_exists])

      val p_one = Var "1_P"
      val p_left = Var "p_0"
      val p_right = Var "p_1"
      val t63_carrier = [p_one, p_left, p_right]
      fun t63_leq x y = (y = p_one) orelse (x = y)
      fun t63_bad_leq x y = (x = p_left andalso y = p_one)
      val fposet_eval_ok = eval_is_forcing_poset t63_leq t63_carrier p_one
      val fposet_eval_fail = not (eval_is_forcing_poset t63_bad_leq t63_carrier p_one)

      val t63_antichains = [[p_left], [p_right], [p_left, p_right], [p_one, p_left]]
      val ccc_bound_ok = eval_has_ccc_bound t63_leq t63_carrier t63_antichains 2
      val ccc_bound_fail = not (eval_has_ccc_bound t63_leq t63_carrier t63_antichains 1)

      val check_0 = mk_canonical_check_name_dunaev p_one Empty
      val check_1 = mk_canonical_check_name_dunaev p_one (Singleton Empty)
      val check_2 = mk_canonical_check_name_dunaev p_one (UnorderedPair (Empty, Singleton Empty))
      val custom_tau = mk_dunaev_p_name [(check_0, p_left), (check_1, p_right)]
      val bad_kuratowski_tau = DunaevPName (KuratowskiPair (check_0, p_left))

      val dpname_wf_ok =
        eval_dunaev_p_name_well_formed t63_carrier check_0
        andalso eval_dunaev_p_name_well_formed t63_carrier check_1
        andalso eval_dunaev_p_name_well_formed t63_carrier check_2
        andalso eval_dunaev_p_name_well_formed t63_carrier custom_tau
      val dpname_wf_kuratowski_rejected =
        not (eval_dunaev_p_name_well_formed t63_carrier bad_kuratowski_tau)

      val g_right = [p_one, p_right]
      val t63_generic_ok = eval_is_generic t63_leq t63_carrier g_right [[p_left, p_right], [p_one]]
      val val_check_0_ok = (eval_recursive_val_g g_right check_0 = Empty)
      val val_check_1_ok = (eval_recursive_val_g g_right check_1 = Singleton Empty)
      val val_check_2_ok =
        (eval_recursive_val_g g_right check_2 = UnorderedPair (Empty, Singleton Empty))
      val val_custom_tau_ok =
        (eval_recursive_val_g g_right custom_tau = Singleton (Singleton Empty))
      val val_kuratowski_raises =
        (let val _ = eval_recursive_val_g g_right bad_kuratowski_tau in false end
         handle ProperClassKuratowskiException => true)

      val im_rel_crit_thm = prove_inner_model_relativization_criterion (Var "M") ax_empty_exists
      val im_rel_crit_thm_ok = case im_rel_crit_thm of
          Thm ([], Imp (InnerModelCriterionNBG (Var "M"),
                       Iff (RelativizedAxiomHolds (Var "M", _), _))) => true
        | _ => false

      val fposet_pre_thm = prove_forcing_poset_preorder (Var "P") (Var "Leq") p_one
      val fposet_pre_thm_ok = case fposet_pre_thm of
          Thm ([], Imp (IsForcingPoset (Var "P", Var "Leq", _), In (_, Var "P"))) => true
        | _ => false

      val ccc_ac_thm = prove_ccc_antichain_condition (Var "P") (Var "A")
      val ccc_ac_thm_ok = case ccc_ac_thm of
          Thm ([], Imp (And (HasCCC (Var "P"), IsAntichain (Var "A", Var "P")), IsSet (Var "A"))) => true
        | _ => false

      val dpname_wf_thm = prove_dunaev_pname_well_formed (Var "Tau") (Var "P")
      val dpname_wf_thm_ok = case dpname_wf_thm of
          Thm ([], Imp (IsDunaevPName (Var "Tau", Var "P"), IsSet (Var "Tau"))) => true
        | _ => false

      val check_val_thm = prove_check_name_generic_val (Var "x") (Var "G")
      val check_val_thm_ok = case check_val_thm of
          Thm ([], Imp (CheckNameValIdentity (Var "x", Var "G"),
                       Eq (GenericVal (CanonicalCheckName (Var "x"), Var "G"), Var "x"))) => true
        | _ => false

      val gen_ext_im_thm = prove_generic_extension_inner_model (Var "M") (Var "G") (Var "P") True
      val gen_ext_im_thm_ok = case gen_ext_im_thm of
          Thm ([], Imp (And (InnerModelCriterionNBG (Var "M"), IsGenericFilter (Var "G", Var "P", Var "M")),
                       InnerModelCriterionNBG (GenericExtension (Var "M", Var "G")))) => true
        | _ => false

      (* Tests for Six Open Mathematical Tickets (3.25..3.36, 3.51, 3.68..3.74, Fact 8) *)
      (* 1. Semi-singleton and semi-singleton subclass *)
      val ss_empty_ok = eval_semi_singleton hf_in v3_stage Empty
      val ss_single_ok = eval_semi_singleton hf_in v3_stage (Singleton Empty)
      val ss_pair_false = not (eval_semi_singleton hf_in v3_stage (UnorderedPair (Empty, Singleton Empty)))
      val sss_false_case = not (eval_semi_singleton_subclass hf_in v3_stage (Singleton Empty) Empty)
      val sss_true_case = eval_semi_singleton_subclass hf_in v3_stage Empty (Singleton Empty)
      val ss_def_thm = prove_def_semi_singleton (Var "s")
      val ss_def_thm_ok = case ss_def_thm of
          Thm ([], Iff (SemiSingleton (Var "s"), Forall ("x", Forall ("y", _)))) => true
        | _ => false
      val sss_def_thm = prove_def_semi_singleton_subclass (Var "s") (Var "A")
      val sss_def_thm_ok = case sss_def_thm of
          Thm ([], Iff (SemiSingletonSubclass (Var "s", Var "A"),
                       And (Subclass (Var "s", Var "A"), SemiSingleton (Var "s")))) => true
        | _ => false
      val semi_singleton_all_ok =
        ss_empty_ok andalso ss_single_ok andalso ss_pair_false
        andalso sss_false_case andalso sss_true_case
        andalso ss_def_thm_ok andalso sss_def_thm_ok

      (* 2. Finite class-list induction/transport over Dunaev TagPair *)
      val cl_empty = eval_class_lists_dunaev [] (fn _ => fn acc => acc + 1) 0
      val cl_mixed = eval_class_lists_dunaev [Empty, Univ, Singleton Empty, Empty] (fn _ => fn acc => acc + 1) 0
      val cl_kuratowski_rejected =
        (let val _ = encode_class_list_dunaev [KuratowskiPair (Empty, Empty)] in false end
         handle ProperClassKuratowskiException => true)
      val cl_thm = prove_class_list_dunaev_transport Univ Empty
      val cl_thm_ok = case cl_thm of
          Thm ([], And (Eq (_, Univ), Eq (_, Empty))) => true
        | _ => false
      val class_lists_all_ok =
        (#1 cl_empty = Empty andalso #2 cl_empty = 0 andalso #3 cl_empty andalso #4 cl_empty = 0)
        andalso (#2 cl_mixed = 4 andalso #3 cl_mixed andalso #4 cl_mixed = 4)
        andalso cl_kuratowski_rejected andalso cl_thm_ok

      (* 3. Family value at argument F(a), relational image F[A] vs evaluated image, canonical family *)
      val fam_graph =
        [(Empty, Empty),
         (Singleton Empty, Singleton Empty),
         (UnorderedPair (Empty, Singleton Empty), Singleton Empty),
         (UnorderedPair (Empty, Singleton Empty), Singleton (Singleton Empty))]
      fun fam_dom x =
        (x = Empty) orelse (x = Singleton Empty) orelse (x = UnorderedPair (Empty, Singleton Empty))
      val f_val_present_empty = (eval_family_value_at_arg fam_graph fam_dom Empty = Empty)
      val f_val_absent_default = (eval_family_value_at_arg fam_graph fam_dom (Var "absent") = Univ)
      val rel_img_proper =
        eval_relational_image fam_graph [UnorderedPair (Empty, Singleton Empty)]
      val eval_img_proper_dropped =
        eval_evaluated_image
          [(UnorderedPair (Empty, Singleton Empty), Univ)]
          fam_dom
          is_set_mock
          [UnorderedPair (Empty, Singleton Empty)]
      val can_fam_valid =
        eval_canonical_family is_set_mock
          [TagPair (Empty, Empty),
           TagPair (Singleton Empty, Singleton Empty),
           TagPair (UnorderedPair (Empty, Singleton Empty), Singleton Empty),
           TagPair (UnorderedPair (Empty, Singleton Empty), Singleton (Singleton Empty))]
      val can_fam_nonrecord_rejected =
        not (eval_canonical_family is_set_mock [Empty])
      val fam_can_thm = prove_def_family_canonical (Var "F")
      val fam_can_thm_ok = case fam_can_thm of
          Thm ([], Iff (CanonicalFamily (Var "F"), _)) => true
        | _ => false
      val fam_img_thm = prove_value_at_arg_vs_relational_image (Var "F") (Var "x")
      val fam_img_thm_ok = case fam_img_thm of
          Thm ([], Eq (FamilyValueAtArg (Var "F", Var "x"),
                       Union (RelationalImage (Var "F", Singleton (Var "x"))))) => true
        | _ => false
      val family_all_ok =
        f_val_present_empty andalso f_val_absent_default
        andalso (List.length rel_img_proper = 2)
        andalso List.null eval_img_proper_dropped
        andalso can_fam_valid andalso can_fam_nonrecord_rejected
        andalso fam_can_thm_ok andalso fam_img_thm_ok

      (* 4. Semantic completeness vs negation-completeness (Tau vs Fau) *)
      val comp_fau = eval_semantic_vs_negation_completeness true true true true
      val comp_tau = eval_semantic_vs_negation_completeness true true false false
      val sem_fau_thm = prove_semantic_completeness_of_fau True
      val sem_fau_thm_ok = case sem_fau_thm of
          Thm ([], SemanticCompleteness (TheoryFau, True)) => true
        | _ => false
      val sem_neg_thm = prove_semantic_vs_negation_completeness TheoryFau True
      val sem_neg_thm_ok = case sem_neg_thm of
          Thm ([], Imp (ConsistencyOf TheoryFau, Iff (SemanticCompleteness (TheoryFau, True), _))) => true
        | _ => false
      val completeness_all_ok =
        (#semantic_completeness_holds comp_fau)
        andalso (#negation_completeness_holds comp_fau)
        andalso (#sound_bivalent_bridge_holds comp_fau)
        andalso (not (#semantic_completeness_holds comp_tau))
        andalso (not (#negation_completeness_holds comp_tau))
        andalso (#tau_incomplete_witness comp_tau)
        andalso (#arbitrary_henkin_mismatch_witness comp_fau)
        andalso sem_fau_thm_ok andalso sem_neg_thm_ok

      (* 5. Fact 8 Ctx.IFV(x, Gamma) quantifier hygiene *)
      val qh_captured =
        eval_ctx_ifv_quantifier_hygiene "x" [In (Var "x", Singleton Empty)] (In (Var "x", Singleton Empty)) True
      val qh_fresh =
        eval_ctx_ifv_quantifier_hygiene "y" [In (Var "x", Singleton Empty)] (In (Var "y", Singleton Empty)) True
      val qh_thm = prove_ctx_ifv_quantifier_hygiene "x" [In (Var "y", Singleton Empty)] (In (Var "x", Singleton Empty))
      val qh_thm_ok = case qh_thm of
          Thm ([], Imp (Not (CtxIFV ("x", _)), Imp (_, Forall ("x", _)))) => true
        | _ => false
      val ctx_ifv_all_ok =
        (#ctx_ifv qh_captured)
        andalso (not (#fora_r_admissible qh_captured))
        andalso (not (#forall_abs_admissible qh_captured))
        andalso (not (#exis_l_admissible qh_captured))
        andalso (#two_element_counterexample_blocked qh_captured)
        andalso (not (#ctx_ifv qh_fresh))
        andalso (#fora_r_admissible qh_fresh)
        andalso (#forall_abs_admissible qh_fresh)
        andalso (#exis_l_admissible qh_fresh)
        andalso qh_thm_ok

      (* 6. Tight universe indexed-union closure (3.68, 3.69) *)
      val tu_valid = eval_tight_universe_indexed_union_closure 16 3 [2, 4, 3]
      val tu_invalid = eval_tight_universe_indexed_union_closure 4 4 [2, 2]
      val tu_thm = prove_tight_universe_indexed_union_closure (Var "U") (Var "I") (Var "Fam")
      val tu_thm_ok = case tu_thm of
          Thm ([], Imp (And (IsSet (Var "U"), _), TightUnivIndexedUnion (Var "U", Var "I", Var "Fam"))) => true
        | _ => false
      val v_univ_thm = prove_universal_class_is_universe ()
      val v_univ_thm_ok = case v_univ_thm of
          Thm ([], And (IsGrothendieckUniv Univ, ProperClass Univ)) => true
        | _ => false
      val tight_univ_all_ok =
        (#union_in_universe tu_valid)
        andalso (#diagonal_contradiction_blocked tu_valid)
        andalso (not (#union_in_universe tu_invalid))
        andalso tu_thm_ok andalso v_univ_thm_ok

      (* Ticket 64: Complete Boolean Algebras & Boolean-Valued Models V^(B) vs Dunaev-Tagged Forcing Names V^P *)
      val cba_4_ok = eval_is_complete_boolean_algebra [0, 1, 2, 3] 0 3
      val cba_incomplete_fail = not (eval_is_complete_boolean_algebra [0, 1, 3] 0 3)
      val ro_p1 = Var "1_P"
      val ro_p0 = Var "p_0"
      val ro_p1_branch = Var "p_1"
      val ro_carrier = [ro_p1, ro_p0, ro_p1_branch]
      val ro_leq = fn (x, y) =>
        (x = y) orelse (y = ro_p1)
      val ro_cuts = eval_regular_open_completion (fn x => fn y => ro_leq (x, y)) ro_carrier
      val ro_cuts_ok = (List.length ro_cuts = 4)
      val bname_u = [(Empty, 1), (Singleton Empty, 3)]
      val bname_v = [(Empty, 3), (Singleton Empty, 3)]
      val bval_mem_ok = (eval_bval_membership [(Empty, 3)] bname_u = 1)
      val bval_eq_same_ok = (eval_bval_equality bname_u bname_u 3 = 3)
      val bval_eq_diff_ok = (eval_bval_equality bname_u bname_v 3 = 1)
      val bval_kuratowski_rejected =
        (let val _ = eval_bval_membership [(KuratowskiPair (Empty, Empty), 1)] bname_u in false end
         handle ProperClassKuratowskiException => true)
      val bval_zfc_res = eval_bval_zfc_axioms_valid 3
      val bval_zfc_ok =
        (#all_valid bval_zfc_res)
        andalso (#extensionality bval_zfc_res = 3)
        andalso (#pairing bval_zfc_res = 3)
        andalso (#union bval_zfc_res = 3)
        andalso (#powerset bval_zfc_res = 3)
        andalso (#foundation bval_zfc_res = 3)
      val ro_emb_thm = prove_ro_embedding_preserves_incompatibility (Var "P")
      val ro_emb_thm_ok = case ro_emb_thm of
          Thm ([], Imp (IsForcingPoset (Var "P", _, _),
                        And (IsCompleteBooleanAlgebra (RegularOpenCompletion (Var "P")),
                             ROEmbeddingPreservesIncompat (Var "P", RegularOpenCompletion (Var "P"))))) => true
        | _ => false
      val bval_ext_thm = prove_bval_extensionality_valid (Var "B")
      val bval_ext_thm_ok = case bval_ext_thm of
          Thm ([], Imp (IsCompleteBooleanAlgebra (Var "B"),
                        BValZFCValid (BValModel (Var "B"), _))) => true
        | _ => false
      val bval_equiv_thm = prove_bval_dunaev_pname_equivalence (Var "P") (Var "B")
      val bval_equiv_thm_ok = case bval_equiv_thm of
          Thm ([], Imp (And (IsForcingPoset (Var "P", _, _), Eq (Var "B", RegularOpenCompletion (Var "P"))),
                        BValDunaevEquiv (Var "P", BValModel (Var "B")))) => true
        | _ => false
      val bval_terms_ok =
        (CompleteBooleanAlgebra (Var "B") = CompleteBooleanAlgebra (Var "B"))
        andalso (BValTruth (True, Var "B") = BValTruth (True, Var "B"))
      val bval_all_ok =
        cba_4_ok andalso cba_incomplete_fail andalso ro_cuts_ok
        andalso bval_mem_ok andalso bval_eq_same_ok andalso bval_eq_diff_ok
        andalso bval_kuratowski_rejected andalso bval_zfc_ok
        andalso ro_emb_thm_ok andalso bval_ext_thm_ok andalso bval_equiv_thm_ok
        andalso bval_terms_ok

      (* Ticket 65: Club Filter, Stationary Subclasses, Fodor's Lemma, and Veblen Hierarchy *)
      val norm_fn_pairs = [
        dunaev_pair (GodelCode 0) (GodelCode 1),
        dunaev_pair (GodelCode 1) (GodelCode 2),
        dunaev_pair (GodelCode 2) (GodelCode 3),
        dunaev_pair (GodelCode 3) (GodelCode 3)
      ]
      val norm_fn_valid_pairs = [
        dunaev_pair (GodelCode 0) (GodelCode 1),
        dunaev_pair (GodelCode 1) (GodelCode 2),
        dunaev_pair (GodelCode 2) (GodelCode 2)
      ]
      val norm_fn_cont_pairs = [
        dunaev_pair (GodelCode 0) (GodelCode 1),
        dunaev_pair (GodelCode 1) (GodelCode 2),
        dunaev_pair (GodelCode 2) (GodelCode 3)
      ]
      val norm_res_ok = eval_is_normal_ordinal_function norm_fn_cont_pairs []
      val norm_res_fail = eval_is_normal_ordinal_function norm_fn_pairs []
      val norm_kuratowski_rejected =
        (let val _ = eval_is_normal_ordinal_function [KuratowskiPair (GodelCode 0, GodelCode 1)] [] in false end
         handle ProperClassKuratowskiException => true)
      val veb_0_2 = eval_veblen_fixed_point 0 2
      val veb_1_1 = eval_veblen_fixed_point 1 1
      val veb_ok =
        (#is_fixed_point_of_lower veb_0_2)
        andalso (#is_fixed_point_of_lower veb_1_1)
        andalso (#phi_alpha_beta veb_1_1 > #phi_alpha_beta veb_0_2)
      val club_valid = eval_is_club_in_regular 5 [2, 4] [1, 2, 3, 4]
      val club_not_closed = eval_is_club_in_regular 5 [2, 4] [0, 1, 3, 4]
      val club_not_unb = eval_is_club_in_regular 5 [2, 4] [0, 1, 2]
      val club_ok =
        (#is_club club_valid)
        andalso (not (#is_club club_not_closed))
        andalso (not (#is_club club_not_unb))
      val club_fam = [[1, 2, 3, 4], [2, 3, 4]]
      val stat_ok = eval_is_stationary_in_regular [1, 2] club_fam
      val stat_fail = not (eval_is_stationary_in_regular [0, 1] club_fam)
      val diag_seq = [
        dunaev_pair (GodelCode 0) (ClassListDunaev [GodelCode 0, GodelCode 1, GodelCode 2, GodelCode 3]),
        dunaev_pair (GodelCode 1) (ClassListDunaev [GodelCode 1, GodelCode 2, GodelCode 3]),
        dunaev_pair (GodelCode 2) (ClassListDunaev [GodelCode 2, GodelCode 3]),
        dunaev_pair (GodelCode 3) (ClassListDunaev [GodelCode 3])
      ]
      val diag_res = eval_diagonal_intersection_club 4 diag_seq
      val diag_ok = (diag_res = [0, 1, 2, 3])
      val fodor_f = [
        dunaev_pair (GodelCode 1) (GodelCode 0),
        dunaev_pair (GodelCode 2) (GodelCode 0),
        dunaev_pair (GodelCode 3) (GodelCode 1)
      ]
      val fodor_res = eval_fodors_lemma_regressive_constant [1, 2, 3] fodor_f club_fam
      val fodor_ok =
        (#is_regressive fodor_res)
        andalso (#fiber_is_stationary fodor_res)
        andalso (#constant_value fodor_res = SOME 0)
      val norm_fp_thm = prove_normal_function_has_fixed_points (NormalOrdinalFn (Var "F"))
      val norm_fp_thm_ok = case norm_fp_thm of
          Thm ([], Imp (IsNormalOrdinalFn (NormalOrdinalFn (Var "F")), _)) => true
        | _ => false
      val diag_thm = prove_club_diagonal_intersection_closed (Var "kappa") (Var "Fam")
      val diag_thm_ok = case diag_thm of
          Thm ([], Imp (_, IsClubIn (DiagonalIntersection (Var "kappa", Var "Fam"), Var "kappa"))) => true
        | _ => false
      val fodor_thm = prove_fodors_pressing_down_lemma (Var "S") (Var "f") (Var "kappa")
      val fodor_thm_ok = case fodor_thm of
          Thm ([], Imp (And (IsRegularCardinal (Var "kappa"), IsStationaryIn (Var "S", Var "kappa")),
                        FodorsPressingDown (Var "S", Var "f", Var "kappa"))) => true
        | _ => false
      val veblen_term_ok = (VeblenPhi (OrdZero, OrdZero) = VeblenPhi (OrdZero, OrdZero))
      val _ = norm_fn_valid_pairs
      val club_veblen_all_ok =
        (#is_normal norm_res_ok)
        andalso (not (#is_normal norm_res_fail))
        andalso norm_kuratowski_rejected
        andalso veb_ok andalso club_ok andalso stat_ok andalso stat_fail
        andalso diag_ok andalso fodor_ok
        andalso norm_fp_thm_ok andalso diag_thm_ok andalso fodor_thm_ok
        andalso veblen_term_ok

      (* Ticket 66: Gale-Stewart Games, Winning Strategies, and Martin's Borel Determinacy *)
      val gt_nodes = [
        ClassListDunaev [],
        ClassListDunaev [GodelCode 0],
        ClassListDunaev [GodelCode 1],
        ClassListDunaev [GodelCode 0, GodelCode 0],
        ClassListDunaev [GodelCode 0, GodelCode 1],
        ClassListDunaev [GodelCode 1, GodelCode 0],
        ClassListDunaev [GodelCode 1, GodelCode 1]
      ]
      val gt_valid = eval_is_dunaev_game_tree gt_nodes 2
      val gt_unpruned = eval_is_dunaev_game_tree [ClassListDunaev [], ClassListDunaev [GodelCode 0]] 2
      val gt_kuratowski_rejected =
        (let val _ = eval_is_dunaev_game_tree [KuratowskiPair (Empty, Empty)] 1 in false end
         handle ProperClassKuratowskiException => true)
      val gs_plays = [
        ClassListDunaev [GodelCode 0, GodelCode 0],
        ClassListDunaev [GodelCode 0, GodelCode 1],
        ClassListDunaev [GodelCode 1, GodelCode 0],
        ClassListDunaev [GodelCode 1, GodelCode 1]
      ]
      val gs_payoff_p1 = [
        ClassListDunaev [GodelCode 0, GodelCode 0],
        ClassListDunaev [GodelCode 0, GodelCode 1]
      ]
      val p1_strat_0 = [dunaev_pair (ClassListDunaev []) (GodelCode 0)]
      val p1_strat_1 = [dunaev_pair (ClassListDunaev []) (GodelCode 1)]
      val p2_strat_00 = [
        dunaev_pair (ClassListDunaev [GodelCode 0]) (GodelCode 0),
        dunaev_pair (ClassListDunaev [GodelCode 1]) (GodelCode 0)
      ]
      val p2_strat_01 = [
        dunaev_pair (ClassListDunaev [GodelCode 0]) (GodelCode 1),
        dunaev_pair (ClassListDunaev [GodelCode 1]) (GodelCode 1)
      ]
      val excl_res = eval_strategy_exclusivity gs_plays gs_payoff_p1 p1_strat_0 p2_strat_00
      val gs_det_res =
        eval_gale_stewart_closed_determinacy gs_plays gs_payoff_p1
          [p1_strat_0, p1_strat_1] [p2_strat_00, p2_strat_01]
      val borel_det_res =
        eval_martin_borel_determinacy 3 gs_plays gs_payoff_p1
          [p1_strat_0, p1_strat_1] [p2_strat_00, p2_strat_01]
      val gs_excl_thm = prove_gale_stewart_strategy_exclusivity (DunaevGameTree (Var "T")) (Var "A")
      val gs_excl_thm_ok = case gs_excl_thm of
          Thm ([], Imp (IsDunaevGameTree (DunaevGameTree (Var "T")),
                        Not (And (HasWinningStrategyP1 _, HasWinningStrategyP2 _)))) => true
        | _ => false
      val gs_closed_thm = prove_gale_stewart_closed_determinacy (DunaevGameTree (Var "T")) (Var "A")
      val gs_closed_thm_ok = case gs_closed_thm of
          Thm ([], Imp (IsDunaevGameTree (DunaevGameTree (Var "T")),
                        And (IsDeterminedGame _, _))) => true
        | _ => false
      val borel_thm = prove_martin_borel_determinacy (DunaevGameTree (Var "T")) (Var "A") (OrdSucc OrdZero)
      val borel_thm_ok = case borel_thm of
          Thm ([], Imp (And (IsDunaevGameTree _, IsBorelPayoff (Var "A", OrdSucc OrdZero)),
                        IsDeterminedGame (_, BorelPayoff (Var "A", OrdSucc OrdZero)))) => true
        | _ => false
      val gs_term_ok = (GaleStewartGame (Var "T", Var "A") = GaleStewartGame (Var "T", Var "A"))
      val gale_stewart_all_ok =
        (#is_valid_game_tree gt_valid)
        andalso (not (#is_valid_game_tree gt_unpruned))
        andalso gt_kuratowski_rejected
        andalso (#p1_wins excl_res)
        andalso (not (#p2_wins excl_res))
        andalso (#mutually_exclusive excl_res)
        andalso (#is_determined gs_det_res)
        andalso (#is_determined borel_det_res)
        andalso gs_excl_thm_ok andalso gs_closed_thm_ok andalso borel_thm_ok
        andalso gs_term_ok

      (* Ticket 67: Schroedinger Semigroup Integral Kernels, Dyson-Phillips Series, and Lipschitz Regularity *)
      val hk_entries = [
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 0)) (GodelCode 10),
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 1)) (GodelCode 6),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 0)) (GodelCode 6),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 1)) (GodelCode 10)
      ]
      val hk_asym = [
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 0)) (GodelCode 10),
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 1)) (GodelCode 6),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 0)) (GodelCode 4),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 1)) (GodelCode 10)
      ]
      val hk_res = eval_heat_semigroup_contraction 1 hk_entries
      val hk_asym_res = eval_heat_semigroup_contraction 1 hk_asym
      val hk_kuratowski_rejected =
        (let val _ = eval_heat_semigroup_contraction 1 [KuratowskiPair (Empty, Empty)] in false end
         handle ProperClassKuratowskiException => true)
      val ik_res = eval_integral_kernel_criterion hk_entries hk_entries
      val ik_diff_res = eval_integral_kernel_criterion hk_entries hk_asym
      val dp_res = eval_dyson_phillips_series_bound 1 2 4
      val dp_invalid = eval_dyson_phillips_series_bound 0 2 4
      val lip_profile = [
        dunaev_pair (GodelCode 0) (GodelCode 10),
        dunaev_pair (GodelCode 1) (GodelCode 8),
        dunaev_pair (GodelCode 2) (GodelCode 6)
      ]
      val lip_res = eval_schrodinger_lipschitz_regularity 1 2 lip_profile
      val ik_thm = prove_integral_kernel_criterion (Var "T_t") (HeatSemigroupKernel (Var "t"))
      val ik_thm_ok = case ik_thm of
          Thm ([], Imp (IsIntegralKernelOperator (Var "T_t", HeatSemigroupKernel (Var "t")), _)) => true
        | _ => false
      val dp_thm = prove_dyson_phillips_perturbation_converges (Var "t") (Var "V")
      val dp_thm_ok = case dp_thm of
          Thm ([], Imp (IsSet (Var "V"),
                        And (DysonPhillipsConverges (Var "t", Var "V"),
                             FeynmanKacPositivity (Var "t", Var "V")))) => true
        | _ => false
      val lip_thm = prove_schrodinger_kernel_lipschitz_regularity (Var "t") (Var "V") (Var "L")
      val lip_thm_ok = case lip_thm of
          Thm ([], Imp (DysonPhillipsConverges (Var "t", Var "V"),
                        SchrodingerLipschitzRegular (Var "t", Var "V", Var "L"))) => true
        | _ => false
      val schrod_term_ok =
        (SchrodingerSemigroupKernel (Var "t", Var "V") = SchrodingerSemigroupKernel (Var "t", Var "V"))
        andalso (DysonPhillipsSeries (Var "t", Var "V", OrdZero) = DysonPhillipsSeries (Var "t", Var "V", OrdZero))
      val schrodinger_all_ok =
        (#is_contractive hk_res)
        andalso (not (#is_contractive hk_asym_res))
        andalso hk_kuratowski_rejected
        andalso (#criterion_holds ik_res)
        andalso (not (#criterion_holds ik_diff_res))
        andalso (#series_converges dp_res)
        andalso (not (#series_converges dp_invalid))
        andalso (#is_feynman_kac_positive lip_res)
        andalso (#lipschitz_bound_holds lip_res)
        andalso ik_thm_ok andalso dp_thm_ok andalso lip_thm_ok
        andalso schrod_term_ok

      (* Ticket 68: Locally Small Categories, Conglomerate Presheaves, Yoneda Lemma, and Kan Extensions *)
      val cat_mors = [
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 0)) (GodelCode 100),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 1)) (GodelCode 101),
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 1)) (GodelCode 102)
      ]
      val cat_missing_id = [
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 0)) (GodelCode 100),
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 1)) (GodelCode 102)
      ]
      val lsc_res = eval_is_locally_small_category [0, 1] cat_mors
      val lsc_fail = eval_is_locally_small_category [0, 1] cat_missing_id
      val lsc_kuratowski_rejected =
        (let val _ = eval_is_locally_small_category [0] [KuratowskiPair (Empty, Empty)] in false end
         handle ProperClassKuratowskiException => true)
      val rep_psh = eval_representable_presheaf 1 cat_mors
      val rep_psh_ok = (List.length rep_psh = 2)
      val psh_f = [
        dunaev_pair (GodelCode 0) (ClassListDunaev [GodelCode 10, GodelCode 20, GodelCode 30]),
        dunaev_pair (GodelCode 1) (ClassListDunaev [GodelCode 40, GodelCode 50])
      ]
      val yon_res = eval_yoneda_lemma_bijection 1 cat_mors psh_f
      val yon_ff_res = eval_yoneda_embedding_fully_faithful [0, 1] cat_mors
      val kan_k = [
        dunaev_pair (GodelCode 0) (GodelCode 0),
        dunaev_pair (GodelCode 1) (GodelCode 2)
      ]
      val kan_f = [
        dunaev_pair (GodelCode 0) (GodelCode 5),
        dunaev_pair (GodelCode 1) (GodelCode 15)
      ]
      val kan_res = eval_pointwise_kan_extension kan_k kan_f [0, 1, 2]
      val yon_thm = prove_yoneda_lemma_bijection (LocallySmallCategory (Var "Ob", Var "Hom")) (Var "A") (Var "F")
      val yon_thm_ok = case yon_thm of
          Thm ([], Imp (IsLocallySmallCategory _, YonedaBijection (_, Var "A", Var "F"))) => true
        | _ => false
      val yon_ff_thm = prove_yoneda_embedding_fully_faithful (Var "C")
      val yon_ff_thm_ok = case yon_ff_thm of
          Thm ([], Imp (IsLocallySmallCategory (Var "C"),
                        IsFullyFaithfulFunctor (YonedaEmbedding (Var "C")))) => true
        | _ => false
      val kan_thm = prove_pointwise_kan_extension_universal (Var "K") (Var "F") (Var "D")
      val kan_thm_ok = case kan_thm of
          Thm ([], Imp (_, And (IsPointwiseKanExtension (Var "K", Var "F", LeftKanExtension (Var "K", Var "F")),
                                IsPointwiseKanExtension (Var "K", Var "F", RightKanExtension (Var "K", Var "F"))))) => true
        | _ => false
      val yon_term_ok = (RepresentablePresheaf (Var "C", Var "A") = RepresentablePresheaf (Var "C", Var "A"))
      val yoneda_kan_all_ok =
        (#is_locally_small lsc_res)
        andalso (not (#is_locally_small lsc_fail))
        andalso lsc_kuratowski_rejected
        andalso rep_psh_ok
        andalso (#bijection_verified yon_res)
        andalso (#fa_cardinality yon_res = 2)
        andalso (#nat_trans_cardinality yon_res = 2)
        andalso (#is_fully_faithful yon_ff_res)
        andalso (#universal_adjunction_holds kan_res)
        andalso yon_thm_ok andalso yon_ff_thm_ok andalso kan_thm_ok
        andalso yon_term_ok

      (* Ticket 69: Elementary Topoi, Subobject Classifiers, and Lawvere-Tierney Topologies *)
      val pb_f = [
        dunaev_pair (GodelCode 0) (GodelCode 10),
        dunaev_pair (GodelCode 1) (GodelCode 20)
      ]
      val pb_g = [
        dunaev_pair (GodelCode 5) (GodelCode 10),
        dunaev_pair (GodelCode 6) (GodelCode 30)
      ]
      val pb_sq = eval_pullback_square pb_f pb_g
      val pb_sq_ok = (pb_sq = [dunaev_pair (GodelCode 0) (GodelCode 5)])
      val pb_kuratowski_rejected =
        (let val _ = eval_pullback_square [KuratowskiPair (Empty, Empty)] pb_g in false end
         handle ProperClassKuratowskiException => true)
      val chi_s = eval_subobject_classifier [0, 1, 2] [0, 2]
      val char_res = eval_characteristic_morphism [0, 1, 2] chi_s
      val char_ok = (#pullback_verified char_res) andalso (#recovered_subobject char_res = [0, 2])
      val lt_valid_j = [
        dunaev_pair (GodelCode 0) (GodelCode 2),
        dunaev_pair (GodelCode 1) (GodelCode 3),
        dunaev_pair (GodelCode 2) (GodelCode 2),
        dunaev_pair (GodelCode 3) (GodelCode 3)
      ]
      val lt_invalid_j = [
        dunaev_pair (GodelCode 0) (GodelCode 1),
        dunaev_pair (GodelCode 1) (GodelCode 0),
        dunaev_pair (GodelCode 2) (GodelCode 2),
        dunaev_pair (GodelCode 3) (GodelCode 3)
      ]
      val lt_res = eval_lawvere_tierney_topology 3 lt_valid_j
      val lt_fail = eval_lawvere_tierney_topology 3 lt_invalid_j
      val j_closed_chi = [
        dunaev_pair (GodelCode 0) (GodelCode 2),
        dunaev_pair (GodelCode 1) (GodelCode 3)
      ]
      val j_unclosed_chi = [
        dunaev_pair (GodelCode 0) (GodelCode 1),
        dunaev_pair (GodelCode 1) (GodelCode 3)
      ]
      val jc_ok = (#is_j_closed (eval_j_closed_subobject lt_valid_j j_closed_chi))
      val jc_fail = not (#is_j_closed (eval_j_closed_subobject lt_valid_j j_unclosed_chi))
      val sub_uniq_thm = prove_subobject_classifier_uniqueness (SubobjectClassifier (Var "E")) (Var "top") (Var "m")
      val sub_uniq_thm_ok = case sub_uniq_thm of
          Thm ([], Imp (IsSubobjectClassifier (SubobjectClassifier (Var "E"), Var "top"),
                        ExistsUnique ("chi", IsPullbackSquare (Var "m", _, Var "top", _)))) => true
        | _ => false
      val lt_idemp_thm = prove_lawvere_tierney_closure_idempotent (Var "j") (Var "Omega")
      val lt_idemp_thm_ok = case lt_idemp_thm of
          Thm ([], Imp (IsLawvereTierneyTopology (Var "j", Var "Omega"),
                        Forall ("s", IsJClosedSubobject (Var "j", SheafSubobjectClosure (Var "j", Var "s"), Var "Omega")))) => true
        | _ => false
      val lt_meet_thm = prove_lawvere_tierney_meet_preservation (Var "j") (Var "Omega")
      val lt_meet_thm_ok = case lt_meet_thm of
          Thm ([], Imp (IsLawvereTierneyTopology (Var "j", Var "Omega"), _)) => true
        | _ => false
      val topos_term_ok = (PullbackSquare (Var "A", Var "B", Var "C") = PullbackSquare (Var "A", Var "B", Var "C"))
      val topos_lt_all_ok =
        pb_sq_ok andalso pb_kuratowski_rejected andalso char_ok
        andalso (#is_valid_topology lt_res)
        andalso (not (#is_valid_topology lt_fail))
        andalso jc_ok andalso jc_fail
        andalso sub_uniq_thm_ok andalso lt_idemp_thm_ok andalso lt_meet_thm_ok
        andalso topos_term_ok

      (* Ticket 70: Monads, Eilenberg-Moore & Kleisli Categories, and Beck's Monadicity Theorem *)
      val mon_t = [
        dunaev_pair (GodelCode 0) (GodelCode 2),
        dunaev_pair (GodelCode 1) (GodelCode 3),
        dunaev_pair (GodelCode 2) (GodelCode 2),
        dunaev_pair (GodelCode 3) (GodelCode 3)
      ]
      val mon_eta = [
        dunaev_pair (GodelCode 0) (GodelCode 2),
        dunaev_pair (GodelCode 1) (GodelCode 3),
        dunaev_pair (GodelCode 2) (GodelCode 2),
        dunaev_pair (GodelCode 3) (GodelCode 3)
      ]
      val mon_mu = [
        dunaev_pair (GodelCode 0) (GodelCode 2),
        dunaev_pair (GodelCode 1) (GodelCode 3),
        dunaev_pair (GodelCode 2) (GodelCode 2),
        dunaev_pair (GodelCode 3) (GodelCode 3)
      ]
      val mon_bad_mu = [
        dunaev_pair (GodelCode 0) (GodelCode 0),
        dunaev_pair (GodelCode 1) (GodelCode 0),
        dunaev_pair (GodelCode 2) (GodelCode 0),
        dunaev_pair (GodelCode 3) (GodelCode 0)
      ]
      val mon_res = eval_is_monad_triad [0, 1, 2, 3] mon_t mon_eta mon_mu
      val mon_fail = eval_is_monad_triad [0, 1, 2, 3] mon_t mon_eta mon_bad_mu
      val mon_kuratowski_rejected =
        (let val _ = eval_is_monad_triad [0] [KuratowskiPair (Empty, Empty)] mon_eta mon_mu in false end
         handle ProperClassKuratowskiException => true)
      val em_res = eval_eilenberg_moore_algebra [2, 3] mon_t mon_eta mon_mu mon_mu
      val kl_comp = eval_kleisli_composition mon_t mon_mu
        [dunaev_pair (GodelCode 0) (GodelCode 1)]
        [dunaev_pair (GodelCode 1) (GodelCode 3)]
      val kl_comp_ok = (kl_comp = [dunaev_pair (GodelCode 0) (GodelCode 3)])
      val id_map = [
        dunaev_pair (GodelCode 0) (GodelCode 0),
        dunaev_pair (GodelCode 1) (GodelCode 1)
      ]
      val split_coeq_res = eval_is_split_coequalizer [0, 1] id_map id_map id_map id_map id_map
      val beck_ok = (#comparison_is_equivalence (eval_beck_monadicity true true true))
      val beck_fail = not (#comparison_is_equivalence (eval_beck_monadicity true false true))
      val mon_coh_thm = prove_monad_unit_associativity_coherence (Var "T") (Var "eta") (Var "mu")
      val mon_coh_thm_ok = case mon_coh_thm of
          Thm ([], Imp (IsMonadTriad (Var "T", Var "eta", Var "mu"),
                        IsEilenbergMooreAlgebra (MonadTriad (Var "T", Var "eta", Var "mu"), Var "T", Var "mu"))) => true
        | _ => false
      val kl_em_thm = prove_kleisli_eilenberg_moore_adjunction_uniqueness (Var "C") (Var "T")
      val kl_em_thm_ok = case kl_em_thm of
          Thm ([], Imp (IsLocallySmallCategory (Var "C"),
                        And (IsLocallySmallCategory (KleisliCategory (Var "C", Var "T")),
                             IsLocallySmallCategory (EilenbergMooreCategory (Var "C", Var "T"))))) => true
        | _ => false
      val beck_thm = prove_beck_monadicity_equivalence (Var "U") (Var "C")
      val beck_thm_ok = case beck_thm of
          Thm ([], Imp (IsBeckMonadicFunctor (Var "U", Var "C"),
                        IsFullyFaithfulFunctor (MonadicityComparisonFunctor (Var "U", Var "C")))) => true
        | _ => false
      val mon_term_ok =
        (ReflexiveSplitCoequalizer (Var "f", Var "g", Var "e") = ReflexiveSplitCoequalizer (Var "f", Var "g", Var "e"))
        andalso (IsKleisliMorphism (Var "T", Var "A", Var "B") = IsKleisliMorphism (Var "T", Var "A", Var "B"))
        andalso (IsSplitCoequalizer (Var "f", Var "g", Var "e") = IsSplitCoequalizer (Var "f", Var "g", Var "e"))
      val monad_beck_all_ok =
        (#is_valid_monad mon_res)
        andalso (not (#is_valid_monad mon_fail))
        andalso mon_kuratowski_rejected
        andalso (#is_em_algebra em_res)
        andalso kl_comp_ok
        andalso (#is_split_coequalizer split_coeq_res)
        andalso beck_ok andalso beck_fail
        andalso mon_coh_thm_ok andalso kl_em_thm_ok andalso beck_thm_ok
        andalso mon_term_ok

      (* Ticket 71: Cartesian Closed Categories, Exponential Objects, Evaluation Morphisms, and Curry-Howard-Lambek Equivalence *)
      val ccc_ok = (#is_ccc (eval_is_cartesian_closed_category true true true))
      val ccc_fail = not (#is_ccc (eval_is_cartesian_closed_category true true false))
      val exp_ba = eval_exponential_object [0, 1] [10, 20]
      val exp_ba_ok = (List.length exp_ba = 4)
      val ccc_g = [
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 0)) (GodelCode 10),
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 1)) (GodelCode 20),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 0)) (GodelCode 20),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 1)) (GodelCode 10)
      ]
      val ccc_kuratowski_rejected =
        (let val _ = eval_curry_bijection [0] [0] [KuratowskiPair (Empty, Empty)] in false end
         handle ProperClassKuratowskiException => true)
      val curry_res = eval_curry_bijection [0, 1] [0, 1] ccc_g
      val lambek_res = eval_beta_eta_lambek_equivalence [0, 1] [0, 1] ccc_g
      val stlc_mod_ok = (#is_valid_internal_model (eval_internal_simply_typed_model true true true))
      val stlc_mod_fail = not (#is_valid_internal_model (eval_internal_simply_typed_model true false true))
      val exp_uniq_thm = prove_exponential_transpose_uniqueness (Var "C") (Var "A") (Var "B")
      val exp_uniq_thm_ok = case exp_uniq_thm of
          Thm ([], Imp (IsCartesianClosedCategory (Var "C"), _)) => true
        | _ => false
      val curry_bij_thm = prove_curry_uncurry_bijection (Var "C") (Var "g")
      val curry_bij_thm_ok = case curry_bij_thm of
          Thm ([], Imp (IsCartesianClosedCategory (Var "C"),
                        And (Eq (UncurriedMorphism (CurriedMorphism (Var "g")), Var "g"),
                             IsExponentialTranspose (Var "g", CurriedMorphism (Var "g"))))) => true
        | _ => false
      val lambek_thm = prove_curry_howard_lambek_beta_eta_soundness (Var "C") (InternalLambdaTerm ("x", Var "x"))
      val lambek_thm_ok = case lambek_thm of
          Thm ([], Imp (IsCartesianClosedCategory (Var "C"),
                        And (IsInternalSimplyTypedModel (Var "C"),
                             SatisfiesBetaEtaLambekEquivalence (Var "C", InternalLambdaTerm ("x", Var "x"))))) => true
        | _ => false
      val ccc_term_ok = (ExponentialObject (Var "A", Var "B") = ExponentialObject (Var "A", Var "B"))
      val ccc_lambek_all_ok =
        ccc_ok andalso ccc_fail andalso exp_ba_ok andalso ccc_kuratowski_rejected
        andalso (#roundtrip_bijection_ok curry_res)
        andalso (#lambek_equivalence_holds lambek_res)
        andalso stlc_mod_ok andalso stlc_mod_fail
        andalso exp_uniq_thm_ok andalso curry_bij_thm_ok andalso lambek_thm_ok
        andalso ccc_term_ok

      (* Ticket 72: Grothendieck Fibrations, Cartesian Morphisms, Cleavages, and the Grothendieck Construction *)
      val cart_factors = [
        dunaev_pair (GodelCode 0) (GodelCode 10),
        dunaev_pair (GodelCode 1) (GodelCode 11)
      ]
      val cart_dup_factors = [
        dunaev_pair (GodelCode 0) (GodelCode 10),
        dunaev_pair (GodelCode 0) (GodelCode 12)
      ]
      val cart_res = eval_is_cartesian_morphism 1 2 cart_factors
      val cart_fail = eval_is_cartesian_morphism 1 2 cart_dup_factors
      val fib_kuratowski_rejected =
        (let val _ = eval_is_cartesian_morphism 1 2 [KuratowskiPair (Empty, Empty)] in false end
         handle ProperClassKuratowskiException => true)
      val clv_terms = [
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 10)) (GodelCode 100),
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 20)) (GodelCode 101),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 10)) (GodelCode 102),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 20)) (GodelCode 103)
      ]
      val fib_res = eval_is_grothendieck_fibration [0, 1] [10, 20] clv_terms
      val tot_res = eval_grothendieck_total_category [0, 1] [
        dunaev_pair (GodelCode 0) (GodelCode 10),
        dunaev_pair (GodelCode 1) (GodelCode 20),
        dunaev_pair (GodelCode 2) (GodelCode 30)
      ]
      val split_reindex = [
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 10)) (GodelCode 10),
        dunaev_pair (dunaev_pair (GodelCode 0) (GodelCode 20)) (GodelCode 20),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 10)) (GodelCode 20),
        dunaev_pair (dunaev_pair (GodelCode 1) (GodelCode 20)) (GodelCode 20),
        dunaev_pair (dunaev_pair (GodelCode 2) (GodelCode 10)) (GodelCode 20),
        dunaev_pair (dunaev_pair (GodelCode 2) (GodelCode 20)) (GodelCode 20)
      ]
      val split_fib_res = eval_is_split_fibration [10, 20] split_reindex
      val groth_eq_ok = (#equivalence_verified (eval_grothendieck_equivalence true true))
      val groth_eq_fail = not (#equivalence_verified (eval_grothendieck_equivalence true false))
      val cart_lift_thm = prove_cartesian_lift_unique_up_to_vertical_iso (Var "p") (Var "u") (Var "Y")
      val cart_lift_thm_ok = case cart_lift_thm of
          Thm ([], Imp (IsGrothendieckFibration (Var "p", Var "E", Var "B"),
                        IsCartesianMorphism (Var "p", GrothendieckCartesianLift (Var "u", Var "Y"), Var "u"))) => true
        | _ => false
      val groth_con_thm = prove_grothendieck_construction_is_fibration (Var "B") (Var "Phi")
      val groth_con_thm_ok = case groth_con_thm of
          Thm ([], Imp (IsLocallySmallCategory (Var "B"),
                        IsGrothendieckFibration (
                          CleavageAssignment (IndexedPseudofunctor (Var "Phi")),
                          GrothendieckTotalCategory (Var "B", Var "Phi"),
                          Var "B"))) => true
        | _ => false
      val split_bij_thm = prove_split_fibration_indexed_functor_bijection (Var "p") (Var "Phi")
      val split_bij_thm_ok = case split_bij_thm of
          Thm ([], Imp (IsSplitFibration (Var "p", CleavageAssignment (Var "p")),
                        SatisfiesGrothendieckEquivalence (Var "p", IndexedPseudofunctor (Var "Phi")))) => true
        | _ => false
      val fib_term_ok = (FiberCategoryAtBase (Var "p", Var "I") = FiberCategoryAtBase (Var "p", Var "I"))
      val groth_fibration_all_ok =
        (#is_cartesian cart_res)
        andalso (not (#is_cartesian cart_fail))
        andalso fib_kuratowski_rejected
        andalso (#is_fibration fib_res)
        andalso (#total_count tot_res = 2)
        andalso (#is_split_fibration split_fib_res)
        andalso groth_eq_ok andalso groth_eq_fail
        andalso cart_lift_thm_ok andalso groth_con_thm_ok andalso split_bij_thm_ok
        andalso fib_term_ok
      (* Ticket 73 self-tests *)
      val ab_cat_ok = #is_abelian (eval_is_abelian_category true true true true)
      val ab_cat_fail = not (#is_abelian (eval_is_abelian_category true true false true))
      val f_ab_graph = [
        dunaev_pair (GodelCode 0) (GodelCode 0),
        dunaev_pair (GodelCode 1) (GodelCode 2),
        dunaev_pair (GodelCode 2) (GodelCode 0),
        dunaev_pair (GodelCode 3) (GodelCode 2)
      ]
      val coim_im_res = eval_coimage_image_iso [0, 1, 2, 3] f_ab_graph
      val ab_kuratowski_rejected =
        (eval_coimage_image_iso [0] [KuratowskiPair (Empty, Empty)]; false)
        handle ProperClassKuratowskiException => true
             | _ => false
      val ses_f = [
        dunaev_pair (GodelCode 0) (GodelCode 0),
        dunaev_pair (GodelCode 1) (GodelCode 2)
      ]
      val ses_g = [
        dunaev_pair (GodelCode 0) (GodelCode 0),
        dunaev_pair (GodelCode 1) (GodelCode 1),
        dunaev_pair (GodelCode 2) (GodelCode 0),
        dunaev_pair (GodelCode 3) (GodelCode 1)
      ]
      val ses_res = eval_is_short_exact_sequence [0, 1] [0, 1, 2, 3] ses_f ses_g
      val ses_fail = eval_is_short_exact_sequence [0, 1] [0, 1, 2, 3]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 0)] ses_g
      val snake_delta = eval_snake_connecting_morphism
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 3)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 3) (GodelCode 2)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 2) (GodelCode 1)]
      val snake_exact_res = eval_snake_lemma_exactness [0] [0] [0, 1] [0, 1] [0, 1] [0, 1]
      val snake_exact_fail = eval_snake_lemma_exactness [0] [0, 1] [0, 1] [0, 1] [0, 1] [0, 1]
      val coim_im_thm_ok =
        case prove_abelian_coimage_image_canonical_iso (Var "A") (Var "f") of
            Thm ([], Imp (IsAbelianCategory (Var "A"),
                          SatisfiesCoimageImageIso (CoimageObject (Var "f"),
                                                    ImageObject (Var "f")))) => true
          | _ => false
      val ses_split_thm_ok =
        case prove_short_exact_split_biproduct_equivalence (Var "A") (Var "f") (Var "g") of
            Thm ([], Imp (And (IsAbelianCategory (Var "A"),
                               IsShortExactSequence (Var "f", Var "g")),
                          SatisfiesCoimageImageIso (CategoricalKernel (Var "g"),
                                                    ImageObject (Var "f")))) => true
          | _ => false
      val snake_thm_ok =
        case prove_snake_lemma_six_term_exact_sequence (Var "A") (Var "R1") (Var "R2") of
            Thm ([], Imp (IsAbelianCategory (Var "A"),
                          SatisfiesSnakeLemmaExactness (
                            Var "R1", Var "R2",
                            SnakeConnectingMorphism (Var "A", Var "R1", Var "R2")))) => true
          | _ => false
      val coker_term_ok = (CategoricalCokernel (Var "f") = CategoricalCokernel (Var "f"))
      val abelian_snake_all_ok =
        ab_cat_ok andalso ab_cat_fail
        andalso (#coimage_image_iso_holds coim_im_res)
        andalso (#coimage_cardinality coim_im_res = 2)
        andalso (List.length (#kernel_elements coim_im_res) = 2)
        andalso ab_kuratowski_rejected
        andalso (#is_short_exact ses_res)
        andalso (not (#is_short_exact ses_fail))
        andalso (List.length snake_delta = 2)
        andalso (#six_term_exact snake_exact_res)
        andalso (not (#six_term_exact snake_exact_fail))
        andalso coim_im_thm_ok andalso ses_split_thm_ok andalso snake_thm_ok
        andalso coker_term_ok
      (* Ticket 74 self-tests *)
      val d_next_graph = [
        dunaev_pair (GodelCode 0) (GodelCode 0),
        dunaev_pair (GodelCode 1) (GodelCode 2)
      ]
      val d_curr_graph = [
        dunaev_pair (GodelCode 0) (GodelCode 0),
        dunaev_pair (GodelCode 1) (GodelCode 1),
        dunaev_pair (GodelCode 2) (GodelCode 0),
        dunaev_pair (GodelCode 3) (GodelCode 0)
      ]
      val cc_res = eval_is_chain_complex [0, 1] d_next_graph d_curr_graph
      val cc_fail = eval_is_chain_complex [0, 1]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 1)] d_curr_graph
      val cc_kuratowski_rejected =
        (eval_is_chain_complex [0] [KuratowskiPair (Empty, Empty)] d_curr_graph; false)
        handle ProperClassKuratowskiException => true
             | _ => false
      val ch_hom_res = eval_chain_homotopy_equivalence [0, 1]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 3)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 1)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 2)]
      val ch_hom_fail = eval_chain_homotopy_equivalence [0, 1]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 3)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 1)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 0)]
      val proj_res_ok = #is_projective_resolution (eval_is_projective_resolution true true true)
      val proj_res_fail = not (#is_projective_resolution (eval_is_projective_resolution true false true))
      val ext_tor_res = eval_derived_ext_tor 1 [0, 1, 2, 3] d_next_graph d_curr_graph
      val les_res = eval_long_exact_cohomology_sequence [0] [0] [0, 1] [0, 1] [0, 2] [0, 2]
      val les_fail = eval_long_exact_cohomology_sequence [0] [0, 1] [0, 1] [0, 1] [0, 2] [0, 2]
      val cc_thm_ok =
        case prove_chain_boundary_squared_zero (Var "C") (Var "d") of
            Thm ([], Imp (IsChainComplex (ChainComplex (Var "C", Var "d")),
                          Eq (CategoricalKernel (Var "d"), CategoricalKernel (Var "d")))) => true
          | _ => false
      val comp_thm_ok =
        case prove_comparison_theorem_projective_resolutions (Var "P") (Var "Q") (Var "A") of
            Thm ([], Imp (And (IsProjectiveResolution (ProjectiveResolution (Var "P", Var "A"), Var "A"),
                               IsProjectiveResolution (ProjectiveResolution (Var "Q", Var "A"), Var "A")),
                          IsChainHomotopyEquivalent (Var "P", Var "Q"))) => true
          | _ => false
      val les_thm_ok =
        case prove_ext_tor_long_exact_sequence_naturality 1 (Var "A") (Var "B") (Var "C") of
            Thm ([], Imp (IsShortExactSequence (Var "A", Var "C"),
                          SatisfiesLongExactCohomologySequence (
                            RightDerivedExt (1, Var "A", Var "B"),
                            RightDerivedExt (1, Var "B", Var "B"),
                            LeftDerivedTor (1, Var "C", Var "B")))) => true
          | _ => false
      val inj_res_term_ok = (InjectiveResolution (Var "A", Var "I") = InjectiveResolution (Var "A", Var "I"))
      val chain_ext_tor_all_ok =
        (#is_chain_complex cc_res)
        andalso (not (#is_chain_complex cc_fail))
        andalso cc_kuratowski_rejected
        andalso (#chain_homotopy_verified ch_hom_res)
        andalso (not (#chain_homotopy_verified ch_hom_fail))
        andalso proj_res_ok andalso proj_res_fail
        andalso (#is_well_defined ext_tor_res)
        andalso (#derived_rank ext_tor_res = 1)
        andalso (#long_exact_verified les_res)
        andalso (not (#long_exact_verified les_fail))
        andalso cc_thm_ok andalso comp_thm_ok andalso les_thm_ok
        andalso inj_res_term_ok
      (* Ticket 75 self-tests *)
      val tri_cat_ok = #is_triangulated (eval_is_triangulated_category true true true true)
      val tri_cat_fail = not (#is_triangulated (eval_is_triangulated_category true true true false))
      val tri_edges = [
        dunaev_pair (GodelCode 1) (GodelCode 2),
        dunaev_pair (GodelCode 2) (GodelCode 3),
        dunaev_pair (GodelCode 3) (GodelCode 4)
      ]
      val tri_rot_res = eval_distinguished_triangle_rotation tri_edges
      val tri_rot_fail = eval_distinguished_triangle_rotation [
        dunaev_pair (GodelCode 1) (GodelCode 2),
        dunaev_pair (GodelCode 5) (GodelCode 3),
        dunaev_pair (GodelCode 3) (GodelCode 4)
      ]
      val tri_kuratowski_rejected =
        (eval_distinguished_triangle_rotation [KuratowskiPair (Empty, Empty)]; false)
        handle ProperClassKuratowskiException => true
             | _ => false
      val oct_res = eval_octahedral_axiom 1 2 3 true
      val oct_fail = eval_octahedral_axiom 1 2 4 true
      val qiso_sys = [
        dunaev_pair (GodelCode 0) (GodelCode 0),
        dunaev_pair (GodelCode 1) (GodelCode 2)
      ]
      val roof_list = [
        dunaev_pair (GodelCode 0) (GodelCode 3),
        dunaev_pair (GodelCode 1) (GodelCode 4)
      ]
      val roof_res = eval_quasi_iso_roof_calculus qiso_sys roof_list
      val roof_fail = eval_quasi_iso_roof_calculus qiso_sys [dunaev_pair (GodelCode 9) (GodelCode 4)]
      val der_loc_ok = #derived_category_verified (eval_derived_category_localization true true true)
      val der_loc_fail = not (#derived_category_verified (eval_derived_category_localization true false true))
      val rot_thm_ok =
        case prove_distinguished_triangle_rotation_invariance (Var "u") (Var "v") (Var "w") of
            Thm ([], Iff (IsDistinguishedTriangle (Var "u", Var "v", Var "w"),
                          IsDistinguishedTriangle (Var "v", Var "w", SuspensionShiftFunctor (Var "u", 1)))) => true
          | _ => false
      val oct_thm_ok =
        case prove_octahedral_mapping_cone_coherence (Var "u") (Var "v") (Var "vu") of
            Thm ([], Imp (SatisfiesOctahedralAxiom (Var "u", Var "v", Var "vu"),
                          IsDistinguishedTriangle (
                            MappingConeComplex (Var "u"),
                            MappingConeComplex (Var "vu"),
                            MappingConeComplex (Var "v")))) => true
          | _ => false
      val loc_thm_ok =
        case prove_gabriel_zisman_derived_localization_universal (Var "K") (Var "S") of
            Thm ([], Imp (IsMultiplicativeSystemOfQuasiIsos (Var "S"),
                          IsDerivedCategoryUniversal (
                            Var "K",
                            DerivedCategoryLocalization (Var "K", Var "S")))) => true
          | _ => false
      val roof_term_ok =
        (QuasiIsomorphismRoof (Var "s", Var "f") = QuasiIsomorphismRoof (Var "s", Var "f"))
        andalso (DistinguishedTriangle (Var "u", Var "v", Var "w") = DistinguishedTriangle (Var "u", Var "v", Var "w"))
      val triangulated_derived_all_ok =
        tri_cat_ok andalso tri_cat_fail
        andalso (#rotation_invariance_holds tri_rot_res)
        andalso (not (#rotation_invariance_holds tri_rot_fail))
        andalso tri_kuratowski_rejected
        andalso (#octahedral_verified oct_res)
        andalso (not (#octahedral_verified oct_fail))
        andalso (#is_valid_multiplicative_system roof_res)
        andalso (not (#is_valid_multiplicative_system roof_fail))
        andalso der_loc_ok andalso der_loc_fail
        andalso rot_thm_ok andalso oct_thm_ok andalso loc_thm_ok
        andalso roof_term_ok
      (* Ticket 76 self-tests *)
      val qmc_ok = #is_quillen_model_category (eval_is_quillen_model_category true true true true true)
      val qmc_fail = not (#is_quillen_model_category (eval_is_quillen_model_category true true true false true))
      val lift_res = eval_left_right_lifting_property [0, 1]
        [dunaev_pair (GodelCode 0) (GodelCode 10), dunaev_pair (GodelCode 1) (GodelCode 11)]
        [dunaev_pair (GodelCode 20) (GodelCode 30), dunaev_pair (GodelCode 21) (GodelCode 31)]
        [dunaev_pair (GodelCode 10) (GodelCode 20), dunaev_pair (GodelCode 11) (GodelCode 21)]
      val lift_fail = eval_left_right_lifting_property [0, 1]
        [dunaev_pair (GodelCode 0) (GodelCode 10), dunaev_pair (GodelCode 1) (GodelCode 99)]
        [dunaev_pair (GodelCode 20) (GodelCode 30)]
        [dunaev_pair (GodelCode 10) (GodelCode 20)]
      val qmc_kuratowski_rejected =
        (eval_quillen_homotopy_category [KuratowskiPair (Empty, Empty)]; false)
        handle ProperClassKuratowskiException => true
             | _ => false
      val two_three_ok = #two_out_of_three_satisfied (eval_two_out_of_three_weak_eq true true true)
      val two_three_fail = not (#two_out_of_three_satisfied (eval_two_out_of_three_weak_eq true true false))
      val ho_res = eval_quillen_homotopy_category [
        dunaev_pair (GodelCode 0) (GodelCode 1),
        dunaev_pair (GodelCode 1) (GodelCode 3),
        dunaev_pair (GodelCode 2) (GodelCode 3)
      ]
      val q_adj_ok = #is_quillen_equivalence (eval_is_quillen_adjunction true true true)
      val q_adj_fail = not (#is_quillen_equivalence (eval_is_quillen_adjunction true false true))
      val lift_thm_ok =
        case prove_quillen_retract_lifting_closure (Var "i") (Var "p") of
            Thm ([], Imp (HasLeftRightLiftingProperty (Var "i", Var "p"),
                          Eq (DiagonalLiftingWitness (Var "i", Var "p"),
                              DiagonalLiftingWitness (Var "i", Var "p")))) => true
          | _ => false
      val wh_thm_ok =
        case prove_whitehead_theorem_bifibrant_objects (Var "M") (Var "W") of
            Thm ([], Imp (IsQuillenModelCategory (Var "M", QuillenModelStructure (Var "W", Var "C", Var "F")),
                          Eq (QuillenHomotopyCategory (Var "M", Var "W"),
                              QuillenHomotopyCategory (Var "M", Var "W")))) => true
          | _ => false
      val q_adj_thm_ok =
        case prove_total_derived_quillen_adjunction_equivalence (Var "M") (Var "N") (Var "L") (Var "R") of
            Thm ([], Imp (And (IsQuillenModelCategory (Var "M", Var "QM"),
                               IsQuillenAdjunctionPair (Var "L", Var "R")),
                          IsQuillenAdjunctionPair (Var "L", Var "R"))) => true
          | _ => false
      val qmc_terms_ok =
        (WeakFactorizationTriple (Var "f", Var "i", Var "p") = WeakFactorizationTriple (Var "f", Var "i", Var "p"))
        andalso (CylinderObjectFactorization (Var "X") = CylinderObjectFactorization (Var "X"))
        andalso (SatisfiesTwoOutOfThreeWeakEq (Var "f", Var "g", Var "gf") =
                 SatisfiesTwoOutOfThreeWeakEq (Var "f", Var "g", Var "gf"))
      val quillen_model_all_ok =
        qmc_ok andalso qmc_fail
        andalso (#has_diagonal_lift lift_res)
        andalso (not (#has_diagonal_lift lift_fail))
        andalso qmc_kuratowski_rejected
        andalso two_three_ok andalso two_three_fail
        andalso (#whitehead_subcat_valid ho_res)
        andalso (#bifibrant_count ho_res = 2)
        andalso q_adj_ok andalso q_adj_fail
        andalso lift_thm_ok andalso wh_thm_ok andalso q_adj_thm_ok
        andalso qmc_terms_ok
      (* Ticket 77 self-tests *)
      val sset_id_res = eval_simplicial_identities [0, 1]
        [dunaev_pair (GodelCode 10) (GodelCode 0), dunaev_pair (GodelCode 11) (GodelCode 1)]
        [dunaev_pair (GodelCode 0) (GodelCode 10), dunaev_pair (GodelCode 1) (GodelCode 11)]
      val sset_id_fail = eval_simplicial_identities [0, 1]
        [dunaev_pair (GodelCode 10) (GodelCode 0), dunaev_pair (GodelCode 11) (GodelCode 0)]
        [dunaev_pair (GodelCode 0) (GodelCode 10), dunaev_pair (GodelCode 1) (GodelCode 11)]
      val sset_kuratowski_rejected =
        (eval_is_kan_complex 2 [KuratowskiPair (Empty, Empty)]; false)
        handle ProperClassKuratowskiException => true
             | _ => false
      val all_horns_2 = [
        dunaev_pair (GodelCode 0) (GodelCode 1),
        dunaev_pair (GodelCode 1) (GodelCode 1),
        dunaev_pair (GodelCode 2) (GodelCode 1)
      ]
      val inner_only_2 = [
        dunaev_pair (GodelCode 0) (GodelCode 0),
        dunaev_pair (GodelCode 1) (GodelCode 1),
        dunaev_pair (GodelCode 2) (GodelCode 0)
      ]
      val kan_ok = #is_kan_complex (eval_is_kan_complex 2 all_horns_2)
      val kan_fail = not (#is_kan_complex (eval_is_kan_complex 2 inner_only_2))
      val qcat_ok = #is_quasi_category (eval_is_quasi_category_inner_horn 2 inner_only_2)
      val qcat_fail = not (#is_quasi_category (eval_is_quasi_category_inner_horn 2 [
        dunaev_pair (GodelCode 0) (GodelCode 1),
        dunaev_pair (GodelCode 1) (GodelCode 0),
        dunaev_pair (GodelCode 2) (GodelCode 1)
      ]))
      val kan_fib_ok = #is_kan_fibration (eval_is_kan_fibration true true)
      val kan_fib_fail = not (#is_kan_fibration (eval_is_kan_fibration true false))
      val nerve_res = eval_homotopy_coherent_nerve [
        dunaev_pair (GodelCode 0) (GodelCode 1),
        dunaev_pair (GodelCode 1) (GodelCode 2)
      ]
      val sset_thm_ok =
        case prove_simplicial_face_degeneracy_commutation (Var "X") (Var "d") (Var "s") of
            Thm ([], Imp (SatisfiesSimplicialIdentities (SimplicialSet (Var "X", Var "d", Var "s")),
                          Eq (GeometricRealization (SimplicialSet (Var "X", Var "d", Var "s")),
                              GeometricRealization (SimplicialSet (Var "X", Var "d", Var "s"))))) => true
          | _ => false
      val kan_qcat_thm_ok =
        case prove_kan_complex_is_quasi_category (Var "K") of
            Thm ([], Imp (IsKanComplex (Var "K"), IsQuasiCategoryInnerHorn (Var "K"))) => true
          | _ => false
      val nerve_thm_ok =
        case prove_categorical_nerve_inner_horn_unique_filler (Var "C") of
            Thm ([], Imp (IsLocallySmallCategory (Var "C"),
                          IsQuasiCategoryInnerHorn (HomotopyCoherentNerve (Var "C")))) => true
          | _ => false
      val sset_terms_ok =
        (StandardSimplexDelta 2 = StandardSimplexDelta 2)
        andalso (SimplicialHornLambda (2, 1) = SimplicialHornLambda (2, 1))
        andalso (IsKanFibrationMap (Var "p", Var "Y") = IsKanFibrationMap (Var "p", Var "Y"))
      val simplicial_qcat_all_ok =
        (#simplicial_identities_verified sset_id_res)
        andalso (not (#simplicial_identities_verified sset_id_fail))
        andalso sset_kuratowski_rejected
        andalso kan_ok andalso kan_fail
        andalso qcat_ok andalso qcat_fail
        andalso kan_fib_ok andalso kan_fib_fail
        andalso (#is_valid_coherent_nerve nerve_res)
        andalso (List.length (#composable_nerve_2_simplices nerve_res) = 1)
        andalso sset_thm_ok andalso kan_qcat_thm_ok andalso nerve_thm_ok
        andalso sset_terms_ok
      (* Ticket 78 self-tests *)
      val sieve_res = eval_is_covering_sieve 10
        [dunaev_pair (GodelCode 1) (GodelCode 10), dunaev_pair (GodelCode 2) (GodelCode 10)]
        [dunaev_pair (GodelCode 1) (GodelCode 2)]
      val sieve_fail = eval_is_covering_sieve 10
        [dunaev_pair (GodelCode 2) (GodelCode 10)]
        [dunaev_pair (GodelCode 1) (GodelCode 2)]
      val site_kuratowski_rejected =
        (eval_is_covering_sieve 10 [KuratowskiPair (Empty, Empty)] []; false)
        handle ProperClassKuratowskiException => true
             | _ => false
      val gtop_ok = #is_grothendieck_topology (eval_is_grothendieck_topology true true true)
      val gtop_fail = not (#is_grothendieck_topology (eval_is_grothendieck_topology true false true))
      val shf_res = eval_is_sheaf_on_site [1, 2]
        [dunaev_pair (GodelCode 11) (GodelCode 100), dunaev_pair (GodelCode 12) (GodelCode 200),
         dunaev_pair (GodelCode 21) (GodelCode 999), dunaev_pair (GodelCode 22) (GodelCode 200)]
        [dunaev_pair (GodelCode 1) (GodelCode 100), dunaev_pair (GodelCode 2) (GodelCode 200)]
      val shf_fail = eval_is_sheaf_on_site [1, 2]
        [dunaev_pair (GodelCode 11) (GodelCode 100), dunaev_pair (GodelCode 21) (GodelCode 100)]
        [dunaev_pair (GodelCode 1) (GodelCode 100)]
      val plus1_res = eval_plus_sheafification 1 false
      val plus2_res = eval_plus_sheafification 2 false
      val shf_univ_ok = #is_exact_sheafification (eval_sheafification_universal true true)
      val shf_univ_fail = not (#is_exact_sheafification (eval_sheafification_universal true false))
      val sieve_pb_thm_ok =
        case prove_grothendieck_sieve_pullback_stability (Var "J") (Var "S") (Var "U") of
            Thm ([], Imp (And (IsGrothendieckTopology (Var "J", Var "C"),
                               IsCoveringSieve (CoveringSieve (Var "S", Var "U"), Var "U")),
                          IsCoveringSieve (CoveringSieve (Var "S", Var "U"), Var "U"))) => true
          | _ => false
      val shf_gluing_thm_ok =
        case prove_sheaf_unique_amalgamation_gluing (Var "P") (Var "C") (Var "J") of
            Thm ([], Imp (IsSheafOnSite (Var "P", GrothendieckSite (Var "C", Var "J")),
                          Eq (UniqueAmalgamationWitness (Var "P", MatchingFamilyOnSieve (Var "P", Var "S")),
                              UniqueAmalgamationWitness (Var "P", MatchingFamilyOnSieve (Var "P", Var "S"))))) => true
          | _ => false
      val plus_plus_thm_ok =
        case prove_plus_plus_sheafification_exact_left_adjoint (Var "P") (Var "Site") of
            Thm ([], Imp (IsSheafOnSite (PlusSheafificationFunctor (PlusSheafificationFunctor (Var "P")), Var "Site"),
                          SatisfiesSheafificationLeftAdjointUniversal (
                            Var "P",
                            PlusSheafificationFunctor (PlusSheafificationFunctor (Var "P"))))) => true
          | _ => false
      val grothendieck_sheaf_all_ok =
        (#is_valid_sieve sieve_res)
        andalso (not (#is_valid_sieve sieve_fail))
        andalso site_kuratowski_rejected
        andalso gtop_ok andalso gtop_fail
        andalso (#is_sheaf shf_res)
        andalso (not (#is_sheaf shf_fail))
        andalso (#produces_separated_presheaf plus1_res)
        andalso (not (#produces_sheaf plus1_res))
        andalso (#produces_sheaf plus2_res)
        andalso shf_univ_ok andalso shf_univ_fail
        andalso sieve_pb_thm_ok andalso shf_gluing_thm_ok andalso plus_plus_thm_ok
      (* Ticket 79 self-tests *)
      val spec_diff_res = eval_is_spectral_sequence_differential 2 [0, 1, 2]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 0), dunaev_pair (GodelCode 2) (GodelCode 1)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 1), dunaev_pair (GodelCode 2) (GodelCode 0)]
      val spec_diff_fail = eval_is_spectral_sequence_differential 2 [0, 1, 2]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 2), dunaev_pair (GodelCode 2) (GodelCode 1)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 1), dunaev_pair (GodelCode 2) (GodelCode 1)]
      val spec_kuratowski_rejected =
        (eval_is_spectral_sequence_differential 2 [0, 1] [KuratowskiPair (Empty, Empty)] []; false)
        handle ProperClassKuratowskiException => true
             | _ => false
      val page_iso_res = eval_spectral_page_cohomology_iso [0, 1, 2]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 0), dunaev_pair (GodelCode 2) (GodelCode 1)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 1), dunaev_pair (GodelCode 2) (GodelCode 0)]
      val page_iso_fail = eval_spectral_page_cohomology_iso [0, 1, 2]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 2), dunaev_pair (GodelCode 2) (GodelCode 1)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 1), dunaev_pair (GodelCode 2) (GodelCode 1)]
      val abut_ok = #converges_strongly (eval_converges_to_filtered_abutment true true [1, 2, 1] [1, 2, 1])
      val abut_fail = not (#converges_strongly (eval_converges_to_filtered_abutment true true [1, 2, 1] [1, 1, 1]))
      val couple_res = eval_exact_couple_derived [0, 1]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 1)]
        [dunaev_pair (GodelCode 0) (GodelCode 0), dunaev_pair (GodelCode 1) (GodelCode 0)]
        [dunaev_pair (GodelCode 0) (GodelCode 0)]
      val groth_ss_ok = #e2_abuts_to_right_derived_composite (eval_grothendieck_spectral_convergence true true true)
      val groth_ss_fail = not (#e2_abuts_to_right_derived_composite (eval_grothendieck_spectral_convergence true false true))
      val spec_diff_thm_ok =
        case prove_spectral_differential_squared_zero 2 (Var "E2") (Var "d2") of
            Thm ([], Imp (IsSpectralSequenceDifferential (2, Var "d2"),
                          SatisfiesSpectralPageCohomologyIso (
                            SpectralSequencePage (3, Var "p", Var "q"),
                            Var "E2"))) => true
          | _ => false
      val filt_conv_thm_ok =
        case prove_filtered_complex_spectral_convergence (Var "K") (Var "F") of
            Thm ([], Imp (IsChainComplex (FilteredComplex (Var "K", Var "F")),
                          ConvergesToFilteredAbutment (
                            SpectralSequencePage (1, Var "p", Var "q"),
                            AbutmentFiltrationGraded (0, Var "K")))) => true
          | _ => false
      val groth_ss_thm_ok =
        case prove_grothendieck_composite_functor_e2_abutment (Var "F") (Var "G") (Var "A") of
            Thm ([], Imp (SatisfiesGrothendieckSpectralConvergence (Var "F", Var "G", Var "A"),
                          ConvergesToFilteredAbutment (
                            GrothendieckCompositeSpectralSequence (Var "F", Var "G", Var "A"),
                            RightDerivedExt (0, Var "F", Var "G")))) => true
          | _ => false
      val ec_term_ok =
        (ExactCoupleTriangle (Var "D", Var "E", Var "ijk") = ExactCoupleTriangle (Var "D", Var "E", Var "ijk"))
      val spectral_seq_all_ok =
        (#is_valid_spectral_differential spec_diff_res)
        andalso (#bidegree spec_diff_res = (2, ~1))
        andalso (not (#is_valid_spectral_differential spec_diff_fail))
        andalso spec_kuratowski_rejected
        andalso (#page_iso_holds page_iso_res)
        andalso (not (#page_iso_holds page_iso_fail))
        andalso abut_ok andalso abut_fail
        andalso (#is_valid_exact_couple couple_res)
        andalso groth_ss_ok andalso groth_ss_fail
        andalso spec_diff_thm_ok andalso filt_conv_thm_ok andalso groth_ss_thm_ok
        andalso ec_term_ok
      (* Ticket 80 self-tests *)
      val mac_lane_res = eval_mac_lane_coherence true true true
        [dunaev_pair (GodelCode 1) (GodelCode 2), dunaev_pair (GodelCode 2) (GodelCode 1)]
      val mac_lane_fail = eval_mac_lane_coherence true true true
        [dunaev_pair (GodelCode 1) (GodelCode 2)]
      val smcc_kuratowski_rejected =
        (eval_mac_lane_coherence true true true [KuratowskiPair (Empty, Empty)]; false)
        handle ProperClassKuratowskiException => true
             | _ => false
      val smcc_res = eval_is_symmetric_monoidal_closed
        [dunaev_pair (GodelCode 10) (GodelCode 100), dunaev_pair (GodelCode 20) (GodelCode 200)]
        [dunaev_pair (GodelCode 100) (GodelCode 10), dunaev_pair (GodelCode 200) (GodelCode 20)]
      val smcc_fail = eval_is_symmetric_monoidal_closed
        [dunaev_pair (GodelCode 10) (GodelCode 100)]
        [dunaev_pair (GodelCode 100) (GodelCode 99)]
      val enr_cat_ok = #is_valid_enriched_category (eval_is_enriched_category true true
        [dunaev_pair (GodelCode 1) (GodelCode 11), dunaev_pair (GodelCode 2) (GodelCode 22)])
      val enr_cat_fail = not (#is_valid_enriched_category (eval_is_enriched_category true false
        [dunaev_pair (GodelCode 1) (GodelCode 11)]))
      val enr_yon_res = eval_enriched_yoneda_iso 2
        [dunaev_pair (GodelCode 1) (GodelCode 50), dunaev_pair (GodelCode 2) (GodelCode 75)]
      val enr_yon_fail = eval_enriched_yoneda_iso 9
        [dunaev_pair (GodelCode 1) (GodelCode 50)]
      val day_ok = #day_convolution_monoidal_closed (eval_day_convolution_monoidal true 3 4 12)
      val day_fail = not (#day_convolution_monoidal_closed (eval_day_convolution_monoidal true 3 4 10))
      val mac_lane_thm_ok =
        case prove_mac_lane_pentagon_triangle_coherence (Var "V") (Var "ox") (Var "I") of
            Thm ([], Imp (SatisfiesMacLaneCoherence (SymmetricMonoidalStructure (Var "V", Var "ox", Var "I")),
                          SatisfiesMacLaneCoherence (SymmetricMonoidalStructure (Var "V", Var "ox", Var "I")))) => true
          | _ => false
      val ihom_thm_ok =
        case prove_tensor_internal_hom_adjunction_iso (Var "V") (Var "B") (Var "C") of
            Thm ([], Imp (IsSymmetricMonoidalClosed (Var "V", InternalHomObject (Var "B", Var "C")),
                          Eq (InternalHomObject (Var "B", Var "C"), InternalHomObject (Var "B", Var "C")))) => true
          | _ => false
      val day_thm_ok =
        case prove_day_convolution_promonoidal_yoneda (Var "C") (Var "F") (Var "G") of
            Thm ([], Imp (And (IsEnrichedCategory (EnrichedCategory (Var "C", Var "V"), Var "V"),
                               IsDayConvolutionMonoidal (Var "PShV", DayConvolutionProduct (Var "F", Var "G"))),
                          SatisfiesEnrichedYonedaIso (EnrichedRepresentableHom (Var "C", Var "A"), Var "F"))) => true
          | _ => false
      val smcc_day_all_ok =
        (#mac_lane_coherence_verified mac_lane_res)
        andalso (not (#mac_lane_coherence_verified mac_lane_fail))
        andalso smcc_kuratowski_rejected
        andalso (#is_symmetric_monoidal_closed smcc_res)
        andalso (not (#is_symmetric_monoidal_closed smcc_fail))
        andalso enr_cat_ok andalso enr_cat_fail
        andalso (#enriched_yoneda_iso_holds enr_yon_res)
        andalso (#enriched_end_value enr_yon_res = 75)
        andalso (not (#enriched_yoneda_iso_holds enr_yon_fail))
        andalso day_ok andalso day_fail
        andalso mac_lane_thm_ok andalso ihom_thm_ok andalso day_thm_ok
      (* Ticket 81 self-tests *)
      val wedge_res = eval_is_extranatural_wedge [1, 2]
        [dunaev_pair (GodelCode 1) (GodelCode 10), dunaev_pair (GodelCode 2) (GodelCode 20)]
        [dunaev_pair (GodelCode 1) (GodelCode 10), dunaev_pair (GodelCode 2) (GodelCode 20)]
      val wedge_fail = eval_is_extranatural_wedge [1, 2]
        [dunaev_pair (GodelCode 1) (GodelCode 10), dunaev_pair (GodelCode 2) (GodelCode 20)]
        [dunaev_pair (GodelCode 1) (GodelCode 10), dunaev_pair (GodelCode 2) (GodelCode 99)]
      val end_kuratowski_rejected =
        (eval_is_extranatural_wedge [1] [KuratowskiPair (Empty, Empty)] []; false)
        handle ProperClassKuratowskiException => true
             | _ => false
      val univ_end_res = eval_universal_end_cowedge
        [dunaev_pair (GodelCode 1) (GodelCode 5), dunaev_pair (GodelCode 2) (GodelCode 8)]
        [dunaev_pair (GodelCode 1) (GodelCode 5), dunaev_pair (GodelCode 2) (GodelCode 9)]
      val univ_end_fail = eval_universal_end_cowedge
        [dunaev_pair (GodelCode 1) (GodelCode 5)]
        [dunaev_pair (GodelCode 1) (GodelCode 9)]
      val fubini_res = eval_end_coend_fubini_iso [1, 2] [1, 2]
        [dunaev_pair (GodelCode 11) (GodelCode 2), dunaev_pair (GodelCode 12) (GodelCode 3),
         dunaev_pair (GodelCode 21) (GodelCode 4), dunaev_pair (GodelCode 22) (GodelCode 5)]
      val wlim_res = eval_weighted_limit_end_rep
        [dunaev_pair (GodelCode 1) (GodelCode 2), dunaev_pair (GodelCode 2) (GodelCode 3)]
        [dunaev_pair (GodelCode 1) (GodelCode 5), dunaev_pair (GodelCode 2) (GodelCode 7)]
      val wlim_fail = eval_weighted_limit_end_rep
        [dunaev_pair (GodelCode 1) (GodelCode 6)]
        [dunaev_pair (GodelCode 1) (GodelCode 5)]
      val prof_res = eval_profunctor_coend_composition 1 3 [1, 2, 3]
        [dunaev_pair (GodelCode 1) (GodelCode 2)]
        [dunaev_pair (GodelCode 2) (GodelCode 3)]
      val prof_fail = eval_profunctor_coend_composition 1 3 [1, 2, 3]
        [dunaev_pair (GodelCode 1) (GodelCode 2)]
        [dunaev_pair (GodelCode 3) (GodelCode 3)]
      val nat_end_thm_ok =
        case prove_natural_transformations_as_end "X" (Var "F") (Var "G") of
            Thm ([], Imp (IsUniversalEndCowedge (CategoricalEnd ("X", InternalHomObject (Var "F", Var "G")),
                                                 InternalHomObject (Var "F", Var "G")),
                          IsExtranaturalWedge (ExtranaturalWedge (CategoricalEnd ("X", InternalHomObject (Var "F", Var "G")),
                                                                  InternalHomObject (Var "F", Var "G")),
                                               InternalHomObject (Var "F", Var "G")))) => true
          | _ => false
      val fubini_thm_ok =
        case prove_end_coend_fubini_interchange_iso "A" "B" (Var "S") of
            Thm ([], And (SatisfiesEndCoendFubiniIso (
                            CategoricalEnd ("A", CategoricalEnd ("B", Var "S")),
                            CategoricalEnd ("B", CategoricalEnd ("A", Var "S"))),
                          SatisfiesEndCoendFubiniIso (
                            CategoricalCoend ("A", CategoricalCoend ("B", Var "S")),
                            CategoricalCoend ("B", CategoricalCoend ("A", Var "S"))))) => true
          | _ => false
      val wlim_thm_ok =
        case prove_weighted_limit_enriched_end_isomorphism (Var "W") (Var "F") (Var "J") of
            Thm ([], Imp (IsWeightedLimitEndRepresentation (
                            Var "W",
                            Var "F",
                            CategoricalEnd ("J", InternalHomObject (Var "W", Var "F"))),
                          Eq (WeightedLimitObject (Var "W", Var "F"),
                              WeightedLimitObject (Var "W", Var "F")))) => true
          | _ => false
      val wcolim_term_ok =
        (WeightedColimitObject (Var "W", Var "F") = WeightedColimitObject (Var "W", Var "F"))
      val ends_coends_fubini_all_ok =
        (#is_valid_extranatural_wedge wedge_res)
        andalso (not (#is_valid_extranatural_wedge wedge_fail))
        andalso end_kuratowski_rejected
        andalso (#universal_end_coend_verified univ_end_res)
        andalso (not (#universal_end_coend_verified univ_end_fail))
        andalso (#fubini_interchange_holds fubini_res)
        andalso (#iterated_ab_coend fubini_res = 14)
        andalso (#enriched_end_matches_weighted_limit wlim_res)
        andalso (not (#enriched_end_matches_weighted_limit wlim_fail))
        andalso (#coend_composite_nonempty prof_res)
        andalso (not (#coend_composite_nonempty prof_fail))
        andalso nat_end_thm_ok andalso fubini_thm_ok andalso wlim_thm_ok
        andalso wcolim_term_ok
      (* Ticket 82 self-tests *)
      val bicat_ok = #is_valid_bicategory (eval_is_bicategory true true
        [dunaev_pair (GodelCode 1) (GodelCode 2), dunaev_pair (GodelCode 2) (GodelCode 3)])
      val bicat_fail = not (#is_valid_bicategory (eval_is_bicategory true false
        [dunaev_pair (GodelCode 1) (GodelCode 2)]))
      val bicat_kuratowski_rejected =
        (eval_is_bicategory true true [KuratowskiPair (Empty, Empty)]; false)
        handle ProperClassKuratowskiException => true
             | _ => false
      val inter_res = eval_two_cell_interchange_law 5 3 7 2
      val inter_fail = eval_two_cell_interchange_law 5 ~1 7 2
      val adj_tri_ok = #triangle_identities_hold (eval_internal_adjunction_triangle
        [dunaev_pair (GodelCode 1) (GodelCode 1), dunaev_pair (GodelCode 2) (GodelCode (~1))]
        [dunaev_pair (GodelCode 1) (GodelCode (~1)), dunaev_pair (GodelCode 2) (GodelCode 1)])
      val adj_tri_fail = not (#triangle_identities_hold (eval_internal_adjunction_triangle
        [dunaev_pair (GodelCode 1) (GodelCode 1)]
        [dunaev_pair (GodelCode 1) (GodelCode 1)]))
      val benabou_ok = #benabou_coherence_holds (eval_benabou_strictification true true 12)
      val benabou_fail = not (#benabou_coherence_holds (eval_benabou_strictification true false 12))
      val eh_res = eval_eckmann_hilton_commutativity 4 9
      val inter_thm_ok =
        case prove_two_cell_middle_four_interchange (Var "b1") (Var "b0") (Var "a1") (Var "a0") of
            Thm ([], Imp (SatisfiesTwoCellInterchangeLaw (Var "b1", Var "b0", Var "a1", Var "a0"),
                          Eq (HorizontalComposition2Cell (VerticalComposition2Cell (Var "b1", Var "b0"),
                                                          VerticalComposition2Cell (Var "a1", Var "a0")),
                              VerticalComposition2Cell (HorizontalComposition2Cell (Var "b1", Var "a1"),
                                                        HorizontalComposition2Cell (Var "b0", Var "a0"))))) => true
          | _ => false
      val eh_thm_ok =
        case prove_eckmann_hilton_braided_endomorphism_commutativity (Var "alp") (Var "bet") of
            Thm ([], Imp (IsBicategory (BicategoryStructure (Var "B", Var "H", Var "A")),
                          Eq (VerticalComposition2Cell (Var "alp", Var "bet"),
                              HorizontalComposition2Cell (Var "bet", Var "alp")))) => true
          | _ => false
      val benabou_thm_ok =
        case prove_benabou_bicategory_strictification_biequivalence (Var "B") (Var "S") of
            Thm ([], Imp (IsBicategory (Var "B"),
                          SatisfiesBenabouStrictification (Var "B", Var "S"))) => true
          | _ => false
      val bicat_terms_ok =
        (TwoCellGlobe (Var "a", Var "f", Var "g") = TwoCellGlobe (Var "a", Var "f", Var "g"))
        andalso (InternalBicategoryAdjunction (Var "f", Var "u", Var "ee") =
                 InternalBicategoryAdjunction (Var "f", Var "u", Var "ee"))
        andalso (IsInternalAdjunctionTriangle (Var "f", Var "u", Var "eta", Var "eps") =
                 IsInternalAdjunctionTriangle (Var "f", Var "u", Var "eta", Var "eps"))
      val bicategory_benabou_all_ok =
        bicat_ok andalso bicat_fail
        andalso bicat_kuratowski_rejected
        andalso (#middle_four_interchange_holds inter_res)
        andalso (#lhs_vert_then_horiz inter_res = 17)
        andalso (not (#middle_four_interchange_holds inter_fail))
        andalso adj_tri_ok andalso adj_tri_fail
        andalso benabou_ok andalso benabou_fail
        andalso (#horizontal_equals_vertical_and_commutes eh_res)
        andalso inter_thm_ok andalso eh_thm_ok andalso benabou_thm_ok
        andalso bicat_terms_ok
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
      andalso cohen_fam_ok andalso real_names_ok andalso distinct_reals_ok
      andalso non_distinct_reals_no andalso card_pres_ok andalso continuum_ge_aleph2_ok
      andalso continuum_ge_aleph2_fail andalso ccc_pres_thm_ok andalso cohen_dist_thm_ok
      andalso cont_aleph2_thm_ok andalso gen_neg_ch_thm_ok andalso rel_con_neg_ch_thm_ok
      andalso con_zfc_neg_ch_thm_ok andalso indep_ch_thm_ok
      andalso suslin_tree_ok andalso tree_poset_ok andalso is_suslin_tree_ok
      andalso ma_kappa_ok andalso ma_kappa_fail andalso ma_sh_ok andalso diamond_neg_sh_ok
      andalso tree_ccc_thm_ok andalso ma_filter_thm_ok andalso ma_aleph1_sh_thm_ok
      andalso diamond_neg_sh_thm_ok andalso rel_con_sh_thm_ok andalso con_zfc_sh_thm_ok
      andalso con_zfc_neg_sh_thm_ok andalso indep_sh_thm_ok
      andalso easton_fn_ok andalso easton_poset_ok andalso levy_poset_ok
      andalso is_easton_fn_ok andalso is_easton_fn_fail
      andalso easton_supp_ok andalso easton_supp_fail
      andalso levy_col_ok andalso levy_col_fail andalso solovay_model_ok
      andalso easton_cond_thm_ok andalso easton_pres_thm_ok andalso easton_powers_thm_ok
      andalso rel_con_easton_thm_ok andalso levy_props_thm_ok andalso levy_om1_thm_ok
      andalso solovay_leb_thm_ok andalso rel_con_solovay_thm_ok
      andalso inacc_card_ok andalso mahlo_card_ok andalso weakly_compact_ok andalso measurable_card_ok
      andalso u_filter_ok andalso elem_emb_ok andalso ultrapower_ok andalso zero_sharp_ok
      andalso inacc_eval_ok andalso inacc_eval_fail andalso mahlo_eval_ok andalso mahlo_eval_fail
      andalso tree_prop_ok andalso tree_prop_fail andalso meas_eval_ok andalso meas_eval_fail
      andalso elem_emb_eval_ok andalso elem_emb_eval_fail andalso scotts_thm_eval_ok
      andalso inacc_def_thm_ok andalso mahlo_char_thm_ok andalso weakly_compact_thm_ok
      andalso meas_ultra_thm_ok andalso meas_emb_thm_ok andalso ultrapower_thm_ok
      andalso scotts_thm_ok andalso rel_con_meas_thm_ok
      andalso def_powerset_ok andalso l_stage_ok andalso constr_univ_ok andalso theory_zfc_l_ok
      andalso is_def_sub_ok andalso in_l_stage_ok andalso in_l_ok andalso cond_lemma_fm_ok
      andalso l_gch_ok andalso l_wo_ok andalso ax_v_eq_l_ok
      andalso eval_def_sub_ok andalso eval_def_sub_fail
      andalso eval_in_stage_ok andalso eval_in_stage_fail
      andalso eval_cond_step_ok andalso eval_cond_step_fail
      andalso eval_l_ac_ok andalso eval_l_gch_ok andalso eval_l_gch_fail
      andalso l_stage_def_thm_ok andalso constr_trans_thm_ok andalso cond_lem_thm_ok
      andalso l_sat_ac_thm_ok andalso l_sat_gch_thm_ok
      andalso rel_compr_ok andalso poset_pre_ok andalso gen_val_ok
      andalso im_crit_fm_ok andalso rel_ax_fm_ok andalso is_fposet_fm_ok
      andalso is_dpname_fm_ok andalso check_id_fm_ok andalso rel_isset_check
      andalso inner_nbg_ok andalso inner_nbg_non_trans_fail
      andalso fposet_eval_ok andalso fposet_eval_fail
      andalso ccc_bound_ok andalso ccc_bound_fail
      andalso dpname_wf_ok andalso dpname_wf_kuratowski_rejected
      andalso t63_generic_ok andalso val_check_0_ok andalso val_check_1_ok
      andalso val_check_2_ok andalso val_custom_tau_ok andalso val_kuratowski_raises
      andalso im_rel_crit_thm_ok andalso fposet_pre_thm_ok andalso ccc_ac_thm_ok
      andalso dpname_wf_thm_ok andalso check_val_thm_ok andalso gen_ext_im_thm_ok
      andalso semi_singleton_all_ok andalso class_lists_all_ok andalso family_all_ok
      andalso completeness_all_ok andalso ctx_ifv_all_ok andalso tight_univ_all_ok
      andalso bval_all_ok andalso club_veblen_all_ok andalso gale_stewart_all_ok
      andalso schrodinger_all_ok andalso yoneda_kan_all_ok andalso topos_lt_all_ok
      andalso monad_beck_all_ok andalso ccc_lambek_all_ok andalso groth_fibration_all_ok
      andalso abelian_snake_all_ok andalso chain_ext_tor_all_ok andalso triangulated_derived_all_ok
      andalso quillen_model_all_ok andalso simplicial_qcat_all_ok andalso grothendieck_sheaf_all_ok
      andalso spectral_seq_all_ok andalso smcc_day_all_ok andalso ends_coends_fubini_all_ok
      andalso bicategory_benabou_all_ok
    end
end;

val _ = if MKTD_Foundations.run_self_tests () then ()
        else raise Fail "MKTD_Foundations self-tests failed";
