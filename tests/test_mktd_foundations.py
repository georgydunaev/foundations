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
        self.assertIn("russell_class", content)
        self.assertIn("prove_russell_is_proper_class", content)
        self.assertIn("prove_separation", content)
        self.assertIn("prove_dunaev_pair_injectivity", content)
        self.assertIn("axiom_class_comprehension", content)
        self.assertIn("prove_tau_spec", content)
        self.assertIn("prove_iota_spec", content)
        self.assertIn("prove_epsilon_empty", content)
        self.assertIn("eval_tau", content)
        self.assertIn("eval_iota", content)
        self.assertIn("eval_unique_choice", content)
        self.assertIn("prove_transfinite_induction", content)
        self.assertIn("prove_transfinite_recursion", content)
        self.assertIn("eval_transfinite_recursion", content)
        self.assertIn("cat_pairing_morphism", content)
        self.assertIn("cat_equalizer", content)
        self.assertIn("cat_subobject_comprehension", content)
        self.assertIn("prove_categorical_product", content)
        self.assertIn("relativize", content)
        self.assertIn("eval_sat", content)
        self.assertIn("axiom_tarski_truth", content)
        self.assertIn("axiom_relativization", content)
        self.assertIn("prove_tarski_truth", content)
        self.assertIn("eval_cumulative_level", content)
        self.assertIn("eval_reflects", content)
        self.assertIn("axiom_reflection_schema", content)
        self.assertIn("prove_reflection_schema", content)
        self.assertIn("cat_functor", content)
        self.assertIn("natural_trans", content)
        self.assertIn("cat_identity_functor", content)
        self.assertIn("cat_comp_functors", content)
        self.assertIn("check_naturality", content)
        self.assertIn("cat_dunaev_coprod", content)
        self.assertIn("cat_copairing_morphism", content)
        self.assertIn("cat_pullback_eval", content)
        self.assertIn("cat_pullback_cone_morphism", content)
        self.assertIn("cat_pushout_eval", content)
        self.assertIn("cat_slice_obj", content)
        self.assertIn("cat_slice_morphism_p", content)
        self.assertIn("cat_slice_product", content)
        self.assertIn("axiom_pullback_square", content)
        self.assertIn("axiom_pushout_square", content)
        self.assertIn("axiom_equalizer_pullback_duality", content)
        self.assertIn("axiom_slice_product_pullback", content)
        self.assertIn("axiom_limit_colimit_duality", content)
        self.assertIn("prove_pullback_square", content)
        self.assertIn("prove_pushout_square", content)
        self.assertIn("prove_equalizer_pullback_duality", content)
        self.assertIn("prove_slice_product_pullback", content)
        self.assertIn("prove_limit_colimit_duality", content)
        self.assertIn("mk_hartogs", content)
        self.assertIn("eval_hartogs_finite", content)
        self.assertIn("check_injection_exists", content)
        self.assertIn("axiom_hartogs", content)
        self.assertIn("prove_hartogs", content)
        self.assertIn("scotts_trick_eval", content)
        self.assertIn("axiom_scotts_trick", content)
        self.assertIn("prove_scotts_trick", content)
        self.assertIn("eval_cardinal_size", content)
        self.assertIn("check_limitation_of_size", content)
        self.assertIn("axiom_limitation_of_size", content)
        self.assertIn("prove_limitation_of_size", content)
        self.assertIn("axiom_limitation_of_size_cardinal", content)
        self.assertIn("prove_limitation_of_size_cardinal", content)
        self.assertIn("eval_ord_add", content)
        self.assertIn("eval_ord_mult", content)
        self.assertIn("eval_ord_exp", content)
        self.assertIn("axiom_ord_add_zero", content)
        self.assertIn("axiom_ord_add_succ", content)
        self.assertIn("axiom_ord_mult_zero", content)
        self.assertIn("axiom_ord_mult_succ", content)
        self.assertIn("axiom_ord_exp_zero", content)
        self.assertIn("axiom_ord_exp_succ", content)
        self.assertIn("prove_ord_add_zero", content)
        self.assertIn("prove_ord_add_succ", content)
        self.assertIn("prove_ord_mult_zero", content)
        self.assertIn("prove_ord_mult_succ", content)
        self.assertIn("prove_ord_exp_zero", content)
        self.assertIn("prove_ord_exp_succ", content)
        self.assertIn("prove_ord_addition_noncommutative", content)
        self.assertIn("prove_ord_multiplication_noncommutative", content)

        # Grothendieck Universes, Inaccessible Cardinals, and Internalized Satisfaction
        self.assertIn("axiom_grothendieck_universe", content)
        self.assertIn("prove_grothendieck_universe", content)
        self.assertIn("axiom_inaccessible_universe", content)
        self.assertIn("prove_inaccessible_universe", content)
        self.assertIn("axiom_inaccessible_models_zfc", content)
        self.assertIn("prove_inaccessible_models_zfc", content)
        self.assertIn("axiom_level_reflection", content)
        self.assertIn("prove_level_reflection", content)
        self.assertIn("axiom_internalized_satisfaction", content)
        self.assertIn("prove_internalized_satisfaction", content)
        self.assertIn("eval_is_transitive", content)
        self.assertIn("eval_is_grothendieck", content)
        self.assertIn("eval_internalized_sat", content)

        # Godel Constructible Hierarchy L_alpha, Def(X), and Delta_0 Absoluteness
        self.assertIn("DefPowerset", content)
        self.assertIn("LAlpha", content)
        self.assertIn("LUniv", content)
        self.assertIn("check_is_delta0", content)
        self.assertIn("eval_def_powerset", content)
        self.assertIn("eval_l_stage", content)
        self.assertIn("eval_is_constructible", content)
        self.assertIn("eval_delta0_satisfaction", content)
        self.assertIn("eval_delta0_absoluteness", content)
        self.assertIn("axiom_def_powerset", content)
        self.assertIn("prove_def_powerset", content)
        self.assertIn("axiom_l_zero", content)
        self.assertIn("prove_l_zero", content)
        self.assertIn("axiom_l_succ", content)
        self.assertIn("prove_l_succ", content)
        self.assertIn("axiom_l_limit", content)
        self.assertIn("prove_l_limit", content)
        self.assertIn("axiom_is_constructible", content)
        self.assertIn("prove_is_constructible", content)
        self.assertIn("axiom_v_equals_l", content)
        self.assertIn("prove_v_equals_l", content)
        self.assertIn("axiom_delta0_absoluteness", content)
        self.assertIn("prove_delta0_absoluteness", content)
        self.assertIn("axiom_l_models_zfc", content)
        self.assertIn("prove_l_models_zfc", content)
        self.assertIn("prove_pairing_delta0_absolute", content)
        self.assertIn("prove_union_delta0_absolute", content)
        self.assertIn("prove_empty_set_delta0_absolute", content)
        self.assertIn("prove_bounded_quant_delta0_absolute", content)

        # Canonical Well-Ordering of L, AC in L (L |= AC), and Condensation Scaffolding
        self.assertIn("LWellOrder", content)
        self.assertIn("GodelCode", content)
        self.assertIn("ElemSubmodel", content)
        self.assertIn("TransCollapse", content)
        self.assertIn("ChoiceFnL", content)
        self.assertIn("IsWellOrdered", content)
        self.assertIn("LWellOrders", content)
        self.assertIn("AxiomChoiceL", content)
        self.assertIn("ElemSubmodelFm", content)
        self.assertIn("ExtensionalRel", content)
        self.assertIn("TransCollapseFm", content)
        self.assertIn("CondensationScaffold", content)
        self.assertIn("godel_number_fm", content)
        self.assertIn("eval_canonical_well_ordering_l", content)
        self.assertIn("check_is_well_ordered", content)
        self.assertIn("eval_l_choice", content)
        self.assertIn("eval_tarski_vaught", content)
        self.assertIn("eval_mostowski_collapse", content)
        self.assertIn("axiom_canonical_well_order", content)
        self.assertIn("prove_canonical_well_order", content)
        self.assertIn("axiom_well_ordering_l", content)
        self.assertIn("prove_well_ordering_l", content)
        self.assertIn("axiom_l_models_ac", content)
        self.assertIn("prove_l_models_ac", content)
        self.assertIn("axiom_tarski_vaught_criterion", content)
        self.assertIn("prove_tarski_vaught_criterion", content)
        self.assertIn("axiom_mostowski_collapse", content)
        self.assertIn("prove_mostowski_collapse", content)
        self.assertIn("axiom_condensation_scaffold", content)
        self.assertIn("prove_condensation_scaffold", content)

    def test_strict_cakeml_polyml_ascii_purity(self):
        """User Directive #16: Zero raw non-ASCII bytes in SML code for CakeML/PolyML portability."""
        raw_bytes = MKTD_ML.read_bytes()
        non_ascii = [b for b in raw_bytes if b >= 128]
        self.assertEqual(
            len(non_ascii),
            0,
            f"Found {len(non_ascii)} non-ASCII bytes in {MKTD_ML}, violating CakeML/PolyML portability",
        )

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
