# PROJECT.dev.md: foundations

Workspace rules: `/botworkspace/AGENTS.md`. Definitions used by the book's Obelisk chapters:
`/botworkspace/set_theory_prover/FACTBOOK.md`.

## Contents

- **The book** `001_foundations.tex`: preamble `000_preamble.tex`, chapters `0NN_*.tex` to
  `3NN_*.tex` included with `\input`, bibliography `references.bib`. Only files reachable from
  `001_foundations.tex` are part of the book. Unused drafts are in `archive/`.
- **Schrödinger thesis** `thesis_schrodinger.tex` (separate document; plan in
  `THESIS_RESEARCH_PLAN.md`).
- **Python package** `foundations/`: finite executable illustrations, not proofs (see its
  docstring). Tests are in `tests/`.
- **SML** `presentation.ML` and `examples/*.ML`.

## Commands

```bash
cd /botworkspace/foundations
python3 run_tests.py                                   # Python tests (about 10 s)
bash tests/check_preamble.sh                           # LaTeX preamble checks
# Build the book into a scratch directory (one pass about 1 min; run detached for the full build)
pdflatex -interaction=nonstopmode -output-directory=<dir> 001_foundations.tex
(cd <dir> && BIBINPUTS=/botworkspace/foundations biber 001_foundations)
pdflatex -interaction=nonstopmode -output-directory=<dir> 001_foundations.tex
```

After a successful build, copy the PDF to `/botworkspace/obeliskproofassistant.github.io/foundations.pdf`
and commit that repository separately.

## Rules

- Statements of theorems that are machine-checked in `set_theory_prover` must match the kernel
  statement exactly (GitLab #8088 will generate them).
- Do not call a Python check a "formalization" or "verification".
- Removed files are listed in `docs/REMOVED_DOCUMENTS.md`.
