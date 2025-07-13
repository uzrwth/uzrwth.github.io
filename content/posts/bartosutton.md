---
title: "Bartosutton"
date: 2025-07-13T12:29:33+02:00
draft: false
---



# preface 1

Revive the idea
- that networks of neuronlike adaptive elements might prove to be a promising approach to artificial adaptive intelligence.
- A. Harry Klopf's work was a rich source of ideas
- task became teasing the ideas apart and understanding their relationships and relative importance
- the simplest of the ideas: a learning system that wants something, that adapts its behavior in order to maximize a special signal from its environment.
- the special issues involved in learning how to get something from the environment received relatively little attention. (such a fundamental idea had not yet been thoroughly explored)




RL evolves and matures
- deveopled strong mathematical foundations and impressive applications
- developing the relationships to the theory of optimal control and dynamic programming.
- we can now place component ideas, such as temporal-difference learning, dynamic programming, and function approximation, within a coherent perspective with respect to the overall problem


Goal of the book
- provide a clear and simple account of the key ideas and algorithms
- mathematical detail without distracting from the simplicity and potential generality of the underlying ideas


Three parts in the book
- introductory and problem oriented
- tabular versions of all the basic solution methods based on estimating action values
- extending the tabular methods to include various forms of approximation
- frontiers of reinforcement learning in biology and applications.


Supplemented by readings
- Bertsekas and Tsitsiklis (1996)
- Szepesvari (2010)

This book can be used
- a text
- as a part of a borader course on machine learning, artificial intelligence, or neural networks
- Part II are best covered in sequence, Chapter 6 is the most important for the subject and for the rest of the book


This book is self-contained
- the only mathematical backround assumed is: probability (expectations of random variables)
- Chapter 9 is easier to digest with background: artificial neural networks, or some other kind of supervised learning method


# preface 2

The edition remains an introduction and we retain a focus on core, online learning algorithms.

Required a bit more mathematics to explain
- For example, the state, action, and reward at time step $t$ are denoted $S_t, A_t$, and $R_t$, while their possible values might be denoted $s, a$, and $r$.
- Along with this, it is natural to use lower case for value functions (e.g., $v_{\pi}$) and restrict capitals to their tabular estimates (e.g., $Q_t(s,a)$).
- Approximate value functions are deterministic functions of random parameters and are thus also in lower case (e.g., $\hat{v}(s,\mathbf{w_t}) \approx v_\pi(s)$).
- Vectors, such as the weight vector $\mathbf{w_t}$ (formerly $\mathbf{\theta}_t$) and the feature vector $\mathbf{x_t}$ (formerly $\mathbf{\phi_t}$), are bold and written in lowercase even if they are random variables.
- special notations for the transition probabilities and expected rewards.
- first edition
	- $\mathcal{P}_{ss^{\prime}}^{a}$
	- $\mathcal{R}_{ss^{\prime}}^{a}$
	- Weakness of that notation: it still did not fully characterize the dynamics of the rewards, giving only their expectations, which is sufficient for dynamic programming but not for reinforcement learning.
- this edition
	- $p(s',r|s,a)$ for the joint probability for the next state and reward given the current state and action

structure of the book
- introductory
- first part
	- without going beyond the tabular case for which exact solutions can be found
- second part
	- extending the ideas to function approximation
-  third part
	- psychology and neuroscience

used
- the first ten chapters should be covered in order and form a good core


Supplemented by readings
- Bertsekas and Tsitsiklis (1996)
- Wiering van Otterlo (2012)
- Szepesvári (2010)


# Chapter 1


## Reinforcement learning

how to map situations to actions
- so as to maximize a numerical reward signal
- the learner is not told which actions to take, but instead must discover which actions yields the most reward by trying them
- actions may affect not only the immediate reward but also the next situation and, through that, all subsequent rewards
- these two characteristics are the two most important distinguishing features of reinforcement learning
	- trial-and-error
	- delayed reward

ing
- a problem
- a class of solution methods that work well on the problem
- the field that studies this problem and its solution methods
- it is convenient to use a single name for all three things
- but at the same time essential to keep the three conceptually separate
- important to make the distinction between problems and solution methods in reinforcement learning; failing to make this distinction is the source of many confusions


Formalize the problem of refinforcement learning
- using ideas from dynamical systems theory (optimal control of incompletely-known Markov decision processes)
- the basic idea is simply to capture the most important aspects of the real problem facing a learning agent interacting over time with its environment to achieve a goal
- a learning agent must be able to sense the state of its environment to some extent and must be able to take actions that affect the state
- the agent must also have a goal relating to the state of the environment
- Markov decision processes are intended to include just these three aspects: sensation, action, and goal
- any method that is well suited to solving such problems we consider to be a reinforcement learning method


reinforcement learning is trying to maximize a reward signal instead of trying to find hidden structure.
Uncovering structure in an agent's experience can certainly be useful in reinforcement learning, but by itself does not address the reinforcement learning problem of maximizing a reward signal. We therefore consider reinforcement learning to be a third machine learning paradigm, alongside supervised learning and unsupervised learning.

Dilemma
- exploreation
- exploitation
- on a stochastic task, each action must be tried many times to gain a reliable estimate of its expected reward

another key feature
- it explicitly considers the whole problem of a goal-directed agent interacting with an uncertain environment
- starting with a complete, interactive, goal-seeking agent
- when reinforcement learning involves supervised learning, it does so for specific reasons that determine which capabilities are critical and which are not

The ability of some reinforcement learning methods to learn with parameterized approximators addresses the classical "curse of dimensionality" in operations research and control theory.


## Elements of reinforcement learning

- policy
- reward signal
- value function
- model

policy is a mapping from perceived states of the environment to actions to be taken when in those states.

it may be a simple function or lookup table

it may involve extensive computation such as a search process

The policy is the core of a reinforcement learning agent in the sense that it alone is sufficient to determine behavior.

In general, policies may be stochastic, specifying probabilities for each action

## Examples

- chess player
- adaptive controller adjusts parameters of a petroleum refinery's operation in real time
- Phil prepares his breakfast

All invole interaction between an active decision-making agent and its environment, within which the agent seeks to achieve a goal despite uncertainty about its environment

The agent can use its experience to improve its performance over time

The chess player refines the intuition he uses to evaluate positions

The knowledge the agent brings to the task at the start --- either from previous experience with related tasks or built into it by design or evolution --- influences what is useful or easy to learn, but interaction with the environment is essential for adjusting behavior to exploit specific features of the task.


## Early history of RL

Two main threads
- learning by trial and error, and originated in the psychology of animal learning
- the problem of optimal control and its solution using value functions and dynamic programming
- two threads became interrelated around a third thread concerning temporal-difference methods


optimal control
- designing a controller to minimize or maximize a measure of a dynamical system's behavior over time
	- Richard Bellman (extending Hamilton, Jacobi): This approach uses the concepts of a dynamical system's state and of a value function, or "optimal return function," to define a function equation, now often called the Bellman equation.
	- The class of methods for solving optimal control problems by solving this equation came to be known as dynamic programming
	- Beelman introduced the discrete stochastic version of the optimal control problem known as Markov decision processes.
	- Ronald Howard (1960) devised the policy iteration method for MDPs.
	- All of these are essential elements underlying the theory and algorithms of modern reinforcement learning
	- dynamic programming is considered the only feasible way of solving general stochastic optimal control problems
	- suffers from what Bellman called "the curse of dimensionality"
	- meaning the its computational requirements grow exponentially with the number of state variables
	- dynamic programming has been developed
		- extensions to partially observable MDPs
		- approximation methods
	- many excellent modern treatments of dynamic programming (Bertsekas 2005, ...)
	- connections between optimal control and dynamic programming and learning were slow to be recognized
	- the prevalent view of dynamic programming as an offline computation depending on accurate system models and analytic solutions to the Bellman equation
	- the simplest form of dynamic programming is a computation that proceeds backwards in time
	- some of the earliest work in dynamic programming (Bellman and Dreyfus 1959), might now be classified as following a learning approach
	- Witten's work (1977) qualifies as a combination of learning and dynamic-programming ideas
	- Werbos 1987 argued for greater interrelation of dynamic programming and learning methods and for dynamic programming's relevance to understanding neural and cognitive mechanisms
	- the full integration of dynamic programming methods with online learning: Chris Watkins 1989
		- whose treatment of reinforcement learning using the MDP formalism has been widely adopted
	- Dimitri Bertsekas and John Tsitsiklis (1996)


we consider all of the work in optimal control also to be work in reinforcement learning
- accordingly, we must consider the solution methods of optimal control, such as dynamic programming, also to be reinforcement learning methods
- conventional methods require complete knowledge of the system
- dynamic programming algorithms are incremental and iterative
- like learning methods, they gradually reach the correct answer through successive approximations
- To be considered reinforcer, the strengthening or weakening must persist after the reinforcer is withdrawn
- a stimulus merely attracts an animal's attention or that energizes its behavior without producing lasting changes would not be considered a reinforcer





the thread: trial-and-error learning
- R. S. Woodworth (1938)
- Alexander Bain’s discussion
- Conway Lloyd Morgan’s 1894

The term "reinforcement" in the context of animal learning
- came into well use after Thorndike’s expression of the Law of Effect
- Pavlov described reinforcement as the strengthening of a pattern of behavior due to an animal receiving a stimulus


many machines were constructed that demonstrated trial-and-error learning
- Thomas Ross (1933)
- 1951 W. Grey Walter
- 1952 Claude Shannon
- J. A. Deutsch




their interests soon shifted from trial-and-error learning to generalization and pattern recognition
- that is, from reinforcement learning to supervised learning Clark and Farley, 1955
- they used the language of rewards and punishments, but the systems were supervised learning systems suitable for pattern recognition and perceptual learning Rosenblatt (1962) and Widrow and Hoff
- Even today, some researchers and textbooks minimize or blur the distinction between these types of learning
- For example, some artificial neural network textbooks have used the term “trial-and-error” to describe networks that learn from training examples
- the essential character of trial-and-error learning as selection actions on the basis of evaluative feedback that does not rely on knowledge of what the correct action should be



“Steps Toward Artificial Intelligence” (Minsky, 1961), well worth reading today

Ian Witten (1977, 1976a) temporal-difference learning rule
- now called tabular TD for use as part of an adaptive controller for solving MDPs
