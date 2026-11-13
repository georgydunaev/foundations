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


if __name__ == '__main__':
    unittest.main()
