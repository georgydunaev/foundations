# groq/meta-llama/llama-prompt-guard-2-22m (Capability Tier 2)
# Test to verify the preamble file content and model declaration
import os
import unittest


class TestPreamble(unittest.TestCase):
    def test_preamble_file_exists(self):
        self.assertTrue(
            os.path.exists('/botworkspace/foundations/000_preamble.tex'),
            "Preamble file does not exist"
        )

    def test_preamble_structure(self):
        """Test that the preamble defines required headers and document class."""
        with open('/botworkspace/foundations/000_preamble.tex', 'r') as f:
            content = f.read()
        self.assertIn(
            '\\def\\MyHeaderIncluded{defined}',
            content,
            "Preamble must define \\MyHeaderIncluded header guard"
        )
        self.assertIn(
            '\\documentclass',
            content,
            "Preamble must define documentclass"
        )
        self.assertIn(
            'biblatex',
            content,
            "Preamble must load biblatex package"
        )


if __name__ == "__main__":
    unittest.main()

