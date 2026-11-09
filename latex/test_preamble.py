from pathlib import Path
import re

LATEX_DIR = Path(__file__).resolve().parent
PREAMBLE_PATH = LATEX_DIR / "000_preamble.tex"

def test_preamble():
    with open(PREAMBLE_PATH, 'r', encoding='utf-8') as f:
        content = f.read()

        # Check for required packages
        required_packages = ['inputenc', 'fontenc', 'lmodern', 'amsmath', 'amssymb', 'graphicx', 'hyperref']
        for pkg in required_packages:
            pattern = r'\\usepackage(?:\[[^\]]*\])?\{' + re.escape(pkg) + r'\}'
            if not re.search(pattern, content):
                return False

        # Check for document structure
        if '\\begin{document}' not in content or '\\end{document}' not in content:
            return False

        return True

if __name__ == '__main__':
    if test_preamble():
        print('Preamble test passed')
    else:
        print('Preamble test failed')
