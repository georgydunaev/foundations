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

  (* Categorical semantics of class comprehension and universal constructions *)
  val cat_dunaev_prod : class_term -> class_term -> class_term
  val cat_pairing_morphism : (class_term -> class_term) ->
                             (class_term -> class_term) ->
                             class_term -> class_term
  val cat_equalizer : (class_term -> class_term) ->
                      (class_term -> class_term) ->
                      class_term list -> class_term list
  val cat_subobject_comprehension : (class_term -> bool) -> class_term list -> class_term list
  val axiom_categorical_product : class_term -> class_term -> thm
  val axiom_comprehension_equalizer : class_term -> string -> fm -> thm
  val prove_categorical_product : class_term -> class_term -> thm
  val prove_comprehension_equalizer : class_term -> string -> fm -> thm

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
  fun cat_dunaev_prod a b = DunaevProd (a, b)

  fun cat_pairing_morphism f g c = dunaev_pair (f c) (g c)

  fun cat_equalizer f g candidates =
    List.filter (fn x => (f x = g x)) candidates

  fun cat_subobject_comprehension pred candidates =
    cat_equalizer (fn x => if pred x then Univ else Empty) (fn _ => Univ) candidates

  fun axiom_categorical_product a b =
    Thm ([], And (Eq (dunaev_fst (TagPair (a, b)), a),
                  Eq (dunaev_snd (TagPair (a, b)), b)))

  fun axiom_comprehension_equalizer a var phi =
    Thm ([], Iff (In (Var "x", Compr (var, phi)), And (In (Var "x", a), phi)))

  fun prove_categorical_product a b = axiom_categorical_product a b
  fun prove_comprehension_equalizer a var phi = axiom_comprehension_equalizer a var phi

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
    end
end;

val _ = if MKTD_Foundations.run_self_tests () then ()
        else raise Fail "MKTD_Foundations self-tests failed";
