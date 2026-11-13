#!/usr/bin/env python3
"""Descriptor tests for foundations."""

import unittest
from pathlib import Path
import sys

REPO_DIR = Path(__file__).resolve().parents[1]
if str(REPO_DIR) not in sys.path:
    sys.path.insert(0, str(REPO_DIR))

from foundations.descriptors import (
    EMPTY_CLASS,
    DescriptorUndefined,
    EmptySetClass,
    NonUniqueWitnessError,
    epsilon_descriptor,
    iota_descriptor,
    partial_varepsilon_descriptor,
    tau_descriptor,
)


class TestDescriptors(unittest.TestCase):
    def test_tau_descriptor_with_witness(self):
        candidates = [1, 2, 3, 4, 5]
        res = tau_descriptor(lambda x: x > 3, candidates, default_witness=99)
        self.assertEqual(res, 4)

    def test_tau_descriptor_default_fallback(self):
        candidates = [1, 2, 3]
        res = tau_descriptor(lambda x: x > 10, candidates, default_witness=99)
        self.assertEqual(res, 99)

    def test_epsilon_descriptor_with_witness(self):
        candidates = ["a", "b", "target", "c"]
        res = epsilon_descriptor(lambda x: x == "target", candidates)
        self.assertEqual(res, "target")

    def test_epsilon_descriptor_empty_default(self):
        candidates = ["a", "b", "c"]
        res = epsilon_descriptor(lambda x: x == "nonexistent", candidates)
        self.assertEqual(res, EMPTY_CLASS)
        self.assertIsInstance(res, EmptySetClass)

    def test_partial_varepsilon_descriptor_defined(self):
        candidates = [10, 20, 30]
        res = partial_varepsilon_descriptor(lambda x: x % 20 == 0, candidates)
        self.assertEqual(res, 20)

    def test_partial_varepsilon_descriptor_undefined(self):
        candidates = [1, 3, 5]
        res = partial_varepsilon_descriptor(lambda x: x % 2 == 0, candidates)
        self.assertIsNone(res)

    def test_iota_descriptor_unique(self):
        candidates = [2, 4, 7, 8]
        res = iota_descriptor(lambda x: x % 2 != 0, candidates)
        self.assertEqual(res, 7)

    def test_iota_descriptor_empty_raises(self):
        candidates = [2, 4, 6]
        with self.assertRaises(DescriptorUndefined):
            iota_descriptor(lambda x: x % 2 != 0, candidates)

    def test_iota_descriptor_non_unique_raises(self):
        candidates = [1, 3, 5]
        with self.assertRaises(NonUniqueWitnessError):
            iota_descriptor(lambda x: x % 2 != 0, candidates)

    def test_macro_consistency(self):
        """Test that MACROS_INDEX.md documents all defined macros."""
        root = Path(__file__).resolve().parents[1]
        index_path = root / "MACROS_INDEX.md"

        if not index_path.exists():
            self.skipTest("MACROS_INDEX.md does not exist")

        index_text = index_path.read_text(encoding="utf-8")
        for file_name in ("000_preamble.tex", "BEGIN.tex"):
            self.assertIn(
                file_name,
                index_text,
                f"MACROS_INDEX.md does not mention {file_name}",
            )


if __name__ == "__main__":
    unittest.main()
