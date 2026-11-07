# Building the book with Texmaker and TeX Live 2024

Use `001_foundations.tex` as the master document and run commands from the
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

Command recipes have been checked against the configuration and source code.
Full TeX Live 2024 PDF and DVI build results are pending; the Texmaker GUI and
viewers have not been launched as part of this check.
