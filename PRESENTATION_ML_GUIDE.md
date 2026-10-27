# Presentation.ML Guide

## Overview
This file presents the underlying theory of Class-Theoretic Foundations based on Morse-Kelley class theory and Tarski's axiom. It includes constructors of terms and formulas, complexity annotations, and definitions.

## Syntax
- `a,b,c,...,x,y,z` denote variables and terms
- `phi,psi,...` denote formulas

## Constructors of Terms and Formulas
- `Sets : Term`
- `c : Term -> Term` ("super global choice")
- `_ : Var -> Term`
- `-[-/-] : Var * Term * Fm -> Fm` (order: x,t,phi for phi[t/x]; raises exception if subst isn't possible)
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
- `{ } = {x|Bot}` (compl. = 2)
- `V  = {x|Top}`
- `(A x B) := {(a,b)| (a in A) /\ (b in B)}` (compl. = 4)
- `(F relation) :<-> (F C (V x V))` (compl. = 2)
- `(A C B) <-> (forall x: x in A -> x in B)`

## Definitions
- `{t|phi, x bound} := {z| exists x : t = z /\ phi }` (z is not free neither in t not in phi)
- `Compr : Bound Fm -> Term`

## Dunaev's Lambda Abstraction
- `(Lam x t) = {(x,s)|(s sss t)`

## Author
- mistral/codestral-2508 (Capability Tier 2)
