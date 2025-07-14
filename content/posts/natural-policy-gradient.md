---
title: "Natural Policy Gradient"
date: 2025-07-08T13:24:07+02:00
draft: true
---

# Natural policy gradient and its projection interpretation

> The natural gradient minimizes the expected squared error between the advantage function and a linear function of the policy score function.


> We provide a natural gradient method that represents the steepest descent direction based on the underlying structure of the parameter space.

> Although gradient methods cannot make large changes in the values of the parameters, we show that the natural gradient is moving toward choosing a greedy optimal action rather than just a better action.


> There has been growing interest in direct policy-gradient methods for approximate planning in large Markov decision problems (MDPs). Such methods seek to find a good policy among some restricted class of policies, by following the gradient of the future reward. Unfortunately, the standard gradient descent rule is non-covariant.



# Natural gradient works efficiently in learning

> When a parameter space has a certain underlying structure, the ordinary gradient of a function does not represent its steepest direction, but the natural gradient does.


# Fisher information matrix

> Expected outer product of score function with itself

The Riemannian structure of the parameter space of a statistical model is defined by the Fisher information.

measures how sensitive the policy is to its parameters - a Riemannian metric on the space of policies.




The stochastic gradient method is a popular learning method in the general nonlinear optimization framework.

The parameter space is not Euclidean but has a Riemannian metric structure in many cases.

In these cases, the ordinary gradient does not give the steepest direction of a target function; rather, the steepest direction is given by the natural gradient.


> Information geometry is used for calculating the natural gradients in the parameter space of perceptrons, the space of matrices (for blind source separation), and the space of linear dynamical systems (for blind source deconvolution). The dynamical behavior of natural gradient online learning is analyzed and is proved to be Fisher efficient, implying that it has asymptotically the same performance as the optimal batch estimation of parameters. This suggests that the plateau phenomenon, which appears in the backpropagation learning algorithm of multilayer perceptrons, might disappear or might not be so serious when the natural gradient is used. An adaptive method of updating the learning rate is proposed and analyzed.

- certain underlying structure: underlying geometric structure (typically Riemannian manifolds)
- the ordinary gradient method: the ordinary Euclidean gradient
- the natural gradient: which accounts for the geometry of the space
- parameter space: the parameter space is the set of all possible values that the parameters of a model (or system) can take.
- the parameter space is where all possible configurations of a model's parameters live
- its structure (Euclidean, curved, constrained) determines how optimization should be performed
- the natural gradient is crucial when the space has non-Euclidean geometry


$\Theta \subseteq \mathbb{R}^n$

# inner/outer product

inner product measures similarity -> scalar

outer product is used to build higher-dimensional structures -> matrix (e.g., covariance matrix, FIM)

> The outer product is a way to expand two vectors into a matrix, where every element is a multiplication of components from the two vectors.


# score function

It is the gradient of the log-likelihood with respect to the parameters $\theta$

