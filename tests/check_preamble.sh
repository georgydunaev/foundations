#!/bin/bash

# Check if the preamble file exists
if [ ! -f "/botworkspace/foundations/000_preamble.tex" ]; then
  echo "Error: Preamble file does not exist."
  exit 1
fi

# Check for common LaTeX syntax errors
if ! grep -q "\\documentclass" "/botworkspace/foundations/000_preamble.tex"; then
  echo "Error: Missing \\documentclass."
  exit 1
fi

if ! grep -q "\\begin{document}" "/botworkspace/foundations/000_preamble.tex"; then
  echo "Error: Missing \\begin{document}. File content: $(cat /botworkspace/foundations/000_preamble.tex)"
  exit 1
fi

if ! grep -q "\\end{document}" "/botworkspace/foundations/000_preamble.tex"; then
  echo "Error: Missing \\end{document}. File content: $(cat /botworkspace/foundations/000_preamble.tex)"
  exit 1
fi

echo "Preamble syntax check passed."
