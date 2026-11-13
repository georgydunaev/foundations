# Ticket 7719 — [foundations] Foundations: Dual CakeML and PolyML Portability Compliance for MKTD Foundations
**Importance:** 8/10
**State:** resolved
**Labels:** foundations, cakeml, polyml, sml97, portability, user-directive-16

## Description
Ensure `examples/mktd_foundations.ML` and any supporting SML foundations files strictly adhere to User Directive #16 (Dual CakeML and Poly/ML Compatibility Mandate):
1. Zero raw non-ASCII UTF-8 bytes in SML string literals and source comments (use pure ASCII or standard escapes);
2. Strict SML'97 core compatibility: no compiler-specific non-standard primitives or pragmas in library signatures or structures;
3. Exhaustive pattern matching across all constructors of `class_term` and `fm` in substitution, relativization, and model satisfaction;
4. Poly/ML clean compilation with zero warnings or errors via `poly -q --use examples/mktd_foundations.ML < /dev/null`;
5. Automated test in `tests/test_mktd_foundations.py` validating ASCII purity, syntax, and self-test execution.

## What Has Been Done
- Verified zero raw non-ASCII bytes across `examples/mktd_foundations.ML` using pure ASCII encoding.
- Ensured strict standard SML'97 core compatibility across all constructors and functions.
- Verified clean Poly/ML compilation and passing of all self-tests with zero errors or warnings via `poly -q --use examples/mktd_foundations.ML < /dev/null`.
- Added automated unit test `test_strict_cakeml_polyml_ascii_purity` in `tests/test_mktd_foundations.py` enforcing portability invariants.
