from pathlib import Path
import sys
import unittest

REPO_DIR = Path(__file__).resolve().parent.parent
if str(REPO_DIR) not in sys.path:
    sys.path.insert(0, str(REPO_DIR))

try:
    import foundations
    HAS_FOUNDATIONS = True
except ImportError:
    HAS_FOUNDATIONS = False


class TestFoundations(unittest.TestCase):
    def test_imports(self):
        self.assertTrue(HAS_FOUNDATIONS, "Failed to import foundations package")

    def test_module_has_init(self):
        self.assertIsNotNone(foundations.__init__)

    def test_all_is_list(self):
        self.assertTrue(HAS_FOUNDATIONS)
        self.assertIsInstance(foundations.__all__, list)
        self.assertGreater(len(foundations.__all__), 0)

    def test_all_symbols_exist(self):
        """Every symbol listed in __all__ must be present on the foundations package."""
        self.assertTrue(HAS_FOUNDATIONS)
        for sym in foundations.__all__:
            with self.subTest(symbol=sym):
                self.assertTrue(
                    hasattr(foundations, sym),
                    f"Symbol '{sym}' listed in __all__ is missing from foundations",
                )
                self.assertIsNotNone(getattr(foundations, sym))

    def test_ticket_7724_constructible_choice_and_collapse_symbols(self):
        """Ticket 7724: verify canonical well-ordering, choice, and collapse symbols."""
        self.assertTrue(HAS_FOUNDATIONS)
        expected_symbols = [
            "godel_number_formula",
            "canonical_l_order_stage",
            "is_well_ordered",
            "l_choice_function",
            "proves_l_models_ac",
            "tarski_vaught_criterion",
            "mostowski_collapse",
            "condensation_lemma_scaffold",
        ]
        for sym in expected_symbols:
            with self.subTest(symbol=sym):
                self.assertTrue(
                    hasattr(foundations, sym),
                    f"Symbol '{sym}' from Ticket 7724 is missing from foundations",
                )
                self.assertTrue(callable(getattr(foundations, sym)))


    def test_ticket_7725_condensation_lemma_and_gch_symbols(self):
        """Ticket 7725: verify Godel Condensation Lemma and GCH in L symbols."""
        self.assertTrue(HAS_FOUNDATIONS)
        expected_symbols = [
            "skolem_hull_l",
            "condensation_lemma",
            "lowenheim_skolem_reflection_l",
            "rank_bounding",
            "constructible_powerset",
            "gch_in_l",
            "proves_l_models_gch",
        ]
        for sym in expected_symbols:
            with self.subTest(symbol=sym):
                self.assertTrue(
                    hasattr(foundations, sym),
                    f"Symbol '{sym}' from Ticket 7725 is missing from foundations",
                )
                self.assertTrue(callable(getattr(foundations, sym)))

    def test_ticket_7726_inner_models_and_relative_consistency_symbols(self):
        """Ticket 7726: verify Inner Model Theory and Relative Consistency symbols."""
        self.assertTrue(HAS_FOUNDATIONS)
        expected_symbols = [
            "godel_operation_f1",
            "godel_operation_f2",
            "godel_operation_f3",
            "godel_operation_f4",
            "godel_operation_f5",
            "godel_operation_f6",
            "godel_operation_f7",
            "godel_operation_f8",
            "is_inner_model",
            "delta0_formula_absoluteness",
            "relative_consistency_ac_gch",
            "proves_relative_consistency_of_ac_and_gch",
        ]
        for sym in expected_symbols:
            with self.subTest(symbol=sym):
                self.assertTrue(
                    hasattr(foundations, sym),
                    f"Symbol '{sym}' from Ticket 7726 is missing from foundations",
                )
                self.assertTrue(callable(getattr(foundations, sym)))

    def test_ticket_7727_forcing_and_generic_filters_symbols(self):
        """Ticket 7727: verify Forcing Foundations, Posets, and Generic Filters symbols."""
        self.assertTrue(HAS_FOUNDATIONS)
        expected_symbols = [
            "ForcingPoset",
            "mk_poset",
            "compat",
            "is_compatible",
            "incompat",
            "is_incompatible",
            "is_antichain",
            "is_dense",
            "is_dense_below",
            "is_filter",
            "is_generic",
            "is_generic_filter",
            "cohen_poset",
            "mk_name",
            "val_G",
            "evaluate_name",
            "canonical_check_name",
            "generic_name",
            "forces",
            "verify_truth_lemma",
            "proves_forcing_foundations",
        ]
        for sym in expected_symbols:
            with self.subTest(symbol=sym):
                self.assertTrue(
                    hasattr(foundations, sym),
                    f"Symbol '{sym}' from Ticket 7727 is missing from foundations",
                )
                self.assertTrue(callable(getattr(foundations, sym)))

    def test_ticket_7728_independence_of_ch_and_cohen_reals_symbols(self):
        """Ticket 7728: verify Independence of Continuum Hypothesis & Cohen Reals symbols."""
        self.assertTrue(HAS_FOUNDATIONS)
        expected_symbols = [
            "cohen_family_poset",
            "verify_ccc_poset",
            "ccc_preserves_cardinals",
            "cohen_real_name",
            "evaluate_cohen_real",
            "dense_cohen_difference",
            "verify_cohen_reals_distinct",
            "continuum_size_and_neg_ch",
            "relative_consistency_neg_ch",
            "independence_of_continuum_hypothesis",
            "proves_independence_of_ch",
        ]
        for sym in expected_symbols:
            with self.subTest(symbol=sym):
                self.assertTrue(
                    hasattr(foundations, sym),
                    f"Symbol '{sym}' from Ticket 7728 is missing from foundations",
                )
                self.assertTrue(callable(getattr(foundations, sym)))

    def test_ticket_7729_martins_axiom_and_suslin_hypothesis_symbols(self):
        """Ticket 7729: verify Martin's Axiom, Suslin Hypothesis, and c.c.c. Forcing symbols."""
        self.assertTrue(HAS_FOUNDATIONS)
        expected_symbols = [
            "martins_axiom_kappa",
            "suslin_tree",
            "tree_to_forcing_poset",
            "dense_levels_in_tree",
            "ma_derivation_no_suslin_tree",
            "jensen_diamond_implies_neg_sh",
            "relative_consistency_sh",
            "relative_consistency_neg_sh",
            "independence_of_suslin_hypothesis",
            "proves_martins_axiom_and_suslin_hypothesis",
        ]
        for sym in expected_symbols:
            with self.subTest(symbol=sym):
                self.assertTrue(
                    hasattr(foundations, sym),
                    f"Symbol '{sym}' from Ticket 7729 is missing from foundations",
                )
                self.assertTrue(callable(getattr(foundations, sym)))

    def test_ticket_7730_easton_and_levy_collapse_symbols(self):
        """Ticket 7730: verify Easton's Theorem and Levy Collapse symbols."""
        self.assertTrue(HAS_FOUNDATIONS)
        expected_symbols = [
            "is_easton_function",
            "easton_support_product",
            "easton_cofinality_and_cardinal_preservation",
            "relative_consistency_easton",
            "levy_collapse",
            "solovay_model_foundations",
            "proves_easton_and_levy_collapse",
        ]
        for sym in expected_symbols:
            with self.subTest(symbol=sym):
                self.assertTrue(
                    hasattr(foundations, sym),
                    f"Symbol '{sym}' from Ticket 7730 is missing from foundations",
                )
                self.assertTrue(callable(getattr(foundations, sym)))

    def test_ticket_7731_large_cardinals_and_scotts_theorem_symbols(self):
        """Ticket 7731: verify Large Cardinals, Ultrafilters, and Scott's Theorem symbols."""
        self.assertTrue(HAS_FOUNDATIONS)
        expected_symbols = [
            "is_inaccessible_cardinal",
            "is_mahlo_cardinal",
            "is_measurable_cardinal",
            "ultrapower_construction",
            "proves_large_cardinals_and_scotts_theorem",
        ]
        for sym in expected_symbols:
            with self.subTest(symbol=sym):
                self.assertTrue(
                    hasattr(foundations, sym),
                    f"Symbol '{sym}' from Ticket 7731 is missing from foundations",
                )
                self.assertTrue(callable(getattr(foundations, sym)))


if __name__ == '__main__':
    unittest.main()
