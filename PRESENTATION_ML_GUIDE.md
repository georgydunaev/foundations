# PRESENTATION_ML_GUIDE.md

## Overview
This file presents the underlying theory of Class-Theoretic Foundations based on Morse-Kelley class theory and Tarski's axiom. It includes constructors of terms and formulas, complexity annotations, and definitions.

## Constructors of Terms and Formulas

1. `Sets : Term` - This constructor represents the set of all terms.
2. `c : Term -> Term` - This constructor represents the complexity annotation for terms.
3. `Compr : Bound Fm -> Term` - This constructor represents the comprehension axiom, which allows the formation of sets based on a given formula.
4. `Lam x.t` - This constructor represents the lambda abstraction, which allows the formation of functions based on a given term.

## Complexity Annotations

Complexity annotations are used to measure the complexity of terms and formulas. Each constructor has a weight assigned to it, which contributes to the overall complexity of the term or formula.

1. `Sets : Term` - This constructor represents the set of all terms.
2. `c : Term -> Term` - This constructor represents the complexity annotation for terms.
3. `Compr : Bound Fm -> Term` - This constructor represents the comprehension axiom, which allows the formation of sets based on a given formula.
4. `Lam x.t` - This constructor represents the lambda abstraction, which allows the formation of functions.

## Complexity Annotations
The complexity annotations in the `presentation.ML` file are used to ensure that the theory is consistent and well-founded. They are based on the Morse-Kelley class theory and Tarski's axiom.

## Definitions
The `presentation.ML` file also includes various definitions that are used to build the theory of Class-Theoretic Foundations.
- `Sets : Term`
- `c : Term -> Term` ("super global choice")
- `_ : Var -> Term`
- `[-/-] : Var * Term * Fm -> Fm` (order: x,t,phi for phi[t/x]; raises exception if subst isn't possible)
- `Bot : Fm` (falsehood)
- `(- <-> -), (- & -), (- \/ -), (- -> -) : Fm * Fm -> Fm`
- `forall, exists : Var * Fm -> Fm`
- `{-|-} : Var * Fm -> Term`
- `{-,-}, (-,-): Term * Term -> Term`
- `{-}, pow(-), dom(-), ran(-), union(-), inter(-) : Term -> Term`
- `(- in -),(- = -), (- C -),(- from -),(- onto -),(- smaller than -) : Term * Term -> Fm`
- `(- func),(- transitive),(- hereditary),(- powerful),(- limited),(- universe) : Term -> Fm`
- `(!-:-): Var * Fm -> Fm`

## Complexity Annotations
The complexity of the definitions is measured in depth of amount of constructors/connectives.

## Definitions
- `Compr : Bound Fm -> Term`
- `{t|phi, x bound} := {z| exists x : t = z /\ phi }` (z is not free neither in t not in phi)
- `{ } = {x|Bot}` (compl. = 2)
- `V  = {x|Top}`
- `(A x B) := {(a,b)| (a in A) /\ (b in B)}` (compl. = 4)
- `(F relation) :<-> (F C (V x V))` (compl. = 2)
- `(A C B) <-> (forall x: x in A -> x in B)`
- `(unite x.t) := {(union t)| (x any) /\ (t inhabited)}` (x is a bound variable for both sides)

## Dunaev Tagged Pairs
The file also includes Dunaev tagged pairs, which are used to represent lambda abstractions in the form `Lam x.t`.
