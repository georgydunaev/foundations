#!/usr/bin/env python3
"""Tests for MKTD Standard ML foundations."""

from pathlib import Path
import shutil
import subprocess
import unittest

ROOT = Path(__file__).resolve().parents[1]
MKTD_ML = ROOT / "examples" / "mktd_foundations.ML"
POLY = shutil.which("poly")


class TestMKTDML(unittest.TestCase):
    def test_file_exists(self):
        self.assertTrue(MKTD_ML.exists(), f"Missing {MKTD_ML}")

    def test_contents_structure(self):
        content = MKTD_ML.read_text(encoding="utf-8")
        self.assertIn("signature MKTD_FOUNDATIONS", content)
        self.assertIn("structure MKTD_Foundations", content)
        self.assertIn("dunaev_pair", content)
        self.assertIn("dunaev_fst", content)
        self.assertIn("dunaev_snd", content)
        self.assertIn("KuratowskiPair", content)
        self.assertIn("ProperClassKuratowskiException", content)
        self.assertIn("Class_Type", content)
        self.assertIn("total_eval", content)
        self.assertIn("guarded_eval", content)

    @unittest.skipUnless(POLY, "Poly/ML required for testing SML foundations")
    def test_poly_ml_compiles_and_passes_self_tests(self):
        result = subprocess.run(
            [POLY, "-q", "--use", str(MKTD_ML)],
            cwd=ROOT,
            input="",
            capture_output=True,
            text=True,
            timeout=30,
            check=False,
        )
        self.assertEqual(
            result.returncode,
            0,
            f"Poly/ML execution failed:\nSTDOUT:\n{result.stdout}\nSTDERR:\n{result.stderr}",
        )


if __name__ == "__main__":
    unittest.main()
