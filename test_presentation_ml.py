import unittest

class TestPresentationML(unittest.TestCase):
    def test_documentation(self):
        # Check if the documentation file exists
        with open('/botworkspace/foundations/PRESENTATION_ML_GUIDE.md', 'r') as f:
            content = f.read()
        self.assertIn("## Overview", content)
        self.assertIn("## Constructors of Terms and Formulas", content)
        self.assertIn("## Complexity Annotations", content)
        self.assertIn("## Definitions", content)
        self.assertIn("## Dunaev Tagged Pairs", content)
        self.assertIn("## Conclusion", content)

    def test_original_file(self):
        # Check if the original file is unchanged
        with open('/botworkspace/foundations/presentation.ML', 'r') as f:
            original_content = f.read()
        self.assertIn("* File: presentation.ML", original_content)
        self.assertIn("Morse-Kelley class theory + Tarski's axiom", original_content)

if __name__ == '__main__':
    unittest.main()