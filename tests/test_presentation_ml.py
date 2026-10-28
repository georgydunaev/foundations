import unittest
import os

class TestPresentationML(unittest.TestCase):
    def test_documentation_exists(self):
        self.assertTrue(os.path.exists('/botworkspace/foundations/PRESENTATION_ML_GUIDE.md'))

if __name__ == '__main__':
    unittest.main()