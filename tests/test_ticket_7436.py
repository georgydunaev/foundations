"""Regression tests for the Dunaev-pair audit in Ticket 7436.

Author: opencode-go/kimi-k3.1-pro (Capability Tier 2).
"""

from pathlib import Path
import re
import unittest


ROOT = Path(__file__).resolve().parents[1]
PRESENTATION = ROOT / "presentation.ML"
GUIDE = ROOT / "PRESENTATION_ML_GUIDE.md"


class TestTicket7436(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.source = PRESENTATION.read_text(encoding="utf-8")
        cls.normalized_source = " ".join(cls.source.split())
        cls.guide = GUIDE.read_text(encoding="utf-8")

    def test_arbitrary_class_pair_uses_dunaev_tags(self):
        self.assertIn(
            "[A, B] := {(1,s)|(s sss A)}u{(0,s)|(s sss B)}",
            self.normalized_source,
        )
        self.assertIn(
            "(s sss x) <-> (s C x) /\\ (s ss)",
            self.normalized_source,
        )
        self.assertIn(
            "(F times G) := (x |-> [F(x),G(x)])",
            self.normalized_source,
        )

    def test_round_pair_axioms_are_explicitly_limited_to_sets(self):
        self.assertIn("# Ordered pair of sets.", self.source)
        self.assertIn(
            "forall (a1, b1, a2, b2 sets): "
            "(((a1, b1) = (a2, b2)) <-> ((a1 = a2) /\\ (b1 = b2)))",
            self.normalized_source,
        )
        self.assertIn(
            "forall (a, b sets): ((a, b) set)",
            self.normalized_source,
        )

    def test_presentation_has_no_kuratowski_pair_encoding(self):
        kuratowski = re.compile(
            r"\{\s*\{\s*([A-Za-z][A-Za-z0-9]*)\s*\}\s*,"
            r"\s*\{\s*\1\s*,\s*[A-Za-z][A-Za-z0-9]*\s*\}\s*\}"
        )
        self.assertIsNone(kuratowski.search(self.source))

    def test_guide_records_the_pairing_distinction(self):
        self.assertIn("no Kuratowski encoding `{{A}, {A,B}}`", self.guide)
        self.assertIn("must not be extrapolated to proper classes", self.guide)
        self.assertIn("Arbitrary-class pairing instead uses", self.guide)
        self.assertIn("not a new formal proof", self.guide)


if __name__ == "__main__":
    unittest.main()
