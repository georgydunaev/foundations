#!/bin/bash

# Test script for 000_preamble.tex

# Compile the preamble file
pdflatex -interaction=nonstopmode 000_preamble.tex

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Preamble compilation successful"
    exit 0
else
    echo "Preamble compilation failed"
    exit 1
fi
