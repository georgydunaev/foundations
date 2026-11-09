# Restore the missing dependent-product membership condition in DefPiPredicateModel

Status: Resolved / Implemented (2026-11-09). Upstream ML source `program/types/foundations.ML` updated to include the pointwise section condition in the antecedent of `pi_predicate_model_def_entry_fm`, and site artifacts regenerated via `html_generator.ML`.

Compared on 2026-11-07 against the local read-only checkout at
`/home/gdunaev/obeliskproofassistant.github.io`.

## Evidence

`generated/theory_db.json`, entry `DefPiPredicateModel` (3.39), and
`generated/proofs/DefPiPredicateModel.html` publish the formula

```text
∀ B f, (family(B) ∧ family(f) ∧ Dom(f)=Dom(B))
       → ∀ x∈Dom(B), f(x)∈B(x).
```

The record has `prf_constructor: CpPi`, an empty side condition, and status
`Verified (Kernel)`. Its `kernel_ast_unicode` has the same missing restriction.
The problem therefore cannot be explained just by dropped typography in the
Unicode formula. Inspection of the source proof object remains necessary.

The book's `130_classes_as_types.tex`, “The first model of Pi-types as
predicates on classes,” supplies the missing idea: being a section of B
includes the pointwise condition. Having the same domain does not establish it.

## Minimal counterexample

Use an injective set-pair convention and let
`B = f = {(0, ∅)}`, where `0=∅`. Each has domain `{0}` and one fiber entry,
so both satisfy concentrated set values and flat proper values. Entry 3.25
(`DefValueAtArg`) gives `B(0)=f(0)=⋃{∅}=∅`; this is an in-domain calculation,
independent of the separate out-of-domain default issue. The published
conclusion requires `∅∈∅`, which is false.

This is a contradiction in the stated theorem under its displayed local
conventions, not a disagreement between alternative foundational systems.
It does not, without checking the source proof object, establish that an
unsound theorem has actually been admitted by the implementation.

## Required upstream change

The catalog identifies its source as `set_theory_prover/program/newchecker.ML`
and generator as `set_theory_prover/program/html_generator.ML`. Fix the
source entry and actual statement/proof producing `DefPiPredicateModel`:

- Define a section predicate by `PiSection(f,B) ↔ class_function(f) ∧
  Dom(f)=Dom(B) ∧ ∀x∈Dom(B), f(x)∈B(x)` (or the correctly scoped equivalent
  in the project's chosen typed syntax).
- If this entry is meant to be an elimination theorem, assume the section
  predicate or a genuine typing judgment `f : Π B` in its antecedent.
- Keep the separate predicate model for proper-class domains. A collected
  class of sections includes only set instances and needs its own size scope.
- Recheck the actual proof and generate the status from that result. Do not
  repair this by hand-editing JSON/HTML or merely changing the printed title.

## Acceptance criteria

1. The singleton-domain empty-value example is rejected as a section.
2. A positive example with `B(0)={0}` and `f(0)=0` satisfies the section rule.
3. Empty-domain sections are handled explicitly and pointwise conditions are
   vacuous there.
4. Predicate-valued products on proper-class domains are not silently replaced
   by classes whose elements would have to be sets.
5. Generated JSON, standalone proof page, dependent-types page, and proof
   object agree on the corrected premises and status.
