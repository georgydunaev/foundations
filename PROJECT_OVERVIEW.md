# Project Overview: Foundations of Mathematics and Schroedinger Semigroups (`foundations`)

## 1. Purpose and Scope
`foundations` (`/botworkspace/foundations` and `/botworkspace/foundations`) is the primary mathematical treatise repository housing two major LaTeX book/thesis developments:
1. **Foundations of Mathematics (`main.tex` and numbered chapters `000_preamble.tex` .. `070_ordered_pair.tex`)**: Formalizes first-order logic, variable-binding operators (quantifiers, class comprehension $\kappa$, definite description $\iota$, and choice descriptors $\tau, \epsilon, \varepsilon$), Morse-Kelley (`MK`) and Von Neumann-Bernays-Goedel (`NBG`) class theories, Dunaev Tagged Ordered Pairs for proper classes, and the `MKTD1` / `MKTD2` foundational semantics.
2. **Schroedinger Semigroups Thesis (`thesis_schrodinger.tex`)**: Develops the free heat equation, separately continuous integral kernel criteria, bounded-potential Schroedinger semigroups, and quantitative Lipschitz regularity.

## 2. Strict Governance Rules
- **Immutability of Stored PDFs (Fact 11)**: Never overwrite, edit, or regenerate tracked `.pdf` artifacts (`main.pdf`, `thesis_schrodinger.pdf`, etc.).
- **Strict MKTD1 / MKTD2 Taxonomy (User Directives #15 & #19)**: Always use explicit `MKTD1-framework`/`MKTD1-system`/`MKTD1-theory` and `MKTD2-framework`/`MKTD2-system`/`MKTD2-theory` terminology, use `Class` variables for comprehension `{x | phi(x)}`, and use the general term **binder** (or **variable-binding operator**).
- **Polite Host RAMDisk Workflow**: Always pull via `bash /botworkspace/scripts/hostramdisk_workspace.sh pull foundations` before editing `/botworkspace/foundations` and commit via `bash /botworkspace/scripts/hostramdisk_workspace.sh commit foundations "<message>"`.

## 3. Key Chapters and Files
- [000_preamble.tex](file:///botworkspace/foundations/000_preamble.tex) and [001_foundations.tex](file:///botworkspace/foundations/001_foundations.tex) — Macro definitions, reading routes, and metatheoretic context ($\mathcal{E} \in \{\mathrm{I}\Sigma_1, \mathrm{PA}, \mathcal{T}, \mathrm{NBG}, \mathrm{MK}\}$).
- [010_logic.tex](file:///botworkspace/foundations/010_logic.tex), [020_descriptors.tex](file:///botworkspace/foundations/020_descriptors.tex), [archive/025_unified_descriptors.tex](file:///botworkspace/foundations/025_unified_descriptors.tex), [archive/050_descriptor_systems.tex](file:///botworkspace/foundations/050_descriptor_systems.tex) — Formal syntax, binders, and Hilbert/iota/tau descriptor calculi.
- [030_alternative_semantics.tex](file:///botworkspace/foundations/030_alternative_semantics.tex), [archive/035_unified_type_semantics.tex](file:///botworkspace/foundations/035_unified_type_semantics.tex), [050_prooftrees.tex](file:///botworkspace/foundations/050_prooftrees.tex), [archive/050_unified_interface.tex](file:///botworkspace/foundations/050_unified_interface.tex) — Sequent calculus, type semantics, and dual interpretation model.
- [060_axioms.tex](file:///botworkspace/foundations/060_axioms.tex), [archive/010_ordered_pairs.tex](file:///botworkspace/foundations/010_ordered_pairs.tex), [070_ordered_pair.tex](file:///botworkspace/foundations/070_ordered_pair.tex) — Class theory axioms and Dunaev Tagged Ordered Pairs.
- [thesis_schrodinger.tex](file:///botworkspace/foundations/thesis_schrodinger.tex) — Standalone Schroedinger semigroup thesis manuscript.
