# Class-Theoretic Foundations Presentation

## Overview

This document presents the underlying theory of Class-Theoretic Foundations based on Morse-Kelley class theory and Tarski's axiom. It includes:

- Constructors of terms and formulas
- Complexity annotations
- Key definitions

## Syntax

- Variables and terms: a,b,c,...,x,y,z
- Formulas: phi,psi,...
- Substitution: phi[a/x] (with technical axioms for binders omitted)

## Constructors

### Terms

- `Sets : Term`
- `c : Term -> Term` (super global choice)
- `_ : Var -> Term`
- `{-,-}, (-,-): Term * Term -> Term`
- `{-}, pow(-), dom(-), ran(-), union(-), inter(-) : Term -> Term`

### Formulas

- `Bot : Fm` (falsehood)
- `(- <-> -), (- & -), (- \/ -), (- -> -) : Fm * Fm -> Fm`
- `forall, exists : Var * Fm -> Fm`
- `-[-/-] : Var * Term * Fm -> Fm` (substitution)
- `(- in -),(- = -), (- C -),(- from -),(- onto -),(- smaller than -) : Term * Term -> Fm`
- `(- func),(- transitive),(- hereditary),(- powerful),(- limited),(- universe) : Term -> Fm`
- `(!-:-): Var * Fm -> Fm`

## Complexity Annotations

Complexity is measured by the depth of constructors/connectives:

- `{ } = {x|Bot} (* compl. = 2 *)`
- `(A x B) := {(a,b)| (a in A) /\ (b in B)} (* compl. = 4 *)`

## Key Definitions

- `{t|phi, x bound} := {z| exists x : t = z /\ phi }`
- `Compr : Bound Fm -> Term`
- `(A C B) <-> (forall x: x in A -> x in B)`

## Notes

- Technical axioms for substitutions of binders are omitted
- Rules of first-order logic are omitted
- Complexity measurement is still under development