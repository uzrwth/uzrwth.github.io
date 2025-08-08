---
title: "Logic Programming"
date: 2025-07-16T13:26:58+02:00
---

- first-order logic: predicate logic (quantified variables, relations: n-ary predicate)
- zeroth-order logic: propositional logic (logic without variables or quantifiers, without relations)

model: those structures in which the statements of the theory hold

structure: a structure consists of a set along with a collection of finitary operations (functions) and relations (predicates) that are defined on it

Herbrand structure: a structure over a vocabulary (signature) that is defined solely by the syntactical properties of it. (no semantics). For a Herbrand structure S, all ground terms t are interpreted as "themselves", i.e., we have S(t) = t. For a Herbrand structure the carrier and the interpretation of the function symbols is fixed. Only the interpretation of the predicate symbols can be chosen freely. If only Herbrand structures instead of arbitrary structures are needed to analyze unstatisfiability, then the search space is already restricted considerably.
- interpretation of the function symbols: fixed
- interpretation of the predicate symbols: chosen freely
- A Herbrand structure interprets terms on top of a Herbrand universe
- term: denotes a mathematical object while a formula denotes a mathematical fact
- Herbrand universe is the set of all ground terms of a first-order language
- ground term: a term that does not contain any variables
- relation symbols are not relevant for a Herbrand universe (consists of terms built with constant symbols and function symbols)

signature: function symbols, relation symbols or predicates, constant symbols

vocabulary provides the non-logical symbols

the constants of a language can be divided into logical symbols and non-logical symbols

logical symbols or logical constants: T, F, ¬, ^, V, ->, ∀, ∃, =

non-logical symbol only has meaning or semantic content when one is assigned to it by means of an interpretation



formula: a finite sequence of symbols from a given alphabet that is part of a formal language. A formal language can be identified with the set of formulas in the language. A formula is a syntactic object that can be given a semantic meaning by means of an interpretation

syntactic: syntax is anything having to do with formal languages without regard to any interpretation or meaning given to them.


literal: an atom or the negation of an atom

clause: a formula of the form