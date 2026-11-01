"""Q#17 regression tests for approach organization and preservation.

Author: opencode-go/kimi-k3.1-pro (Capability Tier 2).
"""

from pathlib import Path
import re
import unittest


ROOT = Path(__file__).resolve().parents[1]


def read(name: str) -> str:
    return (ROOT / name).read_text(encoding="utf-8")


class TestActiveApproachDecision(unittest.TestCase):
    def test_book_contains_front_guide_before_main_chapters(self):
        book = read("001_foundations.tex")
        guide = book.index(r"\input{summary_of_approaches.tex}")
        logic = book.index(r"\chapter{Logical framework}")
        self.assertLess(guide, logic)

    def test_active_pair_summary_uses_dunaev_tags(self):
        content = read("010_ordered_pairs.tex")
        self.assertIn(r"(a,b)\ceq(\{0\}\times a)\cup(\{1\}\times b)", content)
        self.assertIn("not the outer Kuratowski construction", content)
        self.assertNotIn(r"Ordered pair: $(x, y) = \{x, y\}$", content)

    def test_active_type_uniqueness_is_explicit(self):
        inventory = read("APPROACHES_INVENTORY.md")
        summary = read("summary_of_approaches.tex")
        for content in (inventory, summary):
            normalized = content.lower()
            self.assertIn("predicates/formulas-as-types", normalized)
            self.assertIn("classes-as-expressions", normalized)
            self.assertIn("uniqueness", normalized)

    def test_no_semantic_switch_is_claimed(self):
        interface = read("050_unified_interface.tex")
        self.assertIn("not a unified semantics", interface)
        self.assertIn("No Semantic Switch", interface)
        self.assertNotIn("modifying the \\\\topic", interface)


class TestHistoricalAlternativePreservation(unittest.TestCase):
    def test_uncertain_descriptor_sources_retain_three_operators(self):
        descriptors = read("020_descriptors.tex")
        self.assertIn(r"$\tau \ceq \tau^\Un$", descriptors)
        self.assertIn(r"$\epsilon \ceq \tau^{\exists!}_\emptyclass = \tau^{\{\emptyclass\}}$", descriptors)
        self.assertIn(r"$\varepsilon \ceq \tau^\emptyclass$", descriptors)
        many_valued = read("180_many-valued.tex")
        self.assertIn(r"I_\Term(\uncert) \coloneqq U", many_valued)
        self.assertIn(r"\begin{comment}", many_valued)

    def test_pfol_source_retains_definedness_and_kleene_equality(self):
        content = read("210_partial_functions_semantics.tex")
        self.assertIn(r"(\iota x,\ \varphi)\downarrow", content)
        self.assertIn(r"(\exists!x,\ \varphi)", content)
        self.assertIn(r"f(x) \simeq", content)

    def test_conglomerate_semantics_source_remains_outdated_and_intact(self):
        content = read("030_alternative_semantics.tex")
        self.assertIn(r"\section{[OUTDATED]Alternative semantics}", content)
        self.assertIn(r"A:\mbox{Var}\to \power(K)", content)
        self.assertIn(r"I^{\mathrm{Fm}}_A(S\downarrow)", content)

    def test_old_type_interpretation_remains_marked_as_rejected(self):
        content = read("130_classes_as_types.tex")
        self.assertIn("no! it ruins uniqueness of a term--type relation!", content)
        self.assertIn("OUTDATED", content)


class TestApproachDocumentation(unittest.TestCase):
    def test_inventory_covers_the_exact_five_approaches(self):
        content = read("APPROACHES_INVENTORY.md")
        headings = (
            "## 1. Classical Two-Valued MK + Total Comprehension Evaluation",
            "## 2. Predicates/Formulas-as-Types, Classes-as-Expressions",
            "## 3. Three-Valued / Uncertain Descriptor Calculus",
            "## 4. Farmer's Partial First-Order Logic (PFOL)",
            "## 5. Conglomerate-Valued / Subset Semantics",
        )
        for heading in headings:
            with self.subTest(heading=heading):
                self.assertEqual(content.count(heading), 1)
        self.assertEqual(content.count("**Status:** preserved alternative"), 2)
        self.assertIn("**Status:** preserved `[OUTDATED]` alternative", content)

    def test_rejected_unification_drafts_are_non_normative(self):
        for name in ("025_unified_descriptors.tex", "035_unified_type_semantics.tex"):
            with self.subTest(name=name):
                content = read(name)
                self.assertIn("[OUTDATED]", content)
                self.assertIn("non-normative", content)
                self.assertNotIn("configuration parameter", content.split("Independent Alternatives")[0])
        self.assertNotIn("A general descriptor is a tuple", read("025_unified_descriptors.tex"))

    def test_navigation_tex_has_no_literal_newline_escape_artifacts(self):
        names = (
            "010_ordered_pairs.tex",
            "025_unified_descriptors.tex",
            "035_unified_type_semantics.tex",
            "040_partial_functions.tex",
            "050_descriptor_systems.tex",
            "050_unified_interface.tex",
            "summary_of_approaches.tex",
        )
        for name in names:
            with self.subTest(name=name):
                self.assertIsNone(re.search(r"\\n(?![A-Za-z])", read(name)))

    def test_secondary_class_abstraction_draft_does_not_assert_sethood(self):
        content = read("050_descriptor_systems.tex")
        self.assertIn("not\nautomatically a set", content)
        self.assertIn("no\nset or class of all classes", content)

    def test_readme_uses_real_many_valued_filename_and_alternative_statuses(self):
        content = read("README.md")
        self.assertIn("180_many-valued.tex", content)
        self.assertNotIn("180_many_valued.tex", content)
        self.assertIn("*(Preserved Alternative 3)*", content)
        self.assertIn("*(Preserved Alternative 4)*", content)
        self.assertIn("**[OUTDATED] Preserved Alternative 5**", content)


if __name__ == "__main__":
    unittest.main()
