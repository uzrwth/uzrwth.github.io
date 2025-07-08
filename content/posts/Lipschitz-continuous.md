---
title: "Lipschitz Continuous"
date: 2025-07-06T22:35:22+02:00
draft: false
---


The terms "Lipschitz constraint" and "Lipschitz continuous" are closely related, and often used in the context of optimization, differential equations, and machine learning.

Lipschitz continuous.
A function is Lipschitz continuous if there exists a constant L>0 such that
This means the function does not change faster than linearly in its inputs.


Lipschitz constraint.
The Lipschitz constraint typically refers to imposing a Lipschitz condition, often in optimization or learning tasks. 
Enforcing that a function (or its gradient) is Lipschitz continuous with a known constant L.
This is also called L-smoothness.

Lipschitz continuity of the gradient is assumed for convergence guarantees in gradient descent.

In Lipschitz regularization, models are trained to satisfy a Lipschitz constraint to improve stability.



Approximation and fitting -> Function fitting and interpolation -> constraints -> Lipschitz constraint

Norm approximation -> Basic norm approximation problem

The norm approximation problem is a convex problem, and is solvable.


从 L-光滑性可以推导出的结论: Quadratic Upper Bound (with Taylor series)


> Maclaurin series is really just a special case of the Taylor series.

> But the idea of representing particular functions as sums of power series goes back to Newton.


# Series

What do we mean when we express a number as an infinite decimal?

The convention behind our decimal notation is that any number can be written as an infinite sum.

If the sequence is convergent and limit exists as a real number, then the series is called convergent.

The number is called the sum of the series.

If the sequence is divergent, then the series is called divergent.

> The table shows that as we add more and more terms, these partial sums become closer and closer to 1. In fact, by adding sufficiently many terms of the series we can make the partial sums as close as we like to 1. So it seems reasonable to say that the sum of this infinite series is 1.

> Thus the sum of a series is the limit of the sequence of partial sums.


## Geometric series

Each term is obtained from the preceding one by multiplying it by the common ratio r.


### Power series

a series of constants that we can test for convergence or divergence.

A power series may converge for some values of x and diverge for other values of x.


Notice that f resembles a polynomial. The only difference is that f has infinitely many terms.

几何级数是幂级数的特例，即当幂级数的系数 全部相同且中心 为0时，幂级数退化为几何级数。



## Representations of Functions as Power Series

How to represent certain types of functions as sums of power series by manipulating geometric series or by differentiating or integrating such a series.

Why we would ever want to express a known function as a sum of infinitely many terms?
This strategy is useful for integrating functions that don't have elementary antiderivatives, for solving differential equations, and for **approximating functions by polynomials**.



# Taylor's formula with remainder


We turn now to a discussion of the error in the approximation of a function $f$ by its Taylor polynomial $T_nf$ at a point $a$.

The error is defined to be the difference $E_n(x)=f(x)-T_nf(x)$. Thus, if $f$ has a derivative of order $n$ at $a$, we may write 

$f(x)=\sum_{k=0}^{n}\frac{f^{(k)}(a)}{k!}(x-a)^{k}+E_n(x)$


This is known as Taylor's formula with remainder $E_n(x)$; it is useful whenever we can estimate the size of $E_n(x)$. We shall express the error as an integral and then estimate the size of the integral.


Assume $f$ has a continuous second derivative $f''$ in some neighborhood of $a$. Then, for every $x$ in this neighborhood, we have

$f(x)=f(a)+f'(a)(x-a)+E_1(x)$

where

$E_1(x)=\int_a^x(x-t)f''(t)dt$