# Guide to `presentation.ML`

<!-- Documentation update: opencode-go/kimi-k3.1-pro (Capability Tier 3) -->

## Overview

`presentation.ML` is a design note written in SML-like mathematical pseudo-code. The whole file is enclosed in SML comments: its declarations describe a proposed class-theoretic language and are **not** executable Standard ML definitions or a proof kernel.

The background theory is Morse–Kelley (MK) class theory together with the draft's Tarski-style universe axioms. MK treats sets and proper classes as first-class objects and permits impredicative class comprehension. The universe axioms are additional strength; they are not part of the definition of MK itself.

The pseudo-code is preserved verbatim after the new documentation header. This guide explains its notation without silently turning the draft's ideas into verified theorems.

## Notation and Syntactic Categories

- `Var`, `Term`, `Fm`, and `Prf` stand for variables, class terms, formulas, and proof objects.
- `Bound Fm` is a formula together with binding information, as needed for class comprehension.
- `phi[t/x]` means substitution of `t` for `x` in `phi`. The source requires substitution to be free for the bound variable and leaves the associated binder rules implicit.
- `A C B` means that `A` is a subclass of `B`; it does not mean proper inclusion.
- Signatures such as `Term * Term -> Fm` describe notation for binary formula constructors, not necessarily ordinary SML function implementations.

## Constructors of Terms and Formulas

### `Sets : Term`

`Sets` denotes the universal class of sets, not the set of all SML terms. Membership `W in Sets` is used as a sethood side condition. In accordance with MK, a proper class is not a member of this universal class.

### `c : Term -> Term`

The source labels `c` **“super global choice”**. It is therefore a choice/descriptor operator on class terms, not a complement operator. Its signature alone does not specify a particular choice function or prove the required choice properties; those must come from the surrounding axioms.

### `Compr : Bound Fm -> Term`

`Compr` turns a bound formula into a class term, corresponding to notation such as `{x | phi}`. Binding records which variable is abstracted and prevents confusion between free and bound occurrences.

In MK, the comprehension formula may quantify over all classes, so this is **impredicative class comprehension**. Comprehension constructs a class; it does not by itself establish that the resulting class is a set. The source's membership rules consequently include the condition `W in Sets` where appropriate.

### Other Constructors

The draft also introduces variables, substitution, falsehood, propositional connectives, quantifiers, singleton and pair notation, power class, domain, range, union, intersection, membership, equality, function predicates, and universe predicates. These are syntactic forms. Their semantic meaning and proof rules must not be inferred solely from their SML-like types.

## Definitions

A generalized class comprehension is written

```text
{t | phi, x bound} = {z | exists x : t = z /\ phi}
```

with `z` fresh for `t` and `phi`. The source alternates between set-builder notation and `Class (...)`/`Compr` notation; these are explanatory presentations of bound syntax rather than competing executable implementations.

Definitions for domain, range, function application, replacement, products, and related operations are then built from comprehension. Some entries are alternatives or unfinished experiments, so later equations should not automatically be read as additional axioms.

## Morse–Kelley and Tarski's Axiom

The axiom section combines class extensionality, substitution of equals, class comprehension, and universe-related principles. The significant MK point is that formulas used for class comprehension are not restricted to NBG-style quantification over sets alone.

The Tarski-style part is expressed through `universe`, `SetUniverses`, and the axiom

```text
Sets C (union SetUniverses)
```

which says in the draft's notation that every set belongs to some set universe. The other universe clauses characterize the relevant closure and size properties. These statements are part of the pseudo-code being documented; this guide does not claim that the comment-only file mechanically proves them.

## Dunaev Tagged Pairs

Dunaev tagged ordered pairs are required when the components may be proper classes. A Kuratowski pair `{{A}, {A,B}}` would require its components to be set members and therefore cannot be used uncritically for proper classes.

The source's tagged pairing of classes uses complementary tags `1` and `0`:

```text
[A, B] := {(1,s) | (s sss A)} u {(0,s) | (s sss B)}
```

The reversed tag order for `B` is intentional in the original draft. Here `sss` is the source's semi-singleton-subset relation, introduced by `(s sss x) <-> (s C x) /\ (s ss)`.

### Dunaev `Lam x.t`

`Lam x.t` is a **big lambda** or class-family constructor, not merely an ordinary SML function `fn x => t`. Its graph presentation is

```text
(Lam x.t) = {(x,s) | (s sss t)}
```

with `x` and the fresh variable `s` bound by the outer comprehension. The value associated with an index is represented through semi-singleton subsets, which lets the surrounding Dunaev encoding handle families whose values can be proper classes. The related application notation `F(x)` is defined using the union of the values selected at `x`.

Thus, the lambda notation and tagged-pair notation serve different roles: `Lam` forms a family/graph, while Dunaev tags encode ordered pairs of possibly proper classes.

## Complexity Annotations

The `compl. = n` comments are provisional **syntactic complexity weights**. The source proposes measuring a definition by the depth or number of constructors and connectives used to expand it. These numbers are not runtime costs, asymptotic complexity, proof lengths, or independent soundness guarantees.

Examples preserved in the pseudo-code include:

| Definition | Annotation |
| --- | ---: |
| Empty class `{ } = {x|Bot}` | 2 |
| Product `A x B` | 4 |
| `F relation` via `F C (V x V)` | 2 |
| Power class `pow B` | 2 |
| Domain `dom R` and range `ran R` | 3 |
| Expanded `Ran F` definitions | 4 |
| Inhabitedness `m inhabited` | 2 |

The file still contains a TODO asking how the measure should be defined. Consequently, no global weighting algorithm should be inferred from the examples, and alternative expansions of the same operation need not have the same annotation.

## Conclusion

Read `presentation.ML` as a historical mathematical design sketch: `Sets` supplies sethood, `c` is global choice, `Compr` forms MK classes from bound formulas, Dunaev `Lam` forms class-families, and `compl.` values are draft syntactic weights. Executable validation can check that the SML comments are well formed, but it cannot by itself certify the mathematical axioms or proofs sketched inside those comments.
