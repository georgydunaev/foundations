# Automated Test Suite
#
# This test suite validates the foundations of mathematics codebase,
# covering implementations, module integrity, and LaTeX macro consistency.

import sys
import unittest
import pathlib

REPO_DIR = pathlib.Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_DIR))

from tests.test_foundations import TestFoundations
from tests.test_basic import TestBasic


class TestSuite(unittest.TestCase):
    def test_foundations_module(self):
        """Test the foundations module can be imported."""
        found_tests = TestFoundations()
        found_tests.test_imports()
        found_tests.test_module_has_init()
        found_tests.test_all_is_list()

    def test_basic_arithmetic(self):
        """Test basic arithmetic operations."""
        basic_tests = TestBasic()
        basic_tests.test_basic_arithmetic()
        basic_tests.test_comparisons()
        basic_tests.test_boolean_operations()


if __name__ == '__main__':
    unittest.main()
