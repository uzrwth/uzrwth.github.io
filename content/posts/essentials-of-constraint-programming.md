---
title: "Essentials of Constraint Programming"
date: 2025-07-16T14:09:20+02:00
draft: false
---


# preface

abundant in industry and commerce
- scheduling
- planning
- transportation
- resource allocation
- layout
- design
- analysis

This book is a short, concise, and complete presentation of constraint programming and reasoning, covering theoretical foundations, algorithms, implementations, examples, and applications. It is based on more than a decade of experience in teaching and research about this subject.


# introduction


# algorithm = logic + control

# preliminaries of syntax and semantics

# logic programming

## LP calculus


Prolog's origins can be traced back to early work in automated theorem proving and planning.
- Then David Warren defined the Warren Abstract Machine (WAM) that lead to an efficient implementation of Prolog.
- The ideas behind the WAM strongly influenced the implementation of more recent languages like Java.


Today, Prolog is mainly used commercially in expert systems.
- It is often the language of choice in implementing prototypes for research in artificial intelligence and computational logic, symbolic computation, and programming languages


A goal is either $\top$ or $\bot$, or an atom or a conjunction of goals. $\top$ is also called empty goal.


A (Horn) clause is of the form $A \leftarrow G$, where $A$ is an atom and $G$ is a goal. We call $A$ the head and $G$ the body of the clause. Clauses of the form $G \leftarrow \top$ are called facts

## declarative semantics

## soundness and completeness


# constraint logic programming (CLP)


CLP was developed in the mid-1980's as a natural combination of two declarative paradigms
- constraint solving and logic programming
- this makes constraint logic programs more expressive, flexible, and in general more efficient than logic programs


CSP (constraint satisfaction problems) over finite domains were already investigated in the 1970's within the context of artificial intelligence
- a constraint problem consists of a set of variables and constraints
- constraints are predicates which express properties of variables, as well as relations between variables
- a solution of a constraint problem is a valuation of the variables with values such that all constraints are satisfied


At the end of the 1970's constraints started to be integrated in tools and programming languages
- efforts were made to make logic programming more declarative (with a flexible selection strategy), faster (with improved search), and more general (with extended equality)
- A flexible selection strategy would mean that handling of certain atoms can be delayed, thus getting away from the fixed left-to-right order
- improved search would mean to detect failing derivations earlier
- extending equality would mean to consider interpreted function symbols



CLP languages combine the advantages of LP languages (declarative for arbitrary predicates, non-deterministic) with those of constraint solvers (declarative, efficient for special predicates, deterministic)
- the combination of search with solving constraints is particularly useful
- combinatorial problems can be tackled


## CLP calculus

## declarative semantics

## soundness and completeness


# concurrent constraint logic programming

# constraint handling rules

# constraint systems and constraint solvers

# boolean algebra B

# rational trees RT


# linear polynomial equations


# finite domains


# non-linear equations



# market overview


# optimal sender placement for wireless communication



# foundations from logic