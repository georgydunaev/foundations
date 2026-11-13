"""Farmer's Partial First-Order Logic (PFOL) formalization.

Formalizes Alternative 4 from 210_partial_functions_semantics.tex and
APPROACHES_INVENTORY.md:
  - Definedness predicate downarrow;
  - Kleene strong equality simeq;
  - Weak equality =;
  - Partial definite description (iota x. phi(x)) downarrow <-> (exists! x. phi(x)).
"""

from typing import Any, Callable, Optional, Sequence


def is_defined(term: Any) -> bool:
    """Definedness predicate (t downarrow).

    In PFOL, a term is defined if it does not denote the undefined bottom value (None).
    """
    return term is not None


def kleene_equality(t1: Any, t2: Any) -> bool:
    """Kleene strong equality (t1 simeq t2).

    Holds if both terms are undefined, or both are defined and denote equal objects.
    """
    if t1 is None and t2 is None:
        return True
    if t1 is None or t2 is None:
        return False
    return bool(t1 == t2)


def weak_equality(t1: Any, t2: Any) -> bool:
    """Weak / strict equality (t1 = t2).

    Holds if and only if both terms are defined and denote equal objects.
    If either term is undefined, weak equality is False.
    """
    if t1 is None or t2 is None:
        return False
    return bool(t1 == t2)


def pfol_iota(
    predicate: Callable[[Any], bool],
    candidates: Sequence[Any],
) -> Optional[Any]:
    """PFOL definite description (iota x. phi(x)).

    Satisfies: (iota x. phi(x)) downarrow <-> (exists! x. phi(x)).
    Returns the unique witness if it exists, or None (undefined) otherwise.
    """
    witnesses = [item for item in candidates if predicate(item)]
    if len(witnesses) == 1:
        return witnesses[0]
    return None
