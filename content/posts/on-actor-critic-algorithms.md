---
title: "On Actor Critic Algorithms"
date: 2025-07-14T20:56:15+02:00
draft: true
---

# abstract

these are two-time-scale algorithms in which the critic uses temporal difference learning with a linearly parameterized approximation architecture, and the actor is updated in an approximate gradient direction, based on information provided by the critic.

We show that the features for the critic should ideally span a subspace prescribed by the choice of parameterization of the actor.

We study actor-critic algorithms for Markov decision processes with Polish state and action spaces. We state and prove two results regarding their convergence.


# introduction

Many problems in finance, communication networks, operations research, and other fields can be formulated as dynamic programming problems.

However, the dimension of the state space in these formulations is often too large for the problem to be tractable.

Moreover, the underlying dynamics are seldom known and are often difficult to identify.


RL and neuro-dynamic programming methods try to overcome these difficulties by combining simulation based learning and compact representation of policies and value functions.


These methods fall into one the following two categories
- actor-only
	- the gradient of the performance, with respect to the actor parameters, is directly estimated by simulation, and the parameters are updated in a direction of improvement
	- drawback: the gradient estimators may have a large variance
	- furthermore, as the policy changes, a new gradient is estimated independently of past estimates
- critic-only
	- rely exclusively on value function approximation and aim at learning an approximate solution to the Bellman equation
	- which will then hopefully prescribe a near-optimal policy
	- such methods are indirect in the sense that they do not try to optimize directly over a policy space
	- a method of this type may succeed in constructing a "good" approximation of the value function yet lack reliable guarantees in terms of near-optimality of the resulting policy
- actor-critic methods aim at combining the strong points of actor-only and critic-only methods
	- the critic uses an approximation architecture and simulation to learn a value function
	- which is then used to update the actor's policy parameters in a direction of performance improvement
	- such methods, as long as they are gradient-based, may have desirable convergence properties, in contrast to critic-only methods for which convergence is guaranteed in rather limited settings


In this paper, we propose some actor-critic algorithms in which the critic uses linearly parameterized approximations of the value function, and we provide a convergence proof.


important observation
- since the number of parameters that the actor has to update is relatively small (compared to the number of states), the critic need not attempt to compute or approximate the exact value function, which is a high-dimensional object
- in fact, we show that the critic should ideally compute a certain "projection" of the value function onto a low-dimensional subspace spanned by a set of "basis functions," which are completely determined by the parameterization of the actor.
- this key insight was also derived in simultaneous and independent work that also included a discussion of certain actor-critic algorithms

outline of the paper
- section 2, we state a formula for the gradient of the average cost in a Markov decision process with finite state and action space
- section 3, derive our algorithms
- section 4, we consider Markov decision processes and the gradient of the average cost in much greater generality and describe the algorithms in this more general setting
- sections 5 and 6, we provide an analysis of the asymptotic behavior of the critic and actor, respectively


# MDPs and parameterized families of randomized stationary policies


# actor-critic algorithms


# algorithms for Polish state and action spaces



# convergence of the critic


# convergence of the actor