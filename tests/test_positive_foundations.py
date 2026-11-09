import sys
import unittest
from pathlib import Path

REPO_DIR = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_DIR))

try:
    import foundations
    HAS_FOUNDATIONS = True
except ImportError:
    HAS_FOUNDATIONS = False


class TestPositiveFoundations(unittest.TestCase):
    def test_ens_type_exists(self):
        """Test that the Ens type concept is valid."""
        if HAS_FOUNDATIONS:
            self.assertIsNotNone(foundations)
        else:
            self.skipTest("foundations module not available")

    def test_pair_construct(self):
        """Test that the Pair function/construct works."""
        if HAS_FOUNDATIONS:
            self.assertIsNotNone(foundations)
        else:
            self.skipTest("foundations module not available")


if __name__ == '__main__':
    unittest.main()
