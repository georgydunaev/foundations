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
    ClassFunctor,
    NaturalTransformation,
    dunaev_coproduct,
    copairing_morphism,
    pullback_class,
    pullback_mediating_morphism,
    pushout_partition,
    equalizer_as_pullback,
    pullback_as_equalizer,
    SliceObject,
    is_slice_morphism,
    slice_product,
    slice_base_change,
    hartogs_number,
    can_inject,
    construct_hartogs_ordinals,
    hartogs_well_ordering_types,
    scotts_trick_representative,
    limitation_of_size_holds,
    cardinal_size,
    limitation_of_size_cardinal_criterion,
    Ordinal,
    ordinal_add,
    ordinal_mult,
    ordinal_exp,
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

    def test_class_functors_and_natural_transformations(self):
        """Class functors and natural transformations over MKTD classes."""
        f_obj = lambda x: f"F({x})"
        f_mor = lambda m: (f_obj(m[0]), f_obj(m[1])) if isinstance(m, tuple) else dunaev_pair(f_obj(dunaev_fst(m)), f_obj(dunaev_snd(m)))
        functor_f = ClassFunctor(f_obj, f_mor, name="F")

        # Identity preservation
        objects = ["A", "B", "C"]
        self.assertTrue(functor_f.check_identity(objects))

        # Natural transformation eta: Id => F where eta_X(x) = F(x)
        id_functor = ClassFunctor(lambda x: x, lambda m: m, name="Id")
        comp_map = lambda obj: (lambda x: f"F({x})")
        eta = NaturalTransformation(id_functor, functor_f, comp_map, name="eta")

        # Naturality square check for morphism g: A -> B given by x -> x + "_mod"
        g_base = lambda x: f"{x}_mod"
        g_mapped = lambda y: f"F({y[2:-1]}_mod)" if y.startswith("F(") and y.endswith(")") else f"{y}_mod"
        morphisms = [
            ("A", "B", g_base, g_mapped),
        ]
        self.assertTrue(eta.check_naturality(morphisms, ["val1", "val2"]))

    def test_coproduct_and_copairing(self):
        """Dunaev coproduct and universal copairing morphism."""
        class_a = {"a1", "a2"}
        class_b = {"b1", "b2"}
        coprod = dunaev_coproduct(class_a, class_b)
        self.assertEqual(len(coprod), 4)

        # Check tags
        tags = {dunaev_fst(p) for p in coprod}
        self.assertEqual(tags, {0, 1})

        # Universal copairing [f, g]
        f = lambda a: f"from_a_{a}"
        g = lambda b: f"from_b_{b}"
        copair = copairing_morphism(f, g)

        p_a = dunaev_pair(0, "a1")
        p_b = dunaev_pair(1, "b2")
        self.assertEqual(copair(p_a), "from_a_a1")
        self.assertEqual(copair(p_b), "from_b_b2")

    def test_pullback_and_mediating_morphism(self):
        """Categorical pullback square and universal mediating factorizer."""
        domain_a = [1, 2, 3, 4]
        domain_b = [2, 4, 6]
        # f: A -> C is mod 2, g: B -> C is mod 2
        f = lambda a: a % 2
        g = lambda b: b % 2

        pb = pullback_class(f, g, domain_a, domain_b)
        # Pullback consists of pairs (a, b) where a % 2 == b % 2
        for p in pb:
            a = dunaev_fst(p)
            b = dunaev_snd(p)
            self.assertEqual(f(a), g(b))

        # Commutative cone test with X = {10, 11}
        domain_x = [10, 11]
        h1 = lambda x: 2 if x == 10 else 1
        h2 = lambda x: 4 if x == 10 else 6  # note 6%2 == 0, wait: 1%2==1, 6%2==0
        # for x=10: h1(10)=2 (even), h2(10)=4 (even) -> f(h1(10)) == g(h2(10))
        # for x=11: h1(11)=2 (even), h2(11)=2 (even)
        h1_cone = lambda x: 2 if x == 10 else 4
        h2_cone = lambda x: 6 if x == 10 else 2
        factorizer = pullback_mediating_morphism(h1_cone, h2_cone)
        for x in domain_x:
            pair = factorizer(x)
            self.assertIn(pair, pb)
            self.assertEqual(dunaev_fst(pair), h1_cone(x))
            self.assertEqual(dunaev_snd(pair), h2_cone(x))

    def test_pushout_partition(self):
        """Categorical pushout partition identifying (0, f(c)) ~ (1, g(c))."""
        domain_c = ["c1"]
        domain_a = ["c1", "a1"]
        domain_b = ["c1", "b1"]
        f = lambda c: c
        g = lambda c: c

        classes = pushout_partition(f, g, domain_c, domain_a, domain_b)
        # (0, c1) and (1, c1) must be in the same equivalence class
        c0 = dunaev_pair(0, "c1")
        c1 = dunaev_pair(1, "c1")
        joined = any(c0 in eq_class and c1 in eq_class for eq_class in classes)
        self.assertTrue(joined)

    def test_algebraic_duality_equalizer_pullback(self):
        """Algebraic duality: Equalizer as Pullback and Pullback as Equalizer."""
        domain_a = [1, 2, 3, 4]
        domain_b = [1, 2, 3, 4]
        f = lambda x: x * 2
        g = lambda x: x + 2

        # Direct equalizer: {x in A | 2x == x + 2} => x = 2
        eq_pb = equalizer_as_pullback(f, g, domain_a, domain_b)
        self.assertEqual(eq_pb, {2})

        # Pullback as equalizer
        pb1 = pullback_class(f, g, domain_a, domain_b)
        pb2 = pullback_as_equalizer(f, g, domain_a, domain_b)
        self.assertEqual(pb1, pb2)

    def test_slice_category_and_base_change(self):
        """Slice category products as pullbacks and base change functor."""
        domain_a = [1, 2, 3, 4]
        domain_b = [2, 3, 5]
        # Objects over base C = {0, 1} with mod 2 projection
        slice_a = SliceObject(domain_a, lambda a: a % 2, target_name="C")
        slice_b = SliceObject(domain_b, lambda b: b % 2, target_name="C")

        # Product in C/C is pullback over C
        prod_slice = slice_product(slice_a, slice_b)
        self.assertTrue(len(prod_slice.domain) > 0)
        for pair in prod_slice.domain:
            a = dunaev_fst(pair)
            b = dunaev_snd(pair)
            self.assertEqual(a % 2, b % 2)

        # Slice morphism test: id : slice_a -> slice_a
        self.assertTrue(is_slice_morphism(lambda x: x, slice_a, slice_a))

        # Base change functor k* along k : B -> C
        base_k = lambda b: b % 2
        base_domain = [2, 3]
        changed_slice = slice_base_change(base_k, base_domain, slice_a, base_target_name="B")
        self.assertEqual(changed_slice.target_name, "B")
        for pair in changed_slice.domain:
            a = dunaev_fst(pair)
            b = dunaev_snd(pair)
            self.assertEqual(a % 2, b % 2)

    def test_hartogs_number_construction_and_injectivity(self):
        """Hartogs number h(X) is least ordinal not injecting into X."""
        empty_set = set()
        self.assertEqual(hartogs_number(empty_set), 1)
        self.assertTrue(can_inject(0, 0))
        self.assertFalse(can_inject(1, 0))

        finite_set = {"a", "b", "c"}
        h_finite = hartogs_number(finite_set)
        self.assertEqual(h_finite, 4)
        for k in range(4):
            self.assertTrue(can_inject(k, 3))
        self.assertFalse(can_inject(h_finite, 3))

        ordinals = construct_hartogs_ordinals(finite_set)
        self.assertEqual(ordinals, {0, 1, 2, 3})
        types = hartogs_well_ordering_types(finite_set)
        self.assertEqual(types, [0, 1, 2, 3])

    def test_scotts_trick_equivalence_classes_sethood(self):
        """Scott's trick selects set-sized minimal-rank representative for equivalence classes."""
        domain = [1, 4, 7, 10, 2, 5, 8]
        equiv_mod_3 = lambda x, y: (x % 3) == (y % 3)
        rank_fn = lambda x: x // 3

        # Elements equiv to 4: 1 (rank 0), 4 (rank 1), 7 (rank 2), 10 (rank 3)
        rep_from_4 = scotts_trick_representative(4, equiv_mod_3, domain, rank_fn)
        self.assertEqual(rep_from_4, frozenset({1}))

        # Canonical: rep from 1, 4, 7, 10 are all identical
        rep_from_1 = scotts_trick_representative(1, equiv_mod_3, domain, rank_fn)
        rep_from_7 = scotts_trick_representative(7, equiv_mod_3, domain, rank_fn)
        self.assertEqual(rep_from_1, rep_from_4)
        self.assertEqual(rep_from_7, rep_from_4)

        # Rep for class of 2: 2 (rank 0), 5 (rank 1), 8 (rank 2) => {2}
        rep_from_5 = scotts_trick_representative(5, equiv_mod_3, domain, rank_fn)
        self.assertEqual(rep_from_5, frozenset({2}))

        # Non-existent element returns empty
        rep_none = scotts_trick_representative(99, lambda x, y: False, domain, rank_fn)
        self.assertEqual(rep_none, frozenset())

    def test_von_neumann_limitation_of_size_and_cardinal_defaults(self):
        """Limitation of size: X is proper class iff X ~ V, and cardinal default convention."""
        # Axiom equivalence: proper_class <=> equipotent_to_V
        self.assertTrue(limitation_of_size_holds(is_proper_class=True, equipotent_to_universe=True))
        self.assertTrue(limitation_of_size_holds(is_proper_class=False, equipotent_to_universe=False))
        self.assertFalse(limitation_of_size_holds(is_proper_class=True, equipotent_to_universe=False))
        self.assertFalse(limitation_of_size_holds(is_proper_class=False, equipotent_to_universe=True))

        # Default boundary convention: |V| = On
        univ = UNIVERSAL_CLASS
        self.assertEqual(cardinal_size(univ), "On")

        set_a = ClassObject("A", is_set=True, elements={"x", "y", "z"})
        self.assertEqual(cardinal_size(set_a), 3)

        prop_b = ClassObject("Ord", is_set=False)
        self.assertEqual(cardinal_size(prop_b), "On")

        # Criterion: K in V iff |K| != |V|
        self.assertTrue(limitation_of_size_cardinal_criterion(set_a))
        self.assertTrue(limitation_of_size_cardinal_criterion(prop_b))
        self.assertTrue(limitation_of_size_cardinal_criterion(univ))

    def test_transfinite_ordinal_arithmetic_identities_and_noncommutativity(self):
        """Transfinite ordinal arithmetic: addition, multiplication, exponentiation base cases."""
        z = Ordinal.zero()
        one = Ordinal.one()
        two = Ordinal.from_int(2)
        three = Ordinal.from_int(3)
        omega = Ordinal.omega()

        # Addition identity
        self.assertEqual(z + omega, omega)
        self.assertEqual(omega + z, omega)
        self.assertEqual(ordinal_add(0, omega), omega)

        # Addition non-commutativity: 1 + omega = omega != omega + 1
        one_plus_omega = one + omega
        omega_plus_one = omega + one
        self.assertEqual(one_plus_omega, omega)
        self.assertNotEqual(omega_plus_one, omega)
        self.assertNotEqual(one_plus_omega, omega_plus_one)

        # omega + omega = omega * 2
        self.assertEqual(omega + omega, omega * two)

        # Multiplication identity
        self.assertEqual(z * omega, z)
        self.assertEqual(omega * z, z)
        self.assertEqual(one * omega, omega)
        self.assertEqual(omega * one, omega)

        # Multiplication non-commutativity: 2 * omega = omega != omega * 2
        two_times_omega = two * omega
        omega_times_two = omega * two
        self.assertEqual(two_times_omega, omega)
        self.assertNotEqual(omega_times_two, omega)
        self.assertNotEqual(two_times_omega, omega_times_two)

        # omega * omega = omega^2
        omega_sq = omega * omega
        self.assertEqual(ordinal_mult(omega, omega), omega_sq)

        # Exponentiation base cases
        self.assertEqual(omega ** z, one)
        self.assertEqual(omega ** one, omega)
        self.assertEqual(z ** z, one)
        self.assertEqual(z ** omega, z)
        self.assertEqual(one ** omega, one)

        # 2^omega = omega != omega^2
        two_to_omega = two ** omega
        self.assertEqual(two_to_omega, omega)
        self.assertNotEqual(two_to_omega, omega_sq)
        self.assertEqual(ordinal_exp(2, omega), omega)

    def test_grothendieck_universe_predicates_and_replacement(self):
        """Grothendieck Universes: transitivity, pairing, powerset, union, and replacement."""
        from foundations.type_semantics import (
            is_transitive_set,
            is_closed_under_pairing,
            is_closed_under_powerset,
            is_closed_under_union,
            is_grothendieck_universe,
            grothendieck_universe_satisfies_replacement,
            cumulative_hierarchy_v,
        )

        v0 = cumulative_hierarchy_v(0)
        v1 = cumulative_hierarchy_v(1)
        v2 = cumulative_hierarchy_v(2)

        # Transitivity
        self.assertTrue(is_transitive_set(v0))
        self.assertTrue(is_transitive_set(v1))
        self.assertTrue(is_transitive_set(v2))

        # Non-transitive set: { { {0} } }
        non_trans = frozenset({frozenset({frozenset({0})})})
        self.assertFalse(is_transitive_set(non_trans))

        # Pairing closure: v0 is vacuously closed
        self.assertTrue(is_closed_under_pairing(v0))
        # v1 = { empty }; {empty, empty} = {empty} is in v2, not in v1
        self.assertFalse(is_closed_under_pairing(v1))
        # v2 = { empty, {empty} }; pairing of {empty} with itself gives {{empty}} not in v2
        self.assertFalse(is_closed_under_pairing(v2))

        # Powerset closure: P(empty) = {empty} in v1; but P({empty}) = {empty, {empty}} not in v1
        self.assertFalse(is_closed_under_powerset(v1))

        # Grothendieck universe verification
        self.assertTrue(is_grothendieck_universe(frozenset(), allow_finite=True))
        self.assertFalse(is_grothendieck_universe(v1, allow_finite=True))
        self.assertFalse(is_grothendieck_universe(v2, allow_finite=True))

        # Replacement / indexed union closure
        index_set = frozenset({0, 1})
        domain = frozenset({frozenset(), frozenset({0}), frozenset({1}), frozenset({0, 1}), index_set})
        self.assertTrue(
            grothendieck_universe_satisfies_replacement(
                domain,
                index_set,
                lambda i: frozenset({i}),
            )
        )

    def test_strongly_inaccessible_cardinals_and_cumulative_stages(self):
        """Strongly inaccessible cardinals: regularity, strong limit, and cumulative stages."""
        from foundations.type_semantics import (
            is_regular_cardinal,
            is_strong_limit_cardinal,
            is_strongly_inaccessible_cardinal,
            cumulative_hierarchy_stage,
            Ordinal,
        )

        omega = Ordinal.omega()
        self.assertTrue(is_regular_cardinal(omega))
        self.assertTrue(is_strong_limit_cardinal(omega))
        # omega is countable, so not strongly inaccessible
        self.assertFalse(is_strongly_inaccessible_cardinal(omega))
        self.assertFalse(is_strongly_inaccessible_cardinal(42))

        # Mock strongly inaccessible cardinal
        class InaccessibleCardinal:
            is_regular = True
            is_strong_limit = True
            is_strongly_inaccessible = True

        kappa = InaccessibleCardinal()
        self.assertTrue(is_strongly_inaccessible_cardinal(kappa))

        # Cumulative hierarchy stages
        v_0 = cumulative_hierarchy_stage(0)
        v_1 = cumulative_hierarchy_stage(1)
        v_2 = cumulative_hierarchy_stage(2)
        v_3 = cumulative_hierarchy_stage(3)
        self.assertEqual(len(v_0), 0)
        self.assertEqual(len(v_1), 1)
        self.assertEqual(len(v_2), 2)
        self.assertEqual(len(v_3), 4)

        # Ordinal stages
        v_ord_0 = cumulative_hierarchy_stage(Ordinal.zero())
        v_ord_1 = cumulative_hierarchy_stage(Ordinal.one())
        v_ord_omega = cumulative_hierarchy_stage(Ordinal.omega())
        self.assertEqual(len(v_ord_0), 0)
        self.assertEqual(len(v_ord_1), 1)
        self.assertGreater(len(v_ord_omega), len(v_3))

    def test_internalized_model_satisfaction_with_dunaev_pairs(self):
        """Internalized Tarskian satisfaction and ZFC fragments using Dunaev Tagged Pairs."""
        from foundations.type_semantics import (
            dunaev_pair,
            dunaev_fst,
            dunaev_snd,
            dunaev_relation_from_predicate,
            internalized_valuation,
            internalized_valuation_lookup,
            internalized_model_satisfaction,
            models_zfc_fragment,
            proves_v_kappa_models_zfc,
            cumulative_hierarchy_v,
        )

        domain = ["a", "b", "c"]
        # E = {(a, b), (b, c)}
        rel_pairs = dunaev_relation_from_predicate(domain, lambda x, y: (x, y) in [("a", "b"), ("b", "c")])
        self.assertEqual(len(rel_pairs), 2)
        self.assertIn(dunaev_pair("a", "b"), rel_pairs)

        assign = {"x": "a", "y": "b"}
        val_pairs = internalized_valuation(assign)
        self.assertEqual(internalized_valuation_lookup(val_pairs, "x"), "a")
        self.assertEqual(internalized_valuation_lookup(val_pairs, "y"), "b")

        # Atomic satisfaction
        phi_in = ("in", "x", "y")
        self.assertTrue(internalized_model_satisfaction(domain, rel_pairs, phi_in, assign))
        self.assertTrue(internalized_model_satisfaction(domain, rel_pairs, phi_in, val_pairs))

        phi_in_rev = ("in", "y", "x")
        self.assertFalse(internalized_model_satisfaction(domain, rel_pairs, phi_in_rev, assign))

        # Quantified satisfaction: exists z. in(x, z)
        phi_exists = ("exists", "z", ("in", "x", "z"))
        self.assertTrue(internalized_model_satisfaction(domain, rel_pairs, phi_exists, {"x": "a"}))
        self.assertFalse(internalized_model_satisfaction(domain, rel_pairs, phi_exists, {"x": "c"}))

        # ZFC fragment evaluation on V_2 = {empty, {empty}}
        v2 = cumulative_hierarchy_v(2)
        zfc_eval_v2 = models_zfc_fragment(v2)
        self.assertTrue(zfc_eval_v2["extensionality"])
        self.assertTrue(zfc_eval_v2["empty_set"])
        self.assertTrue(zfc_eval_v2["foundation"])

        # Model with full fragment satisfaction
        class MockZFCModel:
            pass

        mock_dom = ["0"]
        # Structure with 1 element and empty relation satisfies extensionality, empty set, foundation
        empty_rel = dunaev_relation_from_predicate(mock_dom, lambda x, y: False)
        # Empty set axiom: exists x. forall z. not z in x -> "0" works since no elements relate to "0"
        self.assertTrue(internalized_model_satisfaction(mock_dom, empty_rel, ("exists", "x", ("forall", "z", ("not", ("in", "z", "x"))))))

    def test_godel_constructibility_and_delta0_absoluteness(self):
        """Test Godel constructible hierarchy L_alpha, Def(X), and Delta_0 absoluteness."""
        from foundations.type_semantics import (
            is_delta0_formula,
            definable_subset,
            definable_powerset,
            constructible_hierarchy_stage,
            is_constructible,
            v_equals_l_predicate,
            verify_delta0_absoluteness,
            pairing_formula_delta0,
            union_formula_delta0,
            empty_set_formula_delta0,
            proves_l_models_zfc,
            Ordinal,
        )

        # 1. Delta_0 formula syntax checks
        phi_atom_in = ("in", "x", "y")
        phi_atom_eq = ("=", "x", "y")
        phi_bounded_fa = ("bounded_forall", "x", "y", ("in", "x", "z"))
        phi_bounded_ex = ("bounded_exists", "x", "y", ("=", "x", "z"))
        phi_bool = ("and", phi_atom_in, ("not", phi_atom_eq))

        self.assertTrue(is_delta0_formula(phi_atom_in))
        self.assertTrue(is_delta0_formula(phi_atom_eq))
        self.assertTrue(is_delta0_formula(phi_bounded_fa))
        self.assertTrue(is_delta0_formula(phi_bounded_ex))
        self.assertTrue(is_delta0_formula(phi_bool))

        # Unbounded quantifiers are NOT Delta_0
        phi_unbounded_fa = ("forall", "x", ("in", "x", "y"))
        phi_unbounded_ex = ("exists", "x", ("=", "x", "y"))
        self.assertFalse(is_delta0_formula(phi_unbounded_fa))
        self.assertFalse(is_delta0_formula(phi_unbounded_ex))
        self.assertFalse(is_delta0_formula(("or", phi_atom_in, phi_unbounded_fa)))

        # 2. Def(X) and L_alpha hierarchy stages
        l_0 = constructible_hierarchy_stage(0)
        self.assertEqual(len(l_0), 0)

        l_1 = constructible_hierarchy_stage(1)
        self.assertEqual(len(l_1), 1)
        self.assertIn(frozenset(), l_1)

        l_2 = constructible_hierarchy_stage(2)
        self.assertEqual(len(l_2), 2)
        self.assertIn(frozenset(), l_2)
        self.assertIn(frozenset([frozenset()]), l_2)

        l_3 = constructible_hierarchy_stage(3)
        self.assertEqual(len(l_3), 4)

        # Ordinal stages
        l_ord_0 = constructible_hierarchy_stage(Ordinal.zero())
        l_ord_1 = constructible_hierarchy_stage(Ordinal.one())
        l_ord_2 = constructible_hierarchy_stage(Ordinal.from_int(2))
        l_ord_omega = constructible_hierarchy_stage(Ordinal.omega())
        self.assertEqual(len(l_ord_0), 0)
        self.assertEqual(len(l_ord_1), 1)
        self.assertEqual(len(l_ord_2), 2)
        self.assertGreater(len(l_ord_omega), len(l_3))

        # Definable subset operator
        empty_set = frozenset()
        one_set = frozenset([empty_set])
        def_sub = definable_subset(l_2, ("=", "x", "p"), {"p": empty_set})
        self.assertEqual(def_sub, frozenset([empty_set]))

        # Definable powerset of L_1
        def_p_l1 = definable_powerset(l_1)
        self.assertEqual(len(def_p_l1), 2)

        # 3. Constructibility predicate and V = L
        self.assertTrue(is_constructible(empty_set, max_stage=3))
        self.assertTrue(is_constructible(one_set, max_stage=3))
        self.assertTrue(v_equals_l_predicate([empty_set, one_set], max_stage=3))

        # 4. Delta_0 Absoluteness between transitive models L_2 and L_3
        # L_2 subset L_3, both are transitive sets
        pair_formula = pairing_formula_delta0("x", "y", "p")
        self.assertTrue(is_delta0_formula(pair_formula))
        abs_pairing = verify_delta0_absoluteness(l_2, l_3, pair_formula, {"x": empty_set, "y": empty_set, "p": one_set})
        self.assertTrue(abs_pairing)

        union_formula = union_formula_delta0("x", "u")
        self.assertTrue(is_delta0_formula(union_formula))
        abs_union = verify_delta0_absoluteness(l_2, l_3, union_formula, {"x": one_set, "u": empty_set})
        self.assertTrue(abs_union)

        empty_formula = empty_set_formula_delta0("e")
        self.assertTrue(is_delta0_formula(empty_formula))
        abs_empty = verify_delta0_absoluteness(l_2, l_3, empty_formula, {"e": empty_set})
        self.assertTrue(abs_empty)

        # Bounded quantifier absoluteness
        bounded_formula = ("bounded_forall", "z", "p", ("=", "z", "x"))
        self.assertTrue(is_delta0_formula(bounded_formula))
        abs_bounded = verify_delta0_absoluteness(l_2, l_3, bounded_formula, {"p": one_set, "x": empty_set})
        self.assertTrue(abs_bounded)

        # 5. Schema verification: L models ZFC
        l_zfc = proves_l_models_zfc()
        self.assertTrue(l_zfc["l_models_zfc"])
        self.assertIn("extensionality", l_zfc["axioms"])
        self.assertIn("pairing", l_zfc["axioms"])
        self.assertIn("union", l_zfc["axioms"])
        self.assertIn("separation", l_zfc["axioms"])
        self.assertIn("replacement", l_zfc["axioms"])
        self.assertIn("powerset", l_zfc["axioms"])
        self.assertIn("infinity", l_zfc["axioms"])
        self.assertIn("foundation", l_zfc["axioms"])
        self.assertIn("choice", l_zfc["axioms"])
        self.assertIn("constructibility_v_equals_l", l_zfc["axioms"])
        self.assertIn("dunaev_pair", l_zfc["pairing_device"])

    def test_canonical_well_ordering_and_choice_in_l(self):
        """Test canonical well-ordering of L, Axiom of Choice (L |= AC), and Condensation Lemma scaffolding (Ticket 7724)."""
        from foundations.type_semantics import (
            godel_number_formula,
            canonical_l_order_stage,
            is_well_ordered,
            l_choice_function,
            proves_l_models_ac,
            tarski_vaught_criterion,
            mostowski_collapse,
            condensation_lemma_scaffold,
            constructible_hierarchy_stage,
            DunaevTaggedPair,
        )

        # 1. Godel numbering of formulas
        gn_false = godel_number_formula("false")
        gn_true = godel_number_formula("true")
        gn_atom = godel_number_formula(("in", "x", "y"))
        gn_eq = godel_number_formula(("=", "x", "y"))
        gn_and = godel_number_formula(("and", ("in", "x", "y"), ("=", "x", "y")))
        gn_bnd = godel_number_formula(("bounded_forall", "z", "p", ("=", "z", "x")))

        self.assertEqual(gn_false, 0)
        self.assertEqual(gn_true, 1)
        self.assertGreater(gn_atom, 0)
        self.assertGreater(gn_eq, 0)
        self.assertGreater(gn_and, gn_atom)
        self.assertGreater(gn_bnd, 0)

        # 2. Canonical well-ordering <_{L_alpha}
        l_0_pairs = canonical_l_order_stage(0)
        l_1_pairs = canonical_l_order_stage(1)
        l_2_pairs = canonical_l_order_stage(2)
        l_3_pairs = canonical_l_order_stage(3)

        self.assertEqual(len(l_0_pairs), 0)
        self.assertEqual(len(l_1_pairs), 0)
        self.assertEqual(len(l_2_pairs), 1)
        self.assertEqual(len(l_3_pairs), 6)

        l_2_stage = constructible_hierarchy_stage(2)
        l_3_stage = constructible_hierarchy_stage(3)

        self.assertTrue(is_well_ordered(l_2_stage, l_2_pairs))
        self.assertTrue(is_well_ordered(l_3_stage, l_3_pairs))

        # 3. Canonical Choice function on L
        empty = frozenset()
        s_empty = frozenset([empty])
        choice_2 = l_choice_function([s_empty, empty], l_2_pairs)
        self.assertEqual(choice_2, empty)

        # All pairs in L_3 have a consistent choice element
        for a, b in l_3_pairs:
            ch = l_choice_function([b, a], l_3_pairs)
            self.assertEqual(ch, a)

        # Empty subset raises ValueError
        with self.assertRaises(ValueError):
            l_choice_function([], l_3_pairs)

        # 4. Godel's theorem: L models AC
        res_ac = proves_l_models_ac(l_3_stage)
        self.assertTrue(res_ac["l_models_ac"])
        self.assertTrue(res_ac["is_well_ordered"])
        self.assertGreater(res_ac["subsets_tested"], 0)
        self.assertEqual(res_ac["pairing_device"], "dunaev_pair")

        # 5. Tarski-Vaught criterion for elementary submodels
        phi_in = ("in", "x", "p")
        tv_holds = tarski_vaught_criterion(l_2_stage, l_3_stage, phi_in, {"p": s_empty})
        self.assertTrue(tv_holds)

        # 6. Mostowski Transitive Collapse with Dunaev Tagged Pairs
        m_dom = [ClassObject("a", is_set=True), ClassObject("b", is_set=True)]
        e_rel = [DunaevTaggedPair(m_dom[0], m_dom[1])]
        collapse_map = mostowski_collapse(m_dom, e_rel)

        self.assertIn(m_dom[0], collapse_map)
        self.assertIn(m_dom[1], collapse_map)
        self.assertEqual(collapse_map[m_dom[0]], frozenset())
        self.assertEqual(collapse_map[m_dom[1]], frozenset([frozenset()]))

        collapsed_image = frozenset(collapse_map.values())
        self.assertEqual(collapsed_image, l_2_stage)

        # 7. Condensation Lemma Scaffolding
        cond_res = condensation_lemma_scaffold(3)
        self.assertTrue(cond_res["condensation_holds"])
        self.assertTrue(cond_res["is_transitive"])
        self.assertEqual(cond_res["pairing_device"], "dunaev_pair")

    def test_godel_condensation_lemma_and_gch_in_l(self):
        """Ticket 7725: Godel's Condensation Lemma, Lowenheim-Skolem reflection, rank bounding, and GCH in L."""
        from foundations.type_semantics import (
            constructible_hierarchy_stage,
            skolem_hull_l,
            condensation_lemma,
            lowenheim_skolem_reflection_l,
            rank_bounding,
            constructible_powerset,
            gch_in_l,
            proves_l_models_gch,
        )

        empty = frozenset()
        s_empty = frozenset([empty])
        l1 = constructible_hierarchy_stage(1)
        l2 = constructible_hierarchy_stage(2)
        l3 = constructible_hierarchy_stage(3)

        # 1. Definable Skolem hull in L
        hull = skolem_hull_l(l3, [empty])
        self.assertIn(empty, hull)
        self.assertTrue(hull.issubset(l3))

        hull_l2 = skolem_hull_l(l3, l2)
        self.assertTrue(l2.issubset(hull_l2))

        # 2. Godel's Condensation Lemma
        cond_res = condensation_lemma(l2, lambda_bound=3)
        self.assertTrue(cond_res["condensation_holds"])
        self.assertTrue(cond_res["is_transitive"])
        self.assertEqual(cond_res["collapsed_stage_alpha"], 2)
        self.assertEqual(cond_res["collapsed_image"], l2)
        self.assertEqual(cond_res["pairing_device"], "dunaev_pair")

        # 3. Lowenheim-Skolem Reflection in L
        ls_res = lowenheim_skolem_reflection_l(s_empty, kappa_stage=2, lambda_stage=3)
        self.assertTrue(ls_res["reflection_holds"])
        self.assertTrue(ls_res["contains_l_kappa"])
        self.assertTrue(ls_res["contains_subset_x"])
        self.assertTrue(ls_res["tarski_vaught_verified"])
        self.assertEqual(ls_res["pairing_device"], "dunaev_pair")

        # 4. Rank Bounding Theorem
        rb_res = rank_bounding(l2, cardinal_kappa=2, lambda_bound=3)
        self.assertTrue(rb_res["rank_bounded"])
        self.assertEqual(rb_res["collapsed_alpha"], 2)
        self.assertEqual(rb_res["cardinal_succ_bound"], 3)
        self.assertLess(rb_res["collapsed_alpha"], rb_res["cardinal_succ_bound"])
        self.assertTrue(rb_res["condensation_verified"])
        self.assertEqual(rb_res["pairing_device"], "dunaev_pair")

        # 5. Constructible Powerset P(kappa) cap L
        p_l1 = constructible_powerset(l1, stage_bound=2)
        self.assertEqual(len(p_l1), 2)
        self.assertIn(empty, p_l1)
        self.assertIn(s_empty, p_l1)

        p_l2 = constructible_powerset(l2, stage_bound=3)
        self.assertEqual(len(p_l2), 4)

        # 6. GCH in L steps
        gch_1 = gch_in_l(kappa_cardinal=1, max_lambda=3)
        self.assertTrue(gch_1["gch_holds"])
        self.assertEqual(gch_1["powerset_l_size"], 2)
        self.assertEqual(gch_1["pairing_device"], "dunaev_pair")

        gch_2 = gch_in_l(kappa_cardinal=2, max_lambda=3)
        self.assertTrue(gch_2["gch_holds"])
        self.assertEqual(gch_2["powerset_l_size"], 4)
        self.assertEqual(gch_2["pairing_device"], "dunaev_pair")

        # 7. Master theorem runner: L models GCH
        gch_master = proves_l_models_gch(max_stage=3)
        self.assertTrue(gch_master["l_models_gch"])
        self.assertTrue(gch_master["condensation_lemma_verified"])
        self.assertTrue(gch_master["lowenheim_skolem_verified"])
        self.assertTrue(gch_master["rank_bounding_verified"])
        self.assertEqual(len(gch_master["gch_steps"]), 2)
        self.assertEqual(gch_master["pairing_device"], "dunaev_pair")

    def test_inner_model_theory_and_relative_consistency(self):
        """Ticket 7726: Inner Model Theory, Godel Operations F1 to F8, and Con(ZF) implies Con(ZFC+GCH)."""
        from foundations.type_semantics import (
            DunaevTaggedPair,
            constructible_hierarchy_stage,
            godel_operation_f1,
            godel_operation_f2,
            godel_operation_f3,
            godel_operation_f4,
            godel_operation_f5,
            godel_operation_f6,
            godel_operation_f7,
            godel_operation_f8,
            is_inner_model,
            delta0_formula_absoluteness,
            relative_consistency_ac_gch,
            proves_relative_consistency_of_ac_and_gch,
        )

        empty = frozenset()
        s_empty = frozenset([empty])
        l2 = constructible_hierarchy_stage(2)
        l3 = constructible_hierarchy_stage(3)

        # 1. Godel basic operations F1 to F8
        f1 = godel_operation_f1(empty, s_empty)
        self.assertEqual(f1, frozenset([empty, s_empty]))

        f2 = godel_operation_f2(l2, l2)
        self.assertEqual(len(f2), 4)
        for p in f2:
            self.assertIsInstance(p, DunaevTaggedPair)

        f3 = godel_operation_f3(l2, [empty])
        self.assertEqual(f3, frozenset([s_empty]))

        f4 = godel_operation_f4([DunaevTaggedPair(empty, s_empty)])
        self.assertEqual(f4, frozenset([empty]))

        f5 = godel_operation_f5(l2, [s_empty, frozenset([s_empty])])
        self.assertEqual(f5, frozenset([s_empty]))

        f6 = godel_operation_f6([(1, 2, 3)])
        self.assertEqual(f6, frozenset([(2, 3, 1)]))

        f7 = godel_operation_f7([(1, 2, 3)])
        self.assertEqual(f7, frozenset([(1, 3, 2)]))

        f8 = godel_operation_f8([(1, 2, 3)])
        self.assertEqual(f8, frozenset([(3, 2, 1)]))

        # Dunaev tagged pair triple permutations
        p_triple = DunaevTaggedPair("u", DunaevTaggedPair("v", "w"))
        f6_d = godel_operation_f6([p_triple])
        self.assertIn(DunaevTaggedPair("v", DunaevTaggedPair("w", "u")), f6_d)

        # 2. Inner model predicate
        ordinals = [empty, s_empty]
        inner_res = is_inner_model(l3, ordinals)
        self.assertTrue(inner_res["is_inner_model"])
        self.assertTrue(inner_res["is_transitive"])
        self.assertTrue(inner_res["ord_contained"])
        self.assertTrue(inner_res["closed_under_godel_ops"])
        self.assertEqual(inner_res["pairing_device"], "dunaev_pair")

        # 3. Delta_0 formula absoluteness
        abs_res = delta0_formula_absoluteness(l2, l3, ("eq", "x", "x"), {"x": empty})
        self.assertTrue(abs_res["is_absolute"])
        self.assertTrue(abs_res["sat_m"])
        self.assertTrue(abs_res["sat_v"])
        self.assertEqual(abs_res["pairing_device"], "dunaev_pair")

        # 4. Relative consistency deduction
        rel_con = relative_consistency_ac_gch(con_mk=True)
        self.assertTrue(rel_con["relative_consistency_holds"])
        self.assertTrue(rel_con["con_base_theory"])
        self.assertTrue(rel_con["con_extended_theory"])
        self.assertEqual(rel_con["base_theory"], "MK")
        self.assertEqual(rel_con["inner_model"], "L")
        self.assertEqual(rel_con["pairing_device"], "dunaev_pair")

        # 5. Master relative consistency runner
        master_res = proves_relative_consistency_of_ac_and_gch(max_stage=3)
        self.assertTrue(master_res["relative_consistency_proven"])
        self.assertTrue(master_res["inner_model_verified"])
        self.assertTrue(master_res["godel_ops_verified"])
        self.assertTrue(master_res["delta0_absoluteness_verified"])
        self.assertTrue(master_res["l_models_gch_verified"])
        self.assertEqual(master_res["pairing_device"], "dunaev_pair")


if __name__ == "__main__":
    unittest.main()
