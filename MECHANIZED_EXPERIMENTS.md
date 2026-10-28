# MECHANIZED_EXPERIMENTS.md

## Summary of Inductive `Ens` W-type Encoding of Dunaev's Ordered Pair in Coq

The Coq file `positive_foundations.v` defines an inductive type `Ens` which represents a set. The `Pair` function is defined using the `sup` constructor, which takes a boolean and returns either the first or second argument based on the boolean value. This encoding allows for the representation of ordered pairs in a way that is consistent with Dunaev's ordered pair theory.

The `EQ` function defines extensional equality between two sets, and the `IN` function defines membership of an element in a set. The `SoundPred` and `SoundPredOf` functions define sound predicates over sets and types, respectively. The `EQ_tran` function is a proof that extensional equality is transitive.

## Summary of Isabelle/FOL Definitions in `IFOLD.thy`

The Isabelle file `IFOLD.thy` defines the syntax and axiomatic basis for intuitionistic first-order logic. It includes the definition of a type `o` and a judgment `Trueprop` that maps terms of type `o` to propositions. The file also includes the definition of equality and propositional logic operators such as `False`, `conj` (conjunction), `disj` (disjunction), and `imp` (implication).

The Isabelle definitions provide a formal foundation for reasoning about intuitionistic first-order logic, which can be used to verify the correctness of the Coq definitions and to explore the relationship between the two formalisms.