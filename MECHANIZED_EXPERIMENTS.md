# MECHANIZED_EXPERIMENTS

## Coq Positive Foundations (`Coq/positive_foundations.v`)

### Inductive `Ens` W-type Encoding

The file defines an inductive type `Ens` with a single constructor `sup` that takes a type `A` and a function `f` from `A` to `Ens`, and returns an `Ens`.

### Pair Definition

The `Pair` definition uses `sup bool` to enumerate `A` and `B`. It therefore
represents the unordered pair `{A,B}` under extensional equality. An ordered
pair requires an additional encoding; the identifier `Pair` alone does not
provide ordered projections.

### Equality of Sets

`EQ` recursively defines a proposition expressing extensional equality:
each represented member on either side has an equal member on the other.
Its result type is `Prop`; this is not a claimed decision procedure.

### Membership

`IN` defines a membership proposition by existence of an extensionally equal
member in the represented family. It does not compute a Boolean membership
test.

### Sound Predicates

`SoundPred` and `SoundPredOf` express the condition that a predicate respects
the chosen equality relation. Establishing that condition requires a proof;
the definitions do not enforce it automatically.

### Transitivity and Symmetry of Equality

The source contains proof definitions `EQ_tran` and `EQ_sym` for transitivity
and symmetry. These observations describe the source, not a fresh Coq replay
or a certification of the entire experimental file.

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

## Obelisk Proof Assistant Cross-Reference (`set_theory_prover`)

The local Obelisk website checkout provides useful newer formulations, but
its generated output is evidence about the export, not independent evidence
that every displayed statement has been proved. The comparison below uses
`../obeliskproofassistant.github.io` at commit
`bb346f112ae91d1649940068c7f210a53b8674bf` (inspected 2026-11-07).
No files in that checkout were edited.

`generated/theory_db.json` reports 106 entries, names
`set_theory_prover/program/newchecker.ML` as its source, and identifies
`program/html_generator.ML` as its generator. `data/theory_database.json` uses a different numbering scheme and sometimes
different prose. Prefer a semantic ID together with its source path and
snapshot over an unqualified item number.

Previous versions of this document reported “105 exported entries”,
“100/100 verified higher-order records”, and “35/35 compiled `.nbg`
theorems”. Those are historical reports, not checks performed in this
workspace. The producing ML source and a runnable proof checker are not
present here; these counts must not be presented as certification of the
edited chapters or of the current generated statements.

| Book discussion | Generated semantic ID / item | Separate catalog mapping | Reading decision |
| :--- | :--- | :--- | :--- |
| `110_family_evaluation.tex`: at-most-one classes | `DefSemiSingleton`, 3.35 | 3.67 | Distinguish a predicate's defining body from its universal assertion. |
| Semi-singleton subsets | `DefSemiSingletonSubclass`, 3.36 | 3.68 | The extra subclass condition matters; this is not the family predicate. |
| Guarded evaluation in `060_axioms.tex` | `DefValueAtArg`, 3.25 | Source ID is more reliable than a catalog number | Uses `V` on an absent fibre. |
| Family evaluation | `ThmFamilyEvaluation`, 3.37 | 3.69 | The displayed theorem needs a domain hypothesis with that guarded default. |
| `130_classes_as_types.tex`: dependent sums | `DefSigmaModel`, 3.38 | 3.70 | Interpret under its stated family encoding and size assumptions. |
| Dependent products | `DefPiPredicateModel`, 3.39 | 3.71 | Matching domains alone do not imply membership in the dependent product; pointwise membership is an additional condition. |
| Metatheoretic principles | Use semantic IDs and hypotheses | 3.72–3.74 have changed meanings across catalogs | Do not carry over the old table's subclass/sethood descriptions solely by number. |

The family-evaluation discrepancy has a concrete empty-family counterexample;
see [the upstream ticket](tickets/obelisk_family_evaluation_domain.md).
Other comparison tickets in `tickets/obelisk_*.md` distinguish actual
same-setting conflicts from differences of notation, representation, or
background assumptions. Corrections belong in the upstream ML definitions,
proofs, or generators, followed by regeneration; generated HTML/JSON is not
an editing surface.

### Explicit Typed Term Interpretation ($\mu_A$ / $I$)

In `130_classes_as_types.tex`, the operator
$\mu_A : A.\mathsf{Expression} \to \mathsf{Class}.\mathsf{Expression}$
(written $I(a)$ or $\mu_A(a)$) is an **explicit typed term interpretation**
at the expression level: it translates a typed expression into a class
expression. The Obelisk documentation attributes related machinery to
`program/types/typetheory.ML` and `program/Presentation.ML`; those upstream
sources have not been inspected here.

Evaluating the translated expression in a fixed model and valuation is a
further operation. The resulting semantic interpretation is a valuation
homomorphism only when preservation of the relevant constructors has been
established. Neither that preservation nor the existence of a suitable
model follows from the displayed function type alone.

### Four-Theory Metatheoretic Hierarchy ($\mathcal{W}, \mathcal{E}, \mathcal{T}, \mathcal{F}$)

The book distinguishes the theories $\mathcal{W}, \mathcal{E},
\mathcal{T}, \mathcal{F}$ by their roles in each argument. The generated
catalog is useful for locating related claims, but those roles must not be
inferred from names alone:

1. $\mathcal{W}$ is a theory parameter in several schemes; its strength and
   soundness are hypotheses, not automatic properties of the letter.
2. $\mathcal{E}$ supplies the elementary metatheory needed for a chosen
   provability predicate and its derivability conditions. The export's
   listed examples include $I\Sigma_1$, $\mathcal{T}$, NBG, and MK, subject
   to the actual hypotheses of the theorem being considered.
3. $\mathcal{T}$ is the effective object theory in the incompleteness
   discussion. Recursive enumerability, coding, and consistency assumptions
   must remain explicit.
4. $\mathcal{F}$ is an ideal non-effective theory considered under a chosen
   intended-truth interpretation. Soundness, syntactic negation-completeness,
   and containment of every intended truth are distinct properties. A
   Co-Necessitation rule needs the stated relationship between truth and
   theoremhood; a slogan about soundness alone does not specify its scope.

The earlier notes cite Bezboruah & Shepherdson 1976 in connection with weak
arithmetic. That citation is not a reason to declare every incompleteness
formulation over Robinson arithmetic meaningless: the exact provability
predicate and available derivability conditions determine which theorem can
be used. The revised logical framework states the needed conditions locally.
See its Obelisk comparison remarks and the logic tickets for conflicts among
the generated formulas, descriptions, and verification labels.
