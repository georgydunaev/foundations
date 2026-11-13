#!/usr/bin/env python3
"""Tests for type semantics and class theory pairing."""

import unittest
from pathlib import Path
import sys

REPO_DIR = Path(__file__).resolve().parents[1]
if str(REPO_DIR) not in sys.path:
    sys.path.insert(0, str(REPO_DIR))

from foundations.type_semantics import (
    CLASS_TYPE,
    SET_TYPE,
    UNIVERSAL_CLASS,
    ClassObject,
    DunaevTaggedPair,
    KuratowskiPair,
    ProperClassError,
    dunaev_fst,
    dunaev_pair,
    dunaev_snd,
    guarded_evaluation,
    has_type,
    kuratowski_pair,
    total_evaluation,
)


class TestTypeSemantics(unittest.TestCase):
    def test_dunaev_pair_projections_with_proper_classes(self):
        """Dunaev tagged pair works with proper classes such as V."""
        a = UNIVERSAL_CLASS
        b = ClassObject("Ord", is_set=False)
        pair = dunaev_pair(a, b)
        self.assertIsInstance(pair, DunaevTaggedPair)
        self.assertEqual(dunaev_fst(pair), UNIVERSAL_CLASS)
        self.assertEqual(dunaev_snd(pair), b)

    def test_kuratowski_pair_rejects_proper_class(self):
        """Kuratowski pair rejects proper classes."""
        s1 = ClassObject("s1", is_set=True)
        s2 = ClassObject("s2", is_set=True)
        k_pair = kuratowski_pair(s1, s2)
        self.assertIsInstance(k_pair, KuratowskiPair)

        with self.assertRaises(ProperClassError):
            kuratowski_pair(UNIVERSAL_CLASS, s1)

        with self.assertRaises(ProperClassError):
            kuratowski_pair(s1, UNIVERSAL_CLASS)

    def test_conglomerate_types(self):
        """Types as conglomerate predicates."""
        s = ClassObject("s", is_set=True)
        c = ClassObject("c", is_set=False)

        self.assertTrue(has_type(s, CLASS_TYPE))
        self.assertTrue(has_type(c, CLASS_TYPE))
        self.assertTrue(has_type(UNIVERSAL_CLASS, CLASS_TYPE))

        self.assertTrue(has_type(s, SET_TYPE))
        self.assertFalse(has_type(c, SET_TYPE))
        self.assertFalse(has_type(UNIVERSAL_CLASS, SET_TYPE))

    def test_total_vs_guarded_evaluation(self):
        graph = [("x", "val_x"), ("y", "val_y")]
        domain = {"x", "y"}

        # Total evaluation (empty default)
        self.assertEqual(total_evaluation(graph, "x"), "val_x")
        self.assertIsNone(total_evaluation(graph, "z"))

        # Guarded evaluation (V default outside domain)
        self.assertEqual(guarded_evaluation(graph, "x", domain), "val_x")
        self.assertEqual(guarded_evaluation(graph, "z", domain), UNIVERSAL_CLASS)


if __name__ == "__main__":
    unittest.main()
