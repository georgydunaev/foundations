# Obelisk: distinguish cardinal defaults from class limitation of size

Status: source-level mathematical clarification required; generated site unchanged.
Snapshot: `obeliskproofassistant.github.io` commit
`bb346f112ae91d1649940068c7f210a53b8674bf`, inspected 2026-11-07.

## Evidence

`docs/axioms/37_limitation_of_size.md` displays
`X in V iff |X| prec |V|` and says that every proper class is bijective
with `V`. `docs/axioms/foundational_comparison.md` associates the size
principle with Global Choice. Current catalog semantic IDs, rather than
the older dossier numbering, are:

- `DefCardinality` (3.41): `|K| = On intersect intersection {a in On : K preccurlyeq a}`.
- `DefCardLess` (3.42): `A prec B iff not (B preccurlyeq A)`.
- `AxmSizeLimitation` (3.43): `X in V iff |X| prec |V|`.

The book's `060_axioms.tex` instead states the existence of an actual
class-function surjection from every proper class onto `V`. These
formulations must not be identified merely by their shared name.

## Mathematical distinction

Work locally in ordinary GB with class replacement and Choice for sets;
do not assume Global Choice. No proper class injects into a set: the
inverse graph on its set-sized image would have a set image by class
replacement. Consequently, for every proper class `K`, the indexing
class in the catalog's cardinal formula is empty. The unrestricted
empty-intersection convention makes `|K| = On`. In particular `|V|=On`.

Every set `X` is well-orderable by set Choice. Its assigned cardinal is
an ordinal set `kappa`, the least ordinal admitting an injection of `X`.
There is no injection `On -> kappa`, so `kappa prec On`. For proper `X`,
both assigned values are `On`, and `On prec On` is false because the
identity is an injection. Thus the displayed `AxmSizeLimitation` holds
in this setting already. Equality of the default values of two proper
classes has supplied no map between the classes themselves.

The distinction matters: set Choice does not imply Global Choice, and
`V` being class-bijective with `On` is equivalent to Global Choice over
GB. See [Hamkins, The global choice principle in Gödel–Bernays set theory](https://jdh.hamkins.org/the-global-choice-principle-in-godel-bernays-set-theory/).
For the model-theoretic separation, the discussion of ZFC models equipped
with their definable classes in [Hamkins and Yao, Reflection in second-order set theory](https://www.cambridge.org/core/journals/journal-of-symbolic-logic/article/reflection-in-secondorder-set-theory-with-abundant-urelements-biinterprets-a-supercompact-cardinal/52DB77836EEDFE34B3A7C986CDF3C140)
explicitly allows failure of Global Choice.

This is a local nonimplication over the stated background, not a claim
that the entire exported Obelisk core has such a model. Additional core
axioms could supply the missing strength; those dependencies must be
identified. The argument also assumes replacement, so it makes no claim
about whether replacement follows from the displayed axiom over a weaker
base.

There is a concrete dependent claim to audit. `DefTightClass` (3.47)
states `Tight(U) iff forall B subseteq U, (B prec U iff B in U)`.
At `U=V`, this compares actual classes, not their assigned cardinal
values. Taking the proper class `B=On` would give `V preccurlyeq On`,
and thus Global Choice in the ordinary GB setting. The provenance of
`ThmUniversalClassIsUniverse` (3.69) says its `Tight(V)` component uses
`AxmSizeLimitation` and the cardinal definitions/order constructor.
Inspect that source dependency: an additional rule connecting actual
class comparison with default-cardinal comparison may carry precisely
the missing strength. The exported provenance does not expose its full
statement; this ticket does not allege that the kernel accepted an
invalid derivation.

## Requested source work

1. State whether the intended axiom compares actual classes by maps, or
   compares their assigned ordinal/default values. Preserve both as
   distinct principles unless an equivalence is proved under explicit
   additional hypotheses.
2. If Global Choice or bijections of every proper class with `V` are
   intended conclusions, provide a derivation with actual class graphs;
   do not infer them from equality of default cardinal values.
3. Qualify the comparison table with the precise axiom list and the
   chosen meanings of MK/NBG, including whether Global Choice is included.
4. Make the source dossier numbering agree with the semantic IDs, then
   regenerate the site. Do not edit generated exports directly.

Acceptance: check sets, `On`, and `V` separately; expose the precise
point where a map `V -> On` is constructed; preserve the book's explicit
surjection-based local theory without silently replacing its axiom.
