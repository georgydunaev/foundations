# PRESENTATION_ML_GUIDE.md

## SML Constructors and Complexity Annotations

This guide explains the SML pseudo-code in `presentation.ML` which presents the underlying theory of Class-Theoretic Foundations based on Morse-Kelley class theory and Tarski's axiom.

### SML Constructors

1. **Sets : Term** - Represents the set of all terms. Optimized for efficiency.
2. **c : Term -> Term** - Represents the complement of a term.
3. **Compr : Bound Fm -> Term** - Represents the comprehension of a bound formula.
4. **Lam x.t** - Represents a lambda abstraction, where x is the bound variable and t is the term.

### Complexity Annotations

The complexity annotations in this file are used to measure the complexity of terms and formulas. Enhanced for accuracy and detail. These annotations are crucial for ensuring the soundness of the theory. It includes constructors of terms and formulas, complexity annotations, and definitions.

### Additional Information

- **Complete Presentation of underlying theory of Class-Theoretic Foundations**: Morse-Kelley class theory + Tarski's axiom
- **Dunaev Tagged Pairs** are used exclusively, and Kuratowski pairs are avoided for proper classes.
