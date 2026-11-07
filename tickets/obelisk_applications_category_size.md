# Obelisk: specify the size level of functor and transformation collections

Status: documentation/theory-scope clarification required; no upstream files changed.
Snapshot: `obeliskproofassistant.github.io` commit `bb346f112ae91d1649940068c7f210a53b8674bf`, inspected 2026-11-07.

## Evidence

Source: `/home/gdunaev/obeliskproofassistant.github.io/yoneda_ai.html`, section **Foundational Context in Morse-Kelley Class Theory**. The page has no generated theorem entry ID for this statement. It says that full impredicative class comprehension guarantees the existence of functor classes and natural transformation classes, in a discussion including categories with proper-class objects and arrows.

The page's **Mathematical Formulation**, parts 1–3, gives the usual locally small Yoneda correspondence and its fully faithful corollary. These componentwise formulas agree with the book's `300_category_theory.tex`; their validity does not settle the size of the entire presheaf category.

## Local analysis

The wording has two possible meanings that need separation:

1. An individual functor or natural transformation may be represented by a class-sized graph of assignments between sets.
2. A collection whose elements are all such class-sized graphs may require a conglomerate or a larger universe. MK class comprehension collects sets, even when its defining formula quantifies over classes; it does not make proper classes into class members.

For example, let `D` be the discrete category on the class of all sets. A functor assigning a fixed one-point set to every object has a proper-class-sized object-assignment graph. That graph cannot itself be an ordinary member of another MK class. Consequently one cannot obtain a class of all these graph-coded functors merely by impredicative class comprehension. Other representations require their own explicit coding and size argument.

This is a scope ambiguity in the foundational explanation, not a counterexample to the Yoneda bijection. Obelisk's predicates-on-classes/conglomerate setting may supply the intended higher level, but it should be stated at this point.

## Requested source-level correction

Revise the authored source of `yoneda_ai.html` (or its actual generator if one owns this file) to distinguish individual class graphs from collections of them. State the selected convention: appropriately universe-small categories and functors, or a conglomerate-level functor category with explicit interpretation. Keep the componentwise Yoneda theorem with its local smallness and ambient-size assumptions.

If the statement is also emitted by the ML manual generator, repair that source and regenerate; do not patch generated pages.

## Acceptance tests/review cases

1. A small category example explains why its relevant functor data fit the chosen ambient universe.
2. A proper-class discrete category example is handled without making a proper class an ordinary class member.
3. The statement distinguishes `Hom_C(x,y)` being a set from the object collection of `[C^op,Set]` being a set or class.
4. The Yoneda maps remain `η ↦ η_A(id_A)` and `u ↦ (f ↦ F(f)(u))`, with sources and targets explicit.
5. Any generated copy preserves the same size qualifications, rather than claiming that impredicative comprehension alone constructs an unrestricted category of all class-coded functors.
