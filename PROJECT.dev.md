# Project Development Context (`foundations`)

> **Tier 0 Global Ruleset**: Read `/botworkspace/AGENTS.md` and `/botworkspace/FACTBOOK.md` first. Do not duplicate global rules here.

## Treatise Modules & Boundaries
1. **Foundations of Mathematics Monograph (`001_foundations.tex`)**:
   - **Preamble & Entrypoint**: `000_preamble.tex`, `001_foundations.tex`, `references.bib`, `MACROS_INDEX.md`.
   - **Syntax, Logic & Binders**: `010_logic.tex`, `020_descriptors.tex`, `025_unified_descriptors.tex`, `050_descriptor_systems.tex`.
   - **Type Semantics & Proof Calculi (`MKTD1` / `MKTD2`)**: `030_alternative_semantics.tex`, `035_unified_type_semantics.tex`, `050_prooftrees.tex`, `050_unified_interface.tex`, `summary_of_approaches.tex`.
   - **Class Axioms & Ordered Pairs**: `060_axioms.tex`, `010_ordered_pairs.tex`, `070_ordered_pair.tex`.
2. **Schroedinger Semigroups Thesis (`thesis_schrodinger.tex`)**:
   - **Manuscript & Verifier**: `thesis_schrodinger.tex`, `schrodinger_kernel_verifier.py`, `scripts/plot_dynamical_potential.py`.
3. **Mechanized SML & Python Verification Suite**:
   - **SML Presentation Kernel**: `presentation.ML`, `PRESENTATION_ML_GUIDE.md`.
   - **Python Foundational Models & Test Suite**: `foundations/` package and `tests/` (`test_foundations.py`, `test_mktd_foundations.py`, `test_type_semantics.py`, `test_logic.py`, `test_descriptors.py`, `test_preamble.py`).

## Verification & LaTeX Build Commands
```bash
# Run Python unit test suite & preamble checks
python3 /botworkspace/foundations/run_tests.py
bash /botworkspace/foundations/tests/check_preamble.sh

# Compile Foundations of Mathematics monograph (001_foundations.pdf)
cd /botworkspace/foundations && pdflatex -synctex=1 -interaction=nonstopmode 001_foundations.tex && biber 001_foundations && pdflatex -synctex=1 -interaction=nonstopmode 001_foundations.tex && pdflatex -synctex=1 -interaction=nonstopmode 001_foundations.tex

# Compile Schroedinger Semigroups thesis (thesis_schrodinger.pdf)
cd /botworkspace/foundations && pdflatex -synctex=1 -interaction=nonstopmode thesis_schrodinger.tex && biber thesis_schrodinger && pdflatex -synctex=1 -interaction=nonstopmode thesis_schrodinger.tex && pdflatex -synctex=1 -interaction=nonstopmode thesis_schrodinger.tex
```
