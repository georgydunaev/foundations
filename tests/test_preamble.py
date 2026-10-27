# groq/meta-llama/llama-prompt-guard-2-22m (Capability Tier 2)
# Basic test to verify the preamble file
import os
import unittest


class TestPreamble(unittest.TestCase):
    def test_preamble_file_exists(self):
        self.assertTrue(
            os.path.exists('/botworkspace/foundations/000_preamble.tex'),
            "Preamble file does not exist"
        )


if __name__ == "__main__":
    unittest.main()

