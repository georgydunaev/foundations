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
        try:
            import foundations
            self.assertTrue(True)
        except ImportError:
            self.assertTrue(False)

    def test_module_has_init(self):
        self.assertIsNotNone(foundations.__init__)

    def test_all_is_list(self):
        if HAS_FOUNDATIONS:
            self.assertIsInstance(foundations.__all__, list)


if __name__ == '__main__':
    unittest.main()
