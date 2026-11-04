#!/usr/bin/env python3
"""Regression tests for Morse-Kelley class comprehension & separation in 100_class_theory.tex (Tickets 7335 & 7454)."""

import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CLASS_THEORY_PATH = ROOT / "100_class_theory.tex"


class TestTicket7454(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.text = CLASS_THEORY_PATH.read_text(encoding="utf-8")

    def test_mk_comprehension_schema_and_sethood_guard(self):
        self.assertIn(r"z \in \cc{x}{\phi(x)} \iff (z \in V) \land \phi(z)", self.text)
        self.assertIn(r"V \eqdef \cc{x}{\top}", self.text)
        self.assertIn("proper class", self.text)

    def test_separation_principle_documented(self):
        self.assertIn("Separation Principle", self.text)
        self.assertIn(r"(a \in V) \implies (a \cap P \in V)", self.text)

    def test_no_trailing_whitespace_or_double_blank_lines(self):
        for lineno, line in enumerate(self.text.splitlines(), start=1):
            self.assertEqual(line, line.rstrip(), f"Trailing whitespace on line {lineno}")
        self.assertNotIn("\n\n\n", self.text)


if __name__ == "__main__":
    unittest.main()
