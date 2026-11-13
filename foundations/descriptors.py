"""Descriptor calculus formalization for Foundations of Mathematics.

Formalizes the three-valued / uncertain descriptor operators and definite
description as documented in 020_descriptors.tex and APPROACHES_INVENTORY.md:
  1. tau = tau^Un: arbitrary class default from the conglomerate of all classes;
  2. epsilon = tau^{{empty}}: empty class is the specified default;
  3. partial varepsilon = tau^empty: no default, term may be undefined;
  4. iota: definite description operator, defined iff unique witness exists.
"""

from typing import Any, Callable, Generic, Optional, Sequence, TypeVar

T = TypeVar("T")


class DescriptorUndefined(Exception):
    """Raised when a partial descriptor has no witness and no default."""


class NonUniqueWitnessError(Exception):
    """Raised when definite description (iota) finds multiple witnesses."""


class EmptySetClass:
    """Represents the canonical empty class emptyclass in class theory."""

    def __repr__(self) -> str:
        return "emptyclass"

    def __eq__(self, other: object) -> bool:
        return isinstance(other, EmptySetClass)

    def __hash__(self) -> int:
        return hash("emptyclass")


EMPTY_CLASS = EmptySetClass()


def tau_descriptor(
    predicate: Callable[[T], bool],
    candidates: Sequence[T],
    default_witness: T,
) -> T:
    """tau-descriptor (tau = tau^Un).

    If there exists an element satisfying the predicate, returns a witness.
    Otherwise, returns an arbitrary default element from the conglomerate.
    """
    for item in candidates:
        if predicate(item):
            return item
    return default_witness


def epsilon_descriptor(
    predicate: Callable[[T], bool],
    candidates: Sequence[T],
    empty_default: Any = EMPTY_CLASS,
) -> Any:
    """epsilon-descriptor (epsilon = tau^{{empty}}).

    If there exists an element satisfying the predicate, returns a witness.
    Otherwise, defaults specifically to the empty class.
    """
    for item in candidates:
        if predicate(item):
            return item
    return empty_default


def partial_varepsilon_descriptor(
    predicate: Callable[[T], bool],
    candidates: Sequence[T],
) -> Optional[T]:
    """Partial varepsilon-descriptor (partial varepsilon = tau^empty).

    If there exists an element satisfying the predicate, returns it.
    If no witness exists, returns None (representing undefinedness downarrow).
    """
    for item in candidates:
        if predicate(item):
            return item
    return None


def iota_descriptor(
    predicate: Callable[[T], bool],
    candidates: Sequence[T],
) -> T:
    """Definite description operator (iota x. phi(x)).

    Defined if and only if there exists a unique witness satisfying phi(x).
    Raises NonUniqueWitnessError if multiple witnesses exist.
    Raises DescriptorUndefined if no witness exists.
    """
    witnesses = [item for item in candidates if predicate(item)]
    if len(witnesses) == 1:
        return witnesses[0]
    if len(witnesses) == 0:
        raise DescriptorUndefined("No witness exists for definite description iota")
    raise NonUniqueWitnessError(
        f"Multiple witnesses ({len(witnesses)}) exist for definite description iota"
    )
