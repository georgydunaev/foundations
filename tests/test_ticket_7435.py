"""Regression tests for the relation-macro audit in Ticket 7435.

Author: opencode-go/kimi-k3.1-pro (Capability Tier 2).
"""

import re
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
RELATIONS_PATH = ROOT / "200_relations.tex"
PREAMBLE_PATH = ROOT / "000_preamble.tex"
_MACRO_DEFINITION = re.compile(r"\\newcommand\*?\{\\([A-Za-z@]+)\}")


def _is_escaped(text, index):
    """Return whether the character at *index* has an odd escape prefix."""
    backslashes = 0
    index -= 1
    while index >= 0 and text[index] == "\\":
        backslashes += 1
        index -= 1
    return backslashes % 2 == 1


def _without_comments(text):
    """Remove TeX comments while retaining line breaks and escaped percent signs."""
    active_lines = []
    for line in text.splitlines(keepends=True):
        for index, character in enumerate(line):
            if character == "%" and not _is_escaped(line, index):
                newline = "\n" if line.endswith("\n") else ""
                active_lines.append(line[:index] + newline)
                break
        else:
            active_lines.append(line)
    return "".join(active_lines)


class TestTicket7435(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.text = RELATIONS_PATH.read_text(encoding="utf-8")
        cls.active_source = _without_comments(cls.text)

    def test_active_braces_are_balanced(self):
        stack = []
        for index, character in enumerate(self.active_source):
            if character not in "{}" or _is_escaped(self.active_source, index):
                continue
            line = self.active_source.count("\n", 0, index) + 1
            if character == "{":
                stack.append(line)
            else:
                self.assertTrue(stack, f"Unmatched closing brace on line {line}")
                stack.pop()
        self.assertFalse(stack, f"Unclosed braces opened on lines {stack}")

    def test_local_macro_does_not_collide_with_preamble(self):
        local_macros = set(_MACRO_DEFINITION.findall(self.active_source))
        preamble = _without_comments(PREAMBLE_PATH.read_text(encoding="utf-8"))
        preamble_macros = set(_MACRO_DEFINITION.findall(preamble))
        self.assertEqual(local_macros, {"classrelation"})
        self.assertFalse(local_macros & preamble_macros)
        self.assertIn(
            r"\newcommand{\classrelation}[2]{\mathcal{R}_{#1,#2}}",
            self.active_source,
        )

    def test_math_mode_usage_and_class_invariants_are_documented(self):
        self.assertIn(r"\(\classrelation{A}{B}\)", self.active_source)
        self.assertIn(r"between classes \(A\) and \(B\)", self.active_source)
        self.assertIn("does not assert sethood", self.text)
        self.assertIn("may therefore be proper classes", self.text)


if __name__ == "__main__":
    unittest.main()
