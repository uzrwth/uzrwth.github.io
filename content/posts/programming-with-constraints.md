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