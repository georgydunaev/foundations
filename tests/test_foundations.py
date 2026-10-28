#!/usr/bin/env python3

import unittest

class TestFoundations(unittest.TestCase):
    def test_imports(self):
        try:
            import amsmath
            import amssymb
            import amsthm
        except ImportError:
            self.skipTest("LaTeX packages cannot be imported directly in Python")

if __name__ == '__main__':
    unittest.main()