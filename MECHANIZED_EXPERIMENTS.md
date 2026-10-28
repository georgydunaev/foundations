# MECHANIZED EXPERIMENTS

## Coq Positive Foundations

### Inductive `Ens` W-type Encoding

The Coq Positive Foundations file defines an inductive type `Ens` which represents a set. It includes:

- A `Pair` function that creates a pair of two sets.
- Extensional equality (`EQ`) for sets.
- Membership (`IN`) for sets.
- Soundness predicates for sets.
- A proof of transitivity of equality (`EQ_tran`).

### Dunaev's Ordered Pair

The file also includes definitions and proofs related to Dunaev's ordered pair (`OPair_Zero`, `OPair_One`).

## Isabelle IFOLD.thy

### Intuitionistic First-Order Logic

The Isabelle IFOLD.thy file defines a theory for intuitionistic first-order logic. It includes:

- Syntax and axiomatic basis for terms and propositions.
- Equality with reflexivity and substitution axioms.
- Propositional logic with conjunction, disjunction, and implication.

### ML File Imports

The file includes ML file imports for various tools and utilities, such as:

- `misc_legacy.ML`
- `splitter.ML`
- `hypsubst.ML`
- `zipper.ML`
- `isand.ML`
- `rw_inst.ML`
- `quantifier1.ML`
- `intuitionistic.ML`
- `project_rule.ML`
- `atomize_elim.ML`

## Summary

The Coq Positive Foundations file provides an inductive `Ens` W-type encoding of Dunaev's ordered pair, while the Isabelle IFOLD.thy file defines a theory for intuitionistic first-order logic with syntax and axiomatic basis for terms and propositions.