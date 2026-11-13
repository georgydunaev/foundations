#!/usr/bin/env python3
"""Tests for Isabelle IFOLD theory syntax and structure."""

import unittest
from pathlib import Path

REPO_DIR = Path(__file__).resolve().parents[1]
IFOLD_PATH = REPO_DIR / "code" / "IFOLD.thy"


class TestIFOLDSyntax(unittest.TestCase):
    def setUp(self):
        self.assertTrue(IFOLD_PATH.exists(), f"Missing {IFOLD_PATH}")
        self.content = IFOLD_PATH.read_text(encoding="utf-8")

    def test_no_empty_axiomatization_block(self):
        """No orphaned 'axiomatization where' block without axioms."""
        lines = [line.strip() for line in self.content.splitlines()]
        for i, line in enumerate(lines):
            if line == "axiomatization":
                # Next non-empty line shouldn't be 'where' followed immediately by section or empty
                j = i + 1
                while j < len(lines) and lines[j] == "":
                    j += 1
                if j < len(lines) and lines[j] == "where":
                    k = j + 1
                    while k < len(lines) and lines[k] == "":
                        k += 1
                    self.assertFalse(
                        k < len(lines) and lines[k].startswith("subsubsection"),
                        f"Found empty axiomatization block at line {i+1}",
                    )

    def test_epsilon_return_type_is_term(self):
        """Hilbert epsilon descriptor operator must return a term ('a), not a proposition (o)."""
        self.assertIn("epsilon ::", self.content)
        # Should be ('a => o) => 'a
        self.assertNotIn(r"epsilon :: \<open>('a \<Rightarrow> o) \<Rightarrow> o\<close>", self.content)
        self.assertIn(r"epsilon :: \<open>('a \<Rightarrow> o) \<Rightarrow> 'a\<close>", self.content)

    def test_iota_declared(self):
        """Definite description iota operator is declared with term return type."""
        self.assertIn(r"iota :: \<open>('a \<Rightarrow> o) \<Rightarrow> 'a\<close>", self.content)

    def test_pure_meta_premises_for_spec_and_exi(self):
        """Pure meta-implication rules must use meta-premises, not object-level conjunction."""
        self.assertNotIn(r"\<lbrakk>(\<forall>x. P(x)) \<and> (exists(x))", self.content)
        self.assertIn(r"spec: \<open>\<lbrakk>\<forall>x. P(x); exists(x)\<rbrakk>", self.content)
        self.assertIn(r"exI: \<open>\<lbrakk>P(x); exists(x)\<rbrakk>", self.content)

    def test_theory_has_proper_enclosure(self):
        """Theory begins with 'theory IFOLD' and ends with 'end'."""
        self.assertIn("theory IFOLD", self.content)
        self.assertTrue(self.content.strip().endswith("end"))


if __name__ == "__main__":
    unittest.main()
