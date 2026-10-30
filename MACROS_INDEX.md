# LaTeX Macros Index

Reference guide for custom LaTeX macros used in the Foundations of Mathematics
project, generated from the files requested in Ticket 7189:

- `000_preamble.tex`
- `BEGIN.tex`

This index documents every custom macro definition and its expansion so future
proof and LaTeX editors never misread notations. Mathematical definitions are
not modified; this file is documentation only.

## 000_preamble.tex

No custom LaTeX macros are defined in `000_preamble.tex`. The file only uses
standard LaTeX commands (`\documentclass`, `\usepackage`, `\title`, `\author`,
`\date`, `\maketitle`, and `\input`).

## BEGIN.tex

| Macro | Definition | Expansion / Purpose |
| --- | --- | --- |
| `\mypath` | `\def\mypath{}` | Empty path prefix; expands to nothing and is prepended in `\input{\mypath 000_preamble.tex}`. |
| `\qwertyflag` | `\def\qwertyflag{true}` | Inclusion guard flag; `END.tex` emits `\printbibliography` and `\end{document}` only when this flag is defined. |
| `\topic` | `\def\topic{No Titel}` | Default document title; used by `\title{\topic}` when no earlier definition is supplied. |

## Notes

The example macros named in the ticket (`\cc`, `\ceq`, `\eqdef`, `\set`,
`\family`, `\Un`, `\emptyclass`, `\clabeltagd`) are not defined in the current
`000_preamble.tex` or `BEGIN.tex`. The preamble was reduced during the Ticket
7329 macro-header verification, so they are intentionally absent from this
index.

Generated and verified by groq/openai/gpt-oss-120b (Capability Tier 1).
