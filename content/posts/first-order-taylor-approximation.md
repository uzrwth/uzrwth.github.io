---
title: "First Order Taylor Approximation"
date: 2025-07-06T23:12:08+02:00
draft: false
---


Also known as the linear approximation.

The first-order Taylor approximation of a function provides a linear approximation to the function near a specific point. It is based on the first two terms of the Taylor series expansion.


This measures the error between the actual change in a function and the first-order Taylor approximation of that change.

Gradient (transposed to a row vector) of the function at θ.
Linear (first-order) approximation of the change in f.


Computer scientists like them because polynomials are the simplest of functions.
How physicists and engineers use them in such fields as relativity, optics, blackbody radiation, electric dipoles, the velocity of water waves, and building highways across a desert.


### Chapter 11: Infinite Sequences and Series

Taylor and Maclaurin Series

Applications of Taylor Polynomials


Power series representation for a certain restricted class of functions.

More general problems: Which functions have power series representations? How can we find such representations?


Infinite sequences and series were introduced briefly in A Preview of Calculus in connection with Zeno's paradoxes and the decimal representation of numbers. Their importance in calculus stems from Newton's idea of representing functions as sums of infinite series.



For instance, in finding areas he often integrated a function by first expressing it as a series and then integrating each term of the series.

We will pursue his idea in Section 11.10 in order to integrate such functions as $e^{-x^2}$. (Recall that we have previously been unable to do this.)


Many of the functions that arise in mathematical physics and chemistry, such as **Bessel functions**, are defined as sums of series, so it is important to be familiar with the basic concepts of convergence of infinite sequences and series.



We start  by supposing that f is any function that can be represented by a power series.
Let's try to determine what the coefficients must be in terms of f. To begin, notice that if we put $x=a$, then all terms after the first one are 0 and we get $f(a)=c_0$

By Theorem 11.9.2, we can differentiate the series in Equation 1 term by term


$ f'(a) = c_1 $

$ f''(a) = 2c_2 $


$ f'''(a) = 3!c_3 $


If $f$ has a power series representation (expansion) at $a$, then its coefficients are given by the formula.

Substituting this formula for $c_n$ back into the series, we see that if $f$ has a power series expansion at $a$, then it must be of the following form.

The series is called the Taylor series of the function $f$ at $a$.

For the special case $a=0$ the Taylor series becomes Maclaurin series.


Example: Find the Maclaurin series of the function $f(x)=e^x$ and its radius of convergence.


So how can we determine whether $e^x$ does have a power series representation?

Under what circumstances is a function equal to the sum of its Taylor series?

As with any convergent series, this means that $f(x)$ is the limit of the sequence of partial sums.

$T_n$ is a polynomial of degree n called the nth-degree Taylor polynomial of $f$ at $a$.

As $n$ increases, $T_n(x)$ appears to approach $e^x$ in Figure. This suggests that $e^x$ is equal to the sum of its Taylor series.

If $f(x) = T_n(x) + R_n(x)$, where $T_n$ is the $n$th-degree Taylor polynomial of $f$ at $a$.


In trying to show that the remainder for a specific function $f$, we usually use the **Taylor's Inequality**.



### A preview of calculus

You will be able to estimate the number of laborers needed to build a pyramid, explain the formation and location of rainbows, design a roller coaster for a smooth ride, and calculate the force on a dam.

Calculus is fundamentally different from the mathematics that you have studied previously: calculus is less static and more dynamic. It is concerned with change and motion; it deals with quantities that approach other quantities.

by showing how the concept of a limit arises when we attempt to solve a variety of problems.
