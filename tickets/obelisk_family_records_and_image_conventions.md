# Obelisk: canonical family records and two distinct image operations

Status: proposed source-level clarification and correction. No generated files edited.

## Evidence inspected

The local site's `generated/theory_db.json`, inspected on 2026-11-07, exports:

- `DefFamily` (3.31): concentrated set values and flat proper values, with no explicit assertion that every member is a pair record.
- `DefHasConcentratedValues` (3.29) and `DefFlatValues` (3.30): conditions only at represented arguments.
- `DefRelationalImage` (3.26): `F[A] = {b | exists a in A, F(a)=b}`.
- `DefValueAtArg` (3.25): guarded union of stored second coordinates, with default `V`.

These are separate issues from the missing domain hypothesis recorded in `obelisk_family_evaluation_domain.md`.

## Nonrecord members and extensionality

For ordinary Kuratowski pairs, the empty set is not a pair. Consequently `F=empty` and `G={empty}` both satisfy the two displayed family conditions vacuously: neither has any pair record or represented argument. They have the same domain and evaluated values but are different classes. The exported marker-tag pair also is never empty, so the same counterexample applies to that encoding.

To reconstruct a family from its fibers, require that it consist entirely of records, for example `F subseteq V times V` for set-coordinate graphs. With this condition, the proposed concentrated/flat rules do determine a canonical fiber:

- A represented set value `v` has precisely the fiber `{v}`.
- A represented proper-class value `P` has precisely the fiber `{{q} | q in P}`.

This proves family extensionality from equal domains and equal values. For set-valued class functions the domain can be recovered as the arguments whose evaluations are sets, so pointwise equality alone suffices. For general families, retaining the domain remains necessary: the family storing all `(x,{q})` for `q in V` has value `V` everywhere under the `V` default, just like the empty family, but has a different domain.

If the intended signature permits proper-class coordinates in set records, give the corresponding explicit representation predicate instead and prove its uniqueness properties. Class quantification alone does not establish those properties.

## Relational image versus evaluated image

The exported `DefRelationalImage` computes an evaluated image. The book's local family construction needs the actual relational image

    RelImage(F,A) = {b | exists a in A, (a,b) in F}.

They agree on ordinary set-valued class functions under the proper-class default. They differ on a represented proper-class value: if `F(x)=P` is proper, then evaluated image at `{x}` is empty because comprehension cannot collect `P`, whereas the relational image consists of its singleton records. Their union recovers `P`.

Retain both operations with distinct names or clearly scoped notation. In particular, rewriting guarded evaluation as `union(F[{x}])` for arbitrary represented family values requires the relational image. For the exported evaluated-image operation the same expression recovers set values but loses proper values.

## Requested source work and acceptance

Inspect the ML definitions and dependent extensionality and image theorems; make source changes, then regenerate exports. Test the nonrecord counterexample, represented empty value, absent argument, ordinary nontransitive set value, and proper-class value separately. Include a proof that a set family has set values using projection images, heredity, and union; this does not need limitation of size. Preserve the distinct historical representations in the book instead of silently conflating their image conventions.
