# MECHANIZED_EXPERIMENTS

## Coq Positive Foundations (`Coq/positive_foundations.v`)

### Inductive `Ens` W-type Encoding

The file defines an inductive type `Ens` with a single constructor `sup` that takes a type `A` and a function `f` from `A` to `Ens`, and returns an `Ens`.

### Pair Definition

The `Pair` function is defined using the `sup` constructor. It takes two `Ens` values `A` and `B` and returns an `Ens` that represents the ordered pair of `A` and `B`.

### Equality of Sets

The `EQ` function is defined to check the extensional equality of two sets. It uses a fixpoint to recursively compare the elements of the sets.

### Membership

The `IN` function is defined to check if an element is a member of a set.

### Sound Predicates

The `SoundPred` and `SoundPredOf` functions are defined to ensure that predicates are sound with respect to the equality relation.

### Transitivity and Symmetry of Equality

The `EQ_tran` and `EQ_sym` functions are defined to prove the transitivity and symmetry of the equality relation.

## Isabelle `code/IFOLD.thy`

### Section and Theory Declaration

The file starts with a section declaration for "Intuitionistic first-order logic" and declares a theory named `IFOLD` that imports the `Pure` theory.

### Abbreviations

The file defines an abbreviation `?<` for the existential quantifier with a subscript `<`.

### ML Files

The file includes several ML files that are used for various purposes, such as `misc_legacy.ML`, `splitter.ML`, `hypsubst.ML`, etc.

### Syntax and Axiomatic Basis

The file defines the syntax and axiomatic basis for the theory, including the declaration of a type `o` and a judgment `Trueprop`.

### Equality

The file defines the equality relation with the `eq` function and provides axioms for reflexivity and substitution.

### Propositional Logic

The file defines the propositional logic operators `False`, `conj`, `disj`, and `imp` with their respective axioms and inference rules.
