#!/bin/bash

# Test LaTeX syntax for all .tex files in the project

# Find all .tex files and check syntax with pdflatex
find . -name "*.tex" -exec pdflatex -interaction=nonstopmode {} \;

# Check the exit status of pdflatex
exit_status=$?

if [ $exit_status -eq 0 ]; then
    echo "All LaTeX files have valid syntax."
else
    echo "Some LaTeX files have syntax errors."
    exit $exit_status
fi


# Find all .tex files and check syntax with latexmk
find . -name "*.tex" -exec latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" {} \;

# Check the exit status of latexmk
exit_status=$?

if [ $exit_status -eq 0 ]; then
    echo "All LaTeX files have valid syntax."
else
    echo "Some LaTeX files have syntax errors."
    exit $exit_status
fi
