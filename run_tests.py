#!/usr/bin/env python3
"""Run the complete foundations unittest suite.

Author: opencode-go/kimi-k3.1-pro (Capability Tier 2).
"""

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parent


def main():
    suite = unittest.defaultTestLoader.discover(
        start_dir=str(ROOT / "tests"),
        top_level_dir=str(ROOT),
    )
    result = unittest.TextTestRunner(verbosity=2).run(suite)
    return 0 if result.wasSuccessful() else 1


if __name__ == "__main__":
    sys.exit(main())
