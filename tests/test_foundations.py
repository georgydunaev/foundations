import unittest

class TestFoundations(unittest.TestCase):
    def test_imports(self):
        try:
            import foundations
            self.assertTrue(True)
        except ImportError:
            self.assertTrue(False)

if __name__ == '__main__':
    unittest.main()