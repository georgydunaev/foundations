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
    TransitiveModel,
    categorical_equalizer,
    categorical_subobject_comprehension,
    cumulative_hierarchy_v,
    dunaev_fst,
    dunaev_pair,
    dunaev_pairing_morphism,
    dunaev_snd,
    find_reflecting_stage,
    guarded_evaluation,
    has_type,
    is_well_founded_relation,
    kuratowski_pair,
    model_satisfaction,
    reflects_formula,
    relation_predecessors,
    relativize_formula,
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

    def test_model_satisfaction_atomic_and_boolean(self):
        """Tarski truth definition for atomic formulas and boolean connectives."""
        # Simple finite model with elements 0, 1, 2 where R is linear order <
        domain = [0, 1, 2]
        in_rel = lambda x, y: x < y
        m = TransitiveModel(domain, in_rel=in_rel, name="M3")

        # Atomic in and eq
        self.assertTrue(m.satisfies(("in", "x", "y"), {"x": 0, "y": 1}))
        self.assertFalse(m.satisfies(("in", "x", "y"), {"x": 1, "y": 0}))
        self.assertTrue(m.satisfies(("eq", "x", "x"), {"x": 2}))

        # Boolean connectives
        p = ("in", "x", "y")
        q = ("eq", "x", "y")
        self.assertTrue(m.satisfies(("and", p, ("not", q)), {"x": 0, "y": 1}))
        self.assertTrue(m.satisfies(("or", p, q), {"x": 1, "y": 1}))
        self.assertTrue(m.satisfies(("imp", p, q), {"x": 1, "y": 0}))

    def test_model_satisfaction_quantifiers(self):
        """Tarski truth definition for bounded quantifiers over transitive models."""
        # Hereditarily finite set V2 = {empty, {empty}}
        v2 = cumulative_hierarchy_v(2)
        m = TransitiveModel(v2, name="V2")

        # Exists an empty element: exists y. forall z. not (z in y)
        empty_exists = ("exists", "y", ("forall", "z", ("not", ("in", "z", "y"))))
        self.assertTrue(m.satisfies(empty_exists))

        # No set is a member of itself (Regularity / Foundation)
        no_self_membership = ("forall", "x", ("not", ("in", "x", "x")))
        self.assertTrue(m.satisfies(no_self_membership))

        # Unique empty set
        unique_empty = ("exists_unique", "y", ("forall", "z", ("not", ("in", "z", "y"))))
        self.assertTrue(m.satisfies(unique_empty))

    def test_formula_relativization(self):
        """Relativization of quantifiers to a model class term."""
        phi = ("forall", "x", ("exists", "y", ("in", "x", "y")))
        rel = relativize_formula(phi, "M")

        expected = (
            "forall",
            "x",
            ("imp", ("in", "x", "M"), ("exists", "y", ("and", ("in", "y", "M"), ("in", "x", "y")))),
        )
        self.assertEqual(rel, expected)

    def test_cumulative_hierarchy_levels(self):
        """Cumulative hierarchy stages V_0, V_1, V_2, V_3, V_4 sizes."""
        v0 = cumulative_hierarchy_v(0)
        v1 = cumulative_hierarchy_v(1)
        v2 = cumulative_hierarchy_v(2)
        v3 = cumulative_hierarchy_v(3)
        v4 = cumulative_hierarchy_v(4)

        self.assertEqual(len(v0), 0)
        self.assertEqual(len(v1), 1)  # {empty}
        self.assertEqual(len(v2), 2)  # {empty, {empty}}
        self.assertEqual(len(v3), 4)  # P(V2), size 4
        self.assertEqual(len(v4), 16) # P(V3), size 16

        # Transitivity check: every element of an element of V_n is an element of V_n
        for elem in v3:
            for sub_elem in elem:
                self.assertIn(sub_elem, v3)

    def test_reflection_principle_and_witness_search(self):
        """Montague-Levy reflection principle on finite cumulative stages."""
        # Formula: exists y. forall z. not (z in y) (existence of empty set)
        empty_exists = ("exists", "y", ("forall", "z", ("not", ("in", "z", "y"))))

        v1 = cumulative_hierarchy_v(1)
        v2 = cumulative_hierarchy_v(2)
        v3 = cumulative_hierarchy_v(3)

        # V1 reflects empty_exists relative to V3
        self.assertTrue(reflects_formula(v1, v3, empty_exists, []))
        self.assertTrue(reflects_formula(v2, v3, empty_exists, []))

        # Smallest reflecting stage for empty_exists is stage 1
        reflecting_stage = find_reflecting_stage(empty_exists, [], max_stage=3)
        self.assertEqual(reflecting_stage, 1)

        # Sentence with empty constant: phi_empty = exists y. (empty in y)
        # In V1, the only element is empty, and there is no y in V1 such that empty in y
        # In V2, {empty} is in V2, so empty in {empty} holds!
        # Thus stage 2 reflects phi_empty relative to V3
        empty_set = frozenset()
        phi_empty = ("exists", "y", ("in", empty_set, "y"))
        self.assertFalse(reflects_formula(v1, v3, phi_empty, []))
        self.assertTrue(reflects_formula(v2, v3, phi_empty, []))
        reflecting_stage_empty = find_reflecting_stage(phi_empty, [], max_stage=3)
        self.assertEqual(reflecting_stage_empty, 2)

        # Formula with parameter: phi(x) = exists y. (x in y)
        # V1 fails for x=empty; V2 fails for x={empty} (its superset {{empty}} is only in V3)
        # Hence stage 3 is the reflecting stage for arbitrary x relative to V3
        has_superset = ("exists", "y", ("in", "x", "y"))
        self.assertFalse(reflects_formula(v1, v3, has_superset, ["x"]))
        self.assertFalse(reflects_formula(v2, v3, has_superset, ["x"]))
        reflecting_stage_sup = find_reflecting_stage(has_superset, ["x"], max_stage=3)
        self.assertEqual(reflecting_stage_sup, 3)



if __name__ == "__main__":
    unittest.main()
