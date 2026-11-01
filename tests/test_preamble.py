"""Regression tests for Ticket 7329's preamble audit.

Author: opencode-go/kimi-k3.1-pro (Capability Tier 2).
"""

import re
import unicodedata
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PREAMBLE_PATH = ROOT / "000_preamble.tex"
_CONDITIONAL_COMMANDS = frozenset(
    {
        "if",
        "ifdefined",
        "ifdim",
        "iffalse",
        "iffirstchoice@",
        "ifmeasuring@",
        "ifmmode",
        "iftrue",
        "ifx",
    }
)
_CONTROL_WORD = re.compile(r"\\([A-Za-z@]+)")


def _is_escaped(text, index):
    """Return whether the character at *index* has an odd escape prefix."""
    backslashes = 0
    index -= 1
    while index >= 0 and text[index] == "\\":
        backslashes += 1
        index -= 1
    return backslashes % 2 == 1


def _without_comments(text):
    """Remove unescaped TeX comments while preserving source line numbers."""
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


class TestPreamble(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.text = PREAMBLE_PATH.read_text(encoding="utf-8")
        cls.active_source = _without_comments(cls.text)

    def test_preamble_structure(self):
        """The preamble retains its document class and required packages."""
        self.assertIn(r"\documentclass", self.active_source)
        self.assertIn(r"\usepackage[style=apa,backend=biber]{biblatex}", self.active_source)

    def test_macro_header_guard_wraps_the_complete_preamble(self):
        """The include-once guard starts first and consumes the final \\fi."""
        header = re.compile(
            r"\A\s*\\ifdefined\\MyHeaderIncluded\s*"
            r"\\else\s*\\def\\MyHeaderIncluded\{defined\}"
        )
        self.assertRegex(self.active_source, header)
        self.assertTrue(
            self.active_source.rstrip().endswith(r"\fi"),
            "The final active command must close \\MyHeaderIncluded's guard",
        )
        self.assertEqual(self.active_source.count(r"\ifdefined\MyHeaderIncluded"), 1)
        self.assertEqual(self.active_source.count(r"\def\MyHeaderIncluded{defined}"), 1)

    def test_active_braces_are_balanced(self):
        """Every unescaped, non-comment TeX group has exactly one closing brace."""
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

    def test_conditional_blocks_are_balanced(self):
        """All active TeX conditionals, including the header guard, are closed."""
        stack = []
        for match in _CONTROL_WORD.finditer(self.active_source):
            command = match.group(1)
            line = self.active_source.count("\n", 0, match.start()) + 1
            if command in _CONDITIONAL_COMMANDS:
                stack.append((command, line))
            elif command == "fi":
                self.assertTrue(stack, f"Unmatched \\fi on line {line}")
                stack.pop()
        self.assertFalse(stack, f"Unclosed conditional blocks: {stack}")

    def test_cosmetic_typos_stay_fixed(self):
        for typo in ("untill", "insiide", "ommited", "Metaheorem", "being write"):
            with self.subTest(typo=typo):
                self.assertNotIn(typo, self.text)
        self.assertIn(r"\newtheorem{metatheorem}{Metatheorem}[section]", self.text)

    def test_no_invisible_unicode_formatting_characters(self):
        invisible = [
            (line_number, f"U+{ord(character):04X}")
            for line_number, line in enumerate(self.text.splitlines(), 1)
            for character in line
            if unicodedata.category(character) == "Cf"
        ]
        self.assertFalse(invisible, f"Invisible formatting characters: {invisible}")


if __name__ == "__main__":
    unittest.main()
