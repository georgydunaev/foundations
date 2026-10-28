import re

def test_preamble():
    with open('/botworkspace/foundations/latex/000_preamble.tex', 'r') as f:
        content = f.read()
        
        # Check for required packages
        required_packages = ['inputenc', 'fontenc', 'lmodern', 'amsmath', 'amssymb', 'graphicx', 'hyperref']
        for pkg in required_packages:
            if f'\\usepackage{{{pkg}}}' not in content:
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