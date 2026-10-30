#!/usr/bin/env python3
# groq/openai/gpt-oss-120b (Capability Tier 1)
"""Automated verification for the LaTeX macros index (Ticket 7189).

The ticket asks for a reference guide at ``MACROS_INDEX.md`` that documents
every custom macro defined in ``000_preamble.tex`` and ``BEGIN.tex``.  These
tests keep that guide honest: if a macro definition is added to either file,
the corresponding entry must be added to the index.
"""

import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
INDEX_PATH = ROOT / "MACROS_INDEX.md"
SCOPE_FILES = (ROOT / "000_preamble.tex", ROOT / "BEGIN.tex")

_MACRO_NAME = r"[A-Za-z@]+"

# Common LaTeX macro-definition forms.  The current scope files only use
# ``\def\name``, but the test accepts the standard variants as well so that a
# future preamble edit cannot silently slip past the index.
_MACRO_PATTERNS = (
    re.compile(r"\\def\\(" + _MACRO_NAME + r")"),
    re.compile(
        r"\\(?:newcommand|renewcommand|providecommand)\*?\{\\("
        + _MACRO_NAME
        + r")\}"
    ),
    re.compile(
        r"\\(?:newcommand|renewcommand|providecommand)\*?\\(" + _MACRO_NAME + r")"
    ),
    re.compile(
        r"\\DeclareMathOperator\*?\{\\(" + _MACRO_NAME + r")\}"
    ),
    re.compile(
        r"\\DeclareMathOperator\*?\\(" + _MACRO_NAME + r")"
    ),
    re.compile(
        r"\\DeclarePairedDelimiter\*?\{\\(" + _MACRO_NAME + r")\}"
    ),
    re.compile(
        r"\\NewDocumentCommand\{\\(" + _MACRO_NAME + r")\}"
    ),
    re.compile(
        r"\\NewDocumentCommand\\(" + _MACRO_NAME + r")"
    ),
)


def _defined_macros(tex_path):
    """Return the set of custom macro names defined in a LaTeX file."""
    text = tex_path.read_text(encoding="utf-8")
    names = set()
    for pattern in _MACRO_PATTERNS:
        names.update(pattern.findall(text))
    return names


class TestMacrosIndex(unittest.TestCase):
    """Ensure MACROS_INDEX.md matches the preamble macro definitions."""

    def test_macros_index_exists(self):
        self.assertTrue(
            INDEX_PATH.exists(),
            f"Missing macros index: {INDEX_PATH}",
        )

    def test_index_covers_ticket_scope_files(self):
        text = INDEX_PATH.read_text(encoding="utf-8")
        for file_name in ("000_preamble.tex", "BEGIN.tex"):
            self.assertIn(
                file_name,
                text,
                f"MACROS_INDEX.md does not mention {file_name}",
            )

    def test_every_defined_macro_is_documented(self):
        index_text = INDEX_PATH.read_text(encoding="utf-8")
        missing = []
        for tex_path in SCOPE_FILES:
            for macro in sorted(_defined_macros(tex_path)):
                if f"`\\{macro}`" not in index_text:
                    missing.append(f"{tex_path.name}: \\{macro}")
        self.assertFalse(
            missing,
            "Custom macros missing from MACROS_INDEX.md: " + ", ".join(missing),
        )


if __name__ == "__main__":
    unittest.main()
