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

    def test_model_declaration(self):
        """Test that the model declaration is correct."""
        with open('/botworkspace/foundations/000_preamble.tex', 'r') as f:
            content = f.read()
        self.assertIn(
            'openrouter/nvidia/nemotron-3.5-lightning:free (Capability Tier 1)',
            content,
            "Model declaration must declare openrouter/nvidia/nemotron-3.5-lightning:free"
        )

    def test_author_declaration(self):
        """Test that the author declaration references the correct model."""
        with open('/botworkspace/foundations/000_preamble.tex', 'r') as f:
            content = f.read()
        self.assertIn(
            'openrouter/nvidia/nemotron-3.5-lightning:free',
            content,
            "Author declaration must reference openrouter/nvidia/nemotron-3.5-lightning:free"
        )


if __name__ == "__main__":
    unittest.main()

