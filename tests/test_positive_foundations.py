#!/usr/bin/env python3
"""Tests and structural verification for Coq Positive Foundations."""

from pathlib import Path
import re
import sys
import unittest

REPO_DIR = Path(__file__).resolve().parent.parent
COQ_FILE = REPO_DIR / "Coq" / "positive_foundations.v"

if str(REPO_DIR) not in sys.path:
    sys.path.insert(0, str(REPO_DIR))

try:
    import foundations
    HAS_FOUNDATIONS = True
except ImportError:
    HAS_FOUNDATIONS = False


class TestPositiveFoundations(unittest.TestCase):
    def setUp(self):
        self.assertTrue(COQ_FILE.exists(), f"Missing {COQ_FILE}")
        self.coq_content = COQ_FILE.read_text(encoding="utf-8")

    def test_foundations_package_available(self):
        """Foundations package imports successfully."""
        self.assertTrue(HAS_FOUNDATIONS)
        self.assertIsNotNone(foundations)

    def test_ens_inductive_wtype_definition(self):
        """Ens is defined as an inductive W-type with sup constructor."""
        pattern = r"Inductive\s+Ens\s*:\s*Type\s*:=\s*sup\s*:\s*forall\s+A\s*:\s*Type,\s*\(A\s*->\s*Ens\)\s*->\s*Ens\."
        self.assertRegex(
            self.coq_content,
            pattern,
            "Ens must be defined as Inductive Ens : Type := sup : forall A : Type, (A -> Ens) -> Ens.",
        )

    def test_pair_construct_is_unordered_bool_sup(self):
        """Pair is defined using sup bool, representing unordered pairing."""
        self.assertIn("Definition Pair (A B:Ens) : Ens", self.coq_content)
        self.assertIn("sup bool", self.coq_content)

    def test_extensional_equality_and_membership(self):
        """Extensional equality EQ and membership IN are defined on Ens."""
        self.assertIn("Fixpoint EQ (E1 E2: Ens)", self.coq_content)
        self.assertIn("Definition IN (E1 E2 : Ens) : Prop", self.coq_content)
        self.assertIn("EQ_tran", self.coq_content)
        self.assertIn("EQ_sym", self.coq_content)

    def test_setoid_and_class_hierarchy(self):
        """Hierarchy of EqualityType, SET, CLASS, CONGLOMERATE, and Universe."""
        self.assertIn("Inductive EqualityType : Type :=", self.coq_content)
        self.assertIn("Definition SET", self.coq_content)
        self.assertIn("Definition CLASS", self.coq_content)
        self.assertIn("Definition CONGLOMERATE", self.coq_content)
        self.assertIn("Fixpoint Universe (n:nat) : EqualityType", self.coq_content)

    def test_positive_class_axiomatization(self):
        """Verification of positive properties and Positivity axiom."""
        self.assertIn("Definition V: Menge CLASS", self.coq_content)
        self.assertIn("Definition intersect_class", self.coq_content)
        self.assertIn("Definition binter", self.coq_content)
        self.assertIn("Definition positive", self.coq_content)
        self.assertIn("Definition ppc", self.coq_content)
        self.assertIn("Axiom Positivity", self.coq_content)

    def test_admitted_lemmas_are_isolated_and_documented(self):
        """Ensure only documented experimental lemmas are marked Admitted."""
        admitted_names = []
        current_thm = None
        for line in self.coq_content.splitlines():
            m = re.match(r"^(?:Theorem|Lemma)\s+([A-Za-z0-9_]+)", line.strip())
            if m:
                current_thm = m.group(1)
            elif line.strip() == "Qed.":
                current_thm = None
            elif line.strip() == "Admitted." and current_thm:
                admitted_names.append(current_thm)
                current_thm = None

        # Only positive_sound and ppc_pos are admitted in the experimental section
        self.assertEqual(
            set(admitted_names),
            {"positive_sound", "ppc_pos"},
            f"Unexpected admitted lemmas: {admitted_names}",
        )


if __name__ == "__main__":
    unittest.main()
