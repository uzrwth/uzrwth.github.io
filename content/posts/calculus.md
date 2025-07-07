---
title: "Calculus"
date: 2025-07-07T23:44:59+02:00
---

Linear algebra has been incorporated, the mean-value theorems and routine applications of calculus are introduced at an earlier stage.

Several sections have been rewritten and reorganized to provide better motivation and to improve the flow of ideas.


As in the first edition, a historical introduction precedes each important new concept, tracing its development from an early intuitive physical notion to its precise mathematical formulation. The student is told something of the struggles of the past and of the triumphs of the men who contributed most to the subject. Thus the student becomes an active participant in the evolution of ideas rather than a passive observer of results.


The first two thirds of Volume I deals with the calculus of functions of one variable, including infinite series and an introduction to differential equations. The last third of Volume I introduces linear algebra with applications to geometry and analysis.


Much of this material leans heavily on the calculus for examples that illustrate the general theory. It provides a natural blending of algebra and analysis and helps pave the way for the transition from one-variable calculus to multivariable calculus, discussed in Volume II.


![alt text](/images/series-expansion.png)



# Taylor Series Test

There is a simple test which guarantees that the remainder of a Taylor series tends to zero.

To prove that a function $f(x)$ equals its Taylor series, it is sufficient to show:
- $f$ is infinitely differentiable on $I$
- the derivatives of $f$ grow no faster than a constant $C$ times the powers of a constant $M$


# Taylor's Formula

> The power series which represents a function is determined by the derivatives of the function at a single point.

Up until now, we have used various makeshift methods to find power series expansions for specific functions. In this section, we shall see how to do this systematically. The idea is to assume the existence of a power series and to identify the coefficients one by one.



# Power Series

> Many functions can be expressed as "polynomials with infinitely many terms."

power series (since we are summing the powers of $(x-x_0)$). Where the $a_i$'s and $x_0$ are constants.

In this section, we show how a power series may be considered as a function of $x$, defined on a certain **interval**.

In the next section, we begin with an arbitrary function and show how to find the power series which represents it (if there is such a series).

In general, we may think of a power series as a polynomial of "infinite degree"; we will see that as long as they converge, power series may be manipulated (added, subtracted, multiplied, divided, differentiated) just like ordinary polynomials.


The simplest power series, after a polynomial, is the geometric series

$f(x)=1+x+x^2+\dots$

which converges when $|x|<1$

Convergence of general power series may often be determined by a test similar to the ratio test.

## Ratio Test for Power Series

series converges if $x$ is in this interval

series diverges if $x$ is outside

$R$ is the radius of convergence of $\sum_{i=0}^{\infty} a_ix^{i}$

The number $R$ in this test is called the radius of convergence of the series.


## Root Test for Power Series

Assume that $\lim_{i \to \infty} |a_i|^{1/i}=\rho$ exists. Then the radius of convergence is $R=1/\rho$.