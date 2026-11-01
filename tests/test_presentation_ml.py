"""Regression tests for ticket 7192.

Documentation update: opencode-go/kimi-k3.1-pro (Capability Tier 2).
"""

import hashlib
from pathlib import Path
import shutil
import subprocess
import unittest


ROOT = Path(__file__).resolve().parents[1]
PRESENTATION = ROOT / "presentation.ML"
GUIDE = ROOT / "PRESENTATION_ML_GUIDE.md"

# Byte-level identity of the complete pseudo-code immediately before the
# original documentation ticket (commit 0df3fa9's parent). Documentation may
# only be prepended; the historical payload must remain an exact suffix.
ORIGINAL_SIZE = 10460
ORIGINAL_SHA256 = "37d0bf024bcee570ae5abe4561e8d4c2948d919158f242a273a7879ce5d9eee1"
POLY = shutil.which("poly")


class TestPresentationML(unittest.TestCase):
    def test_original_pseudo_code_is_an_unchanged_suffix(self):
        data = PRESENTATION.read_bytes()
        self.assertGreater(len(data), ORIGINAL_SIZE)
        original = data[-ORIGINAL_SIZE:]
        self.assertEqual(
            hashlib.sha256(original).hexdigest(),
            ORIGINAL_SHA256,
            "the original presentation.ML lines must remain byte-for-byte intact",
        )
        header = data[:-ORIGINAL_SIZE].decode("utf-8")
        self.assertTrue(header.startswith("(*\n"))
        self.assertTrue(header.rstrip().endswith("*)"))
        self.assertIn("PRESENTATION_ML_GUIDE.md", header)
        self.assertIn("openrouter/nvidia/nemotron-3.5-lightning:free", header)
        self.assertIn("Capability Tier 1", header)

    def test_guide_documents_every_ticket_topic(self):
        content = GUIDE.read_text(encoding="utf-8")
        for heading in (
            "## Overview",
            "## Constructors of Terms and Formulas",
            "## Complexity Annotations",
            "## Definitions",
            "## Dunaev Tagged Pairs",
            "## Conclusion",
        ):
            with self.subTest(heading=heading):
                self.assertIn(heading, content)

        for required_text in (
            "Morse–Kelley",
            "Tarski",
            "`Sets : Term`",
            "`c : Term -> Term`",
            "super global choice",
            "`Compr : Bound Fm -> Term`",
            "impredicative class comprehension",
            "`Lam x.t`",
            "proper classes",
            "syntactic complexity weights",
            "not runtime costs",
        ):
            with self.subTest(required_text=required_text):
                self.assertIn(required_text, content)

    def test_guide_does_not_repeat_known_constructor_errors(self):
        content = GUIDE.read_text(encoding="utf-8").lower()
        self.assertNotIn("represents the set of all terms", content)
        self.assertNotIn("represents the complement of a term", content)
        self.assertIn("not a complement operator", content)
        self.assertIn("not the set of all sml terms", content)

    @unittest.skipUnless(POLY, "Poly/ML is required for the SML syntax check")
    def test_poly_ml_accepts_presentation(self):
        result = subprocess.run(
            [POLY, "-q", "--use", str(PRESENTATION)],
            cwd=ROOT,
            stdin=subprocess.DEVNULL,
            capture_output=True,
            text=True,
            timeout=30,
            check=False,
        )
        self.assertEqual(
            result.returncode,
            0,
            f"Poly/ML rejected presentation.ML:\n{result.stdout}{result.stderr}",
        )


if __name__ == "__main__":
    unittest.main()
