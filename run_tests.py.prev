import unittest
import sys

if __name__ == '__main__':
    # Change to tests directory to avoid module conflicts with top-level test files
    original_dir = __import__('sys').path[0]
    try:
        __import__('sys').path[0] = '/botworkspace/foundations/tests'
        test_loader = unittest.TestLoader()
        test_suite = test_loader.discover('.', pattern='test_*.py')
        test_runner = unittest.TextTestRunner(verbosity=2)
        test_runner.run(test_suite)
    finally:
        __import__('sys').path[0] = original_dir
