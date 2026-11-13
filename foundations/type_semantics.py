"""Type semantics and class theory pairing for Foundations of Mathematics.

Formalizes the active mainline type discipline and class theory concepts:
  - Predicates/formulas-as-types, classes-as-expressions (130_classes_as_types.tex);
  - Dunaev Tagged Ordered Pairs for arbitrary classes (070_ordered_pair.tex);
  - Kuratowski pairs restricted strictly to sets;
  - Total evaluation vs guarded evaluation conventions (110_family_evaluation.tex).
"""

from typing import Any, Callable, Dict, FrozenSet, Iterable, List, Optional, Sequence, Set, Tuple


class ProperClassError(TypeError):
    """Raised when an operation requiring sets is applied to a proper class."""


class UniversalClass:
    """Represents the universal class of all sets V = {x | Top}."""

    def __repr__(self) -> str:
        return "V"

    @property
    def is_set(self) -> bool:
        return False


UNIVERSAL_CLASS = UniversalClass()


class ClassObject:
    """Represents a class in Morse-Kelley class theory."""

    def __init__(self, name: str, is_set: bool = True, elements: Optional[Set[Any]] = None) -> None:
        self.name = name
        self.is_set = is_set
        self.elements: Set[Any] = elements if elements is not None else set()

    def __repr__(self) -> str:
        return f"Class({self.name}, is_set={self.is_set})"

    def __eq__(self, other: object) -> bool:
        if isinstance(other, ClassObject):
            return self.name == other.name and self.is_set == other.is_set
        return False

    def __hash__(self) -> int:
        return hash((self.name, self.is_set))


class DunaevTaggedPair:
    """Dunaev Tagged Ordered Pair: (a, b)_D = ({0} x a) u ({1} x b).

    Unlike Kuratowski pairs, Dunaev tagged ordered pairs are well-defined
    for arbitrary classes a and b, including proper classes (e.g. V).
    """

    def __init__(self, first: Any, second: Any) -> None:
        self.first = first
        self.second = second

    def __repr__(self) -> str:
        return f"DunaevPair({self.first!r}, {self.second!r})"

    def __eq__(self, other: object) -> bool:
        if isinstance(other, DunaevTaggedPair):
            return self.first == other.first and self.second == other.second
        return False

    def __hash__(self) -> int:
        return hash((0, self.first, 1, self.second))


def dunaev_pair(a: Any, b: Any) -> DunaevTaggedPair:
    """Constructs a Dunaev Tagged Ordered Pair for arbitrary classes."""
    return DunaevTaggedPair(a, b)


def dunaev_fst(pair: DunaevTaggedPair) -> Any:
    """Extracts the first projection from a Dunaev Tagged Ordered Pair."""
    if not isinstance(pair, DunaevTaggedPair):
        raise TypeError(f"Expected DunaevTaggedPair, got {type(pair)}")
    return pair.first


def dunaev_snd(pair: DunaevTaggedPair) -> Any:
    """Extracts the second projection from a Dunaev Tagged Ordered Pair."""
    if not isinstance(pair, DunaevTaggedPair):
        raise TypeError(f"Expected DunaevTaggedPair, got {type(pair)}")
    return pair.second


class KuratowskiPair:
    """Kuratowski Ordered Pair: (a, b)_K = {{a}, {a, b}}.

    Valid ONLY when a and b are sets. Proper classes cannot be members of sets.
    """

    def __init__(self, first: Any, second: Any) -> None:
        if getattr(first, "is_set", True) is False:
            raise ProperClassError(f"Kuratowski pair first element must be a set, got {first}")
        if getattr(second, "is_set", True) is False:
            raise ProperClassError(f"Kuratowski pair second element must be a set, got {second}")
        self.first = first
        self.second = second

    def __repr__(self) -> str:
        return f"KuratowskiPair({self.first!r}, {self.second!r})"

    def __eq__(self, other: object) -> bool:
        if isinstance(other, KuratowskiPair):
            return self.first == other.first and self.second == other.second
        return False


def kuratowski_pair(a: Any, b: Any) -> KuratowskiPair:
    """Constructs a Kuratowski pair, raising ProperClassError if either is a proper class."""
    return KuratowskiPair(a, b)


# Conglomerate types: predicates on the domain of classes (Class -> Bool)
ConglomerateType = Callable[[Any], bool]

CLASS_TYPE: ConglomerateType = lambda c: True
SET_TYPE: ConglomerateType = lambda c: getattr(c, "is_set", True)


def has_type(term: Any, type_predicate: ConglomerateType) -> bool:
    """Judgement that term satisfies the type predicate."""
    return bool(type_predicate(term))


def total_evaluation(
    family_graph: Sequence[Tuple[Any, Any]],
    argument: Any,
    empty_default: Any = None,
) -> Any:
    """Prototype total union evaluation: F(x) := union {s | (x, s) in F}.

    Defaults to empty_default when x is not in the domain.
    """
    matches = [s for (x, s) in family_graph if x == argument]
    if not matches:
        return empty_default
    if len(matches) == 1:
        return matches[0]
    return matches


def guarded_evaluation(
    family_graph: Sequence[Tuple[Any, Any]],
    argument: Any,
    domain: Set[Any],
    universe_default: Any = UNIVERSAL_CLASS,
) -> Any:
    """Guarded evaluation: returns union {s | (x, s) in F} if x in domain, else V."""
    if argument not in domain:
        return universe_default
    matches = [s for (x, s) in family_graph if x == argument]
    if not matches:
        return universe_default
    if len(matches) == 1:
        return matches[0]
    return matches


# Well-founded class relations and transfinite recursion under MKTD


def relation_predecessors(
    relation_pairs: Sequence[Tuple[Any, Any]],
    element: Any,
) -> List[Any]:
    """Returns the list of R-predecessors of an element: {y | (y, element) in R}."""
    return [y for (y, x) in relation_pairs if x == element]


def is_well_founded_relation(
    relation_pairs: Sequence[Tuple[Any, Any]],
    domain: Set[Any],
) -> bool:
    """Verifies well-foundedness of relation R on class domain.

    Under Morse-Kelley, a relation R is well-founded on domain A if every
    non-empty subclass X of A has an R-minimal element:
    exists m in X such that for all y in X, (y, m) not in R.
    For finite test models, we verify this over all non-empty subsets.
    """
    domain_list = list(domain)
    n = len(domain_list)
    # Check all non-empty subsets
    for i in range(1, 1 << n):
        subset = {domain_list[j] for j in range(n) if (i & (1 << j))}
        has_minimal = False
        for m in subset:
            preds = {y for (y, x) in relation_pairs if x == m and y in subset}
            if not preds:
                has_minimal = True
                break
        if not has_minimal:
            return False
    return True


def transfinite_recursion_eval(
    step_fn: Callable[[Any, Callable[[Any], Any]], Any],
    relation_pairs: Sequence[Tuple[Any, Any]],
    domain_elements: Sequence[Any],
) -> Dict[Any, Any]:
    """Evaluates transfinite recursion on well-founded class domain.

    Computes F(x) = step_fn(x, F_restr), where F_restr is the restriction
    of F to the R-predecessors of x.
    Operates without assuming class-sized sets, applying local predecessor graphs.
    """
    results: Dict[Any, Any] = {}

    def get_val(x: Any) -> Any:
        if x in results:
            return results[x]
        preds = relation_predecessors(relation_pairs, x)
        restr_fn = lambda y: results[y] if y in preds else None
        val = step_fn(x, restr_fn)
        results[x] = val
        return val

    for elem in domain_elements:
        get_val(elem)

    return results


# Categorical semantics of class comprehension and universal constructions in MKTD


class InitialClass:
    """Canonical initial object 0 = Empty in the category of classes."""

    def __repr__(self) -> str:
        return "InitialClass(Empty)"


INITIAL_CLASS = InitialClass()


class TerminalClass:
    """Canonical terminal object 1 = {Empty} in the category of classes."""

    def __repr__(self) -> str:
        return "TerminalClass(1)"


TERMINAL_CLASS = TerminalClass()


def initial_morphism(target_class: Any) -> Callable[[Any], Any]:
    """Unique morphism from the initial object to any target class."""
    def morphism(x: Any) -> Any:
        raise ValueError("No elements exist in the initial object")
    return morphism


def terminal_morphism(source_class: Any) -> Callable[[Any], Any]:
    """Unique morphism from any source class to the terminal object 1."""
    return lambda x: TERMINAL_CLASS


class DunaevProduct:
    """Binary categorical product A cross_D B using Dunaev Tagged Ordered Pairs.

    Because Dunaev tagged pairs are well-defined for proper classes,
    categorical products exist for all classes in MKTD without Kuratowski obstruction.
    """

    def __init__(self, first_class: Any, second_class: Any) -> None:
        self.first_class = first_class
        self.second_class = second_class

    def __repr__(self) -> str:
        return f"DunaevProduct({self.first_class!r}, {self.second_class!r})"

    def pair(self, a: Any, b: Any) -> DunaevTaggedPair:
        return dunaev_pair(a, b)

    def proj1(self, pair: DunaevTaggedPair) -> Any:
        return dunaev_fst(pair)

    def proj2(self, pair: DunaevTaggedPair) -> Any:
        return dunaev_snd(pair)


def dunaev_pairing_morphism(
    f: Callable[[Any], Any],
    g: Callable[[Any], Any],
) -> Callable[[Any], DunaevTaggedPair]:
    """Universal pairing morphism <f, g>_D : C to A cross_D B.

    Satisfies: proj1 o <f, g>_D = f and proj2 o <f, g>_D = g.
    """
    return lambda c: dunaev_pair(f(c), g(c))


def categorical_equalizer(
    f: Callable[[Any], Any],
    g: Callable[[Any], Any],
    domain_candidates: Sequence[Any],
) -> List[Any]:
    """Categorical equalizer Eq(f, g) = {x in A | f(x) = g(x)}."""
    return [x for x in domain_candidates if f(x) == g(x)]


def categorical_subobject_comprehension(
    predicate: Callable[[Any], bool],
    domain_candidates: Sequence[Any],
) -> List[Any]:
    """Class comprehension as categorical equalizer.

    Equalizer of characteristic morphism chi_phi and constant true morphism.
    """
    chi = lambda x: bool(predicate(x))
    const_true = lambda x: True
    return categorical_equalizer(chi, const_true, domain_candidates)


# Model-Theoretic Metamathematics, Tarski Truth Definition & Cumulative Hierarchy Reflection


class TransitiveModel:
    """Represents a model structure M = (domain, in_rel) under MKTD.

    For transitive set models, in_rel is standard set membership.
    For class models, in_rel can be evaluated over Dunaev tagged pairs or predicates.
    """

    def __init__(
        self,
        domain: Iterable[Any],
        in_rel: Optional[Callable[[Any, Any], bool]] = None,
        name: str = "M",
    ) -> None:
        self.domain = list(domain)
        self.name = name
        self.in_rel = in_rel if in_rel is not None else (lambda x, y: x in y)

    def __repr__(self) -> str:
        return f"TransitiveModel({self.name}, size={len(self.domain)})"

    def satisfies(self, formula: Any, assignment: Optional[Dict[str, Any]] = None) -> bool:
        """Evaluates whether this model satisfies formula under variable assignment."""
        return model_satisfaction(
            self.domain,
            formula,
            assignment or {},
            in_rel=self.in_rel,
        )


def model_satisfaction(
    domain: Iterable[Any],
    formula: Any,
    assignment: Dict[str, Any],
    in_rel: Optional[Callable[[Any, Any], bool]] = None,
) -> bool:
    """Tarski truth definition for satisfaction relation M |= phi[s].

    Formula is represented as nested tuples:
      - ("in", t1, t2)
      - ("eq", t1, t2)
      - ("subclass", t1, t2)
      - ("not", phi)
      - ("and", phi, psi)
      - ("or", phi, psi)
      - ("imp", phi, psi)
      - ("iff", phi, psi)
      - ("forall", var, phi)
      - ("exists", var, phi)
      - ("exists_unique", var, phi)
    """
    domain_list = list(domain)
    rel = in_rel if in_rel is not None else (lambda x, y: x in y)

    def term_val(t: Any) -> Any:
        if isinstance(t, str) and t in assignment:
            return assignment[t]
        return t

    tag = formula[0]

    if tag == "in":
        return rel(term_val(formula[1]), term_val(formula[2]))
    elif tag == "eq":
        return term_val(formula[1]) == term_val(formula[2])
    elif tag == "subclass":
        a = term_val(formula[1])
        b = term_val(formula[2])
        return all((not rel(x, a)) or rel(x, b) for x in domain_list)
    elif tag == "not":
        return not model_satisfaction(domain_list, formula[1], assignment, rel)
    elif tag == "and":
        return model_satisfaction(domain_list, formula[1], assignment, rel) and model_satisfaction(
            domain_list, formula[2], assignment, rel
        )
    elif tag == "or":
        return model_satisfaction(domain_list, formula[1], assignment, rel) or model_satisfaction(
            domain_list, formula[2], assignment, rel
        )
    elif tag == "imp":
        return (not model_satisfaction(domain_list, formula[1], assignment, rel)) or model_satisfaction(
            domain_list, formula[2], assignment, rel
        )
    elif tag == "iff":
        return model_satisfaction(domain_list, formula[1], assignment, rel) == model_satisfaction(
            domain_list, formula[2], assignment, rel
        )
    elif tag == "forall":
        var = formula[1]
        body = formula[2]
        for elem in domain_list:
            new_assign = dict(assignment)
            new_assign[var] = elem
            if not model_satisfaction(domain_list, body, new_assign, rel):
                return False
        return True
    elif tag == "exists":
        var = formula[1]
        body = formula[2]
        for elem in domain_list:
            new_assign = dict(assignment)
            new_assign[var] = elem
            if model_satisfaction(domain_list, body, new_assign, rel):
                return True
        return False
    elif tag == "exists_unique":
        var = formula[1]
        body = formula[2]
        witnesses = 0
        for elem in domain_list:
            new_assign = dict(assignment)
            new_assign[var] = elem
            if model_satisfaction(domain_list, body, new_assign, rel):
                witnesses += 1
                if witnesses > 1:
                    return False
        return witnesses == 1
    else:
        raise ValueError(f"Unknown formula constructor: {tag}")


def relativize_formula(formula: Any, model_class_name: str) -> Any:
    """Relativizes quantifiers in formula to bounded quantifiers over model_class_name.

    - forall x. phi  becomes  forall x. (In(x, M) -> phi^M)
    - exists x. phi  becomes  exists x. (In(x, M) and phi^M)
    """
    tag = formula[0]
    if tag in ("in", "eq", "subclass"):
        return formula
    elif tag == "not":
        return ("not", relativize_formula(formula[1], model_class_name))
    elif tag in ("and", "or", "imp", "iff"):
        return (
            tag,
            relativize_formula(formula[1], model_class_name),
            relativize_formula(formula[2], model_class_name),
        )
    elif tag == "forall":
        var = formula[1]
        rel_body = relativize_formula(formula[2], model_class_name)
        return ("forall", var, ("imp", ("in", var, model_class_name), rel_body))
    elif tag == "exists":
        var = formula[1]
        rel_body = relativize_formula(formula[2], model_class_name)
        return ("exists", var, ("and", ("in", var, model_class_name), rel_body))
    elif tag == "exists_unique":
        var = formula[1]
        rel_body = relativize_formula(formula[2], model_class_name)
        return ("exists_unique", var, ("and", ("in", var, model_class_name), rel_body))
    else:
        return formula


def cumulative_hierarchy_v(n: int) -> FrozenSet[Any]:
    """Generates the cumulative hierarchy stage V_n as hereditarily finite sets.

    V_0 = empty
    V_{n+1} = Powerset(V_n)
    """
    v: FrozenSet[Any] = frozenset()
    for _ in range(n):
        elem_list = list(v)
        k = len(elem_list)
        subsets = [
            frozenset(elem_list[j] for j in range(k) if (mask & (1 << j)))
            for mask in range(1 << k)
        ]
        v = frozenset(subsets)
    return v


def reflects_formula(
    submodel_domain: Iterable[Any],
    ambient_domain: Iterable[Any],
    formula: Any,
    free_vars: Sequence[str],
    in_rel: Optional[Callable[[Any, Any], bool]] = None,
) -> bool:
    """Verifies whether submodel_domain reflects formula with respect to ambient_domain.

    Submodel M reflects phi iff for all assignments s : free_vars -> M:
      (M |= phi[s]) <-> (Ambient |= phi[s])
    """
    sub_list = list(submodel_domain)
    amb_list = list(ambient_domain)

    def check_assignments(vars_left: Sequence[str], current_assign: Dict[str, Any]) -> bool:
        if not vars_left:
            sat_sub = model_satisfaction(sub_list, formula, current_assign, in_rel)
            sat_amb = model_satisfaction(amb_list, formula, current_assign, in_rel)
            return sat_sub == sat_amb
        v = vars_left[0]
        for elem in sub_list:
            new_assign = dict(current_assign)
            new_assign[v] = elem
            if not check_assignments(vars_left[1:], new_assign):
                return False
        return True

    return check_assignments(list(free_vars), {})


def find_reflecting_stage(
    formula: Any,
    free_vars: Sequence[str],
    max_stage: int = 3,
    in_rel: Optional[Callable[[Any, Any], bool]] = None,
) -> Optional[int]:
    """Finds the smallest cumulative hierarchy stage V_alpha reflecting formula.

    Searches stages alpha in 1..max_stage reflecting relative to V_{max_stage}.
    """
    ambient = cumulative_hierarchy_v(max_stage)
    for stage in range(1, max_stage + 1):
        v_stage = cumulative_hierarchy_v(stage)
        if reflects_formula(v_stage, ambient, formula, free_vars, in_rel):
            return stage
    return None

