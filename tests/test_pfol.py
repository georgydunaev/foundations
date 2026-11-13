#!/usr/bin/env python3
"""Tests for Farmer's Partial First-Order Logic (PFOL)."""

import unittest
from pathlib import Path
import sys

REPO_DIR = Path(__file__).resolve().parents[1]
if str(REPO_DIR) not in sys.path:
    sys.path.insert(0, str(REPO_DIR))

from foundations.pfol import (
    is_defined,
    kleene_equality,
    pfol_iota,
    weak_equality,
)


class TestPFOL(unittest.TestCase):
    def test_definedness(self):
        self.assertTrue(is_defined(42))
        self.assertTrue(is_defined("class"))
        self.assertFalse(is_defined(None))

    def test_kleene_equality(self):
        # Both undefined => True
        self.assertTrue(kleene_equality(None, None))
        # One defined, one undefined => False
        self.assertFalse(kleene_equality(42, None))
        self.assertFalse(kleene_equality(None, 42))
        # Both defined and equal => True
        self.assertTrue(kleene_equality(42, 42))
        # Both defined and unequal => False
        self.assertFalse(kleene_equality(42, 43))

    def test_weak_equality(self):
        # Any undefined => False
        self.assertFalse(weak_equality(None, None))
        self.assertFalse(weak_equality(42, None))
        self.assertFalse(weak_equality(None, 42))
        # Both defined and equal => True
        self.assertTrue(weak_equality(42, 42))
        # Both defined and unequal => False
        self.assertFalse(weak_equality(42, 43))

    def test_pfol_iota(self):
        candidates = [1, 2, 3, 4]
        # Unique witness => defined
        res = pfol_iota(lambda x: x == 3, candidates)
        self.assertTrue(is_defined(res))
        self.assertEqual(res, 3)

        # No witness => undefined
        res_none = pfol_iota(lambda x: x > 10, candidates)
        self.assertFalse(is_defined(res_none))
        self.assertIsNone(res_none)

        # Multiple witnesses => undefined in PFOL
        res_mult = pfol_iota(lambda x: x > 2, candidates)
        self.assertFalse(is_defined(res_mult))
        self.assertIsNone(res_mult)


if __name__ == "__main__":
    unittest.main()
