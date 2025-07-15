---
title: "Survey of Actor Critic"
date: 2025-07-14T16:50:08+02:00
draft: true
---

# abstract

Policy gradient based actor-critic algorithms are amongst the most popular algorithms in the reinforcement learning framework.
- able to search for optimal policies using low-variance gradient **estimates** has made them useful in real-life applications, such as robotics, power control and finance
- this paper therefore describes the state of the art of actor-critic algorithms
- with a focus on methods that can work in an online setting and use function approximation in order to deal with continuous state and action spaces.
- describes the origins of actor-critic algorithms
- describes the workings of the natural gradient, which has made its way into many actor-critic algorithms in the past few years
- a review of several standard and natural actor-critic algorithms


# introduction


RL learning is a framework in which an agent (or controller) optimizes its behavior by interacting with its environment.
- After taking an action in some state, the agent receives a scalar reward from the environment, which gives the agent an indication of the quality of that action
- the function that indicates the action to take in a certain state is called the policy
- the main goal of the agent is to find a policy that maximizes the total accumulated reward, also called the return
- by following a given policy and processing the rewards, the agent can build **estimates of the return**
- the function representing this estimated return is known as the value function
- using this value function allows the agent to make indirect use of past experiences to decide on future actions to take in or around a certain state

types of RL algorithms
- actor-only
- critic-only
- actor-critic

Where the words actor and critic are synonyms for the policy and value function, respectively
- actor-only methods: a parameterized familiy of policies over which optimization procedures can be used directly
- the benefit of a parameterized policy is that a spectrum of continuous actions can be generated
- but the optimization methods used (typically called policy gradient methods) suffer from high variance in the estimates of the gradient, leading to slow learning
- critic-only methods that use temporal difference learning have a lower variance in the estimates of expected returns
- a straightforward way of deriving a policy in critic-only methods is by selecting greedy actions
- actor-critic methods combine the advantages of actor-only and critic-only methods
	- the parameterized actor brings the advantage of computing continuous actions without the need for optimization procedures on a value function
	- the critic's merit is that it supplies the actor with low-variance knowledge of the performance


# markov decision processes


# Actor-Critic in the context of RL



# standard gradient actor-critic algorithms



# natural gradient actor-critic algorithms



# applications



# discussion and outlook