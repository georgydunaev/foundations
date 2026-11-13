#!/bin/bash
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_TEX="${1:-$REPO_DIR/tests/test_preamble.tex}"

# Check if the target file exists
if [ ! -f "$TARGET_TEX" ]; then
  echo "Error: Target preamble file does not exist: $TARGET_TEX"
  exit 1
fi

# Check for common LaTeX syntax elements
if ! grep -F -q '\documentclass' "$TARGET_TEX"; then
  echo "Error: Missing \documentclass in $TARGET_TEX."
  exit 1
fi

# A file can be either a complete document or a standalone/modular preamble
if grep -F -q '\begin{document}' "$TARGET_TEX"; then
  if ! grep -F -q '\end{document}' "$TARGET_TEX"; then
    echo "Error: Missing \end{document} in $TARGET_TEX."
    exit 1
  fi
else
  # For pure preambles, check for header guard or packages
  if ! grep -E -q '(\\usepackage|\\ifdefined)' "$TARGET_TEX"; then
    echo "Error: Preamble $TARGET_TEX contains neither document body nor packages/guards."
    exit 1
  fi
fi

echo "Preamble syntax check passed."

