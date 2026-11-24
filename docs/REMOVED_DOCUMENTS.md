# Removed documents and files

Restore any of them with

    git -C /botworkspace/foundations log --diff-filter=D --format=%h -1 -- <path>
    git -C /botworkspace/foundations show <hash>^:<path>

| Date | Path | Why |
|---|---|---|
| 2026-11-24 | `AUDIT_REPORT.md`, `LATEX_AUDIT_REPORT.md`, `ARCHITECTURE_AND_THEOREMS.md`, `PROJECT_OVERVIEW.md`, `COMPETING_APPROACHES.md`, `TICKET.md` | agent-written reports and overviews from October-November 2026; superseded by `README.md`, `PROJECT.dev.md`, `APPROACHES_INVENTORY.md` |
| 2026-11-24 | `Term`, `test.txt` | empty files |
| 2026-11-24 | `presentation.ML.bak`, `run_tests.py.prev` | stray backups |
| 2026-11-24 | `UNFINISHED_SECTIONS_SOLUTIONS.md` | moved to `archive/` next to the archived `unfinished_sections_completions.tex` |
| 2026-11-24 | 13 orphan `.tex` files | moved to `archive/` (commit 5aefab9) |
