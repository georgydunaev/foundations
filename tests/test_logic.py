#!/usr/bin/env python3
"""Tests for Foundations Logic, Binder Hygiene, and Reflection Scope.

Audits and resolves:
1. obelisk_uniqueness_binder_hygiene.md
2. obelisk_logic_verification_status.md
3. obelisk_logic_reflection_scope.md
"""

from pathlib import Path
import sys
import unittest

REPO_DIR = Path(__file__).resolve().parent.parent
if str(REPO_DIR) not in sys.path:
    sys.path.insert(0, str(REPO_DIR))

import foundations
from foundations.logic import (
    And,
    AtMostOne,
    BinderHygieneError,
    DerivabilityConditions,
    DerivationStep,
    Eq,
    Exists,
    ExistsUnique,
    FalseFm,
    Forall,
    FormulaConstructor,
    Iff,
    Imp,
    In,
    Neq,
    Not,
    Pred,
    ProofCertificate,
    ProofConstructor,
    ProofVerificationError,
    ReflectionScopeError,
    Term,
    TheoremLevel,
    TheoryLevel,
    TheorySpecification,
    TrueFm,
    Var,
    all_variables,
    apply_meta_conecessitation,
    are_alpha_equivalent,
    bound_variables,
    build_loeb_certificate,
    build_second_incompleteness_certificate,
    check_reflection_soundness,
    check_uniqueness_hygiene,
    eval_at_most_one_predicate,
    eval_exists_unique_predicate,
    eval_formula,
    expand_at_most_one,
    free_variables,
    fresh_variable,
    fresh_variable_pair,
    get_standard_theories,
    naive_expand_at_most_one,
    proves_foundations_logic_and_binder_hygiene,
    substitute_formula,
    validate_soundness_axiom_scope,
    verify_proof_certificate,
    VerificationStatus,
)


class TestUniquenessBinderHygiene(unittest.TestCase):
    """Ticket: obelisk_uniqueness_binder_hygiene.md."""

    def test_free_and_bound_variables(self):
        phi = Neq(Var("z"), Var("x"))
        self.assertEqual(free_variables(phi), {"z", "x"})
        self.assertEqual(bound_variables(phi), set())

        binder = AtMostOne("z", phi)
        self.assertEqual(free_variables(binder), {"x"})
        self.assertEqual(bound_variables(binder), {"z"})

    def test_fresh_variable_generator(self):
        forbidden = {"x", "y", "z", "y1"}
        v = fresh_variable("y", forbidden)
        self.assertNotIn(v, forbidden)
        self.assertEqual(v, "y2")

        v1, v2 = fresh_variable_pair("x", "y", {"x", "y"})
        self.assertNotEqual(v1, v2)
        self.assertNotIn(v1, {"x", "y"})
        self.assertNotIn(v2, {"x", "y"})

    def test_capture_avoiding_substitution(self):
        # forall y. (x = y) with substitution [y / x] must rename y to avoid capture
        fm = Forall("y", Eq(Var("x"), Var("y")))
        sub = substitute_formula(fm, "x", Var("y"))
        self.assertIsInstance(sub, Forall)
        self.assertNotEqual(sub.var, "y")
        self.assertIn("y", sub.free_vars())

    def test_hygiene_checker(self):
        phi = Neq(Var("z"), Var("x"))
        # Using x as an introduced variable should be rejected because x is free in phi
        ok_x, msg_x = check_uniqueness_hygiene(phi, "z", "x", "y")
        self.assertFalse(ok_x)
        self.assertIn("free in phi", msg_x)

        # Using non-distinct variables should be rejected
        ok_dup, msg_dup = check_uniqueness_hygiene(phi, "z", "u", "u")
        self.assertFalse(ok_dup)
        self.assertIn("must be distinct", msg_dup)

        # Fresh distinct variables should pass
        ok_fresh, msg_fresh = check_uniqueness_hygiene(phi, "z", "u", "v")
        self.assertTrue(ok_fresh)
        self.assertIn("passed", msg_fresh)

    def test_preservation_of_free_parameter_after_expansion(self):
        # Formula phi(z) := z != x, containing free parameter x
        phi = Neq(Var("z"), Var("x"))
        expanded = expand_at_most_one(phi, "z")

        # Acceptance check 1: parameter 'x' is preserved as free
        self.assertIn("x", expanded.free_vars())
        self.assertNotIn("x", expanded.bound_vars())

    def test_three_object_structure_evaluation(self):
        """Acceptance check 2: !z. z != x in a 3-object structure.

        Domain = {a, b, c}, x = a.
        z != a holds for b and c (2 witnesses).
        Therefore !z. z != a must evaluate to False.
        """
        domain = ["a", "b", "c"]
        env = {"x": "a"}
        phi = Neq(Var("z"), Var("x"))
        fm_at_most_one = AtMostOne("z", phi)

        # Direct evaluation
        direct_result = eval_formula(fm_at_most_one, domain, env)
        self.assertFalse(direct_result)

        # Hygienic expansion
        hygienic_expanded = expand_at_most_one(phi, "z")
        hygienic_result = eval_formula(hygienic_expanded, domain, env)
        self.assertFalse(hygienic_result)
        self.assertEqual(direct_result, hygienic_result)

        # Naive expansion (variable capture bug):
        # forall x forall y. ((x != x /\ y != x) -> x = y)
        # x != x is False, so antecedent is False, making implication vacuously True!
        naive_expanded = naive_expand_at_most_one(phi, "z", fixed_x="x", fixed_y="y")
        naive_result = eval_formula(naive_expanded, domain, env)
        self.assertTrue(naive_result, "Naive expansion must exhibit the variable capture bug (unsound True)")

    def test_alpha_equivalence_invariance(self):
        """Acceptance check 3: expansion is invariant under alpha-renaming."""
        phi = Neq(Var("z"), Var("x"))
        exp1 = expand_at_most_one(phi, "z", introduced_var1="u", introduced_var2="v")
        exp2 = expand_at_most_one(phi, "z", introduced_var1="w1", introduced_var2="w2")
        self.assertTrue(are_alpha_equivalent(exp1, exp2))

    def test_predicate_witness_counts(self):
        """Acceptance check 4: empty and singleton satisfy !; 2 witnesses do not."""
        domain = [1, 2, 3, 4]
        # Empty predicate (0 witnesses)
        self.assertTrue(eval_at_most_one_predicate(lambda w: False, domain))
        # Singleton predicate (1 witness)
        self.assertTrue(eval_at_most_one_predicate(lambda w: w == 2, domain))
        # Two witnesses
        self.assertFalse(eval_at_most_one_predicate(lambda w: w in (1, 2), domain))
        # Three witnesses
        self.assertFalse(eval_at_most_one_predicate(lambda w: w in (1, 2, 3), domain))

    def test_distinction_at_most_one_vs_exists_unique(self):
        """Acceptance check 5: distinction from exists!."""
        domain = ["alpha", "beta"]
        # Empty predicate: satisfies ! (at most one), but NOT exists! (exists and unique)
        empty_pred = lambda w: False
        self.assertTrue(eval_at_most_one_predicate(empty_pred, domain))
        self.assertFalse(eval_exists_unique_predicate(empty_pred, domain))

        # Singleton predicate: satisfies both
        singleton_pred = lambda w: w == "alpha"
        self.assertTrue(eval_at_most_one_predicate(singleton_pred, domain))
        self.assertTrue(eval_exists_unique_predicate(singleton_pred, domain))

    def test_expand_at_most_one_rejects_hygiene_violations(self):
        phi = Neq(Var("z"), Var("x"))
        with self.assertRaises(BinderHygieneError):
            expand_at_most_one(phi, "z", introduced_var1="x", introduced_var2="y")
        with self.assertRaises(BinderHygieneError):
            expand_at_most_one(phi, "z", introduced_var1="u", introduced_var2="u")


class TestLogicVerificationStatus(unittest.TestCase):
    """Ticket: obelisk_logic_verification_status.md."""

    def test_tpholds_alone_cannot_earn_verified_status(self):
        """Acceptance check: constructing a TpHolds formula alone is Stated (WIP)."""
        wip_cert = build_loeb_certificate(as_wip_only=True)
        status, msg = verify_proof_certificate(wip_cert)
        self.assertEqual(status, VerificationStatus.STATED_WIP)
        self.assertIn("TpHolds is a formula constructor", msg)

    def test_verified_loeb_theorem_derivation(self):
        """Acceptance check: checked derivation yields Verified (Kernel)."""
        verified_cert = build_loeb_certificate(valid=True, as_wip_only=False)
        status, msg = verify_proof_certificate(verified_cert)
        self.assertEqual(status, VerificationStatus.VERIFIED_KERNEL)
        self.assertIn("verified", msg.lower())

    def test_corrupted_derivation_revokes_verified_status(self):
        """Acceptance check: corrupting a derivation prevents verified status."""
        corrupted_cert = build_loeb_certificate(valid=False, as_wip_only=False)
        status, msg = verify_proof_certificate(corrupted_cert)
        self.assertEqual(status, VerificationStatus.UNVERIFIED)

    def test_second_incompleteness_derivation(self):
        """Acceptance check: second incompleteness derivation verified."""
        cert = build_second_incompleteness_certificate(valid=True, as_wip_only=False)
        status, msg = verify_proof_certificate(cert)
        self.assertEqual(status, VerificationStatus.VERIFIED_KERNEL)

        # Corrupted target formula
        cert_corrupt = build_second_incompleteness_certificate(valid=False, as_wip_only=False)
        status_c, _ = verify_proof_certificate(cert_corrupt)
        self.assertEqual(status_c, VerificationStatus.UNVERIFIED)

    def test_derivability_conditions_requirement(self):
        """Acceptance check: D1-D3 and diagonal lemma must hold."""
        conds = DerivabilityConditions(d1_necessitation=False)
        self.assertFalse(conds.satisfies_lob_hypotheses())

        cert = build_loeb_certificate(valid=True, as_wip_only=False)
        cert.derivability_conditions = conds
        status, msg = verify_proof_certificate(cert)
        self.assertEqual(status, VerificationStatus.UNVERIFIED)
        self.assertIn("Derivability conditions", msg)

    def test_theorem_level_distinctions(self):
        """Acceptance check: distinguish external theorem, internal implication, and consistency premise."""
        self.assertIn("External Theorem", TheoremLevel.EXTERNAL_RULE.value)
        self.assertIn("Internal Formalized", TheoremLevel.INTERNAL_FORMALIZED.value)
        self.assertIn("Assumed Consistency", TheoremLevel.ASSUMED_CONSISTENCY.value)


class TestLogicReflectionScope(unittest.TestCase):
    """Ticket: obelisk_logic_reflection_scope.md."""

    def test_theory_stratification_and_schematic_wau(self):
        theories = get_standard_theories()
        self.assertEqual(theories["Tau"].level, TheoryLevel.TAU)
        self.assertEqual(theories["Fau"].level, TheoryLevel.FAU)
        self.assertEqual(theories["Qau"].level, TheoryLevel.QAU)
        self.assertEqual(theories["Wau"].level, TheoryLevel.WAU)
        self.assertTrue(theories["Wau"].is_schematic)
        self.assertFalse(theories["Tau"].is_schematic)

    def test_soundness_axiom_scope(self):
        """Acceptance check: AxmSoundnessOfBaseTheory cannot reside in T itself."""
        # Soundness asserted in external metatheory / Fau is sound
        ok_ext, _ = validate_soundness_axiom_scope("Fau", "Tau")
        self.assertTrue(ok_ext)

        # Soundness asserted inside Tau itself is rejected
        ok_int, msg_int = validate_soundness_axiom_scope("Tau", "Tau")
        self.assertFalse(ok_int)
        self.assertIn("Lob obstruction", msg_int)

    def test_meta_conecessitation_preserves_gamma_and_requires_empty_outer_context(self):
        """Acceptance check: DefMetaConecessitation (4.03).

        F, [] |- <F, Gamma |- phi>  ==>  F, Gamma |- phi.
        """
        inner_gamma = ["Hyp1", "Hyp2"]
        theory, ctx, fm = apply_meta_conecessitation(
            outer_theory="Fau",
            outer_context=[],
            inner_theory="Fau",
            inner_context=inner_gamma,
            formula_str="phi",
        )
        self.assertEqual(theory, "Fau")
        self.assertEqual(ctx, ["Hyp1", "Hyp2"])
        self.assertEqual(fm, "phi")

        # Non-empty outer context must be rejected
        with self.assertRaises(ReflectionScopeError):
            apply_meta_conecessitation(
                outer_theory="Fau",
                outer_context=["OuterHyp"],
                inner_theory="Fau",
                inner_context=inner_gamma,
                formula_str="phi",
            )

    def test_syntactic_self_provability_admitted(self):
        """Acceptance check: syntactic self-provability Pr_T (E = T) is admitted."""
        admitted, msg = check_reflection_soundness(
            target_theory="Tau",
            ambient_theory="Tau",
            formula_str="phi",
            is_syntactic_provability=True,
            is_provable_in_target=False,
        )
        self.assertTrue(admitted)
        self.assertIn("Syntactic provability", msg)

    def test_semantic_self_reflection_rejected_by_loeb_obstruction(self):
        """Acceptance check: negative tests reject unjustified internal self-truth reflection."""
        # Unprovable formula cannot have internal self-reflection Box_T phi -> phi in T
        admitted, msg = check_reflection_soundness(
            target_theory="Tau",
            ambient_theory="Tau",
            formula_str="UnprovableConjecture",
            is_syntactic_provability=False,
            is_provable_in_target=False,
        )
        self.assertFalse(admitted)
        self.assertIn("Lob obstruction", msg)

        # But if formula is already provable in T, Box phi -> phi holds trivially
        admitted_provable, _ = check_reflection_soundness(
            target_theory="Tau",
            ambient_theory="Tau",
            formula_str="ProvedTheorem",
            is_syntactic_provability=False,
            is_provable_in_target=True,
        )
        self.assertTrue(admitted_provable)

    def test_master_auditor_runner(self):
        """Acceptance check: master auditor runner executes all checks cleanly."""
        res = proves_foundations_logic_and_binder_hygiene()
        self.assertEqual(res["ticket_uniqueness_binder_hygiene"]["status"], "RESOLVED")
        self.assertEqual(res["ticket_logic_verification_status"]["status"], "RESOLVED")
        self.assertEqual(res["ticket_logic_reflection_scope"]["status"], "RESOLVED")
        self.assertEqual(res["ticket_logic_context_freshness"]["status"], "RESOLVED")
        self.assertEqual(res["ticket_logic_completeness"]["status"], "RESOLVED")


class TestContextFreshnessAndCompleteness(unittest.TestCase):
    """Tickets: obelisk_logic_context_freshness.md and obelisk_logic_completeness.md."""

    def test_ctx_ifv_quantifier_hygiene(self):
        from foundations.logic import (
            check_exists_left_rule,
            check_forall_right_rule,
            eval_ctx_ifv,
            eval_ctx_ifv_quantifier_hygiene,
            eval_fm_ifv,
        )

        gamma_with_x = [Eq(Var("x"), Var("a"))]
        gamma_without_x = [Eq(Var("y"), Var("a"))]
        self.assertTrue(eval_fm_ifv("x", gamma_with_x[0]))
        self.assertTrue(eval_ctx_ifv("x", gamma_with_x))
        self.assertFalse(eval_ctx_ifv("x", gamma_without_x))

        ok_fora_fresh, _ = check_forall_right_rule("x", gamma_without_x, Eq(Var("x"), Var("x")))
        self.assertTrue(ok_fora_fresh)
        ok_fora_captured, _ = check_forall_right_rule("x", gamma_with_x, Eq(Var("x"), Var("a")))
        self.assertFalse(ok_fora_captured)

        ok_exis_fresh, _ = check_exists_left_rule("x", gamma_without_x, FalseFm())
        self.assertTrue(ok_exis_fresh)
        ok_exis_ctx_captured, _ = check_exists_left_rule("x", gamma_with_x, FalseFm())
        self.assertFalse(ok_exis_ctx_captured)
        ok_exis_psi_captured, _ = check_exists_left_rule("x", gamma_without_x, Eq(Var("x"), Var("b")))
        self.assertFalse(ok_exis_psi_captured)

        res = eval_ctx_ifv_quantifier_hygiene()
        self.assertEqual(res["status"], "RESOLVED")
        self.assertTrue(res["fora_r_sound_when_fresh"])
        self.assertTrue(res["fora_r_rejected_when_ctx_ifv"])
        self.assertTrue(res["fora_r_counterexample_premise_valid"])
        self.assertTrue(res["fora_r_counterexample_conclusion_invalid"])
        self.assertTrue(res["exis_l_sound_when_fresh"])
        self.assertTrue(res["exis_l_rejected_when_ctx_ifv"])
        self.assertTrue(res["exis_l_rejected_when_fm_ifv_in_psi"])

    def test_semantic_vs_negation_completeness_374(self):
        from foundations.logic import eval_semantic_vs_negation_completeness

        res = eval_semantic_vs_negation_completeness()
        self.assertEqual(res["status"], "RESOLVED")
        self.assertEqual(res["item_id"], "3.74")
        self.assertTrue(res["tau_is_recursively_enumerable"])
        self.assertFalse(res["fau_is_recursively_enumerable"])
        self.assertFalse(res["tau_syntactic_negation_complete"])
        self.assertFalse(res["tau_semantic_completeness_holds"])
        self.assertTrue(res["fau_syntactic_negation_complete"])
        self.assertTrue(res["fau_consistent"])
        self.assertTrue(res["fau_semantic_completeness_holds"])
        self.assertTrue(res["fau_semantic_biconditional_holds"])


if __name__ == "__main__":
    unittest.main()
