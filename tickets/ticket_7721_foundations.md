# Ticket 7721 — [foundations] Foundations: Hartogs Number, Scott's Trick, Limitation of Size Axiom, and Transfinite Ordinal Arithmetic in MKTD Class Theory
**Importance:** 8/10
**State:** resolved
**Labels:** foundations, math, ordinals, hartogs, scotts-trick, limitation-of-size, ordinal-arithmetic, mktd, sml, python

## Description
Mechanize four central foundational and mathematical problems in Morse-Kelley class theory with Dunaev Tagged Ordered Pairs (MKTD) across both Standard ML (`examples/mktd_foundations.ML`) and Python (`foundations/type_semantics.py`):

1. **Hartogs Number Construction**:
   - For every set X, construct the least ordinal h(X) not injecting into X;
   - Verify that h(X) is an ordinal, does not inject into X, while every beta < h(X) injects into X;
   - Implement finite Hartogs number evaluations and order-type representations.

2. **Well-Ordering Properties and Scott's Trick**:
   - Under Morse-Kelley class theory without global choice, equivalence classes [x]_E on proper classes can themselves be proper classes;
   - Mechanize Dana Scott's trick (1955) using cumulative hierarchy rank to select the canonical subset of members of minimum rank mu;
   - Prove that Scott's representative class is a set bounded in V_{mu + 1}, enabling quotient construction on proper classes.

3. **von Neumann's Limitation of Size Axiom vs Cardinal Default Definitions**:
   - Mechanize von Neumann's limitation of size principle: X is a proper class iff X ~ V;
   - Contrast structural equipotence with the cardinal default boundary convention (|V| = On vs |K| < |V|);
   - Validate deductive and computational criteria: (K in V) iff (|K| != |V|).

4. **Transfinite Ordinal Arithmetic**:
   - Mechanize ordinal addition, multiplication, and exponentiation;
   - Formalize base cases and recurrence steps (zero, successor, limit);
   - Prove non-commutativity: 1 + omega = omega != omega + 1, and 2 * omega = omega != omega * 2;
   - Implement transfinite Cantor Normal Form arithmetic in Python.

Strict constraints:
- FACTBOOK.md compliance (Dunaev Tagged Ordered Pairs only, never Kuratowski pairs for proper classes);
- User Directive #16 compliance: Zero raw non-ASCII bytes in SML code for CakeML and Poly/ML portability;
- Absolute prohibition of emojis and directional arrows in titles and links;
- Dual verification via Poly/ML and Python unittest test suites.

## What Has Been Done
- Extended SML `class_term` with `Hartogs`, `ScottsClass`, `CardOf`, `OrdUniv`, `OrdZero`, `OrdSucc`, `OrdOmega`, `OrdAdd`, `OrdMult`, `OrdExp`, and `fm` with `InjectsInto`, `Equipotent`, `ProperClass`, `IsOrdinal` in `examples/mktd_foundations.ML`.
- Implemented SML evaluator functions: `mk_hartogs`, `eval_hartogs_finite`, `check_injection_exists`, `scotts_trick_eval`, `eval_cardinal_size`, `check_limitation_of_size`, `eval_ord_add`, `eval_ord_mult`, `eval_ord_exp`.
- Mechanized formal SML deductive theorems and axioms: `axiom_hartogs`, `prove_hartogs`, `axiom_scotts_trick`, `prove_scotts_trick`, `axiom_limitation_of_size`, `prove_limitation_of_size`, `axiom_limitation_of_size_cardinal`, `prove_limitation_of_size_cardinal`, `prove_ord_add_zero`, `prove_ord_add_succ`, `prove_ord_mult_zero`, `prove_ord_mult_succ`, `prove_ord_exp_zero`, `prove_ord_exp_succ`, `prove_ord_addition_noncommutative`, `prove_ord_multiplication_noncommutative`.
- Implemented Python foundational infrastructure in `foundations/type_semantics.py` and exported through `foundations/__init__.py`: `hartogs_number`, `can_inject`, `construct_hartogs_ordinals`, `hartogs_well_ordering_types`, `scotts_trick_representative`, `limitation_of_size_holds`, `cardinal_size`, `limitation_of_size_cardinal_criterion`, `Ordinal` (with Cantor Normal Form arithmetic), `ordinal_add`, `ordinal_mult`, `ordinal_exp`.
- Added unit tests in `tests/test_mktd_foundations.py` and `tests/test_type_semantics.py`.
- Verified strict ASCII purity (0 non-ASCII bytes) in `examples/mktd_foundations.ML`.
- Verified 100% test passing in Poly/ML (`poly -q --use examples/mktd_foundations.ML < /dev/null`) and 154/154 Python unit tests in `run_tests.py`.
