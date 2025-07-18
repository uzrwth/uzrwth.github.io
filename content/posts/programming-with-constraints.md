---
title: "Programming With Constraints"
date: 2025-07-16T16:39:34+02:00
draft: false
---

# preface

several good texts
- Foundations of Constraint satisfaction
- Constraint satisfaction in logic programming (for constraint logic programming techniques for finite domains)
- The art of Prolog


It is self-contained, providing the necessary background material from artificial intelligence, logic programming, operation research and mathematical programming.
- from constraint solving techniques
- to programming methodologies for constraint programming languages



# introduction


constraint programming
- based on a strong theoretical foundation
- becoming the method of choice for modelling many types of optimization problems


The reason for this interest in constraint programming is simple
- early programming languages closely reflected the underlying physical architecture of the computer
- however, traditional programming languages, including object oriented languages, provide little support for specifying relationships or constraints among programmer-defined entities
- it is the role of the programmer to explicitly maintain these relationships, and to find objects which satisfy them

Requiring the programmer to explicitly maintain relationships between objects in the program is reasonable for applications in which the relationships are simple and static.
- However, for many applications, the crux of the problem is to model the relationships and find objects that satisfy them
- For this reason, since the late 1960's, there has been interest in programming languages which allow the programmer simply to state relationships between objects
- It is the role of the underlying implementation to ensure that these relationships or "constraints" are maintained.
- Such languages are called constraint programming languages




Local propagation works by using a constraint to assign a value to an unknown variable given known values for the other variables in the constraint
- the problem with local propagation is that it is relatively weak constraint solving methods


More recent constraint programming languages have overcome the difficulties of the early languages
- they provide constraints which are thoroughly integrated into the programming language, allowing the programmer to state problems at a very high level, while their underlying execution mechanism uses powerful incremental constraint solvers
- the new generation of constraint programming languages are true programming languages which are suited for a wide variety of applications



A simple example of an application using a modern constraint programming language
- the accrued interest is added to the current principle to obtain a new principal $NP$. NP is short for new principal.


This example program illustrates how constraint programming can be naturally used to model complex applications



earlier constraint programming languages were suggested by
- Steele
- Borning
- these languages allowed the user to describe the behaviour of systems using static collections of constraints
- in essence, these languages were domain specific modelling languages without the computational power of true programming languages


constraint logic programming (CLP) languages arose from research at three different locations
- Melbourne
- Marseilles
- Munich, employed it to solve many different types of combinatorial problems



concurrent constraint languages originate from work on concurrent logic programming languages


constraint programming is now a fertile research area, with two main international conferences
- principles and practice of constraint programming
- practical applications of constraint technology
- one journal, constraints, published by Kluwer Academic is exclusively devoted to constraints and constraint programming
- other journals: the journal of logic programming
- artificial intelligence, also publish papers on constraint programming