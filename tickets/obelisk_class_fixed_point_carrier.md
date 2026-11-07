# Obelisk: keep class fixed points separate from the powerclass carrier

Status: proposed upstream mathematical clarification; generated files untouched.

## Evidence and failure

In checkout `../obeliskproofassistant.github.io` at commit
`bb346f112ae91d1649940068c7f210a53b8674bf`, read on 2026-11-07,
`docs/theorems/schroeder_bernstein.md` states the theorem for arbitrary
classes `A,B`, then declares

\[
F:\mathcal P(A)\to\mathcal P(A),\qquad
F(X)=A\setminus g[B\setminus f[X]].
\]

The site's guarded powerclass contains only **set** subclasses of `A`.
For a proper `A`, the displayed operation need not take its values there.
For example, take `A=B=V`, `f` the identity, and `g(x)={x}`. These are
injective class functions. Then `F(empty)` is the class of nonsingleton
sets. It is proper: it contains every ordinal at least two, and that
ordinal tail is proper. Thus `F(empty)` is not an element of `power(V)`.

Also, the collection of all subclasses of a proper class is not itself
an object-theoretic set or class containing those subclasses as elements.
It cannot silently serve as the set-sized complete lattice in the usual
Knaster--Tarski theorem. The book's set-lattice theorem in
`160_some_order_theory.tex` deliberately does not make that substitution.

## Valid repairs

For **sets** `A,B`, the displayed powerset-lattice proof applies as written.
For arbitrary classes, retain the same monotone formula as a schematic
operation on class parameters and use MK comprehension with class
quantification. For example, define

\[
C=\{a\in A:\exists X\,(X\subseteq A\land X\subseteq F(X)\land a\in X)\}.
\]

Every admitted `X` lies in `C`; monotonicity gives `C subseteq F(C)`.
It follows that `F(C) subseteq F(F(C))`, and `F(C) subseteq A`, so `F(C)`
is itself an admitted subclass and `F(C) subseteq C`. Thus `F(C)=C`.
No proper class is collected as a member, and no class graph with class
arguments is asserted. The subsequent bijection construction then works.

Alternatively use the book's least-class closure construction
`C=(A\g[B]) union g[f[C]]`, whose MK proof is already explicit in
`150_ordinals.tex`. This fixed point differs from the greatest fixed point
chosen in the dossier but supplies the same desired bijection property.

## Acceptance checks

State the set-versus-class domains and the required comprehension fragment
in the source proof. Test the singleton-map example. Keep the choice-free
claim for this MK construction, and distinguish this schematic class
argument from ordinary set-lattice Knaster--Tarski. Regenerate only through
the owning source pipeline.
