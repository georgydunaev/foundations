"""Compile the actual optional companion listing with active underscores."""

import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


def _group(source, start):
    """Read a braced TeX argument, respecting escaped braces and comments."""
    position = start
    while position < len(source):
        if source[position].isspace():
            position += 1
        elif source[position] == "%":
            position = source.find("\n", position)
            if position == -1:
                raise ValueError("Argument expected after end-of-file comment")
        else:
            break
    if position == len(source) or source[position] != "{":
        raise ValueError("Expected a braced argument")
    opening = position
    depth = 1
    position += 1
    while position < len(source):
        character = source[position]
        if character == "\\":
            position += 2
            continue
        if character == "%":
            position = source.find("\n", position)
            if position == -1:
                break
            continue
        if character == "{":
            depth += 1
        elif character == "}":
            depth -= 1
            if depth == 0:
                return source[opening + 1:position], position + 1
        position += 1
    raise ValueError("Unclosed TeX argument")


def _companion_block():
    """Extract the file test and both branches, without copying their contents."""
    source = (ROOT / "010_logic.tex").read_text(encoding="utf-8")
    matches = []
    for match in re.finditer(r"\\IfFileExists\b", source):
        filename, end = _group(source, match.end())
        if "CONTENT.ML" not in filename:
            continue
        _, end = _group(source, end)
        _, end = _group(source, end)
        matches.append(source[match.start():end])
    if len(matches) != 1:
        raise ValueError("Expected one optional CONTENT.ML listing in 010_logic.tex")
    return matches[0]


class TestOptionalListingCompatibility(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        requested = os.environ.get("FOUNDATIONS_PDFLATEX", "pdflatex")
        cls.pdflatex = shutil.which(requested)
        if cls.pdflatex is None:
            raise unittest.SkipTest(
                "pdfLaTeX unavailable; put pdflatex on PATH or set "
                "FOUNDATIONS_PDFLATEX to its executable path"
            )
        cls.block = _companion_block()

    def _compile(self, companion_present, block=None):
        with tempfile.TemporaryDirectory(prefix="foundations_listing_") as temp:
            root = Path(temp)
            book = root / "book"
            book.mkdir()
            if companion_present:
                companion = root / "set_theory_prover" / "program"
                companion.mkdir(parents=True)
                (companion / "CONTENT.ML").write_text(
                    "datatype term = Variable of string\n", encoding="utf-8"
                )
            # Keep the book's package order: underscore is active when the
            # listing's filename is read. These environments avoid importing
            # the full manuscript and make the exercised branch observable.
            document = r"""\documentclass{article}
\usepackage{underscore}
\usepackage{listings}
\newenvironment{nolinenumbers}{\typeout{OPTIONAL-CONTENT-PRESENT}}{}
\newenvironment{note}[1][]{\typeout{OPTIONAL-CONTENT-MISSING}}{}
\begin{document}
""" + (self.block if block is None else block) + "\n\\end{document}\n"
            (book / "listing.tex").write_text(document, encoding="utf-8")
            result = subprocess.run(
                [self.pdflatex, "-interaction=nonstopmode", "-halt-on-error",
                 "-no-shell-escape", "listing.tex"],
                cwd=book,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                encoding="utf-8",
                errors="replace",
                timeout=60,
                check=False,
            )
            self.assertEqual(result.returncode, 0, result.stdout[-8000:])
            self.assertTrue((book / "listing.pdf").is_file())
            expected = "PRESENT" if companion_present else "MISSING"
            other = "MISSING" if companion_present else "PRESENT"
            self.assertIn("OPTIONAL-CONTENT-" + expected, result.stdout)
            self.assertNotIn("OPTIONAL-CONTENT-" + other, result.stdout)

    def test_companion_present_with_underscored_path(self):
        """The optional listing compiles when the companion checkout exists."""
        self._compile(companion_present=True)

    def test_missing_companion_uses_the_fallback(self):
        """A checkout without the companion still compiles its explanatory note."""
        self._compile(companion_present=False)


if __name__ == "__main__":
    unittest.main()
