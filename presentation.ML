(*
 * Documentation update: openrouter/nvidia/nemotron-3.5-lightning:free (Capability Tier 1) PRESENTATION_ML_GUIDE.md
 * Ticket: ticket_7192_zone_delegated.md
 *
 * This file presents the underlying theory of Class-Theoretic Foundations based on Morse-Kelley class theory and Tarski's axiom.
 *
 * SML pseudo-code documentation:
 * - MK + Tarski's axiom: Foundations with Morse-Kelley class theory and Tarski-style universe axioms
 * - Sets : Term: Universal class of sets (proper classes are not members)
 * - c : Term -> Term: "Super global choice" descriptor/choice operator
 * - Compr : Bound Fm -> Term: Impredicative class comprehension {x | phi}
 * - Dunaev Lam x.t: Big lambda forming class-families/graphs, not SML functions
 * - Complexity weights (compl. = n): Provisional syntactic weights, not runtime costs
 *
*)
(*
 * File: presentation.ML
 * Author: mistral/codestral-2508 (Capability Tier 2)
 * Description: This file presents the underlying theory of Class-Theoretic Foundations based on Morse-Kelley class theory and Tarski's axiom.
 * It includes constructors of terms and formulas, complexity annotations, and definitions.
 *
 * Complete Presentation of underlying theory of Class-Theoretic Foundations:
Morse-Kelley class theory + Tarski's axiom

Syntax:
a,b,c,...,x,y,z denote variables and terms; phi,psi,... denote formulas
phi[a/x] denote the substitution. 
(only for cases when a is free for x in phi("ffi a x phi"))
Technical axioms for substitutions of binders are ommited:
e.g. {x|phi}={w|phi[w/x]} (ffi w x phi).

Constructors of terms and formulas:
Sets : Term
c : Term -> Term (* "super global choice" *)
 _ : Var -> Term
-[-/-] : Var * Term * Fm -> Fm (*order: x,t,phi for phi[t/x]; raises exception if subst isn't possible)*)
Bot : Fm (* falsehood *)
(- <-> -), (- & -), (- \/ -), (- -> -) : Fm * Fm -> Fm
forall, exists : Var * Fm -> Fm
{-|-} : Var * Fm -> Term
{-,-}, (-,-): Term * Term -> Term
{-}, pow(-), dom(-), ran(-), union(-), inter(-) : Term -> Term
(- in -),(- = -), (- C -),(- from -),(- onto -),(- smaller than -) : Term * Term -> Fm
(- func),(- transitive),(- hereditary),(- powerful),(- limited),(- universe) : Term -> Fm
(!-:-): Var * Fm -> Fm

Todo: measure the complexity of the definition in depth of amount of constructors/connectives
or in... ?
Definitions: (constructors of type Prf; rules of the 1st order logic are ommited)
{t|phi, x bound} := {z| exists x : t = z /\ phi }  (* z is not free neither in t not in phi *)
                  = Class (z. (exists x : t = z /\ phi))
Compr : Bound Fm -> Term

   { } = {x|Bot} (* compl. = 2 *)
    V  = {x|Top}
(A x B) := {(a,b)| (a in A) /\ (b in B)} (* compl. = 4 *)
(F relation) :<-> (F C (V x V))  (* compl. = 2 *)
(A C B) <-> (forall x: x in A -> x in B)  (* :Var*Term*Term->Prf *)
(**s"A C B" means "A is a subclass of B"**)

(if (X empty) then V else union X)
{t|phi, }

{z|phi} = Class (z.phi)

(unite x.t) := {(union t)| (x any) /\ (t inhabited)} (*x is a bound variable for both sides*)
             = {z| exists x: (z=(union t))/\(t inhabited) }
             = {z| exists x': (z=(union t[x'/x]))/\(t inhabited) }
             = {z| exists x': (z=(union (x.t)(x') ))/\(t inhabited) }

W = {w|(w inhabited)}
"x.t" is surely a bounded term

(* s.phi := x. x=s /\ phi[s/x] ? *)

(Lam x t) = {(x,s)|(s sss t)}
(Lam x.t) = {(x,s)|(s sss t)}
          = {z| exists x: ((z=(x,s)) /\ (s sss t))}
          = Class z.(exists x.((z=(x,s)) /\ (s sss t)) )
F(x) := (union {s|(x,s) in F})

(pow B) := {A|(A C B)}       (* :Var*Term->Prf *)  (* compl. = 2 *)
(dom R) := {x|exists s: (x,s) in R}  (* compl. = 3 *)
(ran R) := {y|exists x: (x,y) in R}  (* compl. = 3 *)
(Dom F) := dom(F)
(Ran F) := { F(x) | (x in Dom(F)) }
         = Repl (x |-> F(x)) Dom(F)
         = F[Dom F]
         = (unite {s|(x,s) in F} for x)
 ?        
F|A = F n fst^{-1}[A]


  F|A := {(a,s) in F | a in A}

 F[A] := Ran F|A
dom F := fst[F]

union : Term -> Term

 [-]: Term -> ((Term -> Term) -> Term)
-[Q]: (Term -> Term) -> Term

U:Term -> Term
"U[Q]":= {union m| m in Q}

up : Term -> (Term -> Term)
  (up F) := (fn x => F(x))

down : (Term -> Term) -> Term
(down S) := { (x, S(x)) | x any }

up_opt : Term -> (Term -> Prf -> (Term option))
  (up F) := (fn x => if (x in (dom F)) then SOME F(x) else NONE)

down_opt : (Term -> (Term option)) -> Term
(down S) := { (x,z) | (x any) /\ (case S(x) of SOME y => z=y ; NONE => Bot) }

"-[-]" : (Term -> Term) -> Term -> Term

"(F |--> (x |--> F(x))" : Term -> (Term -> Term)


F|A = F n (A x V)
F[A] = (Ran (F|A))
Ran F|(A n dom(F))

   F/A/ := {F(a) | (a in A)}
(Ran F) := F/dom(F)/
   F[A] := Ran F|A

   F[A] := {F(a) | (a in A)/\(a in dom(F))}
   F[A] := {F(a) | (a in (A n dom(F)))}
   F[A] := {F(a) | (a in A)/\(a in dom(F))}

(Ran F) := { F(x) | (x in dom(F)) } 
(Ran F) := F[V]
(Ran F) := F[dom(F)]

(Ran F) := {y|exists (x in dom(F)): F(x) = y}    (* compl. = 4 *)
(Ran F) := {y|exists x: (exists s: (x,s) in F)/\ F(x) = y}    (* compl. = 4 *)

(Ran F) := {y|exists x: (exists s: (x,s) in F) /\ (union {s|(x,s) in F} = y)}    (* compl. = 4 *)
(Ran F) := {(union m)|exists x: (exists s: (x,s) in F) /\ ({s|(x,s) in F} = m)}
(Ran F) := {(union m)|exists x: (m inhabited) /\ ({s|(x,s) in F} = m)}
(Ran F) := {(union {s|(x,s) in F})| (x any) /\ ({s|(x,s) in F} inhabited)}
(qqq t) := {(union t)| (x any) /\ (t inhabited)}
(Ran F) := unite_inhabited ( x.{s|(x,s) in F} )


(m inhabited) <-> (exists q: q in m)  (* compl. = 2 *)
F[A] = {s| exists (a in A): (a,s) in F}
F[{x}] = {s|(x,s) in F}

(F from A) <-> (dom(F) = A)   (* :Term*Term->Prf *)
(F onto B) <-> (ran(F) = B)  (* :Term*Term->Prf *)
(not phi) <-> (phi -> Bot) (* negation *)
(z smaller than U) <-> (not (exists f: (f func) & (f from z) & (f onto U)))  (* :Var*Term*Term->Prf *)
(U transitive) <-> (forall (B in U): (B C U))  (* :Var*Term->Prf *) (*B not free in U*)
(U hereditary) <-> (forall (B in U): forall (X C B): (X in U))  (* :Var*Var*Term->Prf *)
(U powerful) <-> (forall (B in U): ((pow B) in U))  (* :Var*Term->Prf *)
(U limited) <-> (forall (z C U): ((z smaller than U) <-> (z in U)))  (* :Var*Term->Prf *)
(U universe) <-> (U  transitive, hereditary, powerful, limited)  (* :Term->Prf *)
SetUniverses = {U|U universe}   (* :Var->Prf *)
(union X) = {z|exists (y in X): z in y}  (*:Var*Var*Term -> Prf*) (*order: z,y,X*)
 
Axioms: (constructors of type Prf) (* first 4 are given axiomatically, but they can be defined *)
 ({W|phi} exists)
 (A C B) & (B C A) -> (A = B)
 forall A, B: (A = B) -> (phi[A/v] -> phi[B/v])
 forall W: ((phi) & (W in Sets)) <-> ((W in {W|phi}))  (*:Var*Fm->Prf*)
 ((phi) & (W in Sets)) <- ((W in {W|phi}) & (W exists))  (*:Var*Fm->Prf*)
 ((phi) & (W in Sets)) -> ((W in {W|phi})             )  (*:Var*Fm->Prf*)
 ((pow K) C K) -> (Sets C K)             (*:Term->Prf*)
 (Sets universe)                         (*:Prf*)
 Sets C (union SetUniverses)             (*:Prf*)

Logical notes: 
1) (A = B) -> (A unique).
2) (exists B:(A = B)) <-> (A unique).
 ((phi) & (W in Sets) & (W exists)) <-> ((W in {W|phi}) & (W exists))  (*:Var*Fm->Prf*)

Def. ("s is a semi-singleton subset of x")
 (s sss x) <-> (s C x) /\ (s ss)

Axioms for constructions:
Sometimes objects can be defined by explicit term, but often they are working only in certain
conditions, and we don't want the details, and keep focus on important properties.
The main idea is that you cannot say anything about term, if it is unspecified.
# Singleton (3 equivalent variants.)
(
intro: (A set) -> (A in {A})
elim: (A set) -> ((B in {A}) -> (B = A))
,
(A set) -> ((B in {A}) -> (B = A))
(A set) -> ((B = A) -> (B in {A}))
,
(A set) -> ((B in {A}) <-> (B = A))
)

(A set) -> ({A} set)
Projection class-functions:
  fst := {z|exists x,y: z = ((x,y),x)}
  snd := {z|exists x,y: z = ((x,y),y)}
# Composition ?
# union of two classes
  A u B := {x|(x in A) \/ (x in B) }

# Ordered pair of sets.
  forall (a1, b1, a2, b2 sets): (((a1, b1) = (a2, b2)) <-> ((a1 = a2) /\ (b1 = b2)))
  forall (a, b sets): ((a, b) set)

  ([a, b] sets) -> ((a, b) set)
# Family constructor (big lambda)
  (x |-> t) := {(x,s) | (s C t) /\ (s ss)}  := {(x,s)|(s sss t)}  
  (both x and s are bound by class comprehension on r.h.s., variable s is not free in t)
# Identity:
  Function: id = {(x,x) | x any}
  Family:   (note: here Id = {(x,s) | (s C x) /\ (s ss)})  ("sic! preimage of the inverse of sss relation class")
            Id := (x |-> x). (*GOOD for family! "(Lambda x x)" *)
# (Binary) Product of families of classes: 
  Classes:  A x B := {(a,b)|(a in A)/\(b in B)}
  Families: F x G := ...
  it implies that there is an ordered pair of proper classes. E.g. [F(a), G(a)]. ... sth is shady
  
# Binary product of functions
  For usual functions:
  (f1 times f2) := {(x,(y1,y2)) | ((x,y1) in f1) /\ ((x,y2) in f2)}
  For families(WIP):
  (F1 times F2) := {(x,[y1,y2]) | (F1(x)=y1) /\ ((F2(x)=y2))}
  (F1 times F2) := {(x,s) | (x in dom(F1)) /\ (dom(F1)=dom(F2)) /\ (s ss) /\ (s C [y1,y2]) /\ (F1(x)=y1) /\ (F2(x)=y2)}
  (F times G) := (x |-> [F(x),G(x)])
  For any classes A and B,
  [A, B] := {(1,s)|(s sss A)}u{(0,s)|(s sss B)} (*Note the reversed order! It is correct.*)
          = (x |-> A)|`{1} u (x |-> B)|`{0}
# Lists of classes(!).
  Intended use:
   "([a,b,c] are sets) -> ..."
  Constructors: (nil:Term), (cons:Term->Term)
  Notation:
       :: := cons    (infix op)
       [] := nil
      [c] := c::nil
    [b,c] := b::[c]
  [a,b,c] := a::[b,c]
  "(h :: t) increases first elements of pairs in t by one(1+alpha), and adds {(0,{q})|q in t}."
  
  Semantics:
       nil := emptyclass
  (h :: t) := {(0,{q})|q in h} u ((1+_) times Id)[t]
  (h :: t) := {(0,{q})|q in h} u {(1+n,x)|(n,x) in t}
(*" 'n+1':= n u {n} "
    '1+n':=? 
  By Transfinite recursion:
    1+0 := 1
    1+(q+1) = (1+q)+1
    (1+alpha) := sup {1+m| m < alpha}. (if n is a limit ordinal)
           = if (alpha non-zero limit ordinal) then alpha else (alpha+1).
           note: Ord is a limit ordinal proper class.
# Transfinite recursion (yet for functions only, which is enough for the previous application)
    
    G:V^On -> V   ?
    K={f\in V^On| \forall x in (dom f): f(x)=G(f|`x)}
    F:=(union K)
    1) (F mapping), (dom(F) = On)
    2) forall (alpha ordinal): F(alpha) = G(F|`alpha)
    3) Mapping with properties (1) and (2) is unique.

An ordinal alpha is called a limit ordinal, if there is not ordinal beta such, that alpha = beta + 1.
The semantics of the supremum on ordinals is union.)
*)
  ([x1,x2,...] are sets) :<-> forall (j in (dom [x1,x2,...])): ([x1,x2,...](j) is set)

# Descriptors
  (exists X: phi) -> phi[(eps X: phi)/X]
  (exists_unique X: phi) -> phi[(iota X: phi)/X]
  (basically the extension by definitions embedded in the system)
  (if (not (exists X: phi)) then (eps X: phi) is not specified.)

# Dependent classes
  E = {(x,y)| x in y}  (*A relation, it can not be a family, since it is not functional. *)
  Sigma P = {(x,y)| y in P(x)} (* good for both cases: function P and family P *)

# image of a function

(* Every class can be enumerated by an ordinal class.
   Therefore, it is possible to define family of classes as an image of some family.
   Basically, it is a restriction of original family to any class.
*)
# Value of a function 
  (x in (dom f)) -> f(x) := (U(f[{x}]))

End of foundations. **)
