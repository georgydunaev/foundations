(* Auto-generated SML'97 module completing presentation.ML Todo and WIP items *)
(* Source file: /hostramdisk/foundations/presentation.ML (lines 51 and 233)   *)
(* Companion LaTeX: /hostramdisk/foundations/unfinished_sections_completions.tex *)
(* Compatibility: Portable Standard ML (SML'97) for Poly/ML and CakeML        *)

structure FamilyAndComplexityCompletions =
struct

  (* ======================================================================== *)
  (* Part 1: Syntactic AST for Terms, Formulas, and Definition Chains         *)
  (* Resolves presentation.ML line 51:                                        *)
  (* "Todo: measure the complexity of the definition in depth of amount of    *)
  (*  constructors/connectives"                                               *)
  (* ======================================================================== *)

  datatype Term =
      Sets
    | VarTerm of string
    | Choice of Term
    | Compr of string * Fm
    | SetPair of Term * Term
    | DunaevTaggedPair of Term * Term
    | Singleton of Term
    | Pow of Term
    | Dom of Term
    | Ran of Term
    | Union of Term
    | Inter of Term
    | BigLam of string * Term
    | FamApp of Term * Term
    | FamProd of Term * Term
    | DefTerm of string * Term list

  and Fm =
      Bot
    | Top
    | Mem of Term * Term
    | Eq of Term * Term
    | SubClass of Term * Term
    | SemiSingleton of Term
    | SemiSingletonSub of Term * Term
    | NotFm of Fm
    | AndFm of Fm * Fm
    | OrFm of Fm * Fm
    | ImpFm of Fm * Fm
    | IffFm of Fm * Fm
    | ForallFm of string * Fm
    | ExistsFm of string * Fm
    | ExistsUniqueFm of string * Fm
    | DefFm of string * Term list

  fun max_int (a : int, b : int) : int =
    if a > b then a else b

  fun sum_list (xs : int list) : int =
    case xs of
        [] => 0
      | x :: rest => x + sum_list rest

  fun max_list (xs : int list) : int =
    case xs of
        [] => 0
      | x :: rest => max_int (x, max_list rest)

  (* Constructor-count complexity of a class term *)
  fun term_complexity (t : Term) : int =
    case t of
        Sets => 1
      | VarTerm _ => 1
      | Choice u => 1 + term_complexity u
      | Compr (_, phi) => 1 + fm_complexity phi
      | SetPair (a, b) => 1 + term_complexity a + term_complexity b
      | DunaevTaggedPair (a, b) => 2 + term_complexity a + term_complexity b
      | Singleton u => 1 + term_complexity u
      | Pow u => 2 + term_complexity u
      | Dom u => 3 + term_complexity u
      | Ran u => 3 + term_complexity u
      | Union u => 1 + term_complexity u
      | Inter u => 1 + term_complexity u
      | BigLam (_, body) => 2 + term_complexity body
      | FamApp (f, arg) => 2 + term_complexity f + term_complexity arg
      | FamProd (f, g) => 3 + term_complexity f + term_complexity g
      | DefTerm (_, args) => 1 + sum_list (List.map term_complexity args)

  (* Constructor/connective-count complexity of a formula *)
  and fm_complexity (phi : Fm) : int =
    case phi of
        Bot => 1
      | Top => 1
      | Mem (a, b) => 1 + term_complexity a + term_complexity b
      | Eq (a, b) => 1 + term_complexity a + term_complexity b
      | SubClass (a, b) => 2 + term_complexity a + term_complexity b
      | SemiSingleton a => 2 + term_complexity a
      | SemiSingletonSub (s, x) => 3 + term_complexity s + term_complexity x
      | NotFm p => 1 + fm_complexity p
      | AndFm (p, q) => 1 + fm_complexity p + fm_complexity q
      | OrFm (p, q) => 1 + fm_complexity p + fm_complexity q
      | ImpFm (p, q) => 1 + fm_complexity p + fm_complexity q
      | IffFm (p, q) => 1 + fm_complexity p + fm_complexity q
      | ForallFm (_, p) => 1 + fm_complexity p
      | ExistsFm (_, p) => 1 + fm_complexity p
      | ExistsUniqueFm (_, p) => 2 + fm_complexity p
      | DefFm (_, args) => 1 + sum_list (List.map term_complexity args)

  (* Syntactic AST height (nesting depth of constructors and connectives) *)
  fun term_depth (t : Term) : int =
    case t of
        Sets => 1
      | VarTerm _ => 1
      | Choice u => 1 + term_depth u
      | Compr (_, phi) => 1 + fm_depth phi
      | SetPair (a, b) => 1 + max_int (term_depth a, term_depth b)
      | DunaevTaggedPair (a, b) => 1 + max_int (term_depth a, term_depth b)
      | Singleton u => 1 + term_depth u
      | Pow u => 1 + term_depth u
      | Dom u => 1 + term_depth u
      | Ran u => 1 + term_depth u
      | Union u => 1 + term_depth u
      | Inter u => 1 + term_depth u
      | BigLam (_, body) => 1 + term_depth body
      | FamApp (f, arg) => 1 + max_int (term_depth f, term_depth arg)
      | FamProd (f, g) => 1 + max_int (term_depth f, term_depth g)
      | DefTerm (_, args) => 1 + max_list (List.map term_depth args)

  and fm_depth (phi : Fm) : int =
    case phi of
        Bot => 1
      | Top => 1
      | Mem (a, b) => 1 + max_int (term_depth a, term_depth b)
      | Eq (a, b) => 1 + max_int (term_depth a, term_depth b)
      | SubClass (a, b) => 1 + max_int (term_depth a, term_depth b)
      | SemiSingleton a => 1 + term_depth a
      | SemiSingletonSub (s, x) => 1 + max_int (term_depth s, term_depth x)
      | NotFm p => 1 + fm_depth p
      | AndFm (p, q) => 1 + max_int (fm_depth p, fm_depth q)
      | OrFm (p, q) => 1 + max_int (fm_depth p, fm_depth q)
      | ImpFm (p, q) => 1 + max_int (fm_depth p, fm_depth q)
      | IffFm (p, q) => 1 + max_int (fm_depth p, fm_depth q)
      | ForallFm (_, p) => 1 + fm_depth p
      | ExistsFm (_, p) => 1 + fm_depth p
      | ExistsUniqueFm (_, p) => 1 + fm_depth p
      | DefFm (_, args) => 1 + max_list (List.map term_depth args)

  (* Definition environment entry: (symbol_name, dependency_names, body_cost) *)
  type DefEntry = string * string list * int

  fun lookup_def (name : string, env : DefEntry list) : DefEntry option =
    case env of
        [] => NONE
      | (nm, deps, cost) :: rest =>
          if nm = name then SOME (nm, deps, cost)
          else lookup_def (name, rest)

  (* Unfolding rank (depth of definition chain) with fuel bound to prevent cycles *)
  fun def_chain_rank_bounded (fuel : int, name : string, env : DefEntry list) : int =
    if fuel <= 0 then 0
    else
      case lookup_def (name, env) of
          NONE => 0
        | SOME (_, deps, cost) =>
            let
              fun rank_dep d = def_chain_rank_bounded (fuel - 1, d, env)
              val dep_ranks = List.map rank_dep deps
            in
              cost + max_list dep_ranks
            end

  fun def_chain_rank (name : string, env : DefEntry list) : int =
    def_chain_rank_bounded (List.length env + 1, name, env)

  (* ======================================================================== *)
  (* Part 2: Family Evaluation, Binary Products of Families, and              *)
  (* Three-Valued Semi-Equality (presentation.ML line 233 & 110_family_eval)  *)
  (* ======================================================================== *)

  datatype Truth3 =
      LTrue
    | LFalse
    | LUndef

  datatype 'a CandidateStatus =
      Underdefined
    | UniquelyDefined of 'a
    | Uncertain of 'a list

  fun member_eq eq (x, ys) =
    case ys of
        [] => false
      | y :: rest => if eq (x, y) then true else member_eq eq (x, rest)

  fun dedup_eq eq xs =
    case xs of
        [] => []
      | x :: rest =>
          let
            val tail_dedup = dedup_eq eq rest
          in
            if member_eq eq (x, tail_dedup) then tail_dedup
            else x :: tail_dedup
          end

  fun subset_eq eq (xs, ys) =
    case xs of
        [] => true
      | x :: rest => member_eq eq (x, ys) andalso subset_eq eq (rest, ys)

  fun set_eq eq (xs, ys) =
    subset_eq eq (xs, ys) andalso subset_eq eq (ys, xs)

  fun set_union eq (xs, ys) =
    dedup_eq eq (xs @ ys)

  fun set_big_union eq (sets : 'a list list) : 'a list =
    case sets of
        [] => []
      | s :: rest => set_union eq (s, set_big_union eq rest)

  fun intersects_eq eq (xs, ys) =
    case xs of
        [] => false
      | x :: rest => if member_eq eq (x, ys) then true else intersects_eq eq (rest, ys)

  (* Classify a candidate set S_t *)
  fun classify_candidates eq (candidates : 'a list) : 'a CandidateStatus =
    let
      val unique_cands = dedup_eq eq candidates
    in
      case unique_cands of
          [] => Underdefined
        | [v] => UniquelyDefined v
        | vs => Uncertain vs
    end

  (* Evaluate a family F at key x via total union evaluation:                 *)
  (* F(x) = union { s | (x, s) in F }                                         *)
  (* Here each record in F pairs a domain element with a fiber set (s : 'b list). *)
  fun eval_family_fiber key_eq (family : ('a * 'b list) list, x : 'a) : 'b list list =
    case family of
        [] => []
      | (k, s) :: rest =>
          if key_eq (k, x) then s :: eval_family_fiber key_eq (rest, x)
          else eval_family_fiber key_eq (rest, x)

  fun eval_family_union (key_eq, val_eq) (family : ('a * 'b list) list, x : 'a) : 'b list =
    set_big_union val_eq (eval_family_fiber key_eq (family, x))

  (* Check whether a family is functional on candidate values:                *)
  (* For every key k in dom(F), all non-empty semi-singleton fibers [v]       *)
  (* over k agree on the same element v.                                      *)
  fun is_functional_family (key_eq, val_eq) (family : ('a * 'b list) list) : bool =
    let
      fun all_semi_singletons_and_consistent ((k, s) :: rest) =
            (List.length (dedup_eq val_eq s) <= 1) andalso
            let
              val union_at_k = eval_family_union (key_eq, val_eq) (family, k)
            in
              List.length union_at_k <= 1 andalso all_semi_singletons_and_consistent rest
            end
        | all_semi_singletons_and_consistent [] = true
    in
      all_semi_singletons_and_consistent family
    end

  (* Three-valued semi-equality I_Fm(s approx t) on candidate sets S_s, S_t *)
  fun three_valued_semi_eq eq (s_cands : 'a list, t_cands : 'a list) : Truth3 =
    let
      val s_norm = dedup_eq eq s_cands
      val t_norm = dedup_eq eq t_cands
    in
      case (s_norm, t_norm) of
          ([u], [v]) => if eq (u, v) then LTrue else LFalse
        | ([], _) => LUndef
        | (_, []) => LUndef
        | _ =>
            if not (intersects_eq eq (s_norm, t_norm)) then LFalse
            else LUndef
    end

  (* Classical strict equality, Kleene equality, directed quasi-equality, and candidate equality *)
  fun strict_eq eq (s_cands : 'a list, t_cands : 'a list) : bool =
    case (dedup_eq eq s_cands, dedup_eq eq t_cands) of
        ([u], [v]) => eq (u, v)
      | _ => false

  fun kleene_eq eq (s_cands : 'a list, t_cands : 'a list) : bool =
    case (dedup_eq eq s_cands, dedup_eq eq t_cands) of
        ([u], [v]) => eq (u, v)
      | ([], []) => true
      | ([], _ :: _ :: _) => true
      | (_ :: _ :: _, []) => true
      | (_ :: _ :: _, _ :: _ :: _) => true
      | _ => false

  fun quasi_eq eq (s_cands : 'a list, t_cands : 'a list) : bool =
    let
      val s_def = (List.length (dedup_eq eq s_cands) = 1)
      val t_def = (List.length (dedup_eq eq t_cands) = 1)
    in
      if s_def orelse t_def then strict_eq eq (s_cands, t_cands)
      else true
    end

  fun candidate_eq eq (s_cands : 'a list, t_cands : 'a list) : bool =
    set_eq eq (s_cands, t_cands)

  (* AST constructor for Dunaev tagged pair [A, B] and binary product of families *)
  (* Resolves presentation.ML lines 233-239:                                  *)
  (* (F times G) := BigLam(x, [F(x), G(x)])                                   *)
  fun dunaev_tagged_pair_ast (a : Term, b : Term) : Term =
    DunaevTaggedPair (a, b)

  fun family_binary_product_ast (var_x : string, f1 : Term, f2 : Term) : Term =
    BigLam (var_x, DunaevTaggedPair (FamApp (f1, VarTerm var_x), FamApp (f2, VarTerm var_x)))

end
