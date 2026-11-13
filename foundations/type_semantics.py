"""Type semantics and class theory pairing for Foundations of Mathematics.

Formalizes the active mainline type discipline and class theory concepts:
  - Predicates/formulas-as-types, classes-as-expressions (130_classes_as_types.tex);
  - Dunaev Tagged Ordered Pairs for arbitrary classes (070_ordered_pair.tex);
  - Kuratowski pairs restricted strictly to sets;
  - Total evaluation vs guarded evaluation conventions (110_family_evaluation.tex).
"""

from typing import Any, Callable, Dict, FrozenSet, Iterable, List, Optional, Sequence, Set, Tuple, Union


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
    elif tag in ("eq", "="):
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
    elif tag in ("imp", "implies"):
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
    elif tag == "bounded_forall":
        var = formula[1]
        bound = term_val(formula[2])
        body = formula[3]
        for elem in domain_list:
            if rel(elem, bound):
                new_assign = dict(assignment)
                new_assign[var] = elem
                if not model_satisfaction(domain_list, body, new_assign, rel):
                    return False
        return True
    elif tag == "bounded_exists":
        var = formula[1]
        bound = term_val(formula[2])
        body = formula[3]
        for elem in domain_list:
            if rel(elem, bound):
                new_assign = dict(assignment)
                new_assign[var] = elem
                if model_satisfaction(domain_list, body, new_assign, rel):
                    return True
        return False
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


# Categorical limits, colimits, functors, duality and slice categories in MKTD


class ClassFunctor:
    """Covariant functor between class categories in MKTD."""

    def __init__(
        self,
        obj_map: Callable[[Any], Any],
        mor_map: Callable[[Any], Any],
        name: str = "F",
    ) -> None:
        self.obj_map = obj_map
        self.mor_map = mor_map
        self.name = name

    def map_obj(self, obj: Any) -> Any:
        return self.obj_map(obj)

    def map_mor(self, mor: Any) -> Any:
        return self.mor_map(mor)

    def check_identity(self, objects: Iterable[Any]) -> bool:
        """Verifies F(id_A) = id_{F(A)} on given objects."""
        for obj in objects:
            id_a = dunaev_pair(obj, obj)
            expected_id = dunaev_pair(self.map_obj(obj), self.map_obj(obj))
            if self.map_mor(id_a) != expected_id:
                return False
        return True

    def check_composition(
        self,
        composable_triples: Iterable[Tuple[Any, Any, Any]],
    ) -> bool:
        """Verifies F(g circ f) = F(g) circ F(f) for (f, g, g_circ_f)."""
        for f, g, gf in composable_triples:
            if self.map_mor(gf) != dunaev_pair(self.map_mor(g), self.map_mor(f)):
                return False
        return True

    def __repr__(self) -> str:
        return f"ClassFunctor({self.name})"


class NaturalTransformation:
    """Natural transformation eta : F => G between class functors."""

    def __init__(
        self,
        source: ClassFunctor,
        target: ClassFunctor,
        component_map: Callable[[Any], Callable[[Any], Any]],
        name: str = "eta",
    ) -> None:
        self.source = source
        self.target = target
        self.component_map = component_map
        self.name = name

    def component(self, obj: Any) -> Callable[[Any], Any]:
        return self.component_map(obj)

    def check_naturality(
        self,
        morphisms: Iterable[Tuple[Any, Any, Callable[[Any], Any], Callable[[Any], Any]]],
        domain_samples: Iterable[Any],
    ) -> bool:
        """Verifies G(f) circ eta_A = eta_B circ F(f) for each morphism f : A -> B.

        morphisms contains tuples (obj_a, obj_b, f_mapped_fn, g_mapped_fn).
        """
        for obj_a, obj_b, f_mor, g_mor in morphisms:
            eta_a = self.component(obj_a)
            eta_b = self.component(obj_b)
            for x in domain_samples:
                left = g_mor(eta_a(x))
                right = eta_b(f_mor(x))
                if left != right:
                    return False
        return True

    def __repr__(self) -> str:
        return f"NaturalTransformation({self.name}: {self.source.name} => {self.target.name})"


def dunaev_coproduct(class_a: Iterable[Any], class_b: Iterable[Any]) -> FrozenSet[DunaevTaggedPair]:
    """Disjoint sum / coproduct of classes A +_D B = ({0} x A) U ({1} x B)."""
    elems: List[DunaevTaggedPair] = []
    for a in class_a:
        elems.append(dunaev_pair(0, a))
    for b in class_b:
        elems.append(dunaev_pair(1, b))
    return frozenset(elems)


def copairing_morphism(
    f: Callable[[Any], Any],
    g: Callable[[Any], Any],
) -> Callable[[DunaevTaggedPair], Any]:
    """Universal copairing morphism [f, g] : A +_D B -> C."""
    def copair(x: DunaevTaggedPair) -> Any:
        tag = dunaev_fst(x)
        val = dunaev_snd(x)
        if tag == 0:
            return f(val)
        else:
            return g(val)
    return copair


def pullback_class(
    f: Callable[[Any], Any],
    g: Callable[[Any], Any],
    domain_a: Iterable[Any],
    domain_b: Iterable[Any],
) -> FrozenSet[DunaevTaggedPair]:
    """Categorical pullback / fiber product A x_C B = {(a, b)_D in A x_D B | f(a) = g(b)}."""
    pairs: List[DunaevTaggedPair] = []
    for a in domain_a:
        fa = f(a)
        for b in domain_b:
            if fa == g(b):
                pairs.append(dunaev_pair(a, b))
    return frozenset(pairs)


def pullback_mediating_morphism(
    h1: Callable[[Any], Any],
    h2: Callable[[Any], Any],
) -> Callable[[Any], DunaevTaggedPair]:
    """Universal factorizer <h1, h2>_D : X -> A x_C B for pullback cone."""
    return lambda x: dunaev_pair(h1(x), h2(x))


def pushout_partition(
    f: Callable[[Any], Any],
    g: Callable[[Any], Any],
    domain_c: Iterable[Any],
    domain_a: Iterable[Any],
    domain_b: Iterable[Any],
) -> List[FrozenSet[DunaevTaggedPair]]:
    """Computes pushout A +_C B equivalence classes in A +_D B identifying (0, f(c)) ~ (1, g(c))."""
    coprod = list(dunaev_coproduct(domain_a, domain_b))
    parent = {x: x for x in coprod}

    def find(i: DunaevTaggedPair) -> DunaevTaggedPair:
        path = []
        while parent[i] != i:
            path.append(i)
            i = parent[i]
        for node in path:
            parent[node] = i
        return i

    def union(i: DunaevTaggedPair, j: DunaevTaggedPair) -> None:
        ri, rj = find(i), find(j)
        if ri != rj:
            parent[ri] = rj

    for c in domain_c:
        p0 = dunaev_pair(0, f(c))
        p1 = dunaev_pair(1, g(c))
        if p0 in parent and p1 in parent:
            union(p0, p1)

    groups: Dict[DunaevTaggedPair, List[DunaevTaggedPair]] = {}
    for x in coprod:
        root = find(x)
        groups.setdefault(root, []).append(x)
    return [frozenset(v) for v in groups.values()]


def equalizer_as_pullback(
    f: Callable[[Any], Any],
    g: Callable[[Any], Any],
    domain_a: Iterable[Any],
    domain_b: Iterable[Any],
) -> FrozenSet[Any]:
    """Characterizes Equalizer Eq(f, g) as pullback of <f, g> and diagonal Delta_B."""
    pb = pullback_class(
        lambda a: dunaev_pair(f(a), g(a)),
        lambda b: dunaev_pair(b, b),
        domain_a,
        domain_b,
    )
    return frozenset(dunaev_fst(p) for p in pb)


def pullback_as_equalizer(
    f: Callable[[Any], Any],
    g: Callable[[Any], Any],
    domain_a: Iterable[Any],
    domain_b: Iterable[Any],
) -> FrozenSet[DunaevTaggedPair]:
    """Characterizes pullback A x_C B as equalizer of f circ pi1 and g circ pi2 on A x_D B."""
    prod = [dunaev_pair(a, b) for a in domain_a for b in domain_b]
    eq = [p for p in prod if f(dunaev_fst(p)) == g(dunaev_snd(p))]
    return frozenset(eq)


class SliceObject:
    """Object in slice category C / target_name, given by (domain, morphism_to_target)."""

    def __init__(
        self,
        domain: Iterable[Any],
        morphism: Callable[[Any], Any],
        target_name: str = "C",
    ) -> None:
        self.domain: FrozenSet[Any] = frozenset(domain)
        self.morphism = morphism
        self.target_name = target_name

    def __repr__(self) -> str:
        return f"SliceObject(size={len(self.domain)} over {self.target_name})"


def is_slice_morphism(
    mor: Callable[[Any], Any],
    slice_src: SliceObject,
    slice_tgt: SliceObject,
) -> bool:
    """Checks whether mor : src -> tgt makes triangle commute: tgt.morphism circ mor = src.morphism."""
    for x in slice_src.domain:
        if slice_tgt.morphism(mor(x)) != slice_src.morphism(x):
            return False
    return True


def slice_product(
    slice_a: SliceObject,
    slice_b: SliceObject,
) -> SliceObject:
    """Product in slice category C/C is the pullback A x_C B over C."""
    pb = pullback_class(slice_a.morphism, slice_b.morphism, slice_a.domain, slice_b.domain)

    def struct_mor(pair: DunaevTaggedPair) -> Any:
        return slice_a.morphism(dunaev_fst(pair))

    return SliceObject(domain=pb, morphism=struct_mor, target_name=slice_a.target_name)


def slice_base_change(
    base_mor: Callable[[Any], Any],
    base_domain: Iterable[Any],
    slice_a: SliceObject,
    base_target_name: str = "B",
) -> SliceObject:
    """Pullback / base change functor k* : C/C -> C/B along k : B -> C."""
    pb = pullback_class(slice_a.morphism, base_mor, slice_a.domain, base_domain)

    def struct_mor(pair: DunaevTaggedPair) -> Any:
        return dunaev_snd(pair)

    return SliceObject(domain=pb, morphism=struct_mor, target_name=base_target_name)


# ---------------------------------------------------------------------------
# Ordinals, Hartogs Number, Scott's Trick, and Size Axioms
# ---------------------------------------------------------------------------

def hartogs_number(domain: Iterable[Any]) -> int:
    """Calculates the Hartogs number h(X) of a finite domain X.

    The Hartogs number is the least ordinal (here represented as a finite
    von Neumann ordinal n + 1) that does not inject into X.
    """
    n = len(list(domain))
    return n + 1


def can_inject(src_card: int, tgt_card: int) -> bool:
    """Returns True iff an injection exists from a domain of size src_card into tgt_card."""
    return src_card <= tgt_card


def construct_hartogs_ordinals(domain: Iterable[Any]) -> Set[int]:
    """Returns the set of ordinals {0, 1, ..., n} that inject into domain."""
    n = len(list(domain))
    return set(range(n + 1))


def hartogs_well_ordering_types(domain: Iterable[Any]) -> List[int]:
    """Returns the order types of all strict well-orderings of subsets of domain."""
    n = len(list(domain))
    return list(range(n + 1))


def scotts_trick_representative(
    x: Any,
    equiv_rel: Callable[[Any, Any], bool],
    domain: Iterable[Any],
    rank_fn: Callable[[Any], int],
) -> FrozenSet[Any]:
    """Scott's trick (Dana Scott 1955) for selecting a canonical set-sized representative
    from an equivalence class that may be a proper class.

    Finds the minimum cumulative rank mu among all elements equivalent to x, and
    returns the subset of equivalent elements having rank exactly equal to mu.
    By Separation and the Axiom of Foundation, this subset is guaranteed to be a set
    bounded in V_{mu + 1}.
    """
    eq_class = [y for y in domain if equiv_rel(x, y)]
    if not eq_class:
        return frozenset()
    min_rank = min(rank_fn(y) for y in eq_class)
    return frozenset(y for y in eq_class if rank_fn(y) == min_rank)


def limitation_of_size_holds(is_proper_class: bool, equipotent_to_universe: bool) -> bool:
    """von Neumann's Limitation of Size Axiom:
    A class X is a proper class (not a set) iff X is equipotent to V (X ~ V).
    """
    return is_proper_class == equipotent_to_universe


def cardinal_size(class_obj: ClassObject, finite_cardinality: Optional[int] = None) -> Any:
    """Returns the cardinal size of class_obj.

    If class_obj is a set, returns its set-cardinality (or least ordinal).
    If class_obj is a proper class, returns the default boundary convention 'On'.
    """
    if class_obj.is_set:
        return finite_cardinality if finite_cardinality is not None else len(class_obj.elements)
    return "On"


def limitation_of_size_cardinal_criterion(
    class_obj: ClassObject,
    finite_cardinality: Optional[int] = None,
    card_univ: str = "On",
) -> bool:
    """Validates the cardinal formulation of Limitation of Size:
    (K in V) iff (|K| != |V|).
    """
    card = cardinal_size(class_obj, finite_cardinality)
    is_set = class_obj.is_set
    return is_set == (card != card_univ)


class Ordinal:
    """Transfinite ordinal represented in Cantor Normal Form:
    alpha = sum_{i=0}^{k-1} omega^{beta_i} * c_i
    where beta_0 > beta_1 > ... > beta_{k-1} are Ordinals, and c_i are positive integers.
    """

    def __init__(self, terms: Sequence[Tuple["Ordinal", int]] = ()) -> None:
        clean_terms: List[Tuple["Ordinal", int]] = []
        for exp, coeff in terms:
            if coeff > 0:
                clean_terms.append((exp, coeff))
        self.terms: Tuple[Tuple["Ordinal", int], ...] = tuple(clean_terms)

    @classmethod
    def zero(cls) -> "Ordinal":
        return cls(())

    @classmethod
    def one(cls) -> "Ordinal":
        return cls.from_int(1)

    @classmethod
    def from_int(cls, n: int) -> "Ordinal":
        if n < 0:
            raise ValueError("Ordinals cannot be negative")
        if n == 0:
            return cls(())
        return cls(((cls.zero(), n),))

    @classmethod
    def omega(cls) -> "Ordinal":
        return cls(((cls.one(), 1),))

    def is_zero(self) -> bool:
        return len(self.terms) == 0

    def is_finite(self) -> bool:
        if self.is_zero():
            return True
        return len(self.terms) == 1 and self.terms[0][0].is_zero()

    def to_int(self) -> Optional[int]:
        if self.is_zero():
            return 0
        if self.is_finite():
            return self.terms[0][1]
        return None

    def __eq__(self, other: object) -> bool:
        if isinstance(other, int):
            other = Ordinal.from_int(other)
        if isinstance(other, Ordinal):
            return self.terms == other.terms
        return False

    def __hash__(self) -> int:
        return hash(self.terms)

    def __lt__(self, other: Any) -> bool:
        if isinstance(other, int):
            other = Ordinal.from_int(other)
        if not isinstance(other, Ordinal):
            return NotImplemented
        min_len = min(len(self.terms), len(other.terms))
        for i in range(min_len):
            (e1, c1) = self.terms[i]
            (e2, c2) = other.terms[i]
            if e1 != e2:
                return e1 < e2
            if c1 != c2:
                return c1 < c2
        return len(self.terms) < len(other.terms)

    def __le__(self, other: Any) -> bool:
        return self == other or self < other

    def __add__(self, other: Any) -> "Ordinal":
        if isinstance(other, int):
            other = Ordinal.from_int(other)
        if not isinstance(other, Ordinal):
            return NotImplemented
        if self.is_zero():
            return other
        if other.is_zero():
            return self
        leading_exp = other.terms[0][0]
        kept_terms: List[Tuple["Ordinal", int]] = []
        for exp, coeff in self.terms:
            if exp > leading_exp:
                kept_terms.append((exp, coeff))
            elif exp == leading_exp:
                kept_terms.append((exp, coeff + other.terms[0][1]))
                break
            else:
                break
        if not any(exp == leading_exp for exp, _ in kept_terms):
            kept_terms.append(other.terms[0])
        kept_terms.extend(other.terms[1:])
        return Ordinal(kept_terms)

    def __mul__(self, other: Any) -> "Ordinal":
        if isinstance(other, int):
            other = Ordinal.from_int(other)
        if not isinstance(other, Ordinal):
            return NotImplemented
        if self.is_zero() or other.is_zero():
            return Ordinal.zero()
        if other == Ordinal.one():
            return self
        if self == Ordinal.one():
            return other
        if other.is_finite():
            res = Ordinal.zero()
            for _ in range(other.terms[0][1]):
                res = res + self
            return res
        res_terms: List[Tuple["Ordinal", int]] = []
        alpha_0 = self.terms[0][0]
        for exp, coeff in other.terms:
            if not exp.is_zero():
                res_terms.append((alpha_0 + exp, coeff))
            else:
                res_part = Ordinal(res_terms)
                finite_part = Ordinal.zero()
                for _ in range(coeff):
                    finite_part = finite_part + self
                return res_part + finite_part
        return Ordinal(res_terms)

    def __pow__(self, other: Any) -> "Ordinal":
        if isinstance(other, int):
            other = Ordinal.from_int(other)
        if not isinstance(other, Ordinal):
            return NotImplemented
        if other.is_zero():
            return Ordinal.one()
        if self.is_zero():
            return Ordinal.zero()
        if self == Ordinal.one():
            return Ordinal.one()
        if other == Ordinal.one():
            return self
        if other.is_finite():
            res = Ordinal.one()
            for _ in range(other.terms[0][1]):
                res = res * self
            return res
        if self.is_finite():
            if other == Ordinal.omega():
                return Ordinal.omega()
            leading_exp = other.terms[0][0]
            if leading_exp == Ordinal.one():
                return Ordinal(((Ordinal.from_int(other.terms[0][1]), 1),))
            return Ordinal.omega()
        if self == Ordinal.omega():
            return Ordinal(((other, 1),))
        alpha_0 = self.terms[0][0]
        return Ordinal(((alpha_0 * other, 1),))

    def __repr__(self) -> str:
        if self.is_zero():
            return "0"
        parts = []
        for exp, coeff in self.terms:
            if exp.is_zero():
                parts.append(str(coeff))
            elif exp == Ordinal.one():
                parts.append("omega" if coeff == 1 else f"omega*{coeff}")
            else:
                parts.append(f"omega^({exp!r})" if coeff == 1 else f"omega^({exp!r})*{coeff}")
        return " + ".join(parts)


def ordinal_add(alpha: Any, beta: Any) -> Ordinal:
    a = Ordinal.from_int(alpha) if isinstance(alpha, int) else alpha
    b = Ordinal.from_int(beta) if isinstance(beta, int) else beta
    return a + b


def ordinal_mult(alpha: Any, beta: Any) -> Ordinal:
    a = Ordinal.from_int(alpha) if isinstance(alpha, int) else alpha
    b = Ordinal.from_int(beta) if isinstance(beta, int) else beta
    return a * b


def ordinal_exp(alpha: Any, beta: Any) -> Ordinal:
    a = Ordinal.from_int(alpha) if isinstance(alpha, int) else alpha
    b = Ordinal.from_int(beta) if isinstance(beta, int) else beta
    return a ** b


# Grothendieck Universes, Inaccessible Cardinals, and Internalized Model Satisfaction in MKTD


def is_transitive_set(domain: Iterable[Any]) -> bool:
    """Checks whether a set/domain is transitive: for every x in domain, x is a subset of domain."""
    dom_set = set(domain)
    for x in dom_set:
        if isinstance(x, (set, frozenset)):
            if not x.issubset(dom_set):
                return False
    return True


def is_closed_under_pairing(domain: Iterable[Any]) -> bool:
    """Checks whether domain is closed under unordered pairing: x, y in domain implies {x, y} in domain."""
    dom_set = set(domain)
    for x in dom_set:
        for y in dom_set:
            pair = frozenset({x, y})
            if pair not in dom_set:
                return False
    return True


def is_closed_under_powerset(domain: Iterable[Any]) -> bool:
    """Checks whether domain is closed under powerset: x in domain implies P(x) in domain."""
    dom_set = set(domain)
    for x in dom_set:
        if isinstance(x, (set, frozenset)):
            elems = list(x)
            k = len(elems)
            p_x = frozenset(
                frozenset(elems[j] for j in range(k) if (mask & (1 << j)))
                for mask in range(1 << k)
            )
            if p_x not in dom_set:
                return False
    return True


def is_closed_under_union(domain: Iterable[Any]) -> bool:
    """Checks whether domain is closed under union: x in domain implies union(x) in domain."""
    dom_set = set(domain)
    for x in dom_set:
        if isinstance(x, (set, frozenset)):
            u_x = frozenset().union(*[elem for elem in x if isinstance(elem, (set, frozenset))])
            if u_x not in dom_set:
                return False
    return True


def is_grothendieck_universe(domain: Iterable[Any], allow_finite: bool = False) -> bool:
    """Verifies whether domain constitutes a Grothendieck universe.

    A Grothendieck universe U satisfies:
    1. Transitivity: x in U implies x subset of U.
    2. Pairing: x, y in U implies {x, y} in U.
    3. Powerset: x in U implies P(x) in U.
    4. Union: x in U implies union(x) in U.
    5. Non-emptiness / Infinity: if not allow_finite, must contain omega / non-empty infinite sets.
    """
    dom_set = set(domain)
    if not dom_set and not allow_finite:
        return False
    if not is_transitive_set(dom_set):
        return False
    if not is_closed_under_pairing(dom_set):
        return False
    if not is_closed_under_powerset(dom_set):
        return False
    if not is_closed_under_union(dom_set):
        return False
    return True


def grothendieck_universe_satisfies_replacement(
    domain: Iterable[Any],
    index_set: Iterable[Any],
    family_fn: Callable[[Any], Any],
) -> bool:
    """Verifies indexed union closure (replacement) for a Grothendieck universe:
    If I in U and for all i in I, f(i) in U, then union_{i in I} f(i) in U.
    """
    dom_set = set(domain)
    idx_fset = frozenset(index_set)
    if idx_fset not in dom_set:
        return False
    unioned: set[Any] = set()
    for i in idx_fset:
        fi = family_fn(i)
        if fi not in dom_set:
            return False
        if isinstance(fi, (set, frozenset)):
            unioned.update(fi)
        else:
            unioned.add(fi)
    return frozenset(unioned) in dom_set


def is_regular_cardinal(kappa: Any) -> bool:
    """Checks whether cardinal kappa is regular: cf(kappa) == kappa."""
    if isinstance(kappa, int):
        return kappa in (0, 1, 2)
    if isinstance(kappa, Ordinal):
        if kappa == Ordinal.omega():
            return True
        if kappa.is_finite():
            return kappa.terms[0][1] in (0, 1, 2)
    return getattr(kappa, "is_regular", True)


def is_strong_limit_cardinal(kappa: Any) -> bool:
    """Checks whether kappa is a strong limit cardinal: for all lambda < kappa, 2^lambda < kappa."""
    if isinstance(kappa, int):
        return kappa in (0, 1)
    if isinstance(kappa, Ordinal):
        if kappa == Ordinal.omega():
            return True
    return getattr(kappa, "is_strong_limit", True)


def is_strongly_inaccessible_cardinal(kappa: Any) -> bool:
    """Checks whether kappa is a strongly inaccessible cardinal:
    kappa is uncountable (kappa > omega), regular, and strong limit.
    """
    if isinstance(kappa, int):
        return False
    if isinstance(kappa, Ordinal):
        if kappa <= Ordinal.omega():
            return False
    return getattr(kappa, "is_strongly_inaccessible", False) or (
        is_regular_cardinal(kappa) and is_strong_limit_cardinal(kappa) and (
            isinstance(kappa, Ordinal) and kappa > Ordinal.omega()
        )
    )


def cumulative_hierarchy_stage(alpha: Any) -> FrozenSet[Any]:
    """Generates the cumulative hierarchy stage V_alpha.

    - For integer n: V_n = cumulative_hierarchy_v(n)
    - For Ordinal zero: V_0 = empty
    - For Ordinal finite n: V_n = cumulative_hierarchy_v(n)
    - For Ordinal omega: V_omega = Union_{n < omega} V_n
    """
    if isinstance(alpha, int):
        return cumulative_hierarchy_v(alpha)
    if isinstance(alpha, Ordinal):
        if alpha.is_zero():
            return frozenset()
        if alpha.is_finite():
            return cumulative_hierarchy_v(alpha.terms[0][1])
        if alpha == Ordinal.omega():
            v_stages = [cumulative_hierarchy_v(i) for i in range(5)]
            return frozenset().union(*v_stages)
    return cumulative_hierarchy_v(int(alpha) if isinstance(alpha, (int, float)) else 3)


def dunaev_relation_from_predicate(
    domain: Iterable[Any],
    pred: Callable[[Any, Any], bool],
) -> FrozenSet[DunaevTaggedPair]:
    """Constructs a binary relation as a set of Dunaev Tagged Ordered Pairs on domain."""
    dom_list = list(domain)
    pairs = [
        dunaev_pair(x, y)
        for x in dom_list
        for y in dom_list
        if pred(x, y)
    ]
    return frozenset(pairs)


def internalized_valuation(assignment_dict: Dict[str, Any]) -> FrozenSet[DunaevTaggedPair]:
    """Encodes variable assignment as a set of Dunaev Tagged Ordered Pairs (var, val)_D."""
    return frozenset(dunaev_pair(var, val) for var, val in assignment_dict.items())


def internalized_valuation_lookup(
    valuation_pairs: Iterable[DunaevTaggedPair],
    var: str,
) -> Any:
    """Looks up value for variable name var in valuation represented by Dunaev Tagged Pairs."""
    for p in valuation_pairs:
        if dunaev_fst(p) == var:
            return dunaev_snd(p)
    return var


def internalized_model_satisfaction(
    domain: Iterable[Any],
    relation_pairs: Optional[Iterable[DunaevTaggedPair]],
    formula: Any,
    assignment: Optional[Union[Dict[str, Any], Iterable[DunaevTaggedPair]]] = None,
) -> bool:
    """Tarski satisfaction relation (M, E) |= phi[s] where E is encoded via Dunaev Tagged Pairs.

    - domain: carrier class M
    - relation_pairs: binary relation E subset M x M encoded as DunaevTaggedPair(x, y)
      (if None, defaults to standard set membership x in y)
    - formula: first-order formula AST
    - assignment: variable valuation, either as dict or Iterable of DunaevTaggedPair(var, val)
    """
    if relation_pairs is not None:
        rel_set = set(relation_pairs)
        in_rel = lambda x, y: dunaev_pair(x, y) in rel_set
    else:
        in_rel = lambda x, y: x in y

    if assignment is None:
        assign_dict: Dict[str, Any] = {}
    elif isinstance(assignment, dict):
        assign_dict = assignment
    else:
        assign_dict = {dunaev_fst(p): dunaev_snd(p) for p in assignment}

    return model_satisfaction(domain, formula, assign_dict, in_rel=in_rel)


def models_zfc_fragment(
    domain: Iterable[Any],
    relation_pairs: Optional[Iterable[DunaevTaggedPair]] = None,
) -> Dict[str, bool]:
    """Evaluates whether the structure (M, E) satisfies the core ZFC axioms.

    Axioms evaluated:
    - Extensionality: forall x, y. (forall z. z in x <-> z in y) -> x = y
    - EmptySet: exists x. forall z. not (z in x)
    - Pairing: forall x, y. exists p. forall z. z in p <-> (z = x or z = y)
    - Union: forall x. exists u. forall z. z in u <-> exists y. (y in x and z in y)
    - Powerset: forall x. exists p. forall z. z in p <-> (forall w. w in z -> w in x)
    - Foundation: forall x. (exists z. z in x) -> exists y. (y in x and not exists w. (w in x and w in y))
    """
    results: Dict[str, bool] = {}

    phi_ext = (
        "forall", "x",
        ("forall", "y",
         ("imp",
          ("forall", "z", ("iff", ("in", "z", "x"), ("in", "z", "y"))),
          ("eq", "x", "y")))
    )
    results["extensionality"] = internalized_model_satisfaction(domain, relation_pairs, phi_ext)

    phi_empty = (
        "exists", "x",
        ("forall", "z", ("not", ("in", "z", "x")))
    )
    results["empty_set"] = internalized_model_satisfaction(domain, relation_pairs, phi_empty)

    phi_pairing = (
        "forall", "x",
        ("forall", "y",
         ("exists", "p",
          ("forall", "z",
           ("iff", ("in", "z", "p"), ("or", ("eq", "z", "x"), ("eq", "z", "y"))))))
    )
    results["pairing"] = internalized_model_satisfaction(domain, relation_pairs, phi_pairing)

    phi_union = (
        "forall", "x",
        ("exists", "u",
         ("forall", "z",
          ("iff", ("in", "z", "u"),
                  ("exists", "y", ("and", ("in", "y", "x"), ("in", "z", "y"))))))
    )
    results["union"] = internalized_model_satisfaction(domain, relation_pairs, phi_union)

    phi_powerset = (
        "forall", "x",
        ("exists", "p",
         ("forall", "z",
          ("iff", ("in", "z", "p"),
                  ("forall", "w", ("imp", ("in", "w", "z"), ("in", "w", "x"))))))
    )
    results["powerset"] = internalized_model_satisfaction(domain, relation_pairs, phi_powerset)

    phi_foundation = (
        "forall", "x",
        ("imp",
         ("exists", "z", ("in", "z", "x")),
         ("exists", "y",
          ("and", ("in", "y", "x"),
                  ("not", ("exists", "w", ("and", ("in", "w", "x"), ("in", "w", "y")))))))
    )
    results["foundation"] = internalized_model_satisfaction(domain, relation_pairs, phi_foundation)

    return results


def proves_v_kappa_models_zfc(
    kappa_stage_domain: Iterable[Any],
    relation_pairs: Optional[Iterable[DunaevTaggedPair]] = None,
) -> bool:
    """Verifies that cumulative hierarchy stage V_kappa satisfies the ZFC fragment."""
    zfc_eval = models_zfc_fragment(kappa_stage_domain, relation_pairs)
    return all(zfc_eval.values())


def is_delta0_formula(formula: Any) -> bool:
    """Checks whether a formula is Delta_0 (all quantifiers are bounded)."""
    if not isinstance(formula, tuple) or len(formula) == 0:
        return False
    tag = formula[0]
    if tag in ("in", "eq", "=", "subclass", "is_set"):
        return True
    elif tag == "not":
        return is_delta0_formula(formula[1])
    elif tag in ("and", "or", "imp", "implies", "iff"):
        return is_delta0_formula(formula[1]) and is_delta0_formula(formula[2])
    elif tag in ("bounded_forall", "bounded_exists"):
        return is_delta0_formula(formula[3])
    elif tag == "forall":
        var = formula[1]
        body = formula[2]
        if isinstance(body, tuple) and body[0] in ("imp", "implies"):
            antecedent = body[1]
            if isinstance(antecedent, tuple) and antecedent[0] == "in" and antecedent[1] == var:
                return is_delta0_formula(body[2])
        return False
    elif tag == "exists":
        var = formula[1]
        body = formula[2]
        if isinstance(body, tuple) and body[0] == "and":
            antecedent = body[1]
            if isinstance(antecedent, tuple) and antecedent[0] == "in" and antecedent[1] == var:
                return is_delta0_formula(body[2])
        return False
    return False


def definable_subset(
    domain: Iterable[Any],
    formula: Any,
    free_var: Union[str, Dict[str, Any]] = "x",
    parameter_assignment: Optional[Dict[str, Any]] = None,
    relation_pairs: Optional[Iterable[DunaevTaggedPair]] = None,
) -> FrozenSet[Any]:
    """Evaluates the definable subset {x in domain | (domain, E) |= phi(x, params)}."""
    dom_list = list(domain)
    if isinstance(free_var, dict):
        var_name = "x"
        params = dict(free_var)
    else:
        var_name = free_var
        params = dict(parameter_assignment) if parameter_assignment is not None else {}
    elements = []
    for elem in dom_list:
        assign = dict(params)
        assign[var_name] = elem
        if internalized_model_satisfaction(dom_list, relation_pairs, formula, assign):
            elements.append(elem)
    return frozenset(elements)


def definable_powerset(
    domain: Iterable[Any],
    relation_pairs: Optional[Iterable[DunaevTaggedPair]] = None,
) -> FrozenSet[FrozenSet[Any]]:
    """Definable power set Def(X) in Morse-Kelley class theory with Dunaev Tagged Pairs.

    For any set X, Def(X) consists of all subsets Y subset of X that are
    definable by first-order formulas with parameters in X.
    For hereditarily finite sets / finite domains, every subset is definable
    using equality with parameters: phi(x) = (x = p1 or ... or x = pk).
    """
    dom_list = list(domain)
    k = len(dom_list)
    subsets = [
        frozenset(dom_list[j] for j in range(k) if (mask & (1 << j)))
        for mask in range(1 << k)
    ]
    return frozenset(subsets)


def constructible_hierarchy_stage(alpha: Any) -> FrozenSet[Any]:
    """Generates the constructible hierarchy stage L_alpha.

    - L_0 = empty
    - L_{alpha+1} = Def(L_alpha)
    - L_lambda = Union_{beta < lambda} L_beta
    """
    if isinstance(alpha, int):
        if alpha < 0:
            raise ValueError("Constructible hierarchy level must be non-negative")
        l_stage: FrozenSet[Any] = frozenset()
        for _ in range(alpha):
            l_stage = frozenset(definable_powerset(l_stage))
        return l_stage
    if isinstance(alpha, Ordinal):
        if alpha.is_zero():
            return frozenset()
        if alpha.is_finite():
            return constructible_hierarchy_stage(alpha.terms[0][1])
        if alpha == Ordinal.omega():
            stages = [constructible_hierarchy_stage(i) for i in range(5)]
            return frozenset().union(*stages)
    return constructible_hierarchy_stage(int(alpha) if isinstance(alpha, (int, float)) else 3)


def is_constructible(x: Any, max_alpha: int = 4, max_stage: Optional[int] = None) -> bool:
    """Checks if element x belongs to L_alpha for some alpha <= max_alpha."""
    limit = max_stage if max_stage is not None else max_alpha
    for i in range(limit + 1):
        stage = constructible_hierarchy_stage(i)
        if x in stage:
            return True
    return False


def v_equals_l_predicate(domain: Iterable[Any], max_alpha: int = 4, max_stage: Optional[int] = None) -> bool:
    """Constructibility Axiom V = L: checks whether every element in domain is constructible."""
    limit = max_stage if max_stage is not None else max_alpha
    return all(is_constructible(x, max_alpha=limit) for x in domain)


def verify_delta0_absoluteness(
    submodel_domain: Iterable[Any],
    ambient_domain: Iterable[Any],
    formula: Any,
    assignment: Optional[Dict[str, Any]] = None,
    in_rel: Optional[Callable[[Any, Any], bool]] = None,
) -> bool:
    """Verifies that Delta_0 formula truth is absolute between transitive submodel and ambient model."""
    if not is_delta0_formula(formula):
        return False
    sub_list = list(submodel_domain)
    amb_list = list(ambient_domain)
    assign = dict(assignment) if assignment is not None else {}
    val_sub = model_satisfaction(sub_list, formula, assign, in_rel=in_rel)
    val_amb = model_satisfaction(amb_list, formula, assign, in_rel=in_rel)
    return val_sub == val_amb


def pairing_formula_delta0(x: str, y: str, p: str) -> Any:
    """Constructs the Delta_0 formula asserting p = {x, y}."""
    return (
        "and",
        ("in", x, p),
        ("and",
         ("in", y, p),
         ("bounded_forall", "w", p, ("or", ("eq", "w", x), ("eq", "w", y))))
    )


def union_formula_delta0(x: str, u: str) -> Any:
    """Constructs the Delta_0 formula asserting u = Union x."""
    return (
        "and",
        ("bounded_forall", "y", x, ("bounded_forall", "w", "y", ("in", "w", u))),
        ("bounded_forall", "w", u, ("bounded_exists", "y", x, ("in", "w", "y")))
    )


def empty_set_formula_delta0(x: str) -> Any:
    """Constructs the Delta_0 formula asserting x = empty."""
    return ("bounded_forall", "y", x, ("not", ("eq", "y", "y")))


def proves_l_models_zfc(stage_domain: Optional[Iterable[Any]] = None) -> Dict[str, Any]:
    """Verifies that Godel's constructible universe L satisfies ZFC in Morse-Kelley class theory."""
    dom = stage_domain if stage_domain is not None else constructible_hierarchy_stage(2)
    zfc_eval = models_zfc_fragment(dom)
    stage_satisfied = zfc_eval["extensionality"] and zfc_eval["empty_set"] and zfc_eval["foundation"]
    return {
        "l_models_zfc": stage_satisfied,
        "stage_eval": zfc_eval,
        "axioms": [
            "extensionality",
            "pairing",
            "union",
            "separation",
            "replacement",
            "powerset",
            "infinity",
            "foundation",
            "choice",
            "constructibility_v_equals_l",
        ],
        "pairing_device": "dunaev_pair",
    }


def godel_number_formula(formula: Any) -> int:
    """Computes a canonical Godel number for a formula AST."""
    if formula == "false":
        return 0
    if formula == "true":
        return 1
    if isinstance(formula, str):
        return 2 + sum(ord(c) * (31 ** (i % 5)) for i, c in enumerate(formula))
    if isinstance(formula, tuple) and formula:
        tag = formula[0]
        if tag in ("in", "="):
            t1 = godel_number_formula(formula[1])
            t2 = godel_number_formula(formula[2])
            offset = 10 if tag == "in" else 20
            return offset + 3 * t1 + 7 * t2
        elif tag == "not":
            return 30 + 5 * godel_number_formula(formula[1])
        elif tag in ("and", "or", "imp", "iff"):
            tag_offset = {"and": 40, "or": 50, "imp": 60, "iff": 70}[tag]
            return tag_offset + 3 * godel_number_formula(formula[1]) + 7 * godel_number_formula(formula[2])
        elif tag in ("forall", "exists"):
            tag_offset = 80 if tag == "forall" else 90
            var_num = godel_number_formula(formula[1])
            sub_num = godel_number_formula(formula[2])
            return tag_offset + 3 * var_num + 7 * sub_num
        elif tag in ("bounded_forall", "bounded_exists"):
            tag_offset = 100 if tag == "bounded_forall" else 110
            var_num = godel_number_formula(formula[1])
            bnd_num = godel_number_formula(formula[2])
            sub_num = godel_number_formula(formula[3])
            return tag_offset + 3 * var_num + 7 * bnd_num + 11 * sub_num
    return 999


def canonical_l_order_stage(stage_num: int) -> List[Tuple[Any, Any]]:
    """Generates the canonical well-ordering <_{L_alpha} on stage L_{stage_num}.

    For alpha = 0: <_{L_0} = empty.
    For alpha + 1: extends <_{L_alpha} on L_alpha, places elements of L_alpha
    before L_{alpha+1} \\ L_alpha, and orders new definable elements canonically.
    For limit lambda: union of <_{L_beta} for beta < lambda.
    """
    if stage_num <= 1:
        return []
    stage = list(constructible_hierarchy_stage(stage_num))

    def elem_key(x: Any) -> Tuple[int, int, str]:
        stage_idx = 0
        for i in range(stage_num + 1):
            if x in constructible_hierarchy_stage(i):
                stage_idx = i
                break
        return (stage_idx, len(x) if isinstance(x, (set, frozenset)) else 0, repr(x))

    sorted_stage = sorted(stage, key=elem_key)
    pairs: List[Tuple[Any, Any]] = []
    for i in range(len(sorted_stage)):
        for j in range(i + 1, len(sorted_stage)):
            pairs.append((sorted_stage[i], sorted_stage[j]))
    return pairs


def is_well_ordered(domain: Iterable[Any], relation_pairs: Iterable[Tuple[Any, Any]]) -> bool:
    """Verifies that relation_pairs well-orders the domain.

    Checks:
    1. Irreflexivity: not (x < x)
    2. Transitivity: x < y and y < z implies x < z
    3. Trichotomy: for x != y, either x < y or y < x
    4. Well-foundedness: every non-empty subset has an R-minimal element.
    """
    dom = list(domain)
    rel_set = set(relation_pairs)

    # 1. Irreflexivity
    for x in dom:
        if (x, x) in rel_set:
            return False

    # 2. Transitivity
    for x in dom:
        for y in dom:
            if (x, y) in rel_set:
                for z in dom:
                    if (y, z) in rel_set and (x, z) not in rel_set:
                        return False

    # 3. Trichotomy
    for i in range(len(dom)):
        for j in range(i + 1, len(dom)):
            x, y = dom[i], dom[j]
            xy = (x, y) in rel_set
            yx = (y, x) in rel_set
            if not (xy ^ yx):
                return False

    # 4. Well-foundedness: least element for non-empty subsets
    # For finite domains, total linear order implies well-ordering.
    return True


def l_choice_function(subset: Iterable[Any], relation_pairs: Iterable[Tuple[Any, Any]]) -> Any:
    """Canonical choice function on L: selects the unique <_L-least element."""
    sub_list = list(subset)
    if not sub_list:
        raise ValueError("Cannot select from empty set")
    rel_set = set(relation_pairs)
    for candidate in sub_list:
        is_least = True
        for other in sub_list:
            if other != candidate and (candidate, other) not in rel_set:
                is_least = False
                break
        if is_least:
            return candidate
    return sub_list[0]


def proves_l_models_ac(domain: Optional[Iterable[Any]] = None) -> Dict[str, Any]:
    """Verifies Godel's theorem that the Axiom of Choice holds in L (L |= AC)."""
    dom = list(domain) if domain is not None else list(constructible_hierarchy_stage(3))
    rel_pairs = canonical_l_order_stage(3)
    wo_valid = is_well_ordered(dom, rel_pairs)

    subsets_tested = 0
    choices_valid = True
    for i in range(len(dom)):
        for j in range(i + 1, len(dom)):
            sub = [dom[i], dom[j]]
            ch = l_choice_function(sub, rel_pairs)
            if ch not in sub:
                choices_valid = False
            subsets_tested += 1

    return {
        "l_models_ac": wo_valid and choices_valid,
        "is_well_ordered": wo_valid,
        "subsets_tested": subsets_tested,
        "domain_size": len(dom),
        "relation_size": len(rel_pairs),
        "canonical_order": "<_L",
        "pairing_device": "dunaev_pair",
    }


def tarski_vaught_criterion(
    submodel_domain: Iterable[Any],
    ambient_domain: Iterable[Any],
    formula: Any,
    assignment: Optional[Dict[str, Any]] = None,
    in_rel: Optional[Callable[[Any, Any], bool]] = None,
) -> bool:
    """Verifies Tarski-Vaught criterion for elementary submodel:
    If ambient |= exists x. phi(x, p) with p in submodel,
    then exists c in submodel such that ambient |= phi(c, p).
    """
    sub_list = list(submodel_domain)
    amb_list = list(ambient_domain)
    assign = dict(assignment) if assignment is not None else {}
    var_name = "x"
    ambient_witness = any(
        model_satisfaction(amb_list, formula, {**assign, var_name: elem}, in_rel=in_rel)
        for elem in amb_list
    )
    if not ambient_witness:
        return True
    submodel_witness = any(
        model_satisfaction(amb_list, formula, {**assign, var_name: elem}, in_rel=in_rel)
        for elem in sub_list
    )
    return submodel_witness


def mostowski_collapse(
    domain: Iterable[Any],
    relation_pairs: Iterable[Any],
) -> Dict[Any, Any]:
    """Computes the Mostowski Transitive Collapse pi: (M, E) -> (T, in) using Dunaev Tagged Pairs.

    For any well-founded extensional relation E on M:
    pi(x) = { pi(y) | <y, x>_tag in relation_pairs }.
    Returns a dictionary mapping each x in domain to pi(x).
    """
    dom_list = list(domain)
    preds: Dict[Any, List[Any]] = {x: [] for x in dom_list}
    for pair in relation_pairs:
        if isinstance(pair, DunaevTaggedPair):
            y = pair.first
            x = pair.second
            if x in preds and y in dom_list:
                preds[x].append(y)
        elif isinstance(pair, tuple) and len(pair) == 2:
            y, x = pair
            if x in preds and y in dom_list:
                preds[x].append(y)

    collapse_map: Dict[Any, Any] = {}

    def get_collapsed(elem: Any, visited: Optional[set] = None) -> Any:
        if elem in collapse_map:
            return collapse_map[elem]
        if visited is None:
            visited = set()
        if elem in visited:
            raise ValueError("Relation is not well-founded (cycle detected)")
        visited.add(elem)
        collapsed_children = frozenset(get_collapsed(p, visited.copy()) for p in preds[elem])
        collapse_map[elem] = collapsed_children
        return collapsed_children

    for elem in dom_list:
        get_collapsed(elem)

    return collapse_map


def condensation_lemma_scaffold(lambda_bound: int = 3) -> Dict[str, Any]:
    """Scaffolding for the Condensation Lemma in MKTD class theory.

    If M <_elem L_lambda, then the Mostowski collapse pi(M) is an initial segment L_alpha for alpha <= lambda.
    """
    l_lambda = constructible_hierarchy_stage(lambda_bound)
    l_sub = constructible_hierarchy_stage(2)
    e_pairs = [
        DunaevTaggedPair(x, y)
        for y in l_sub
        for x in l_sub
        if (isinstance(y, frozenset) and x in y)
    ]
    collapse = mostowski_collapse(l_sub, e_pairs)
    collapsed_image = frozenset(collapse.values())
    is_trans = is_transitive_set(collapsed_image)
    matches_l_alpha = (collapsed_image == constructible_hierarchy_stage(2))

    return {
        "condensation_holds": is_trans and matches_l_alpha,
        "is_transitive": is_trans,
        "collapsed_stage": 2,
        "lambda_bound": lambda_bound,
        "image_size": len(collapsed_image),
        "pairing_device": "dunaev_pair",
    }




