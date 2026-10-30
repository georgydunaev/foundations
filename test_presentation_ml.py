"""Compatibility entry point for the canonical tests in tests/.

Documentation update: opencode-go/kimi-k3.1-pro (Capability Tier 3).
"""

import unittest

from tests.test_presentation_ml import TestPresentationML


__all__ = ["TestPresentationML"]


if __name__ == "__main__":
    unittest.main()
