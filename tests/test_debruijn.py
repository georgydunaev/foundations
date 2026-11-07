"""Execute de Bruijn algorithms, including an independent named-term oracle."""

from functools import lru_cache
import itertools
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


@lru_cache(maxsize=None)
def terms(depth, size):
    """All terms of exactly size nodes, scoped in depth context slots."""
    if size == 1:
        return tuple(("v", k) for k in range(depth))
    result = [("l", body) for body in terms(depth + 1, size - 1)]
    for left_size in range(1, size - 1):
        for left in terms(depth, left_size):
            for right in terms(depth, size - 1 - left_size):
                result.append(("a", left, right))
    return tuple(result)


def sml(term):
    if term[0] == "v":
        return f"Var {term[1]}"
    if term[0] == "l":
        return f"Lam ({sml(term[1])})"
    return f"App ({sml(term[1])}, {sml(term[2])})"


def named(term, context, counter=None):
    if counter is None:
        counter = itertools.count()
    if term[0] == "v":
        return ("v", context[term[1]])
    if term[0] == "l":
        name = f"binder{next(counter)}"
        return ("l", name, named(term[1], [name] + context, counter))
    return ("a", named(term[1], context, counter),
            named(term[2], context, counter))


def free_names(term):
    if term[0] == "v":
        return {term[1]}
    if term[0] == "l":
        return free_names(term[2]) - {term[1]}
    return free_names(term[1]) | free_names(term[2])


def all_names(term):
    if term[0] == "v":
        return {term[1]}
    if term[0] == "l":
        return {term[1]} | all_names(term[2])
    return all_names(term[1]) | all_names(term[2])


def substitute_named(term, variable, replacement):
    """Usual named substitution; it never uses index shifting arithmetic."""
    if term[0] == "v":
        return replacement if term[1] == variable else term
    if term[0] == "a":
        return ("a", substitute_named(term[1], variable, replacement),
                substitute_named(term[2], variable, replacement))
    _, binder, body = term
    if binder == variable:
        return term
    if binder in free_names(replacement):
        forbidden = all_names(body) | all_names(replacement) | {variable}
        fresh = "fresh"
        while fresh in forbidden:
            fresh += "_"
        body = substitute_named(body, binder, ("v", fresh))
        binder = fresh
    return ("l", binder, substitute_named(body, variable, replacement))


def indexed(term, context):
    if term[0] == "v":
        return ("v", context.index(term[1]))
    if term[0] == "l":
        return ("l", indexed(term[2], [term[1]] + context))
    return ("a", indexed(term[1], context), indexed(term[2], context))


def named_step(term):
    """Reduce the first redex in preorder using named substitution."""
    if term[0] == "v":
        return None
    if term[0] == "l":
        body = named_step(term[2])
        return None if body is None else ("l", term[1], body)
    function, argument = term[1:]
    if function[0] == "l":
        return substitute_named(function[2], function[1], argument)
    reduced = named_step(function)
    if reduced is not None:
        return ("a", reduced, argument)
    reduced = named_step(argument)
    return None if reduced is None else ("a", function, reduced)


class TestDeBruijn(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.poly = shutil.which(os.environ.get("FOUNDATIONS_POLY", "poly"))
        if cls.poly is None:
            raise unittest.SkipTest(
                "Poly/ML unavailable; put poly on PATH or set FOUNDATIONS_POLY"
            )

    def execute(self, checks):
        # SML filenames use string escaping, not shell interpolation.
        filename = str(ROOT / "examples" / "debruijn.ML")
        filename = filename.replace("\\", "\\\\").replace('"', '\\"')
        program = f'use "{filename}";\nopen DeBruijn;\n' + r'''
fun check message condition = if condition then () else raise Fail message;
fun rejects action = (action (); false) handle Domain => true;
''' + checks + '\nval _ = print "DEBRUIJN-CHECKS-PASSED\\n";\n'
        with tempfile.TemporaryDirectory(prefix="foundations_debruijn_") as temp:
            script = Path(temp) / "checks.ML"
            script.write_text(program, encoding="utf-8")
            completed = subprocess.run(
                [self.poly, "-q", "--use", str(script)],
                cwd=ROOT, stdin=subprocess.DEVNULL, capture_output=True,
                text=True, timeout=60, check=False,
            )
        output = completed.stdout + completed.stderr
        self.assertEqual(completed.returncode, 0, output[-8000:])
        self.assertIn("DEBRUIJN-CHECKS-PASSED", output)

    def test_reduction_and_fuel_contracts(self):
        self.execute(r'''
val identity = Lam (Var 0);
val first = Lam (Lam (Var 1));
val duplicate = Lam (App (Var 0, Var 0));
val omega = App (duplicate, duplicate);
val _ = check "identity" (run 1 (App (identity, first)) = Normal first);
val _ = check "capture avoidance"
  (step (App (Lam (Lam (Var 1)), Var 0)) = SOME (Lam (Var 1)));
val _ = check "abstraction retained"
  (contract (Lam (Lam (Var 2))) (Var 0) = Lam (Lam (Var 2)));
val _ = check "outer slot decremented" (contract (Var 2) (Var 0) = Var 1);
val _ = check "neutral head stops" (run 0 (App (Var 0, Var 1)) =
  Normal (App (Var 0, Var 1)));
val _ = check "neutral argument still reduces"
  (run 1 (App (Var 0, App (identity, Var 1))) = Normal (App (Var 0, Var 1)));
val _ = check "reduction under lambda"
  (run 1 (Lam (App (identity, Var 0))) = Normal identity);
val _ = check "normal order discards divergent argument"
  (run 1 (App (Lam identity, omega)) = Normal identity);
val _ = check "omega self step" (step omega = SOME omega);
val _ = check "omega budget" (run 30 omega = OutOfFuel omega);
val twice = App (identity, App (identity, Var 0));
val _ = check "zero budget preserves term" (run 0 twice = OutOfFuel twice);
val _ = check "one budget" (run 1 twice = OutOfFuel (App (identity, Var 0)));
val _ = check "exact budget recognizes normal form" (run 2 twice = Normal (Var 0));
val _ = check "left child before right child"
  (step (App (App (identity, Var 0), App (identity, Var 1))) =
   SOME (App (Var 0, App (identity, Var 1))));
''')

    def test_steps_against_named_reduction_and_scope(self):
        checks = []
        for depth in range(3):
            context = [f"outer{j}" for j in range(depth)]
            for size in range(1, 8):
                for term in terms(depth, size):
                    reduced = named_step(named(term, context))
                    expected = ("NONE" if reduced is None else
                                f"SOME ({sml(indexed(reduced, context))})")
                    checks.append(
                        f'val _ = let val actual = step ({sml(term)}) in '
                        f'check "named step {len(checks)}" (actual = {expected} '
                        f'andalso (case actual of NONE => true | '
                        f'SOME u => scoped {depth} u)) end;'
                    )
        self.assertGreater(len(checks), 1000)
        self.execute("\n".join(checks))

    def test_replacement_against_named_substitution_and_scope(self):
        checks = []
        for outer in range(3):
            context = [f"outer{j}" for j in range(outer)]
            arguments = sum((terms(outer, size) for size in range(1, 4)), ())
            for depth in range(3):
                locals_ = [f"local{j}" for j in range(depth)]
                bodies = sum((terms(outer + depth + 1, size)
                              for size in range(1, 5)), ())
                for body in bodies:
                    for argument in arguments:
                        expected = indexed(substitute_named(
                            named(body, locals_ + ["target"] + context),
                            "target", named(argument, context)), locals_ + context)
                        label = f"named replacement {len(checks)}"
                        checks.append(
                            f'val _ = let val actual = replace {depth} '
                            f'({sml(argument)}) ({sml(body)}) in check "{label}" '
                            f'(actual = ({sml(expected)}) andalso '
                            f'scoped {outer + depth} actual) end;'
                        )
        self.assertGreater(len(checks), 1000)
        self.execute("\n".join(checks))

    def test_shift_against_named_context_insertion(self):
        checks = []
        for outer in range(3):
            for cutoff in range(3):
                before = [f"local{j}" for j in range(cutoff)]
                after = [f"outer{j}" for j in range(outer)]
                for amount in range(3):
                    inserted = [f"inserted{j}" for j in range(amount)]
                    for size in range(1, 5):
                        for term in terms(outer + cutoff, size):
                            expected = indexed(named(term, before + after),
                                               before + inserted + after)
                            checks.append(
                                f'val _ = check "shift {len(checks)}" '
                                f'(shift {amount} {cutoff} ({sml(term)}) = '
                                f'({sml(expected)}));'
                            )
        self.assertGreater(len(checks), 1000)
        self.execute("\n".join(checks))

    def test_invalid_inputs_and_unbounded_indices(self):
        self.execute(r'''
val _ = check "negative scope" (not (scoped (~1) (Lam (Var 0))));
val _ = check "negative variable" (not (scoped 3 (Var (~1))));
val _ = check "dangling variable" (not (scoped 1 (Var 1)));
val _ = check "negative shift" (rejects (fn () => ignore (shift (~1) 0 (Var 0))));
val _ = check "negative cutoff" (rejects (fn () => ignore (shift 1 (~1) (Var 0))));
val _ = check "negative replacement depth"
  (rejects (fn () => ignore (replace (~1) (Var 0) (Var 0))));
val _ = check "malformed argument"
  (rejects (fn () => ignore (replace 0 (Var (~1)) (Var 0))));
val _ = check "malformed replacement body"
  (rejects (fn () => ignore (replace 0 (Var 0) (Lam (Var (~1))))));
val _ = check "malformed shift"
  (rejects (fn () => ignore (shift 0 0 (Lam (Var (~1))))));
val _ = check "malformed step"
  (rejects (fn () => ignore (step (Lam (Var (~1))))));
val _ = check "malformed unused argument"
  (rejects (fn () => ignore (step (App (Lam (Lam (Var 0)), Var (~1))))));
val _ = check "malformed zero-budget run"
  (rejects (fn () => ignore (run 0 (Var (~1)))));
val _ = check "negative fuel" (rejects (fn () => ignore (run (~1) (Var 0))));
val huge = IntInf.pow (2, 100);
val _ = check "unbounded integer shift" (shift huge 0 (Var huge) = Var (2 * huge));
val _ = check "unbounded scope" (scoped (huge + 1) (Var huge));
val _ = check "unbounded replacement depth"
  (replace huge (Var 0) (Var huge) = Var huge);
val _ = check "unbounded fuel" (run huge (Lam (Var 0)) = Normal (Lam (Var 0)));
''')


class TestNamedOracle(unittest.TestCase):
    def test_substitution_renames_conflicting_binder(self):
        result = substitute_named(("l", "y", ("v", "x")), "x", ("v", "y"))
        self.assertEqual(indexed(result, ["y"]), ("l", ("v", 1)))
        self.assertEqual(free_names(result), {"y"})

    def test_substitution_respects_shadowing(self):
        term = ("l", "x", ("v", "x"))
        self.assertEqual(substitute_named(term, "x", ("v", "y")), term)


if __name__ == "__main__":
    unittest.main()
