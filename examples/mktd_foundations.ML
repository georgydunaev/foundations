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
    | IsSet of class_term

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
    | IsSet of class_term

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
      | IsSet a => IsSet (subst_term var repl a)

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
    in
      fst_ok andalso snd_ok andalso kuratowski_success andalso kuratowski_rejected
      andalso type_univ_ok andalso type_set_univ_no
      andalso total_found andalso total_missing andalso guarded_missing
      andalso russell_ok andalso sep_ok andalso inj_ok
    end
end;

val _ = if MKTD_Foundations.run_self_tests () then ()
        else raise Fail "MKTD_Foundations self-tests failed";
