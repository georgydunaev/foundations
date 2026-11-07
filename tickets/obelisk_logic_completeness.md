# Obelisk: distinguish semantic completeness from negation-completeness

Status: open; theory-record classification and explanatory proof required.

Evidence: `/home/gdunaev/obeliskproofassistant.github.io` at commit
`bb346f112ae91d1649940068c7f210a53b8674bf`, inspected read only.

## Exact discrepancy

In both `generated/data/theory_database.json` and `generated/theory_db.json`,
`AxmCompletenessOfFullTheory` (3.74) has:

- Formula: `∀φ:Fm. (eval(φ) → (F,[] ⊢ φ))`.
- Constructor: `POmnis_prf`.
- Classification: `Definition`; verification: `Definitional (Kernel AST)`.
- Comment: “Negation-completeness ... for every sentence φ, if ¬φ is not
  derivable in F, then φ is derivable in F.”

`generated/proofs/item-3.74.html` and `generated/metatheory.html` repeat this
combination. Entry `AxmSoundnessOfFullTheory` (3.73) separately asserts
`(F,[] ⊢ φ) → eval(φ)`.

The displayed formula is semantic completeness relative to the chosen
interpretation, called *omniscience* in `010_logic.tex`. The comment states
negation-completeness. They concern different data and are not interchangeable
without hypotheses. Moreover, a displayed implication about an already named
F is not automatically a conservative definition of a new symbol.

## Local analysis

With classical bivalent evaluation and soundness of F in the chosen
interpretation, negation-completeness implies semantic completeness. If φ is
true, soundness excludes a proof of ¬φ; negation-completeness gives a proof
of φ. Conversely, semantic completeness and bivalence imply that one of φ and
¬φ is provable. These arguments explain a valid connection while preserving
the two notions. Mere consistency of an arbitrary complete extension does
not guarantee soundness in a separately chosen intended interpretation.

The book now states these hypotheses and arguments explicitly, retaining the
author's ideal F and its omniscience principle.

## Required upstream source change

The generated provenance identifies
`set_theory_prover/program/newchecker.ML` as the theory source and
`set_theory_prover/program/html_generator.ML` as the generator. Inspect the
source record for `AxmCompletenessOfFullTheory` and the actual `POmnis_prf`
checking branch before selecting its status.

Preserve the displayed omniscience principle and identify it accurately in
its title and comment. Classify it according to actual provenance: an assumed
semantic principle, a definition of F as a theory of a specified model, or a
proved consequence of explicit hypotheses. If negation-completeness is also
wanted, give it a separate formula and record the conditional equivalence
proof. Record the sentence restriction or a precise assignment convention.
Regenerate all outputs from the ML sources, never by editing generated files.

## Acceptance criteria

- Formula, prose, constructor, and verification classification agree.
- Negation-completeness and semantic completeness have distinct definitions.
- Their connection cites soundness and bivalence and includes the short proof.
- An arbitrary complete consistent extension is not silently identified with
  the theory of a fixed intended structure.
- HTML and both JSON exports agree on assumptions, domain, and provenance.
