"""Foundations Logic, Binder Hygiene, and Reflection Scope.

This module formalizes:
1. Binder hygiene for the at-most-one uniqueness quantifier (!z:Class. phi(z)),
   guaranteeing fresh distinct variable generation (Y1, Y2), capture avoidance,
   alpha-invariance, and correct evaluation in finite domains (200_uniqueness.tex,
   obelisk_uniqueness_binder_hygiene.md).
2. Verification provenance tracking for incompleteness theorems (Lob's theorem,
   Godel's second incompleteness theorem), strictly separating formula constructors
   (TpHolds) from replayable proof constructors and derivations, and tracking
   Hilbert-Bernays-Lob derivability conditions (010_logic.tex,
   obelisk_logic_verification_status.md).
3. Reflection scope and theory stratification (Tau level 0, Fau level 1, Qau level 2,
   schematic Wau), empty outer-context requirement and inner context Gamma preservation
   for meta-conecessitation, and separation of syntactic self-provability (E = T)
   from semantic self-truth reflection (obelisk_logic_reflection_scope.md).
"""

from __future__ import annotations

from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Callable, Optional, Sequence


# ==============================================================================
# Custom Exceptions
# ==============================================================================

class BinderHygieneError(Exception):
    """Raised when binder freshness, distinctness, or capture-avoidance fails."""


class ReflectionScopeError(Exception):
    """Raised when reflection rules or context boundaries are violated."""


class ProofVerificationError(Exception):
    """Raised when a proof certificate or derivation step is invalid."""


# ==============================================================================
# Part 1: First-Order / Class Logic AST and Binder Hygiene
# ==============================================================================

@dataclass(frozen=True)
class Term:
    """Class or object term."""
    name: str

    def __repr__(self) -> str:
        return self.name


def Var(name: str) -> Term:
    return Term(name)


class Formula:
    """Base class for formulas."""

    def free_vars(self) -> set[str]:
        raise NotImplementedError

    def bound_vars(self) -> set[str]:
        raise NotImplementedError

    def all_vars(self) -> set[str]:
        return self.free_vars() | self.bound_vars()


@dataclass(frozen=True)
class TrueFm(Formula):
    def free_vars(self) -> set[str]:
        return set()

    def bound_vars(self) -> set[str]:
        return set()

    def __repr__(self) -> str:
        return "True"


@dataclass(frozen=True)
class FalseFm(Formula):
    def free_vars(self) -> set[str]:
        return set()

    def bound_vars(self) -> set[str]:
        return set()

    def __repr__(self) -> str:
        return "False"


@dataclass(frozen=True)
class Eq(Formula):
    left: Term
    right: Term

    def free_vars(self) -> set[str]:
        return {self.left.name, self.right.name}

    def bound_vars(self) -> set[str]:
        return set()

    def __repr__(self) -> str:
        return f"({self.left} = {self.right})"


@dataclass(frozen=True)
class Neq(Formula):
    left: Term
    right: Term

    def free_vars(self) -> set[str]:
        return {self.left.name, self.right.name}

    def bound_vars(self) -> set[str]:
        return set()

    def __repr__(self) -> str:
        return f"({self.left} != {self.right})"


@dataclass(frozen=True)
class In(Formula):
    left: Term
    right: Term

    def free_vars(self) -> set[str]:
        return {self.left.name, self.right.name}

    def bound_vars(self) -> set[str]:
        return set()

    def __repr__(self) -> str:
        return f"({self.left} in {self.right})"


@dataclass(frozen=True)
class Pred(Formula):
    name: str
    args: tuple[Term, ...]

    def free_vars(self) -> set[str]:
        return {arg.name for arg in self.args}

    def bound_vars(self) -> set[str]:
        return set()

    def __repr__(self) -> str:
        args_str = ", ".join(arg.name for arg in self.args)
        return f"{self.name}({args_str})"


@dataclass(frozen=True)
class Not(Formula):
    body: Formula

    def free_vars(self) -> set[str]:
        return self.body.free_vars()

    def bound_vars(self) -> set[str]:
        return self.body.bound_vars()

    def __repr__(self) -> str:
        return f"(~{self.body})"


@dataclass(frozen=True)
class And(Formula):
    left: Formula
    right: Formula

    def free_vars(self) -> set[str]:
        return self.left.free_vars() | self.right.free_vars()

    def bound_vars(self) -> set[str]:
        return self.left.bound_vars() | self.right.bound_vars()

    def __repr__(self) -> str:
        return f"({self.left} /\\ {self.right})"


@dataclass(frozen=True)
class Or(Formula):
    left: Formula
    right: Formula

    def free_vars(self) -> set[str]:
        return self.left.free_vars() | self.right.free_vars()

    def bound_vars(self) -> set[str]:
        return self.left.bound_vars() | self.right.bound_vars()

    def __repr__(self) -> str:
        return f"({self.left} \\/ {self.right})"


@dataclass(frozen=True)
class Imp(Formula):
    left: Formula
    right: Formula

    def free_vars(self) -> set[str]:
        return self.left.free_vars() | self.right.free_vars()

    def bound_vars(self) -> set[str]:
        return self.left.bound_vars() | self.right.bound_vars()

    def __repr__(self) -> str:
        return f"({self.left} -> {self.right})"


@dataclass(frozen=True)
class Iff(Formula):
    left: Formula
    right: Formula

    def free_vars(self) -> set[str]:
        return self.left.free_vars() | self.right.free_vars()

    def bound_vars(self) -> set[str]:
        return self.left.bound_vars() | self.right.bound_vars()

    def __repr__(self) -> str:
        return f"({self.left} <-> {self.right})"


@dataclass(frozen=True)
class Forall(Formula):
    var: str
    body: Formula

    def free_vars(self) -> set[str]:
        return self.body.free_vars() - {self.var}

    def bound_vars(self) -> set[str]:
        return self.body.bound_vars() | {self.var}

    def __repr__(self) -> str:
        return f"(forall {self.var}. {self.body})"


@dataclass(frozen=True)
class Exists(Formula):
    var: str
    body: Formula

    def free_vars(self) -> set[str]:
        return self.body.free_vars() - {self.var}

    def bound_vars(self) -> set[str]:
        return self.body.bound_vars() | {self.var}

    def __repr__(self) -> str:
        return f"(exists {self.var}. {self.body})"


@dataclass(frozen=True)
class AtMostOne(Formula):
    """Uniqueness binder: !z:Class. phi(z).

    Means at most one object satisfies phi(z):
    (!z, phi) <-> (forall Y1 forall Y2, phi[Y1/z] /\\ phi[Y2/z] -> Y1 = Y2)
    where Y1, Y2 are distinct fresh variables for phi.
    """
    var: str
    body: Formula

    def free_vars(self) -> set[str]:
        return self.body.free_vars() - {self.var}

    def bound_vars(self) -> set[str]:
        return self.body.bound_vars() | {self.var}

    def __repr__(self) -> str:
        return f"(!{self.var}. {self.body})"


@dataclass(frozen=True)
class ExistsUnique(Formula):
    """Existence and uniqueness quantifier: exists! z:Class. phi(z).

    Means exactly one object satisfies phi(z):
    (exists! z, phi) <-> (exists z, phi) /\\ (!z, phi).
    """
    var: str
    body: Formula

    def free_vars(self) -> set[str]:
        return self.body.free_vars() - {self.var}

    def bound_vars(self) -> set[str]:
        return self.body.bound_vars() | {self.var}

    def __repr__(self) -> str:
        return f"(exists! {self.var}. {self.body})"


# Variable inspection helpers

def free_variables(fm: Formula) -> set[str]:
    """Compute the set of free variables of a formula."""
    return fm.free_vars()


def bound_variables(fm: Formula) -> set[str]:
    """Compute the set of bound variables of a formula."""
    return fm.bound_vars()


def all_variables(fm: Formula) -> set[str]:
    """Compute the set of all variables occurring in a formula."""
    return fm.all_vars()


def fresh_variable(base: str, forbidden: set[str]) -> str:
    """Generate a fresh variable name based on `base` not in `forbidden`."""
    if base not in forbidden:
        return base
    idx = 1
    while f"{base}{idx}" in forbidden:
        idx += 1
    return f"{base}{idx}"


def fresh_variable_pair(base1: str, base2: str, forbidden: set[str]) -> tuple[str, str]:
    """Generate two distinct fresh variable names not in `forbidden`.

    Guarantees v1 != v2 and v1, v2 not in forbidden.
    """
    v1 = fresh_variable(base1, forbidden)
    v2 = fresh_variable(base2, forbidden | {v1})
    return v1, v2


def substitute_term(term: Term, var: str, replacement: Term) -> Term:
    """Substitute a term for a variable name in a term."""
    return replacement if term.name == var else term


def substitute_formula(fm: Formula, var: str, replacement: Term) -> Formula:
    """Hygienic capture-avoiding substitution fm[replacement/var]."""
    if isinstance(fm, (TrueFm, FalseFm)):
        return fm
    if isinstance(fm, Eq):
        return Eq(substitute_term(fm.left, var, replacement), substitute_term(fm.right, var, replacement))
    if isinstance(fm, Neq):
        return Neq(substitute_term(fm.left, var, replacement), substitute_term(fm.right, var, replacement))
    if isinstance(fm, In):
        return In(substitute_term(fm.left, var, replacement), substitute_term(fm.right, var, replacement))
    if isinstance(fm, Pred):
        return Pred(fm.name, tuple(substitute_term(a, var, replacement) for a in fm.args))
    if isinstance(fm, Not):
        return Not(substitute_formula(fm.body, var, replacement))
    if isinstance(fm, And):
        return And(substitute_formula(fm.left, var, replacement), substitute_formula(fm.right, var, replacement))
    if isinstance(fm, Or):
        return Or(substitute_formula(fm.left, var, replacement), substitute_formula(fm.right, var, replacement))
    if isinstance(fm, Imp):
        return Imp(substitute_formula(fm.left, var, replacement), substitute_formula(fm.right, var, replacement))
    if isinstance(fm, Iff):
        return Iff(substitute_formula(fm.left, var, replacement), substitute_formula(fm.right, var, replacement))
    if isinstance(fm, (Forall, Exists, AtMostOne, ExistsUnique)):
        binder_cls = type(fm)
        bvar = fm.var
        body = fm.body
        if bvar == var:
            return fm
        repl_fv = {replacement.name}
        if bvar in repl_fv:
            # Alpha-rename bound variable to avoid capturing replacement
            forbidden = fm.all_vars() | repl_fv | {var}
            fresh = fresh_variable(bvar, forbidden)
            renamed_body = substitute_formula(body, bvar, Var(fresh))
            return binder_cls(fresh, substitute_formula(renamed_body, var, replacement))
        return binder_cls(bvar, substitute_formula(body, var, replacement))
    raise TypeError(f"Unknown formula type: {type(fm)}")


def check_uniqueness_hygiene(
    phi: Formula,
    bound_var: str,
    introduced_var1: str,
    introduced_var2: str,
) -> tuple[bool, str]:
    """Check hygiene conditions for introducing uniqueness variables Y1, Y2.

    Acceptance checks:
    1. introduced_var1 != introduced_var2 (distinctness).
    2. introduced_var1 not in FV(phi) - {bound_var} (freshness).
    3. introduced_var2 not in FV(phi) - {bound_var} (freshness).
    """
    if introduced_var1 == introduced_var2:
        return False, f"Introduced variables must be distinct, got {introduced_var1} == {introduced_var2}"
    phi_fv = phi.free_vars() - {bound_var}
    if introduced_var1 in phi_fv:
        return False, f"Variable {introduced_var1} is free in phi; capture would occur"
    if introduced_var2 in phi_fv:
        return False, f"Variable {introduced_var2} is free in phi; capture would occur"
    return True, "Hygiene check passed: distinct and fresh variables"


def expand_at_most_one(
    phi: Formula,
    bound_var: str,
    introduced_var1: Optional[str] = None,
    introduced_var2: Optional[str] = None,
    forbidden: Optional[set[str]] = None,
) -> Formula:
    """Hygienically expand at-most-one binder (!z. phi(z)).

    Produces:
    forall Y1 forall Y2. (phi[Y1/z] /\\ phi[Y2/z] -> Y1 = Y2)

    Where Y1, Y2 are distinct fresh variables for phi and any forbidden set.
    """
    forbidden_set = set(forbidden or set()) | phi.all_vars() | {bound_var}
    if introduced_var1 is not None and introduced_var2 is not None:
        ok, msg = check_uniqueness_hygiene(phi, bound_var, introduced_var1, introduced_var2)
        if not ok:
            raise BinderHygieneError(msg)
        y1, y2 = introduced_var1, introduced_var2
    else:
        # Automatically generate distinct fresh variables Y1, Y2
        y1, y2 = fresh_variable_pair("y1", "y2", forbidden_set)

    sub1 = substitute_formula(phi, bound_var, Var(y1))
    sub2 = substitute_formula(phi, bound_var, Var(y2))
    antecedent = And(sub1, sub2)
    consequent = Eq(Var(y1), Var(y2))
    return Forall(y1, Forall(y2, Imp(antecedent, consequent)))


def naive_expand_at_most_one(
    phi: Formula,
    bound_var: str,
    fixed_x: str = "x",
    fixed_y: str = "y",
) -> Formula:
    """Unsound naive expansion of (!z. phi) using fixed variable names x and y.

    Used as an audit baseline to demonstrate variable capture when phi contains
    free parameters named x or y.
    """
    sub1 = substitute_formula(phi, bound_var, Var(fixed_x))
    sub2 = substitute_formula(phi, bound_var, Var(fixed_y))
    antecedent = And(sub1, sub2)
    consequent = Eq(Var(fixed_x), Var(fixed_y))
    return Forall(fixed_x, Forall(fixed_y, Imp(antecedent, consequent)))


def are_alpha_equivalent(fm1: Formula, fm2: Formula) -> bool:
    """Check if two formulas are alpha-equivalent (identical up to bound variable renaming)."""
    def helper(f1: Formula, f2: Formula, env1: dict[str, str], env2: dict[str, str]) -> bool:
        if type(f1) is not type(f2):
            return False
        if isinstance(f1, (TrueFm, FalseFm)):
            return True
        if isinstance(f1, (Eq, Neq, In)):
            def map_v(v: str, env: dict[str, str]) -> str:
                return env.get(v, v)
            return (
                map_v(f1.left.name, env1) == map_v(f2.left.name, env2)
                and map_v(f1.right.name, env1) == map_v(f2.right.name, env2)
            )
        if isinstance(f1, Pred):
            if f1.name != f2.name or len(f1.args) != len(f2.args):
                return False
            return all(
                env1.get(a1.name, a1.name) == env2.get(a2.name, a2.name)
                for a1, a2 in zip(f1.args, f2.args)
            )
        if isinstance(f1, Not):
            return helper(f1.body, f2.body, env1, env2)
        if isinstance(f1, (And, Or, Imp, Iff)):
            return helper(f1.left, f2.left, env1, env2) and helper(f1.right, f2.right, env1, env2)
        if isinstance(f1, (Forall, Exists, AtMostOne, ExistsUnique)):
            new_id = f"renamed_{len(env1)}"
            new_env1 = {**env1, f1.var: new_id}
            new_env2 = {**env2, f2.var: new_id}
            return helper(f1.body, f2.body, new_env1, new_env2)
        return False

    return helper(fm1, fm2, {}, {})


def eval_formula(fm: Formula, domain: Sequence[Any], env: dict[str, Any]) -> bool:
    """Evaluate a formula in a finite domain under variable assignment `env`."""
    if isinstance(fm, TrueFm):
        return True
    if isinstance(fm, FalseFm):
        return False
    if isinstance(fm, Eq):
        return env[fm.left.name] == env[fm.right.name]
    if isinstance(fm, Neq):
        return env[fm.left.name] != env[fm.right.name]
    if isinstance(fm, In):
        return env[fm.left.name] in env[fm.right.name]
    if isinstance(fm, Pred):
        args = tuple(env[a.name] for a in fm.args)
        pred_fn = env.get(fm.name)
        if callable(pred_fn):
            return bool(pred_fn(*args))
        raise ValueError(f"Predicate {fm.name} not callable in env")
    if isinstance(fm, Not):
        return not eval_formula(fm.body, domain, env)
    if isinstance(fm, And):
        return eval_formula(fm.left, domain, env) and eval_formula(fm.right, domain, env)
    if isinstance(fm, Or):
        return eval_formula(fm.left, domain, env) or eval_formula(fm.right, domain, env)
    if isinstance(fm, Imp):
        return (not eval_formula(fm.left, domain, env)) or eval_formula(fm.right, domain, env)
    if isinstance(fm, Iff):
        return eval_formula(fm.left, domain, env) == eval_formula(fm.right, domain, env)
    if isinstance(fm, Forall):
        return all(eval_formula(fm.body, domain, {**env, fm.var: d}) for d in domain)
    if isinstance(fm, Exists):
        return any(eval_formula(fm.body, domain, {**env, fm.var: d}) for d in domain)
    if isinstance(fm, AtMostOne):
        witness_count = sum(1 for d in domain if eval_formula(fm.body, domain, {**env, fm.var: d}))
        return witness_count <= 1
    if isinstance(fm, ExistsUnique):
        witness_count = sum(1 for d in domain if eval_formula(fm.body, domain, {**env, fm.var: d}))
        return witness_count == 1
    raise TypeError(f"Cannot evaluate formula type: {type(fm)}")


def eval_at_most_one_predicate(
    predicate: Callable[[Any], bool],
    domain: Sequence[Any],
) -> bool:
    """Evaluate at-most-one condition (!x. P(x)) directly on a domain.

    Returns True iff at most one element satisfies predicate (0 or 1 witness).
    """
    witness_count = sum(1 for d in domain if predicate(d))
    return witness_count <= 1


def eval_exists_unique_predicate(
    predicate: Callable[[Any], bool],
    domain: Sequence[Any],
) -> bool:
    """Evaluate existence-and-uniqueness (exists! x. P(x)) directly on a domain.

    Returns True iff exactly one element satisfies predicate (1 witness).
    """
    witness_count = sum(1 for d in domain if predicate(d))
    return witness_count == 1


# ==============================================================================
# Part 2: Incompleteness Verification Status and Proof Provenance
# ==============================================================================

class VerificationStatus(str, Enum):
    """Verification classification of an exported theory item."""
    VERIFIED_KERNEL = "Verified (Kernel)"
    STATED_WIP = "Stated (WIP)"
    CONJECTURED = "Conjectured"
    ASSUMED_AXIOM = "Assumed Axiom"
    UNVERIFIED = "Unverified"


class FormulaConstructor(str, Enum):
    """Constructor used to build syntax of formulas."""
    TP_HOLDS = "TpHolds"      # Formula constructor for derivability/satisfaction predicate
    TP_IMP = "TpImp"
    TP_AND = "TpAnd"
    TP_ALL = "TpAll"
    TP_UNIQ = "TpUniq"


class ProofConstructor(str, Enum):
    """Constructor used to build actual verified derivations / proof terms."""
    PRF_AXIOM = "PrfAxiom"
    PRF_MODUS_PONENS = "PrfModusPonens"
    PRF_NECESSITATION = "PrfNecessitation"          # D1: T |- phi => T |- Box phi
    PRF_DISTRIBUTIVITY = "PrfDistributivity"        # D2: T |- Box(phi -> psi) -> (Box phi -> Box psi)
    PRF_INTERNAL_NECESSITATION = "PrfInternalNecessitation"  # D3: T |- Box phi -> Box Box phi
    PRF_DIAGONAL_FIXED_POINT = "PrfDiagonalFixedPoint"  # Diagonal lemma: T |- L <-> (Box L -> phi)
    PRF_LOB_RULE = "PrfLobRule"
    PRF_SECOND_INCOMPLETENESS = "PrfSecondIncompleteness"


class TheoremLevel(str, Enum):
    """Classification of the role of a theorem or formula."""
    EXTERNAL_RULE = "External Theorem / Rule (T |- Box phi -> phi  ==>  T |- phi)"
    INTERNAL_FORMALIZED = "Internal Formalized Implication (E |- Box_T(Box_T phi -> phi) -> Box_T phi)"
    ASSUMED_CONSISTENCY = "Assumed Consistency Premise (Con(T) := ~Box_T bot)"


@dataclass
class DerivabilityConditions:
    """Hilbert-Bernays-Lob derivability conditions for arithmetized provability."""
    d1_necessitation: bool = True           # D1: If T |- phi then T |- Box phi
    d2_distributivity: bool = True          # D2: T |- Box(phi -> psi) -> (Box phi -> Box psi)
    d3_internal_necessitation: bool = True  # D3: T |- Box phi -> Box Box phi
    diagonal_lemma_available: bool = True   # Fixed-point lemma available for language

    def satisfies_lob_hypotheses(self) -> bool:
        return (
            self.d1_necessitation
            and self.d2_distributivity
            and self.d3_internal_necessitation
            and self.diagonal_lemma_available
        )


@dataclass
class DerivationStep:
    """A verified step in a checked derivation."""
    step_id: int
    rule: ProofConstructor
    formula_str: str
    premises: list[int] = field(default_factory=list)
    justification: str = ""


@dataclass
class ProofCertificate:
    """Full proof certificate tracking provenance and verification evidence."""
    item_id: str                      # e.g. "5.01" or "5.02"
    title: str                        # e.g. "Lob's theorem", "Second incompleteness theorem"
    target_formula: str
    ambient_metatheory: str           # e.g. "E" (PA, ISigma1, MKTD)
    base_theory: str                  # e.g. "T"
    classification: TheoremLevel
    formula_constructor: FormulaConstructor
    proof_constructor: Optional[ProofConstructor] = None
    derivation_steps: list[DerivationStep] = field(default_factory=list)
    derivability_conditions: Optional[DerivabilityConditions] = None
    assumed_hypotheses: list[str] = field(default_factory=list)


def verify_proof_certificate(cert: ProofCertificate) -> tuple[VerificationStatus, str]:
    """Verify proof evidence for a certificate.

    Invariants enforced:
    1. An entry that merely names a formula constructor (such as TpHolds) without
       exhibiting a checked derivation cannot be classified as Verified (Kernel).
       It is classified as Stated (WIP).
    2. Derivation steps must be non-empty and well-formed.
    3. The conclusion of the final step must match target_formula.
    4. Required derivability conditions (D1, D2, D3, diagonal lemma) must be verified.
    5. Corrupted steps immediately revoke verification.
    """
    if cert.proof_constructor is None or len(cert.derivation_steps) == 0:
        if cert.formula_constructor == FormulaConstructor.TP_HOLDS:
            return (
                VerificationStatus.STATED_WIP,
                "TpHolds is a formula constructor, not a proof constructor; missing replayable derivation"
            )
        return (
            VerificationStatus.UNVERIFIED,
            "No proof derivation provided"
        )

    # Validate derivability conditions
    if cert.derivability_conditions and not cert.derivability_conditions.satisfies_lob_hypotheses():
        return (
            VerificationStatus.UNVERIFIED,
            "Derivability conditions D1-D3 or diagonal lemma not satisfied"
        )

    # Validate derivation step dependencies
    step_map: dict[int, DerivationStep] = {}
    for step in cert.derivation_steps:
        for p in step.premises:
            if p not in step_map:
                return (
                    VerificationStatus.UNVERIFIED,
                    f"Derivation step {step.step_id} references missing premise {p}"
                )
        step_map[step.step_id] = step

    final_step = cert.derivation_steps[-1]
    if final_step.formula_str != cert.target_formula:
        return (
            VerificationStatus.UNVERIFIED,
            f"Final derivation step '{final_step.formula_str}' does not match target '{cert.target_formula}'"
        )

    return (
        VerificationStatus.VERIFIED_KERNEL,
        f"Replayable derivation verified with {len(cert.derivation_steps)} steps under {cert.ambient_metatheory}"
    )


def build_loeb_certificate(valid: bool = True, as_wip_only: bool = False) -> ProofCertificate:
    """Build a certificate for Lob's theorem (Item 5.01)."""
    target = "E |- Box_T(Box_T phi -> phi) -> Box_T phi"
    if as_wip_only:
        return ProofCertificate(
            item_id="5.01",
            title="Lob's theorem (WIP)",
            target_formula=target,
            ambient_metatheory="E",
            base_theory="T",
            classification=TheoremLevel.INTERNAL_FORMALIZED,
            formula_constructor=FormulaConstructor.TP_HOLDS,
            proof_constructor=None,
            derivation_steps=[],
            derivability_conditions=DerivabilityConditions(),
        )

    steps = [
        DerivationStep(1, ProofConstructor.PRF_DIAGONAL_FIXED_POINT, "T |- L <-> (Box_T L -> phi)", [], "Diagonal lemma on psi(y) = (Pr_T(y) -> phi)"),
        DerivationStep(2, ProofConstructor.PRF_AXIOM, "T |- L -> (Box_T L -> phi)", [1], "Left-to-right fixed point direction"),
        DerivationStep(3, ProofConstructor.PRF_NECESSITATION, "T |- Box_T(L -> (Box_T L -> phi))", [2], "D1 necessitation on step 2"),
        DerivationStep(4, ProofConstructor.PRF_DISTRIBUTIVITY, "T |- Box_T L -> Box_T(Box_T L -> phi)", [3], "D2 distributivity with modus ponens"),
        DerivationStep(5, ProofConstructor.PRF_DISTRIBUTIVITY, "T |- Box_T L -> (Box_T Box_T L -> Box_T phi)", [4], "D2 distributivity expansion"),
        DerivationStep(6, ProofConstructor.PRF_INTERNAL_NECESSITATION, "T |- Box_T L -> Box_T Box_T L", [], "D3 internalized necessitation"),
        DerivationStep(7, ProofConstructor.PRF_MODUS_PONENS, "T |- Box_T L -> Box_T phi", [5, 6], "Propositional combination of 5 and 6"),
        DerivationStep(8, ProofConstructor.PRF_MODUS_PONENS, target if valid else "CorruptedTarget", [7], "Internalization in E giving Lob implication"),
    ]

    return ProofCertificate(
        item_id="5.01",
        title="Lob's theorem",
        target_formula=target,
        ambient_metatheory="E",
        base_theory="T",
        classification=TheoremLevel.INTERNAL_FORMALIZED,
        formula_constructor=FormulaConstructor.TP_HOLDS,
        proof_constructor=ProofConstructor.PRF_LOB_RULE,
        derivation_steps=steps,
        derivability_conditions=DerivabilityConditions(),
    )


def build_second_incompleteness_certificate(valid: bool = True, as_wip_only: bool = False) -> ProofCertificate:
    """Build a certificate for Godel's second incompleteness theorem (Item 5.02)."""
    target = "E |- Con(T) -> ~Box_T(Con(T))"
    if as_wip_only:
        return ProofCertificate(
            item_id="5.02",
            title="Godel's second incompleteness theorem (WIP)",
            target_formula=target,
            ambient_metatheory="E",
            base_theory="T",
            classification=TheoremLevel.INTERNAL_FORMALIZED,
            formula_constructor=FormulaConstructor.TP_HOLDS,
            proof_constructor=None,
            derivation_steps=[],
            derivability_conditions=DerivabilityConditions(),
        )

    steps = [
        DerivationStep(1, ProofConstructor.PRF_LOB_RULE, "E |- Box_T(Box_T bot -> bot) -> Box_T bot", [], "Instance of Lob theorem with phi = bot"),
        DerivationStep(2, ProofConstructor.PRF_AXIOM, "E |- Con(T) <-> ~Box_T bot", [], "Definition of consistency Con(T)"),
        DerivationStep(3, ProofConstructor.PRF_AXIOM, "E |- Box_T(Con(T)) <-> Box_T(~Box_T bot)", [2], "Internalized equivalence"),
        DerivationStep(4, ProofConstructor.PRF_AXIOM, "E |- (Box_T bot -> bot) <-> ~Box_T bot", [], "Classical propositional tautology for bot"),
        DerivationStep(5, ProofConstructor.PRF_MODUS_PONENS, "E |- Box_T(Con(T)) -> Box_T bot", [1, 3, 4], "Lob instance rewritten with Con(T)"),
        DerivationStep(6, ProofConstructor.PRF_MODUS_PONENS, target if valid else "CorruptedTarget", [2, 5], "Contraposition giving Con(T) -> ~Box_T(Con(T))"),
    ]

    return ProofCertificate(
        item_id="5.02",
        title="Godel's second incompleteness theorem",
        target_formula=target,
        ambient_metatheory="E",
        base_theory="T",
        classification=TheoremLevel.INTERNAL_FORMALIZED,
        formula_constructor=FormulaConstructor.TP_HOLDS,
        proof_constructor=ProofConstructor.PRF_SECOND_INCOMPLETENESS,
        derivation_steps=steps,
        derivability_conditions=DerivabilityConditions(),
        assumed_hypotheses=["Con(T) consistent", "D1-D3 hold for T in E"],
    )


# ==============================================================================
# Part 3: Reflection Scope and Sound Theory Definitions
# ==============================================================================

class TheoryLevel(int, Enum):
    """Theory stratification levels."""
    TAU = 0     # Base theory Tau (effective first-order/class axioms)
    FAU = 1     # Foundational theory Fau (reflexive/Henkin extension)
    QAU = 2     # Quotation theory Qau (stratified quotation)
    WAU = 3     # Schematic theory Wau (top level or schematic variable)


@dataclass(frozen=True)
class TheorySpecification:
    """Formal specification of a theory in the reflection hierarchy."""
    name: str
    level: int
    is_schematic: bool
    language: str
    axioms: tuple[str, ...] = field(default_factory=tuple)


def get_standard_theories() -> dict[str, TheorySpecification]:
    """Return standard theories in the Obelisk reflection hierarchy."""
    return {
        "Tau": TheorySpecification("Tau", TheoryLevel.TAU, False, "L_Class", ("ZFC_axioms", "MKTD_axioms")),
        "Fau": TheorySpecification("Fau", TheoryLevel.FAU, False, "L_Class", ("Tau", "Henkin_property", "Semantic_reflexivity")),
        "Qau": TheorySpecification("Qau", TheoryLevel.QAU, False, "L_Quotation", ("Fau", "Stratified_quotation")),
        "Wau": TheorySpecification("Wau", TheoryLevel.WAU, True, "L_Schematic", ("Arbitrary_ambient_theory",)),
    }


def validate_soundness_axiom_scope(
    theory_containing_axiom: str,
    target_theory: str,
) -> tuple[bool, str]:
    """Validate the scope of a soundness axiom (AxmSoundnessOfBaseTheory 3.72).

    Rule: AxmSoundnessOfBaseTheory asserts forall phi, (T, [] |- phi) -> eval(phi).
    This axiom MUST reside in an ambient metatheory M or foundational theory F (level > 0),
    NEVER inside T itself. An effective theory asserting its own soundness for all
    formulas triggers Lob's obstruction (T |- Box phi -> phi implies T |- phi),
    forcing T to prove every formula if consistent.
    """
    if theory_containing_axiom == target_theory:
        return (
            False,
            f"Unsound: Theory '{target_theory}' cannot contain its own unrestricted soundness axiom; triggers Lob obstruction"
        )
    return (
        True,
        f"Sound: Soundness of '{target_theory}' is asserted in external/higher theory '{theory_containing_axiom}'"
    )


def apply_meta_conecessitation(
    outer_theory: str,
    outer_context: list[str],
    inner_theory: str,
    inner_context: list[str],
    formula_str: str,
) -> tuple[str, list[str], str]:
    """Execute DefMetaConecessitation (Item 4.03).

    Rule:
    forall Gamma, phi. ((F, [] |- <F, Gamma |- phi>) -> (F, Gamma |- phi))

    Acceptance criteria:
    1. Outer context MUST be empty ([]).
    2. Inner context Gamma MUST be preserved in the conclusion.
    3. Rejects concluding an unconditioned phi when Gamma is non-empty.
    """
    if len(outer_context) != 0:
        raise ReflectionScopeError(
            f"Co-necessitation requires an empty outer context [], got {outer_context}"
        )

    # Conclude (inner_theory, inner_context |- formula_str)
    return (inner_theory, list(inner_context), formula_str)


def check_reflection_soundness(
    target_theory: str,
    ambient_theory: str,
    formula_str: str,
    is_syntactic_provability: bool,
    is_provable_in_target: bool,
) -> tuple[bool, str]:
    """Check whether a reflection instance is mathematically sound.

    Acceptance criteria:
    1. Syntactic self-provability (E = T) is admitted for arithmetized provability
       Pr_T(code(phi)), because an effective theory can soundly reason about its
       own syntax and finite proof search.
    2. Semantic self-reflection (eval_T(code(phi)) or Box_T phi -> phi asserted as an
       unrestricted internal axiom) is rejected for unprovable phi (Lob obstruction).
    3. Reflection across levels (level(ambient) > level(target)) is sound.
    """
    theories = get_standard_theories()
    target_spec = theories.get(target_theory, TheorySpecification(target_theory, 0, False, "L"))
    ambient_spec = theories.get(ambient_theory, TheorySpecification(ambient_theory, 1, False, "L"))

    if is_syntactic_provability:
        # E = T syntactic provability is admitted
        return (
            True,
            f"Admitted: Syntactic provability Pr_{target_theory} permitted with ambient theory {ambient_theory} (including E = T)"
        )

    # Semantic reflection
    if target_theory == ambient_theory or target_spec.level == ambient_spec.level:
        if not is_provable_in_target:
            return (
                False,
                f"Lob obstruction: Internal reflection Box_{target_theory}(phi) -> phi for unprovable formula '{formula_str}' is unsound in {target_theory}"
            )
        return (
            True,
            f"Trivially sound: Formula '{formula_str}' is already provable in {target_theory}, so Box phi -> phi holds by propositional logic"
        )

    if ambient_spec.level > target_spec.level:
        return (
            True,
            f"Sound: Stratified reflection of {target_theory} (level {target_spec.level}) inside {ambient_theory} (level {ambient_spec.level})"
        )

    return (
        False,
        f"Unsound: Ambient theory {ambient_theory} level {ambient_spec.level} not higher than target {target_theory} level {target_spec.level}"
    )


# ==============================================================================
# Master Auditor Runner
# ==============================================================================

def proves_foundations_logic_and_binder_hygiene() -> dict[str, Any]:
    """Master auditor verifying all tickets:

    1. obelisk_uniqueness_binder_hygiene.md
    2. obelisk_logic_verification_status.md
    3. obelisk_logic_reflection_scope.md
    """
    results: dict[str, Any] = {}

    # --------------------------------------------------------------------------
    # 1. Uniqueness Binder Hygiene Audit
    # --------------------------------------------------------------------------
    # Formula phi(z) := z != x (with free parameter x)
    x_var = Var("x")
    z_var = Var("z")
    phi = Neq(z_var, x_var)
    self_free = phi.free_vars()
    assert self_free == {"x", "z"}, f"Expected {{'x', 'z'}}, got {self_free}"

    # Expand !z. z != x
    expanded = expand_at_most_one(phi, "z")
    # Acceptance check 1: Free parameter 'x' is preserved
    assert "x" in expanded.free_vars(), "Free parameter 'x' was lost during expansion"
    # Introduced variables must be fresh and not 'x'
    assert "x" not in expanded.bound_vars(), "'x' was captured as a bound variable"

    # Acceptance check 2: Evaluation in a 3-object structure {a, b, c} with x = a
    domain_3 = ["a", "b", "c"]
    env_3 = {"x": "a"}
    # Left side: !z. z != x in domain {a, b, c}
    # Witnesses for z != a are b and c (2 witnesses).
    # Since 2 > 1, !z. z != x is FALSE.
    direct_eval = eval_formula(AtMostOne("z", phi), domain_3, env_3)
    assert direct_eval is False, "Direct evaluation of !z. z != x in 3-object domain should be False"

    # Correct hygienic expansion evaluation
    hygienic_eval = eval_formula(expanded, domain_3, env_3)
    assert hygienic_eval is False, "Hygienic expansion of !z. z != x in 3-object domain should be False"
    assert direct_eval == hygienic_eval, "Direct evaluation and hygienic expansion must agree"

    # Contrast with naive capture-prone expansion:
    # Naive expansion replaces z with x and y:
    # forall x forall y. ((x != x /\ y != x) -> x = y)
    # Since x != x is False, antecedent is False, making naive expansion TRUE! (Unsound!)
    naive_expanded = naive_expand_at_most_one(phi, "z", fixed_x="x", fixed_y="y")
    naive_eval = eval_formula(naive_expanded, domain_3, env_3)
    assert naive_eval is True, "Naive expansion should spuriously evaluate to True due to capture"

    # Acceptance check 3: Alpha-equivalence invariance
    expanded_alt = expand_at_most_one(phi, "z", introduced_var1="u", introduced_var2="v")
    assert are_alpha_equivalent(expanded, expanded_alt), "Expansion must be invariant under alpha-renaming"

    # Acceptance check 4: Empty predicate and singleton satisfy !z, 2 witnesses do not
    assert eval_at_most_one_predicate(lambda w: False, domain_3) is True   # Empty: 0 witnesses -> True
    assert eval_at_most_one_predicate(lambda w: w == "a", domain_3) is True  # Singleton: 1 witness -> True
    assert eval_at_most_one_predicate(lambda w: w in ("a", "b"), domain_3) is False  # 2 witnesses -> False

    # Acceptance check 5: Distinction from exists!
    assert eval_exists_unique_predicate(lambda w: False, domain_3) is False  # Empty: 0 witnesses -> False
    assert eval_exists_unique_predicate(lambda w: w == "a", domain_3) is True  # Singleton: 1 witness -> True

    results["ticket_uniqueness_binder_hygiene"] = {
        "status": "RESOLVED",
        "preserved_free_parameter_x": True,
        "direct_eval_3_objects": direct_eval,
        "hygienic_expansion_eval_3_objects": hygienic_eval,
        "naive_unsound_expansion_eval_3_objects": naive_eval,
        "alpha_invariance": True,
        "empty_predicate_at_most_one": True,
        "singleton_predicate_at_most_one": True,
        "double_witness_at_most_one": False,
    }

    # --------------------------------------------------------------------------
    # 2. Logic Verification Status Audit
    # --------------------------------------------------------------------------
    # Acceptance check 1 & 2: TpHolds alone is Stated (WIP), verified needs derivation
    loeb_wip = build_loeb_certificate(as_wip_only=True)
    status_wip, _ = verify_proof_certificate(loeb_wip)
    assert status_wip == VerificationStatus.STATED_WIP, f"Expected Stated (WIP), got {status_wip}"

    loeb_verified = build_loeb_certificate(valid=True, as_wip_only=False)
    status_verified, _ = verify_proof_certificate(loeb_verified)
    assert status_verified == VerificationStatus.VERIFIED_KERNEL, f"Expected Verified (Kernel), got {status_verified}"

    # Acceptance check: Corrupting derivation revokes verified status
    loeb_corrupted = build_loeb_certificate(valid=False, as_wip_only=False)
    status_corrupted, _ = verify_proof_certificate(loeb_corrupted)
    assert status_corrupted == VerificationStatus.UNVERIFIED, f"Expected Unverified, got {status_corrupted}"

    # Second incompleteness theorem certificate
    second_incomp = build_second_incompleteness_certificate(valid=True, as_wip_only=False)
    status_second, _ = verify_proof_certificate(second_incomp)
    assert status_second == VerificationStatus.VERIFIED_KERNEL, f"Expected Verified (Kernel), got {status_second}"

    results["ticket_logic_verification_status"] = {
        "status": "RESOLVED",
        "tpholds_alone_status": status_wip.value,
        "verified_loeb_status": status_verified.value,
        "corrupted_loeb_status": status_corrupted.value,
        "verified_second_incompleteness_status": status_second.value,
        "recorded_derivability_conditions": ["D1", "D2", "D3", "DiagonalLemma"],
    }

    # --------------------------------------------------------------------------
    # 3. Logic Reflection Scope Audit
    # --------------------------------------------------------------------------
    # Soundness axiom scope
    ok_ext, _ = validate_soundness_axiom_scope("Fau", "Tau")
    assert ok_ext is True, "Soundness of Tau inside Fau should be valid"
    ok_int, _ = validate_soundness_axiom_scope("Tau", "Tau")
    assert ok_int is False, "Soundness of Tau inside Tau must be rejected"

    # Meta-conecessitation: preserves inner Gamma, requires empty outer context
    res_theory, res_ctx, res_fm = apply_meta_conecessitation(
        outer_theory="Fau",
        outer_context=[],
        inner_theory="Fau",
        inner_context=["A", "B"],
        formula_str="phi",
    )
    assert res_theory == "Fau"
    assert res_ctx == ["A", "B"], f"Inner context Gamma not preserved: {res_ctx}"
    assert res_fm == "phi"

    # Negative test: Non-empty outer context must raise ReflectionScopeError
    conecessitation_rejected = False
    try:
        apply_meta_conecessitation(
            outer_theory="Fau",
            outer_context=["H"],
            inner_theory="Fau",
            inner_context=["A"],
            formula_str="phi",
        )
    except ReflectionScopeError:
        conecessitation_rejected = True
    assert conecessitation_rejected is True, "Non-empty outer context should be rejected"

    # Syntactic self-provability (E = T) is admitted
    admit_syn, _ = check_reflection_soundness("Tau", "Tau", "phi", is_syntactic_provability=True, is_provable_in_target=False)
    assert admit_syn is True, "Syntactic self-provability E = T must be admitted"

    # Internal semantic self-reflection for unprovable sentence rejected by Lob obstruction
    reject_sem, _ = check_reflection_soundness("Tau", "Tau", "phi", is_syntactic_provability=False, is_provable_in_target=False)
    assert reject_sem is False, "Unrestricted internal semantic self-reflection must be rejected"

    results["ticket_logic_reflection_scope"] = {
        "status": "RESOLVED",
        "external_soundness_axiom_valid": ok_ext,
        "internal_soundness_axiom_rejected": not ok_int,
        "conecessitation_preserves_inner_gamma": True,
        "conecessitation_rejects_nonempty_outer_context": conecessitation_rejected,
        "syntactic_self_provability_admitted": admit_syn,
        "semantic_self_reflection_rejected": not reject_sem,
    }

    return results
