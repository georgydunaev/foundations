(* Complete untyped de Bruijn example for 198_debruijn_substitution.tex.
 * Load with: poly --use examples/debruijn.ML
 * Indices and fuel use IntInf: mathematical integers, not machine ints.
 * run terminates by fuel; OutOfFuel is not a proof of divergence.
 *)
structure DeBruijn : sig
  datatype term = Var of IntInf.int | Lam of term | App of term * term
  datatype result = Normal of term | OutOfFuel of term
  val scoped : IntInf.int -> term -> bool
  val shift : IntInf.int -> IntInf.int -> term -> term
  val replace : IntInf.int -> term -> term -> term
  val contract : term -> term -> term
  val step : term -> term option
  val run : IntInf.int -> term -> result
end = struct
  datatype term = Var of IntInf.int | Lam of term | App of term * term
  datatype result = Normal of term | OutOfFuel of term

  fun valid (Var k) = k >= 0
    | valid (Lam body) = valid body
    | valid (App (f, a)) = valid f andalso valid a

  fun scoped n (Var k) = n >= 0 andalso k >= 0 andalso k < n
    | scoped n (Lam body) = n >= 0 andalso scoped (n + 1) body
    | scoped n (App (f, a)) =
        n >= 0 andalso scoped n f andalso scoped n a

  fun shiftRaw amount cutoff (Var k) =
        Var (if k < cutoff then k else k + amount)
    | shiftRaw amount cutoff (Lam body) =
        Lam (shiftRaw amount (cutoff + 1) body)
    | shiftRaw amount cutoff (App (f, a)) =
        App (shiftRaw amount cutoff f, shiftRaw amount cutoff a)

  fun shift amount cutoff t =
    if amount < 0 orelse cutoff < 0 orelse not (valid t)
    then raise Domain
    else shiftRaw amount cutoff t

  (* depth counts the binders between the removed slot and this node.
   * The argument stays in the outer context throughout the recursion. *)
  fun replaceRaw depth argument (Var k) =
        if k < depth then Var k
        else if k = depth then shiftRaw depth 0 argument
        else Var (k - 1)
    | replaceRaw depth argument (Lam body) =
        Lam (replaceRaw (depth + 1) argument body)
    | replaceRaw depth argument (App (f, a)) =
        App (replaceRaw depth argument f,
             replaceRaw depth argument a)

  fun replace depth argument body =
    if depth < 0 orelse not (valid argument) orelse not (valid body)
    then raise Domain
    else replaceRaw depth argument body

  fun contract body argument = replace 0 argument body

  (* One leftmost-outermost step, including reduction beneath lambdas. *)
  fun stepRaw (Var _) = NONE
    | stepRaw (Lam body) =
        (case stepRaw body of
           NONE => NONE
         | SOME next => SOME (Lam next))
    | stepRaw (App (Lam body, argument)) =
        SOME (replaceRaw 0 argument body)
    | stepRaw (App (f, a)) =
        (case stepRaw f of
           SOME next => SOME (App (next, a))
         | NONE =>
             (case stepRaw a of
                SOME next => SOME (App (f, next))
              | NONE => NONE))

  fun step t = if valid t then stepRaw t else raise Domain

  fun run fuel t =
    if fuel < 0 orelse not (valid t) then raise Domain
    else let
      fun loop remaining current =
        case stepRaw current of
          NONE => Normal current
        | SOME next =>
            if remaining = 0 then OutOfFuel current
            else loop (remaining - 1) next
    in loop fuel t end
end;
