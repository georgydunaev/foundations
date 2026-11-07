# Building the book with Texmaker and TeX Live 2024

For the thesis, select `thesis_schrodinger.tex` as the master document.
For the complete book, select `001_foundations.tex`. Run commands from the
repository directory. Keep the source encoding UTF-8 and the build-subdirectory
option disabled (`Tools\OutputDir=false`) for the commands below. The book uses
BibLaTeX with the **Biber** backend and the repository's `references.bib`.

## Existing PDF Quick Build configuration

The supplied `Tools\Quick%20Mode=12` selects **PdfLaTeX + Bib(la)tex +
PdfLaTeX (x2) + View Pdf**. It does **not** run the stored `Tools\Userquick`
command. This mapping was checked in the official Texmaker 5.1.4 and 6.0.2
sources (`configdialog.ui` and `texmaker.cpp`).

To retain this workflow, set these fields in **Options → Configure Texmaker →
Commands**. These are command-field contents, not quoted INI strings:

| Field | Command |
| --- | --- |
| PdfLaTeX | `/usr/local/texlive/2024/bin/x86_64-linux/pdflatex -synctex=1 -interaction=nonstopmode %.tex` |
| Bib(la)tex | `/usr/local/texlive/2024/bin/x86_64-linux/biber %` |

Keep Quick Build on the PDF sequence named above and retain the preferred PDF
viewer. The Bib(la)tex field must invoke Biber even though its internal settings
key is `Tools\Bibtex`.

## Optional DVI Quick Build configuration

To use the stored LaTeX/DVI workflow, select **User** in the Quick Build settings
(mode `6` in the same Texmaker versions), and enter this single line:

```text
/usr/local/texlive/2024/bin/x86_64-linux/latex -interaction=nonstopmode %.tex|/usr/local/texlive/2024/bin/x86_64-linux/biber %|/usr/local/texlive/2024/bin/x86_64-linux/latex -interaction=nonstopmode %.tex|/usr/local/texlive/2024/bin/x86_64-linux/latex -interaction=nonstopmode %.tex|xdvi %.dvi
```

This normalizes the source suffixes and explicitly supplies `.dvi` to the viewer.
The viewer requires `xdvi` on the executable search path and a graphical session.
The corresponding standalone LaTeX field is:

```text
/usr/local/texlive/2024/bin/x86_64-linux/latex -interaction=nonstopmode %.tex
```

Texmaker replaces `%` with the master document's basename, without its extension;
the vertical bars separate commands in a user Quick Build sequence. See the
[official Texmaker manual](https://www.xm1math.net/texmaker/doc.html) for master
document selection and command placeholders.

## Other settings to correct

The supplied LuaLaTeX, XeLaTeX, and MakeIndex settings contain an embedded,
unmatched opening quote. If these tools are used, their command fields should be:

```text
/usr/local/texlive/2024/bin/x86_64-linux/lualatex -interaction=nonstopmode %.tex
/usr/local/texlive/2024/bin/x86_64-linux/xelatex -synctex=1 -interaction=nonstopmode %.tex
/usr/local/texlive/2024/bin/x86_64-linux/makeindex %.idx
```

Ordinary outer quotes in an INI value are serialization syntax and need not be
removed. The problem is the extra literal leading quote encoded as `\"` in those
three supplied values. Prefer changing the command fields in Texmaker rather
than replacing a complete personal settings file.

`Tools\ExtraPath` extends the executable `PATH`; it does not configure TeX's
package search. Consequently `/home/user/texmf/tex/latex/` in that field does not
make a package discoverable. Use the actual TeX user's `TEXMFHOME` tree for
personal packages. Check the selected installation with:

```sh
/usr/local/texlive/2024/bin/x86_64-linux/kpsewhich -var-value=TEXMFHOME
/usr/local/texlive/2024/bin/x86_64-linux/kpsewhich biblatex.sty
/usr/local/texlive/2024/bin/x86_64-linux/biber --version
```

The mode numbers, internal bibliography key, and executable-path behavior above
were checked against the [official source releases](https://www.xm1math.net/texmaker/download.html),
versions 5.1.4 and 6.0.2. Select the named GUI option rather than relying on a
numeric mode when using another version.

## Verification

The compiler sequences were tested with archived TeX Live 2024, using
pdfTeX 1.40.26 and its matching Biber 2.20. Both PdfLaTeX/Biber/PdfLaTeX
twice and LaTeX/Biber/LaTeX twice compiled both the 52-page standalone
thesis and the 383-page full book. The thesis logs have no warnings or
overfull/underfull boxes; the PDF book is also free of those notices.
The DVI book retains one underfull bibliography line, whose rendered output
was inspected, as recorded in `LATEX_AUDIT_REPORT.md`. Separate
temporary output directories kept the PDF and DVI auxiliary files apart.
The test installation lives outside the repository; the executable path
prefix differs from the supplied `/usr/local/texlive/2024`, but the engine
and bibliography versions match that release. The Texmaker GUI and viewers
have not been launched; these are backend compilation checks.

The illustration is selected without a filename extension: PDF engines use
`pictures/DEMO.png`, while LaTeX/DVI uses its lossless EPS companion. The EPS
was rendered independently and its RGB pixels matched the original image
composited on white. Keep the PNG as the source when regenerating this asset.
The DVI preamble uses `breakurl` so long web and bibliography links can wrap.

The dynamical-potential illustration likewise has PDF and EPS versions in
`pictures/`, selected automatically by the output engine. Both are included
assets; Python is not needed to compile the manuscript. To regenerate them,
run `python3 scripts/plot_dynamical_potential.py` with NumPy and Matplotlib
installed. The curves evaluate the displayed cosine potentials directly.

## Packages and fonts

A minimal TeX Live installation needs the packages loaded by
`000_preamble.tex`, not just the engine executable. In particular, the font
packages `clearsans`, `rsfs`, `cm-super`, and `esvect` supply the intended
quantifiers, script letters, text outlines, and vector symbols. `authblk.sty`
is distributed in the TeX Live package `preprint`; `mathrsfs.sty` is in
`jknapltx`. The DVI route additionally needs `breakurl` and `xkeyval`.
Install packages into the selected TeX Live installation rather than adding
a source directory to Texmaker's executable `ExtraPath`.

After switching between PDF and DVI engines, rerun the complete sequence;
their shared auxiliary files can otherwise retain driver-specific link data.

## Underscores in the optional companion listing

The `underscore` package makes `_` an active character. Passing the companion
path directly to `\lstinputlisting` can therefore fail with
`Missing endcsname inserted` and `global invalid in file name`, followed by
a misleading attempt to open `../set.tex`. This happens when the optional
companion file is present; a checkout without it only exercises the fallback.
The manuscript now passes its filename through `\detokenize{...}` to keep
the underscores literal. Both present-file and missing-file branches were
tested. Adding trailing `%` alone does not fix this filename-token issue.

For ordinary multiline macro arguments, a trailing `%` suppresses the
end-of-line space. It is appropriate for deliberate token continuations;
prose still needs its word spaces, and blank lines intended as paragraph
breaks must be retained. These are separate concerns from filename expansion.
