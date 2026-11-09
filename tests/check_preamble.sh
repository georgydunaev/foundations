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

if ! grep -F -q '\begin{document}' "$TARGET_TEX"; then
  echo "Error: Missing \begin{document} in $TARGET_TEX."
  exit 1
fi

if ! grep -F -q '\end{document}' "$TARGET_TEX"; then
  echo "Error: Missing \end{document} in $TARGET_TEX."
  exit 1
fi

echo "Preamble syntax check passed."

