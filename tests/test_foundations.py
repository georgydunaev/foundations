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


if __name__ == '__main__':
    unittest.main()
