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
    INITIAL_CLASS,
    SET_TYPE,
    TERMINAL_CLASS,
    UNIVERSAL_CLASS,
    ClassObject,
    DunaevProduct,
    DunaevTaggedPair,
    KuratowskiPair,
    ProperClassError,
    categorical_equalizer,
    categorical_subobject_comprehension,
    dunaev_fst,
    dunaev_pair,
    dunaev_pairing_morphism,
    dunaev_snd,
    guarded_evaluation,
    has_type,
    is_well_founded_relation,
    kuratowski_pair,
    relation_predecessors,
    terminal_morphism,
    total_evaluation,
    transfinite_recursion_eval,
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

    def test_well_founded_relation_and_recursion(self):
        """Test well-founded relation detection and transfinite recursion."""
        domain = {0, 1, 2, 3}
        pairs = [(0, 1), (1, 2), (2, 3), (0, 2), (0, 3), (1, 3)]
        self.assertTrue(is_well_founded_relation(pairs, domain))

        # Cyclic relation is not well-founded
        cycle_pairs = [(0, 1), (1, 2), (2, 0)]
        self.assertFalse(is_well_founded_relation(cycle_pairs, {0, 1, 2}))

        # Transfinite recursion: compute von Neumann ordinal sets / ranks
        # rank(0) = 0, rank(x) = 1 + max(rank(y) for y < x)
        def rank_step(x, restr):
            preds = relation_predecessors(pairs, x)
            if not preds:
                return 0
            return 1 + max(restr(y) for y in preds)

        ranks = transfinite_recursion_eval(rank_step, pairs, [0, 1, 2, 3])
        self.assertEqual(ranks, {0: 0, 1: 1, 2: 2, 3: 3})

    def test_categorical_product_and_universal_pairing(self):
        """Categorical products with Dunaev pairs and universal property."""
        a = UNIVERSAL_CLASS
        b = ClassObject("Ord", is_set=False)
        prod = DunaevProduct(a, b)

        pair = prod.pair("val_a", "val_b")
        self.assertEqual(prod.proj1(pair), "val_a")
        self.assertEqual(prod.proj2(pair), "val_b")

        # Universal pairing morphism: <f, g>
        f = lambda c: f"f({c})"
        g = lambda c: f"g({c})"
        pairing = dunaev_pairing_morphism(f, g)
        res_pair = pairing("x")

        self.assertEqual(dunaev_fst(res_pair), "f(x)")
        self.assertEqual(dunaev_snd(res_pair), "g(x)")

    def test_categorical_equalizer_and_subobject_comprehension(self):
        """Equalizers and class comprehension as categorical subobjects."""
        candidates = [1, 2, 3, 4, 5, 6]
        evens = categorical_subobject_comprehension(lambda x: x % 2 == 0, candidates)
        self.assertEqual(evens, [2, 4, 6])

        # Equalizer of two morphisms
        f = lambda x: x * 2
        g = lambda x: x + 2
        eq_elements = categorical_equalizer(f, g, candidates)
        self.assertEqual(eq_elements, [2])

    def test_initial_and_terminal_objects(self):
        """Initial and terminal object morphisms."""
        term_m = terminal_morphism(UNIVERSAL_CLASS)
        self.assertEqual(term_m("any_class"), TERMINAL_CLASS)



if __name__ == "__main__":
    unittest.main()
