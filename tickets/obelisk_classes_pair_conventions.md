# Distinguish recursive, marker-tagged, and Kuratowski pair conventions

Status: upstream notation/context correction requested; no website files edited.

Compared on 2026-11-07 against the read-only checkout at
`/home/gdunaev/obeliskproofassistant.github.io`.

## Evidence and local interpretation

The book `070_ordered_pair.tex` develops the recursive equations

```text
P(A,B) = {P(0,a) | a∈A} ∪ {P(1,b) | b∈B},
P(0,0) = ∅.
```

The newer generated catalog instead uses an explicit marker construction in
`generated/theory_db.json`, `DefDunaevOrderedPair` (3.76, `CpOPair`), also
published at `generated/proofs/DefDunaevOrderedPair.html`:

```text
S3(a) = {{{a}}},
M(A,n) = {{0,n}} ∪ { {S3(a),n} | a∈A },
D(A,B) = M(A,1) ∪ M(B,2).
```

Here all displayed braces describe ordinary unordered sets. This transcription
matches the fully expanded 3.76 formula: its payload for tag 1 is
`{{{{a}}},{∅}} = {S3(a), 1}`. `ThmDunaevFirstProjection` (3.77) and
`ThmDunaevSecondProjection` (3.78) decode these payloads.

This is a legitimate different construction: `D(0,0)={{0,1},{0,2}}` is
nonempty, whereas the recursive `P(0,0)` is empty. A projection theorem for
D does not verify the recursive equations or numerical calculations for P.

The catalog also publishes `DefKuratowskiPair` (3.52,
`CpKuratowskiPair`) as `(a,b)={{a,a},{a,b}}`, using the same rendered pair
notation as `CpOPair` but a distinct named constructor. Thus the shared
notation is ambiguous; the records do not by themselves establish that the
kernel identifies the two constructors. On sets, `K(0,0)={{0}}` differs
from both the recursive and marker-tagged empty pairs.

`DefClassLists` (3.51) introduces `mark` and projections using a mixture of
parentheses and braces, while 3.76–3.78 use explicit unordered payload sets.
The relationship of those encodings needs to be made unambiguous.

Finally `docs/axioms/45_tagged_pairs.md` gives `inj_1(X)={<0,x>|x∈X}` and
`inj_2(Y)={<1,y>|y∈Y}` without specifying the inner pair constructor, and
reports a Lean verification. That informal documentation does not identify
which of the above encodings its proof covers.

## Source-level correction

The generated catalog declares `set_theory_prover/program/newchecker.ML`
as source and `set_theory_prover/program/html_generator.ML` as generator.
Correct the definitions' source metadata and symbol rendering there:

- Give the constructors distinct emitted notation, for example `P_rec`,
  `D_mark`, and `K`, including Cartesian products and projections.
- State exactly which pair convention each theory variant uses.
- Explain whether 3.51 is an abbreviation for 3.76 or a separate encoding;
  ensure its payload syntax and projections match that choice.
- Guard the pair-interface claims for Kuratowski pairs by sethood of both
  components. Its class-comprehension expression can exist for proper
  arguments, but it does not recover them injectively.
- Attach proof provenance to the precise construction. A translation or
  equivalence claim requires a separate statement and proof; do not silently
  rename the newer encoding as the older recursive definition.

## Acceptance criteria

1. The generated formulas distinguish all three empty-pair calculations.
2. Constructor IDs and links remain distinct in JSON, formula pages, and the
   symbol index.
3. Marker-pair projection examples include a proper-class component and an
   empty component; recursive examples retain `P_rec(0,0)=∅`.
4. Every use of a Cartesian product identifies its underlying pair convention.
5. All changes are made in upstream source and regenerated; generated output
   is never patched manually.
