# Foundations of Mathematics

LaTeX sources, notes, and mechanized experiments for a class-theoretic
foundation of mathematics (Morse–Kelley class theory with Tarski's axiom,
Dunaev tagged ordered pairs, and a proof-assistant-oriented logical framework).

> **Provenance / maintenance note.** This file map was compiled for ticket
> [#7188](tickets/ticket_7188_zone_delegated.md) by
> `opencode/deepseek-v4.1-flash-free` (capability tier 1).
> The change is **strictly cosmetic**: no `.tex`, `.ML`, `.v`, or `.thy`
> content was modified, and no historical approach was removed.

---

## 1. How the document is assembled

`[001_foundations.tex](001_foundations.tex)` is the master driver. It loads
`[000_preamble.tex](000_preamble.tex)`, emits the title/front matter and table
of contents, then pulls in chapter files with `\input{...}`. Each chapter is a
standalone fragment wrapped by:

- `[BEGIN.tex](BEGIN.tex)` — include guard, loads the preamble, opens the
  `document` environment, and sets the bibliography resource.
- `[END.tex](END.tex)` — closes the `document` and prints the bibliography.

Numeric filename prefixes (`000`, `010`, … `330`) express reading order and
leave room for insertions; they are **not** contiguous chapter numbers. Some
files are intentionally *not* part of the current build (commented out in the
master, or historical appendix material) and are marked as such below.

Build commands recorded at the top of `000_preamble.tex`:

```sh
pdflatex -synctex=1 -interaction=nonstopmode 001_foundations.tex
latexmk -e "$pdflatex=q/pdflatex -synctex=1 -interaction=nonstopmode/" -pdf 001_foundations.tex
biber 001_foundations
```

Note: the build references material outside this repository. The bibliography
`../THESIS/TEX/references.bib` is loaded by `001_foundations.tex`, and the last
chapter is `\input` from `../THESIS/TEX/AcademicWriting.tex`. A full build
therefore expects that sibling thesis tree to be present.

Two *commented* `\input` lines name files that do not exist in this repository
(`some_order_theory.tex` and `240_linal_topology_etc.tex`); they are dormant
placeholders and are not listed as files below.

### Chapter map (as assembled by `001_foundations.tex`)

| Chapter | Files pulled in (in order) | Notes |
| --- | --- | --- |
| Front matter | `000_preamble.tex`, `001_foundations.tex` (driver), `BEGIN.tex` / `END.tex` shims | Title, dedication, introduction, contents. |
| 1. Logical framework | `010_logic.tex` | Proof-assistant output, type theory, unfinished metalanguage section. |
| 2. Classes | `060`, `070`, `140`, `190`, `220`, `150`, `120`, `170`, `080`, `090`, `130`, `160`, `180` (all `.tex`) | Core mathematical development; `100_class_theory.tex` is commented out as blank. |
| 3. Undergraduate mathematics | `230`, `250`, `300` (all `.tex`) | `260`–`310` except `300` are commented out as stubs. |
| 4. Various logic–related ideas | Inline De Bruijn/SML appendix, `199`, `200`, `210`, `110`, `030`, `040`, `050`, `320_strang_thm`, `330` (all `.tex`) | `020` is commented out (“heavy semantics”); `320_src` is commented out. |
| 5. Topics related to Dunford–Pettis theorem | `../THESIS/TEX/AcademicWriting.tex` | External to this repository. |

### Status legend

| Status | Meaning |
| --- | --- |
| **Active** | Part of the current master build and under active development. |
| **Active (draft)** | Part of the current build but incomplete, skeletal, or with proofs marked for upgrade. |
| **Paused** | Substantive draft deliberately excluded from the current build. |
| **Inactive (commented)** | File is `\input` or retained, but all of its body is inside a `comment`/`\iffalse` block and produces no output. |
| **Historical** | Explicitly `[OUTDATED]` or superseded; preserved unmodified for reference. |
| **Stub** | Placeholder section with little or no mathematical content. |
| **Infrastructure** | Build, preamble, include shim, or tooling support. |
| **Mechanized** | Executable/checkable artifact (SML, Coq, Isabelle). |
| **Asset** | Image, data, or auxiliary non-mathematical file. |

---

## 2. Build, front matter, and infrastructure

| File | Mathematical / technical topic | Status | In master? |
| --- | --- | --- | --- |
| [000_preamble.tex](000_preamble.tex) | Preamble: page geometry, fonts, TikZ/pgf arrow patches, `listings` setup, theorem-like environments (`axiom`, `iaxiom`, `constructor`, `definition`, `inferencerule`, `baddefinition`, …), class-builder and label macros. | Infrastructure | Yes (via `BEGIN.tex`) |
| [001_foundations.tex](001_foundations.tex) | Master document: motivation, goals, rationale for descriptors, chapter orchestration, bibliography; includes an appendix implementation of De Bruijn indices for the untyped lambda calculus in SML. | Infrastructure / front matter | Yes (root file) |
| [BEGIN.tex](BEGIN.tex) | Chapter include shim: guards double preamble loading, sets `\mypath`, opens the document. | Infrastructure | Yes (every chapter) |
| [END.tex](END.tex) | Chapter include shim: prints bibliography and closes the document. | Infrastructure | Yes (every chapter) |
| [.gitignore](.gitignore) | Ignores LaTeX build products (`*.aux`, `*.pdf`, `*.bbl`, `*.synctex.gz`, …). | Infrastructure | — |
| [README.md](README.md) | This chapter and file map (documentation only). | Infrastructure (documentation) | — |
| `tickets/` | Delegated zone ticket descriptions, including ticket #7188 which requested this map. | Infrastructure (records) | — |

---

## 3. Chapter 1 — Logical framework

| File | Mathematical topic | Status | In master? |
| --- | --- | --- | --- |
| [010_logic.tex](010_logic.tex) | The logical framework and proof-assistant type theory: sample kernel output, primitive notation, dot/bold conventions, inference-related constants, typed quantification, and a metalanguage section explicitly marked “not yet finished”. | Active | Yes (`\chapter{Logical framework}`) |

---

## 4. Chapter 2 — Classes (core mathematical development)

This is the core mathematical development of the book. Rows follow the order in
which `001_foundations.tex` inputs the files.

| File | Mathematical topic | Status | In master? |
| --- | --- | --- | --- |
| [060_axioms.tex](060_axioms.tex) | Morse–Kelley class theory: setting and motivation, extensionality, class comprehension (class and class-term variants), empty class, universal class, functions and families, unions, intersections, powerclass, heredity, powerset, regularity as epsilon-induction, and limitation of size. | Active | Yes |
| [070_ordered_pair.tex](070_ordered_pair.tex) | Ordered pairs: pair axioms, Kuratowski's pair, Metamath's pair, Morse's pair, Dunaev's tagged pair, and a formally verified implementation. The adopted representation is the Dunaev tagged pair. | Active | Yes |
| [140_setness.tex](140_setness.tex) | Setness: criteria and theorems deciding when a class is a set; class-builder applications. | Active | Yes |
| [190_union_intersection.tex](190_union_intersection.tex) | Elementary theorems about arbitrary unions and intersections. | Active | Yes |
| [220_simpler_img_thms.tex](220_simpler_img_thms.tex) | Relational image/glare theorems, the membership relation `E`, and a choice function with the epsilon operator. | Active | Yes |
| [150_ordinals.tex](150_ordinals.tex) | Ordinals and induction principles: ordinal classes in a general relation setting, the membership relation case, properties of ordinals; then cardinals (axioms, implementation, soundness). | Active | Yes |
| [120_induction_recursion.tex](120_induction_recursion.tex) | Well-founded classes, regularity reformulation, transfinite/epsilon induction and recursion, and the height of a set. | Active | Yes |
| [170_paradoxes.tex](170_paradoxes.tex) | “Paradoxes” of mathematics recast as theorems: no formula equivalent to its negation, no class of all irreflexive classes, regularity implies irreflexivity, powerclass is not a subclass, the conglomerate of all classes is not a class, and the class of ordinals is not a set. | Active | Yes |
| [080_azriel_levi_union_thm.tex](080_azriel_levi_union_thm.tex) | Mechanization/expansion of Azriel Levy's union theorem (“On Von Neumann's Axiom System for Set Theory”): definitions, bounded sets of ordinals, and “the union of a set is a set”; includes source scans from `azriel_levy/`. | Active | Yes |
| [090_proving_limitation_of_size.tex](090_proving_limitation_of_size.tex) | Theorems on limitation of size: deriving the limitation-of-size axiom from simpler axioms, properties preserved by intersections of universes, and a proposed positive-property-only axiomatization. The last section is inside `\iffalse` (and embeds `Coq/positive_foundations.v` via `lstlisting` only when enabled). | Active (last section commented out) | Yes |
| [100_class_theory.tex](100_class_theory.tex) | Placeholder section “Families and evaluations” (marked for deletion by the author); only `BEGIN`/`END` includes and one heading. | Stub | No (commented out) |
| [130_classes_as_types.tex](130_classes_as_types.tex) | Classes as unary predicates; semantics of Π-, Σ-, W-, and M-types in classes; implementations of booleans (unfinished), option types, ordered pairs, lists, functions, Σ/Pi/W-types, and an M-type section explicitly marked “[not present]”. Contains a large historical `[OUTDATED]` Classes-as-Types subsection. | Active (draft; historical subsections) | Yes |
| [160_some_order_theory.tex](160_some_order_theory.tex) | Order theory: up/down sets, sets of majorants/minorants, greatest/least elements, suprema/infima, essential supremum, and related theorems. | Active | Yes |
| [180_many-valued.tex](180_many-valued.tex) | Many-valued ideas: uncertain/undefined truth values, three- and six-valued sketches. The entire body is inside a `comment` environment, so the chapter currently produces no output. | Inactive (commented) | Yes (empty output) |

---

## 5. Chapter 3 — Undergraduate mathematics

| File | Mathematical topic | Status | In master? |
| --- | --- | --- | --- |
| [230_analysis.tex](230_analysis.tex) | Analysis after Amann–Escher: limits with respect to filters/bases, sequential limits, and equivalence of epsilon–delta definitions. Skeleton with notes. | Active (draft) | Yes |
| [250_topology.tex](250_topology.tex) | Topology: filters, filter bases, topology via a relation, topology via (sub)bases, topologies and algebras, topological properties, and an older-notation section. | Active (draft) | Yes |
| [300_category_theory.tex](300_category_theory.tex) | Category theory, culminating in the Yoneda embedding lemma. The file itself notes that its proofs are old and need upgrading. | Active (draft; stale proofs) | Yes |
| [260_linear_algebra.tex](260_linear_algebra.tex) | Linear algebra: matrices over a set, `combine`, and related basic definitions. | Stub | No (commented out) |
| [270_measure_theory.tex](270_measure_theory.tex) | Measure theory: section heading only. | Stub | No (commented out) |
| [280_functional_analysis.tex](280_functional_analysis.tex) | Functional analysis: section heading only. | Stub | No (commented out) |
| [290_probability_theory.tex](290_probability_theory.tex) | Probability theory: section heading only. | Stub | No (commented out) |
| [310_differential_geometry.tex](310_differential_geometry.tex) | Differential geometry: one remark on connected zero-dimensional manifolds. | Stub | No (commented out) |

---

## 6. Chapter 4 — Various logic-related ideas and appendices

These files are compiled into the chapter “Various logic–related ideas”, after
the inline De Bruijn lambda-calculus listing in `001_foundations.tex`.

| File | Mathematical topic | Status | In master? |
| --- | --- | --- | --- |
| [199_languages.tex](199_languages.tex) | A programming language with dependent types; includes `[OUTDATED]` notes on a primitive programming metalanguage, lambda-calculus definitions, and basic type-theoretic definitions. | Active intro + Historical section | Yes |
| [200_uniqueness.tex](200_uniqueness.tex) | The uniqueness quantifier `!`, singleton sets, and their properties. | Active | Yes |
| [210_partial_functions_semantics.tex](210_partial_functions_semantics.tex) | Partial-function semantics following W. Farmer (PFOL): definedness, description operator, and a worked proof in Farmer's calculus. Preserved as an alternative approach. | Active (alternative approach) | Yes |
| [110_family_evaluation.tex](110_family_evaluation.tex) | Evaluation in a pluralistic semantics: value of a function/family, singleton-based families (preferred), semisingleton-based families (outdated), and an old lambda operator. | Active (contains historical subsections) | Yes |
| [020_descriptors.tex](020_descriptors.tex) | Descriptors: Hilbert-style `τ`, `ϵ`, and `ε` operators (total vs. partial choice), definitions/well-definedness, plural vs. nullar vs. singular readings, and “Descriptors NEW” axioms. | Paused (excluded as “heavy semantics”) | No (commented out) |
| [030_alternative_semantics.tex](030_alternative_semantics.tex) | `[OUTDATED]` Alternative semantics: weak/strong interpretations of the membership relation and a class-existence axiom schema. | Historical | Yes (appendix) |
| [040_old_variant_of_iota_defs.tex](040_old_variant_of_iota_defs.tex) | `[OUTDATED]` Variants of iota definitions: values of functions and proper-class families, non-empty families, a unified approach, value via set descriptors, and old descriptors. | Historical | Yes (appendix) |
| [050_prooftrees.tex](050_prooftrees.tex) | `[OUTDATED]` A proof assistant based on the developed theory: commented presentation of the encoded theory (`presentation.ML`) and graphical proof trees. | Historical | Yes (appendix) |
| [320_strang_thm.tex](320_strang_thm.tex) | Empty chapter shell reserved for a “Strang theorem” (only `BEGIN`/`END` includes; no statement or proof yet). | Stub | Yes (appendix, empty output) |
| [330_restricted_quantifiers.tex](330_restricted_quantifiers.tex) | Restricted-quantifier notation (`∀ R : Q`, `∃ R : Q`, `! R : Q`) with meta-context side conditions. All draft content is commented out. | Historical (inactive; commented out) | Yes (appendix, empty output) |
| [320_src.tex](320_src.tex) | Legacy standalone article source: its own `\documentclass`, package list, theorem environments, and a “Logic” section. Not part of the book build. | Historical / standalone | No (commented out) |

### Chapter 5 — Dunford–Pettis material (external)

`001_foundations.tex` ends with `\chapter{Topics related to Dunford--Pettis
theorem}` and `\input{../THESIS/TEX/AcademicWriting.tex}`. That source lives
outside this repository and is therefore not part of the file inventory.

---

## 7. Mechanized artifacts and code

| File | Topic | Status | Notes |
| --- | --- | --- | --- |
| [presentation.ML](presentation.ML) | SML-style presentation of the underlying theory: Morse–Kelley class theory plus Tarski's axiom; term/formula constructors, comprehension, descriptors, and complexity weights. Included verbatim by `050_prooftrees.tex`. | Reference (not compiled) | File is essentially one large SML comment block, so `poly`/`sml` will not execute it as a program. |
| [Coq/positive_foundations.v](Coq/positive_foundations.v) | Coq development of the positive/property-based fragment: inductive `Ens` W-type encoding (`sup : forall A, (A -> Ens) -> Ens`) with `Pair`, extensional equality `EQ`, membership `IN`, and sound predicates. Builds an `EqualityType` tower (`SET` → `CLASS` → `CONGLOMERATE` → `Universe n`) with `ClassOf`/`Predicate`/`Constr`, class intersections, the universal class `V`, and a `positive`-property predicate. Ends with `Axiom Positivity`; `positive_sound` and `ppc_pos` are currently `Admitted`. No ordered-pair definition is present in this file (the Dunaev pair is developed in `070_ordered_pair.tex`). | Mechanized (draft; 2 `Admitted`) | Coq sources; only referenced from a commented-out block in `090_proving_limitation_of_size.tex`. |
| [code/IFOLD.thy](code/IFOLD.thy) | Isabelle/Pure theory `IFOLD`: intuitionistic first-order logic syntax and axiomatic basis. | Mechanized | Isabelle theory. |
| [M-type.txt](M-type.txt) | Coq scratch snippet: `sigma` types, countable collection `Cou`, and an `M`-type encoding. | Scratch / draft code | Not part of the build. |
| [sed_cmds.txt](sed_cmds.txt) | Helper `sed` recipes used for macro migrations (`\AND` → `\LAND`, class-builder rewrites, `:=` → `\ceq`). | Tooling notes | Not part of the build. |

---

## 8. Assets and auxiliary files

| File | Content | Status |
| --- | --- | --- |
| [azriel_levy/1.jpg](azriel_levy/1.jpg), [2.jpg](azriel_levy/2.jpg), [3.jpg](azriel_levy/3.jpg), [4.jpg](azriel_levy/4.jpg), [5.jpg](azriel_levy/5.jpg) | Scanned pages of Levy's 1968 article, included in `080_azriel_levi_union_thm.tex`. | Asset (referenced) |
| [1.jpg](1.jpg) | Loose image asset, not referenced by the current build. | Asset |
| [Thanks.jpg](Thanks.jpg) | Acknowledgements artwork; references in `001_foundations.tex` are commented out. | Asset (optional) |
| [cargo.jpeg](cargo.jpeg) | Miscellaneous artwork; reference in `001_foundations.tex` is commented out. | Asset (optional) |
| [MYTREE.tex](MYTREE.tex) | TikZ experiment drawing a tree of universe/type levels; loaded standalone. | Helper / experiment |
| [MYTREECOPY.tex](MYTREECOPY.tex) | Copy of the TikZ tree styles used by `MYTREE.tex`. | Helper / experiment |

---

## 9. Quick reading paths

- **Core mathematical development:** `010` → `060` → `070` → `140` → `190`
  → `220` → `150` → `120` → `170` → `080` → `090` → `130` → `160` → `180`.
- **Foundational logic and semantics:** `010` → `020` → `030` → `040` →
  `110` → `200` → `210` → `330`.
- **Applied mathematics:** `230` → `250` → `300` (active); `260` → `270` →
  `280` → `290` → `310` are commented-out stubs.
- **Mechanization:** `presentation.ML` (SML-style specification) →
  `Coq/positive_foundations.v` (Coq, draft) → `code/IFOLD.thy` (Isabelle).

## 10. Notes on status and preservation

- Statuses above reflect the file's own `[OUTDATED]` annotations and whether the
  master file currently `\input`s it; they are descriptive only.
- Every `.tex` file, plus `presentation.ML`, `Coq/positive_foundations.v`,
  `code/IFOLD.thy`, `M-type.txt`, and `sed_cmds.txt` in this repository has a
  row in the tables above. The external `../THESIS/TEX/AcademicWriting.tex`
  chapter and the dormant `some_order_theory.tex` /
  `240_linal_topology_etc.tex` `\input` targets are the only names referenced
  by the master without a local file.
- Competing and historical approaches are **preserved in place**, including
  descriptors (`020`), alternative semantics (`030`), old iota definitions
  (`040`), old proof trees (`050`), early Classes-as-Types material (`130`),
  many-valued ideas (`180`), and Farmer's partial-function calculus (`210`).
- Nothing in this map deletes or rewrites source material. Corrections to the
  map itself are welcome; keep the provenance line above intact.
