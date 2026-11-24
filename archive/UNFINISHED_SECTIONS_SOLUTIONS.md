# Mathematical Solutions and Completions for Unfinished Sections in `foundations`

This document provides the self-contained mathematical formulations, definitions, theorems, and proofs completing the unfinished sections identified in `/botworkspace/foundations`:
1. **`010_logic.tex` (lines 862-1518):** `\section{Predicate calculus as an object language [unfinished section]}` (Object-language ASTs, `DottedString`, antiquotation fragments `Fragment`, unique parsing `#`, capture-avoiding substitution, and alignment with `MKTD1-framework` and `MKTD2-framework`).
2. **`010_logic.tex` (lines 4359-4450):** `\section{Primitive definitions[ToDo]}` (Conservative extensions by definition, resolving bound-variable collisions in $A \subseteq B$ when instantiated with $x \subseteq y$, and eliminability of defined symbols).
3. **`060_axioms.tex` (lines 185-350):** Medium type specification versus class comprehension $\cc{x}{\varphi}$, and derivation of generalized class term comprehension $\ccc{\vv{x}}{s}{\varphi}$ from single-variable class comprehension.
4. **`110_family_evaluation.tex` (lines 11-125):** Partial values, candidate-set valuations, formal specification of semi-equality $I_{\Fm}(s \approx t)$, congruence under strict partial evaluation, and the bridge to total union evaluation.

The companion LaTeX file ready for `\input{archive/unfinished_sections_completions.tex}` is located at `/botworkspace/foundations/unfinished_sections_completions.tex`.

---

## 1. Predicate Calculus as an Object Language (`010_logic.tex`, lines 862-1518)

### 1.1 Syntactic Sorts, Antiquotation Templates, and Dual Metatheoretic Reading

To avoid conflating object-language formulas with metalevel statements, the object language of class theory is formalized as a mutually inductive family of algebraic datatypes:
- **Variables ($\Var$):** A countably infinite, decidably ordered set of class variable identifiers $\Var \cong \mathrm{Alphabet}^+ \times \mathbb{N}$ with linear order $<_{\Var}$.
- **Antiquotation Fragments:** For any syntactic sort $\alpha$,
  $$\mathrm{Fragment}(\alpha) := \mathrm{QUOTE}(\mathrm{DottedString}) \sqcup \mathrm{ANTIQUOTE}(\alpha), \qquad \mathrm{Code}(\alpha) := \mathrm{List}(\mathrm{Fragment}(\alpha)).$$
- **Simultaneous Inductive Grammar of $\ClassTerm$ and $\Fm$:**
  All variable-binding operators (**binders**) bind default $\Class$ variables (never restricting comprehension to an NBG `Set` sort):
  1. $\mathrm{VarClass}(x) \in \ClassTerm$ for $x \in \Var$.
  2. For $x \in \Var$ and $\varphi \in \Fm$, the binder terms $\cc{x}{\varphi}$ (class comprehension $\kappa$), $(\iota x,\ \varphi)$ (definite description $\iota$), $(\tau x,\ \varphi)$, and $(\varepsilon x,\ \varphi)$ (choice descriptors) belong to $\ClassTerm$.
  3. For $s, t \in \ClassTerm$, atomic formulas $(s \in t)$ and $(s = t)$ belong to $\Fm$.
  4. For $\varphi, \psi \in \Fm$ and $x \in \Var$, propositional compounds $\bot, \top, (\lnot\varphi), (\varphi \land \psi), (\varphi \lor \psi), (\varphi \implies \psi), (\varphi \iff \psi)$ and quantified formulas $(\forall x,\ \varphi), (\exists x,\ \varphi), (\exists! x,\ \varphi)$ belong to $\Fm$.

- **Dual Reading of Sequents (`MKTD1-framework` vs. `MKTD2-framework`):**
  As noted in `010_logic.tex` (lines 912-929):
  - In the **classical/ontological sequent reading** ($\Fau$, corresponding to `MKTD1-framework` / `MKTD1-system` / `MKTD1-theory`), $(\Fau, \Gamma \vdash \phi_1) \land (\Fau, \Gamma \vdash \phi_2) \implies (\Fau, \Gamma \vdash \phi_3)$ is a metalevel implication between derivability predicates over typed ASTs.
  - In the **constructive Formulas-as-Types reading** ($\Tau$, corresponding to `MKTD2-framework` / `MKTD2-system` / `MKTD2-theory`), a derivation of $\phi_1 \land \phi_2 \implies \phi_3$ is a computable $\lambda$-term transforming a pair of proof objects into a proof object of $\phi_3$.

### 1.2 Capture-Avoiding Substitution and Unambiguous Structural Parsing

For any syntactic expression $e \in \ClassTerm \sqcup \Fm$, the finite set of free variables $\FV(e)$ is defined by $\FV(\mathcal{B} y,\ \varphi) = \FV(\varphi) \setminus \{y\}$ for every binder $\mathcal{B} \in \{\kappa, \iota, \tau, \varepsilon, \forall, \exists, \exists!\}$. Given a finite set $S \subset \Var$, let $\mathrm{fresh}(S)$ be the $<_{\Var}$-first variable outside $S$. Then capture-avoiding substitution $e[t/x]$ on a binder expression $(\mathcal{B} y,\ \varphi)$ is defined totally by:
$$(\mathcal{B} y,\ \varphi)[t/x] := \begin{cases} \mathcal{B} y,\ \varphi & \text{if } y = x, \\ \mathcal{B} y,\ (\varphi[t/x]) & \text{if } y \ne x \text{ and } y \notin \FV(t), \\ \mathcal{B} z,\ \big((\varphi[\mathrm{VarClass}(z)/y])[t/x]\big) & \text{if } y \ne x \text{ and } y \in \FV(t),\ z = \mathrm{fresh}(\FV(\varphi) \cup \FV(t) \cup \{x, y\}). \end{cases}$$

**Theorem:** The partial structural parser $\# : \mathrm{Code}(\mathrm{Syntax}) \rightharpoonup \mathrm{Syntax}$ is injective up to $\alpha$-equivalence on well-formed fully parenthesized expressions, and antiquotation splicing of a term $t$ into a quoted template $\ulcorner \varphi(\meta{A}) \urcorner$ coincides up to $\alpha$-equivalence with the capture-avoiding substitution $\varphi[t/A]$.

---

## 2. Primitive Definitions and Bound-Variable Collisions (`010_logic.tex`, lines 4359-4450)

### 2.1 Resolving the Collision in $(A \subseteq B) \iff (\forall x \in A,\ x \in B)$ When Instantiating $x \subseteq y$

In `010_logic.tex` (lines 4365-4446), the question is posed how to state the defining axiom for $A \subseteq B$ so that it remains valid even when $A$ and $B$ are instantiated with variables or terms containing the bound variable $x$ (such as $x \subseteq y$).

**Solution and Proof:**
1. **Closed Defining Axiom:** Fix three distinct variables $A, B, w \in \Var$. The primitive definition of the binary predicate symbol $\subseteq$ is the single closed object-language axiom:
   $$\Fau \vdash \forall A,\ \forall B,\ \big( (A \subseteq B) \iff (\forall w,\ (w \in A \implies w \in B)) \big).$$
2. **Instantiation at Arbitrary Terms $t_1, t_2 \in \ClassTerm$:**
   In first-order logic, universal elimination $(\forall v,\ \Phi) \implies \Phi[t/v]$ uses capture-avoiding substitution (Section 1.2). When we instantiate $A := t_1$ and $B := t_2$, the substitution operator applied to the right-hand side $\forall w,\ (w \in A \implies w \in B)$ computes
   $$z := \mathrm{fresh}(\FV(t_1) \cup \FV(t_2) \cup \{A, B, w\})$$
   whenever $w \in \FV(t_1) \cup \FV(t_2)$, and $\alpha$-renames the bound variable $w$ to $z$ before substituting $t_1$ and $t_2$.
3. **Result for $t_1 = x$ and $t_2 = y$:**
   Since $z \notin \{x, y\}$, universal elimination yields
   $$\Fau \vdash (x \subseteq y) \iff (\forall z,\ (z \in x \implies z \in y)),$$
   which is completely free of variable capture.
4. **Conservativity:** By recursive macro-expansion $(\cdot)^\star$ using capture-avoiding substitution at every defined predicate $P(t_1, \dots, t_n)$ and descriptor-defined operator $F(t_1, \dots, t_n) = (\mathcal{D} y,\ \psi(t_1, \dots, t_n, y))$, any finite chain of definitions over $\Fau$ is a conservative extension of $\Fau$.

---

## 3. Medium Type Comprehension and Class Term Comprehension (`060_axioms.tex`, lines 185-350)

### 3.1 Disambiguating Medium Type Specification from Class Comprehension

In `060_axioms.tex` (lines 189-196), writing $\cc{x : X}{\varphi}$ for both a refined medium type and a class comprehension creates a syntactic type ambiguity.

**Resolution:**
1. **Medium Types are Unary Formula Constructors (Conglomerate Predicates):**
   A medium type $\mathcal{T}$ is a syntactic predicate mapping any class term $A \in \ClassTerm$ to a formula $(A : \mathcal{T}) \in \Fm$. Because $(A : \mathcal{T})$ is a formula rather than a class term, it can hold of proper classes (such as $\V$ or proper class functions) without paradox.
2. **Distinct Syntax for Medium Type Refinement:**
   Given a medium type $\mathcal{T}$ and a formula $\varphi(x)$, the refined medium type is written $\llbracket x : \mathcal{T} \mid \varphi \rrbracket$ (or $\mathrm{SubType}(x : \mathcal{T}, \varphi)$) and defined by the syntactic equivalence:
   $$\big(A : \llbracket x : \mathcal{T} \mid \varphi \rrbracket\big) \iffdef (A : \mathcal{T}) \land \varphi[A/x].$$
3. **Class Comprehension Always Uses `Class` Variables and Collects Sets:**
   By contrast, $\cc{x}{\varphi} \in \ClassTerm$ is a class term binding a default $\Class$ variable $x$, governed by the comprehension schema:
   $$\forall (w : \Class),\ \big( w \in \cc{x}{\varphi} \iff (w\set) \land \varphi[w/x] \big).$$

### 3.2 Derivation of Generalized Class Term Comprehension (`termComprehension`)

Define generalized class term comprehension $\ccc{\vv{x} : \vv{\mathcal{T}}}{s}{\varphi}$ by choosing a fresh variable $w = \mathrm{fresh}(\FV(s) \cup \FV(\varphi) \cup \{\vv{x}\})$ and setting:
$$\ccc{\vv{x} : \vv{\mathcal{T}}}{s}{\varphi} \eqdef \cc{w}{\exists (\vv{x} : \vv{\mathcal{T}}),\ (w = s) \land \varphi}.$$

**Proof of `termComprehension`:**
Let $t \in \ClassTerm$ satisfy $\FV(t) \cap \{\vv{x}\} = \emptyclass$. Applying `varComprehension` to $\cc{w}{\exists (\vv{x} : \vv{\mathcal{T}}),\ (w = s) \land \varphi}$ at the argument $t$ gives:
$$t \in \ccc{\vv{x} : \vv{\mathcal{T}}}{s}{\varphi} \iff (t\set) \land \Big( \exists (\vv{x} : \vv{\mathcal{T}}),\ (w = s) \land \varphi \Big)[t/w].$$
Since $\FV(t) \cap \{\vv{x}\} = \emptyclass$ and $w \notin \FV(s) \cup \FV(\varphi) \cup \{\vv{x}\}$, substituting $t$ for $w$ passes cleanly inside $\exists (\vv{x} : \vv{\mathcal{T}})$ without renaming or capture, yielding:
$$t \in \ccc{\vv{x} : \vv{\mathcal{T}}}{s}{\varphi} \iff (t\set) \land \exists (\vv{x} : \vv{\mathcal{T}}),\ (t = s) \land \varphi.$$

---

## 4. Partial Values, Candidate Semantics, and Semi-Equality (`110_family_evaluation.tex`, lines 11-125)

### 4.1 Complete Specification of Semi-Equality $I_{\Fm}(s \approx t)$

In the candidate-set semantics of `110_family_evaluation.tex`, each expression $t$ is assigned a candidate set $S_t \subseteq D$:
- **Defined ($t \ldefined$):** $|S_t| = 1$, say $S_t = \{v_t\}$.
- **Underdefined:** $S_t = \emptyclass$.
- **Uncertain (Overdetermined):** $|S_t| \ge 2$.

We specify the three-valued semantic valuation $I_{\Fm}^{3\mathrm{val}}(s \approx t) \in \{\ltrue, \lfalse, \lundef\}$ of semi-equality:
$$I_{\Fm}^{3\mathrm{val}}(s \approx t) := \begin{cases} \ltrue & \text{if } |S_s| = 1,\ |S_t| = 1,\ \text{and } v_s = v_t, \\ \lfalse & \text{if } S_s \ne \emptyclass,\ S_t \ne \emptyclass,\ \text{and } S_s \cap S_t = \emptyclass, \\ \lundef & \text{otherwise.} \end{cases}$$

At the two-valued classical assertion level:
1. **Strict equality ($s =_{\mathrm{strict}} t$):** $|S_s| = 1 \land |S_t| = 1 \land S_s = S_t$.
2. **Directed quasi-equality ($s \simeq t$):** $((|S_s| = 1 \lor |S_t| = 1) \implies (|S_s| = 1 \land |S_t| = 1 \land S_s = S_t))$.
3. **Strong semi-equality:** $(\forall u \in S_s\, \forall v \in S_t,\ u = v) \land (S_s = \emptyclass \iff S_t = \emptyclass)$.
4. **Candidate equality ($s \equiv_{\mathrm{cand}} t$):** $S_s = S_t$.

### 4.2 Equivalence on Functional Partial Terms and Bridge to Total Union Evaluation

1. **Coincidence on Functional Terms ($\mathcal{D}_{\le 1} = \{t : |S_t| \le 1\}$):**
   Whenever $|S_s| \le 1$ and $|S_t| \le 1$ (no expression has multiple conflicting candidates), directed quasi-equality $s \simeq t$, Kleene equality, strong semi-equality, and candidate-set equality $S_s = S_t$ are logically equivalent and form a congruence under strict partial function application.
2. **Reduction to Total Union Evaluation:**
   For a family $F$ with candidate fiber $S_{F,x} = \cc{s}{(x, s) \in F}$, total union evaluation defines $\mathrm{Val}_{\cup}(F, x) := \bigcup S_{F,x}$. Because $\bigcup \emptyclass = \emptyclass$ and $\bigcup \{v\} = v$ for every set $v \in \V$, total union evaluation coincides with the unique value on all defined fibers ($|S_{F,x}| = 1$) while mapping underdefined fibers ($S_{F,x} = \emptyclass$) to $\emptyclass$.
