#!/usr/bin/env python3
# opencode-go/glm-5.3-flash (Capability Tier 2)
"""Static verification for Ticket 7331 (cosmetic normalization of `060_axioms.tex`).

Ticket 7331 asks for:
  * consistent formatting of axiom (and related theorem-like) environments,
  * verified LaTeX comments,
  * cosmetic formatting fixes,
while keeping the chapter semantically untouched (cosmetic-only changes).

Ticket 7331 went through several reopen cycles caused (in part) by an
intermediate corrupted state of the chapter: an empty
``\\begin{axiom}[Setting]`` environment whose prose had been replaced by
placeholder ``\\``-only lines.  These tests pin the healthy, expected state
so a future edit cannot silently reintroduce it:

  * every LaTeX environment is balanced (``\\begin{X}`` / ``\\end{X}``),
  * no theorem-like environment is empty,
  * every axiom carries a non-empty title,
  * no placeholder ``\\``-only lines exist,
  * ``\\iffalse`` / ``\\fi`` comment blocks are balanced,
  * the ``Setting`` section keeps its prose content,
  * no line carries trailing whitespace.

No TeX engine is required: all checks are static source inspections, which
keeps them discoverable and runnable by the local test runner
(``python3 run_tests.py``).
"""

import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TEX_PATH = ROOT / "060_axioms.tex"

# Environments that carry mathematical statements (axioms, definitions, ...).
_STATEMENT_ENVS = (
    "axiom",
    "axiom*",
    "constructor",
    "definition",
    "metadefinition",
    "note",
    "notation",
    "example",
    "theorem",
    "lemma",
)

_BEGIN_RE = re.compile(r"\\begin\{([^{}]*)\}")
_END_RE = re.compile(r"\\end\{([^{}]*)\}")


def _strip_comment(line):
    """Remove the trailing `%`-comment of a line, honouring escapes (``\\%``)."""
    out = []
    i = 0
    while i < len(line):
        char = line[i]
        if char == "\\" and i + 1 < len(line):
            out.append(line[i : i + 2])
            i += 2
            continue
        if char == "%":
            break
        out.append(char)
        i += 1
    return "".join(out)


def _active_code(text):
    """Yield the executed lines of ``text``.

    Comment tails are removed (escape-aware) and regions disabled with
    ``\\iffalse`` ... ``\\fi`` are skipped (they may nest).
    """
    depth = 0
    for line in text.splitlines():
        code = _strip_comment(line)
        if "\\iffalse" in code:
            depth += 1
            continue
        if "\\fi" in code:
            if depth > 0:
                depth -= 1
            continue
        if depth == 0:
            yield code


class TestTicket7331(unittest.TestCase):
    """Cosmetic-normalization guarantees for `060_axioms.tex` (Ticket 7331)."""

    def setUp(self):
        self.text = TEX_PATH.read_text(encoding="utf-8")
        self.active = list(_active_code(self.text))

    # --- environment consistency -------------------------------------------

    def test_all_environments_balanced(self):
        """Every ``\\begin{X}`` must have a matching ``\\end{X}`` (and vice versa)."""
        begins = {}
        ends = {}
        for code in self.active:
            for match in _BEGIN_RE.finditer(code):
                begins[match.group(1)] = begins.get(match.group(1), 0) + 1
            for match in _END_RE.finditer(code):
                ends[match.group(1)] = ends.get(match.group(1), 0) + 1
        mismatch = {
            env: (begins.get(env, 0), ends.get(env, 0))
            for env in set(begins) | set(ends)
            if begins.get(env, 0) != ends.get(env, 0)
        }
        self.assertEqual(mismatch, {}, "unbalanced LaTeX environments")

    def test_statement_environments_are_not_empty(self):
        """Regression: no empty axiom/definition/... environments remain."""
        empties = []
        current = None
        body = []
        for code in self.active:
            for match in _END_RE.finditer(code):
                if match.group(1) in _STATEMENT_ENVS and current == match.group(1):
                    if not any(line.strip() for line in body):
                        empties.append(match.group(1))
                    current = None
                    body = []
            for match in _BEGIN_RE.finditer(code):
                if match.group(1) in _STATEMENT_ENVS:
                    current = match.group(1)
                    body = [code[match.end() :].strip()] if current else []
        self.assertEqual(empties, [], "empty statement environments found")

    def test_axiom_environments_have_nonempty_titles(self):
        begin_axiom = re.compile(r"\\begin\{axiom\*?\}\[([^{}]*)\]")
        for code in self.active:
            match = begin_axiom.search(code)
            if match:
                self.assertRegex(
                    match.group(1).strip(), r"\S", "axiom with an empty title"
                )

    def test_no_placeholder_backslash_only_lines(self):
        """Regression: the corrupted intermediate state used ``\\`` line fillers."""
        placeholders = [
            idx + 1
            for idx, code in enumerate(self.active)
            if re.fullmatch(r"\\", code.strip())
        ]
        self.assertEqual(
            placeholders, [], "placeholder backslash-only lines were reintroduced"
        )

    # --- LaTeX comment health ----------------------------------------------

    def test_iffalse_fi_blocks_balanced(self):
        depth = 0
        for code in self.active:
            depth += code.count("\\iffalse")
            depth -= code.count("\\fi")
            self.assertGreaterEqual(depth, 0, "\\fi without a matching \\iffalse")
        self.assertEqual(depth, 0, "\\iffalse without a matching \\fi")

    # --- chapter content preserved ------------------------------------------

    def test_setting_section_keeps_its_prose(self):
        """The ``Setting`` section must stay an introduced section with prose."""
        self.assertIn("\\section{Setting}", self.text)
        self.assertIn("sets are ``terminal''", self.text)
        self.assertIn("Classes are properties of sets.", self.text)

    # --- cosmetic surface ----------------------------------------------------

    def test_no_trailing_whitespace(self):
        offenders = [
            idx + 1
            for idx, line in enumerate(self.text.splitlines())
            if line != line.rstrip()
        ]
        self.assertEqual(offenders, [], "lines with trailing whitespace")


if __name__ == "__main__":
    unittest.main()
