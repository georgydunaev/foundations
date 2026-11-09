#!/usr/bin/env python3
# Test basic arithmetic and logic operations
# mistral/mistral-small-latest (Capability Tier 1)
import unittest

class TestBasic(unittest.TestCase):
    def test_basic_arithmetic(self):
        self.assertEqual(1 + 1, 2)
        self.assertEqual(2 + 3, 5)
        self.assertEqual(10 - 3, 7)
        self.assertEqual(3 * 4, 12)
        self.assertEqual(10 / 2, 5.0)

    def test_comparisons(self):
        self.assertTrue(1 < 2)
        self.assertTrue(2 > 1)
        self.assertTrue(1 == 1)
        self.assertTrue(1 != 2)

    def test_boolean_operations(self):
        self.assertTrue(True and True)
        self.assertTrue(True or False)
        self.assertFalse(False and False)
        self.assertTrue(not False)


if __name__ == '__main__':
    unittest.main()
