---
title: "Meta Programming"
date: 2025-07-09T10:41:49+02:00
draft: true
---

# Processing Terms and Atomic Formulas

the pre-defined predicate number/1 which can be used to check whether an object is a number.

Prolog offers numerous other predicates in order to recognize different types of terms and atomic formulas.

var(t) is true if t is a non-instantiated variable.

nonvar(t) is true if t is not a variable.

atomic(t) is true if t is a 0-ary predicate or function symbol or if t is a number.

atomic(a(a)) is false. atomic(X) is false.

If one wants to exclude numbers, one can use the predicate atom/1 instead.

compound(t) is true if t is a term or an atomic formula that does not only consist of a 0-ary function or predicate symbol or of a number.


In addition to the above predicates for the identification of certain types of terms, Prolog also contains three predicates to extract components of terms and to construct new terms. The idea here is that terms or atomic formulas like f(a,b) can also be written as lists.

The first element of the list is the outermost function or predicate symbol f and the remaining elements of the list are the arguments of this symbol.

Thus, f(a,b) results in the list [f,a,b]. Here the first element of the list is a 0-ary symbol f/0 whereas the outermost symbol of the term f(a,b) is a 2-ary symbol f/2.

To this end, in Prolog there is a pre-defined 2-ary predicate symbol "=.." (called univ), where t =.. l is true iff l is the list representation of the term or atomic formula t.


As the final example, we define a predicate ground/1, where ground(t) is true if t does not contain any varibles:

`
ground(T) :- nonvar(T),
	T =.. [Functor|ArgumentList],
	groundlist(ArgumentList).

groundlist([]).
groundlist([T|Ts) :- ground(T), groundlist(Ts).
`


# change the current program "during its own execution"


# functor

functor是Prolog中的一个内置谓词(built-in predicate)，用于获取或构造复合项(compound term)的名称和元数(arity)。它是Prolog元编程的重要工具之一。


The standard notation for terms and atoms in Prolog is prefix notation, where the arguments are given in brackets. For example, one writes p(X, f(a)) for predicate or function symbols p/2, f/1, and a/0. Such predicate and function symbols are called functors.

Instead, it is also possible to use predicate or function symbols of arity two in infix notation and predicate or function symbols of arity one in prefix or postfix notation (without brackets for the arguments). For this, the corresponding symbols have to be declared as operators. The advantage of this notation is a more user-friendly syntax with better readability. Thus, one gets closer to the goal of "programming in natural language".

To define operators, so-called directives of the form

`
:- op(precedence, type, name(s)).
`



You may use =.. and functor to first define a predicate findPred/2 which extracts the leading predicate symbol of its first argument. In findPred's second argument, this predicate symbol is applied to pairwise different fresh variables.

For example, the query findPred(p(0), Q) yields the answer Q=p(X).

`
?- functor(father(john, mary), F, A).
F = father,
A = 2.
`
