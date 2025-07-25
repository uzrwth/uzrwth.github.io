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


## Examples

- chess player
- adaptive controller adjusts parameters of a petroleum refinery's operation in real time
- Phil prepares his breakfast

All invole interaction between an active decision-making agent and its environment, within which the agent seeks to achieve a goal despite uncertainty about its environment

The agent can use its experience to improve its performance over time

The chess player refines the intuition he uses to evaluate positions

The knowledge the agent brings to the task at the start --- either from previous experience with related tasks or built into it by design or evolution --- influences what is useful or easy to learn, but interaction with the environment is essential for adjusting behavior to exploit specific features of the task.


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



A reward signal defines the goal of a reinforcement learning problem
- on each time step, the environment sends to the reinforcement learnint agent a single number called the reward
- the agent's sole objective is to maximize the total reward it receives over the long run
- the reward signal is the primary basis for altering the policy
- if an action selected by the policy is followed by low reward, then the policy may be changed to select some other action in that situation in the future
- In general, reward signals may be stochastic functions of the state of the environment and the actions taken


Whereas the reward signal indicates what is good in an immediate sense, a value function specifies what is good in the long run
- the value of a state is the total amount of reward an agent can expect to accumulate over the future, starting from that state
- For example, a state might always yield a low immediate reward but still have a high value because it is regularly followed by other states that yield high rewards
- To make a human analogy, rewards are somewhat like pleasure, whereas values correspond to a more refined and farsighted judgement of how pleased or displeased we are that our environment is in a particular state
- it is values with which we are most concerned when making and evaluating decisions
- action choices are made based on value judgements
- unfortunately, it is much harder to determine values than it is to determine rewards. Rewards are basically given directly by the environment, but values must be estimated and re-estimated from the sequences of observations an agent makes over its entire lifetime

**In fact, the most important component of almost all reinforcement learning algorithms we consider is a method for efficiently estimating values.**

The central role of value estimation is arguably the most important thing that has been learned about reinforcement learning over the last six decades.


models are used for planning
- methods for solving reinforcement learning problems that use models and planning are called model-based methods, as opposed to simpler model-free methods
- modern reinforcement learning spans the spectrum from low-level, trial-and-error learning to high-level, deliberative planning




## Limitations and scope

RL relies heavily on the concept of state
- as input to the policy and value function
- as both input to and output from the model
- we can think of the state as a signal conveying to the agent some sense of "how the environment is" at a particular time
- we encourage the reader to follow the informal meaning and think of the state as whatever information is available to the agent about its environment
- our concern in this book is not with designing the state signal, but with deciding what action to take as a function of whatever state signal is available


Most of the reinforcement learning methods we consider are structured around estimating value functions, but it is not strictly necessary to do this to solve reinforcement learning problems
- our focus is on reinforcement learning methods that learn while interacting with the environment, which evolutionary methods do not do
- although evolution and learning share many features and naturally work together, we do not consider evolutionary methods by themselves to be especially well suited to reinforcement learning problems and, accordingly, we do not cover them in this book


## An Extended Example: Tic-Tac-Toe

let us consider draws and losses to be equally bad for us

cannot be solved in a satisfactory way through classical techniques

the classical "minimax" solution from game theory is not correct here because it assumes a particular way of playing by the opponent

For example, a minimax player would never reach a game state from which it could lose, even if in fact it always won from that state because of incorrect play by the opponent.


Classical optimization methods for sequential decision problems, such as dynamic programming, can compute an optimal solution for any opponent, but require as input a complete specification of that opponent, including the probabilities with which the opponent makes each move in each board state. Let us assume that this information is not available a priori for this problem, as it is not for the vast majority of problems of practical interest. On the other hand, such information can be estimated from experience, in this case by playing many games against the opponent. About the best one can do on this problem is first to learn a model of the opponent's behavior, up to some level of confidence, and then apply dynamic programming to compute an optimal solution given the approximate opponent model. In the end, this is not that different from some of the reinforcement learning methods we examine later in this book.


Here is how the tic-tac-toe problem would be approached with a method making use of a value function. First we would set up a table of numbers, one for each possible state of the game. Each number will be the latest estimate of the probability of our winning from that state. We treat this estimate as the state's value, and the whole table is the learned value function. State A has higher value than state B, or is considered "better" than state B, if the current estimate of the probability of our winning from A is higher than it is from B. Assuming we always play Xs, then for all states with three Xs in a row the probability of winning is 1, because we have already won. Similarly, for all states with three Os in a row, or that are filled up, the correct probability is 0, as we cannot win from them. We set the initial values of all the other states to 0.5, representing a guess that we have a 50% chance of winning.

We then play many games against the opponent. To select our moves we examine the states that would result from each of our possible moves (one for each blank space on the board) and look up their current values in the table. Most of the time we move greedily, selecting the move that leads to the state with greatest value, that is, with the highest estimated probability of winning. Occasionally, however, we select randomly from among the other moves instead. These are called exploratory moves because they cause us to experience states that we might otherwise never see.


back up
- attempt to make them more accurate estimates of the probabilities of winning
- we "back up" the value of the state after each greedy move to the state before the move
- more precisely, the current value of the earlier state is updated to be closer to the value of the later state
- this can be done by moving the earlier state's value a fraction of the way toward the value of the later state
- If we let $S_t$ denote the state before the greedy move, and $S_{t+1}$ the state after the move, then the update to the estimated value of $S_t$, denoted $V(S_t)$ can be written as
	- $V(S_t) \leftarrow V(S_t) +\alpha[V(S_{t+1} - V(S_t)]$
	- $\alpha$ is a small positive fraction called the step-size parameter, which influences the rate of learning
	- this update rule is an example of a temporal-difference learning method, so called because its changes are based on a difference, $V(S_{t+1})-V(S_t)$, between estimates at two successive times

moves
- our second move was an exploratory move, meaning that it was taken even though another sibling move, the one leading to $e^*$, was ranked higher.
- Exploratory moves do not result in any learning, but each of our other moves does, causing updates as suggested by the red arrows in which estimated values are moved up the tree from later nodes to earlier nodes


converges
- The method described above performs quite well on this task
- if the step-size parameter is reduced properly over time, then this method converges, for any fixed opponent, to the true probabilities of winning from each state given optimal play by our player
- in other words, the method converges to an optimal policy for playing the game against this opponent
- if the step-size parameter is not reduced all the way to zero over time, then this player also plays well against opponents that slowly change their way of playing

the differences between evolutionary methods and methods that learn value functions
- to evaluate a policy an evolutionary method holds the policy fixed and plays many games against the opponent, or stimulates many games using a model of the opponent
	- the frequency of wins gives an unbiased estimate of the probability of winning with that policy
	- can be used to direct the next policy selection
	- but each policy change is made only after many games, and only the final outcome of each game is used: what happens during the games is ignored
	- for example, if the player wins, then all of its behavior in the game is given credit, independently of how specific moves might have been critical to the win
- value function methods, in contrast, allow individual states to be evaluated
	- in the end, evolutionary and value function methods both search the space of policies, but learning a value function takes advantage of information available during the course of play


key features of RL
- the emphasis on learning while interacting with an environment
- there is a clear goal, planning or foresight that takes into account delayed effects of one's choices
- for example, the simple reinforcement learning player would learn to set up multi-move traps for a shortsighted opponent
- it is a striking feature of the RL solution that it can achieve the effects of planning and lookahead without using a model of the opponent and without conducting an explicit search over possible sequences of future states and actions


The general principles apply to continuous-time problems as well, although the theory gets more complicated and we omit it from this introductory treatment

when the state set is very large, or even infinite
- The artificial neural network provides the program with the ability to generalize from its experience, so that in new states it selects moves based on information saved from similar states faced in the past, as determined by its network
- How well a RL system can work in problems with such large state sets is intimately tied to how appropriately it can generalize from past experience
- It is in this role that we have the greatest need for supervised learning methods with RL.
- Artificial neural networks and deep learning are not the only, or necessarily the best, way to do this


RL can be applied in either case
- A model is not required, but models can easily be used if they are available or can be learned
- Because models have to be reasonably accurate to be useful, model-free methods can have advantages over more complex methods when the real bottleneck in solving a problem is the difficulty of constructing a sufficiently accurate environment model
- In this book we devote several chapters to model-free methods before we discuss how they can be used as components of more complex model-based methods

## Summary

RL is a computational approach to understanding and automating goal-directed learning and decision making. It is distinguished from other computational approaches by its emphasis on learning by an agent from direct interaction with its environment, without requiring exemplary supervision or complete models of the environment.

RL uses the formal framework of Markov decision processes to define the interaction between a learning agent and its environment in terms of states, actions, and rewards. This framework is intended to be a simple way of representing essential features of the artificial intelligence problem.

The concepts of value and value function are key to most of the RL methods that we consider in this book.
We take the position that value functions are important for efficient search in the space of policies.

The use of value functions distinguishes RL methods from evolutionary methods that search directly in policy space guided by evaluations of entire policies.


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


# Part I: Tabular solution methods

core ideas of RL algorithms in their simplest forms
- that in which the state and action spaces are small enough for the approximate value functions to be represented as arrays, or tables
- in this case, the methods can often find exact solutions. (exactly the optimal value function and the optimal policy)
- this contrasts with the approximate methods described in the next part of the book, which only find approximate solutions, but which in return can be applied effectively to much larger problems



# Finite Markov Decision Processes

In this chapter we introduce the formal problem of finite Markov decision processes, or finite MDPs, which we try to solve in the rest of the book.
- This problem involves evaluative feedback, as in bandits, but also an associative aspect--- choosing different actions in different situations
- MDPs are a classical formalization of sequential decision making, where actions influence not just immediate rewards, but also subsequent situations, or states, and through those future rewards
- Thus MDPs involve delayed reward and the need to tradeoff immediate and delayed reward
- whereas in bandit problems we estimated the value $q_\*(a)$ of each action $a$, in MDPs we estimate the value $q_\*(s,a)$ of each action $a$ in each station $s$, or we estimate the value $v_\*(s)$ of each state given optimal action selections
- These state-dependent quantities are essential to accurately assigning credit for long-term consequences to individual action selections

MDPs are a mathematically idealized form of the reinforcement learning problem for which precise theoretical statements can be made.
- we introduce key elements of the problem's mathematical structure, such as returns, value functions, and Bellman equations
- we try to convey the wide range of applications that can be formulated as finite MDPs.
- as in all of artificial intelligence, there is a tension between breadth of applicability and mathematical tractability


## the Agent-Environment interface

MDPs are meant to be a straightforward framing of the problem of learning from interaction to achieve a goal.
- the learner and decision maker is called the agent
- the thing it interacts with, comprising everything outside the agent, is called the environment
- These interact continually, the agent selecting actions and the environment responding to these actions and presenting new situations to the agent
- the environment also gives rise to rewards, special numerical values that the agent seeks to maximize over time through its choice of actions


The MDP and agent together thereby give rise to a sequence or trajectory that begins like this:
- $S_0, A_0, R_1, S_1, A_1, R_2, S_2, A_2, R_3, ...$




The MDP framework is a considerable abstraction of the problem of goal-directed learning from interaction.


Of course, the particular states and actions vary greatly from task to task, and how they are represented can strongly affect performance.


In this book we offer some advice and examples regarding good ways of representing states and actions, but our primary focus is on general principles for learning how to behave once the representations have been selected.

## goals and rewards


the agent's goal is to maximize the total amount of reward it receives.

this means maximizing not immediate reward, but cumulative reward in the long run.


the use of a reward signal to formalize the idea of a goal is one of the most distinctive features of reinforcement learning



## returns and episodes

## unified notation for episodic and continuing tasks


## policies and value functions


## optimal policies and optimal value functions


## optimality and approximation

We have defined optimal value functions and optimal policies
- clearly, an agent that learns an optimal policy has done very well, but in practice this rarely happens
- for the kinds of tasks in which we are interested, optimal policies can be generated only with extreme computational cost
- A well-defined notion of optimality organizes the approach to learning we describe in this book and provides a way to understand the theoretical properties of various learning algorithms, but it is an ideal that agents can only approximate to varying degrees.
- even if we have a complete and accurate model of the environment's dynamics, it is usually not possible to simply compute an optimal policy by solving the Bellman optimality equation
- For example, board games such as chess are a tiny fraction of human experience, yet large, custom-designed computers still cannot compute the optimal moves
- A critical aspect of the problem facing the agent is always the computational power available to it, in particular, the amount of computation it can perform in a single time step


The memory available is also an important constraint
- A large amount of memory is often required to build up approximations of value functions, policies, and models.
- In tasks with small, finite state sets, it is possible to form these approximations using arrays or tables with one entry for each state (or state-action pair)
- This we call the tabular case, and the corresponding methods we call tabular methods.
- In many cases of practical interest, however, there are far more states than could possibly be entries in a table
- In these cases the functions must be approximated, using some sort of more compact parameterized function representation


Our framing of the reinforcement learning problem forces us to settle for approximations
- However, it also presents us with some unique opportunities for achieving useful approximations
- For example, in approximating optimal behavior, there may be many states that the agent faces with such a low probability that selecting suboptimal actions for them has little impact on the amount of reward the agent receives.
- In fact, it is possible that TD-Gammon makes bad decisions for a large fraction of the game's state set.
- This is one key property that distinguishes reinforcement learning from other approaches to approximately solving MDPs.


## summary

The elements of the reinfocement learning problem
- about learning from interaction how to behave in order to achieve a goal
- the reinforcement learning agent and its environment interact over a sequence of discrete time steps
- the specification of their interface defiens a particular task: the actions are the choices made by the agent; the states are the basis for making the choices; and the rewards are the basis for evaluating the choices
- Everything inside the agent is completely known and controllable by the agent; everything outside is incompletely controllable but may or may not be completely known
- A policy is a stochastic rule by which the agent selects actions as a function of states
- the agent's objective is to maximize the amount of reward it receives over time


When the reinforcement learning setup described above is formulated with well defined transition probabilities it constitutes a Markov decision process (MDP).
- a finite MDP is an MDP with finite state, action, and reward sets.
- much of the current theory of reinforcement learning is restricted to finite MDPs, but the methods and ideas apply more generally.


The return is the function of future rewards that the agent seeks to maximize (in expected value). 
- It has several different definitions depending upon the nature of the task and whether one wishes to discount delayed reward.
- the undiscounted formulation is appropriate for episodic tasks, in which the agent-environment interaction breaks naturally into episodes; the discounted formulation is appropriate for continuing tasks, in which the interaction does not naturally break into episodes but continues without limit
- we try to define the returns for the two kinds of tasks such that one set of equations can apply to both the episodic and continuing cases


A policy's value functions assign to each state, or state-action pair, the expected return from that state, or state-action pair, given that the agent uses the policy.



# Dynamic Programming

The term dynamic programming (DP) refers to a collection of algorithms that can be used to compute optimal policies given a perfect model of the environment as a Markov decision process (MDP).
- Classical DP algorithms are of limited utility in reinforcement learning both because of their assumption of a perfect model and because of their great computational expense, but they are still important theoretically.

We usually assume that the environment is a finite MDP. That is, we assume that its state, action, and reward sets, $\mathcal{S}$, $\mathcal{A}$, and $\mathcal{R}$, are finite, and that its dynamics are given by a set of probabilities $p(s',r \mid s,a)$.
- Although DP ideas can be applied to problems with continuous state and action spaces, exact solutions are possible only in special cases
- A common way of obtaining approximate solutions for tasks with continuous states and actions is to quantize the state and action spaces and then apply finite-state DP methods.

The key idea of DP, and of reinforcement learning generally, is the use of value functions to organize and structure the search for good policies.
- In this chapter we show how DP can be used to compute the value functions defined in Chapter 3.
- As discussed there, we can easily obtain optimal policies once we have found the optimal value functions, $v_\*$ or $q_\*$, which satisfy the Bellman optimality equations
- As we shall see, DP algorithms are obtained by turning Bellman equations such as these into assignments, that is, into update rules for improving approximations of the desired value functions
- $v_\* = \underset{a \in \mathcal{A}}{\max} \mathbb{E}\left[ R_{t+1} + \gamma v_\pi(S_{t+1}) \mid S_t = s, A_t = a \right]$
- $= \underset{a \in \mathcal{A}}{\max} \sum_{s', r} p(s', r \mid s, a) \left[ r + \gamma v_*(s') \right]$
- $q_\*(s,a)=\mathbb{E}\left[R_{t+1}+\gamma \underset{a'}{\max}q_\*(S_{t+1},a') \mid S_t=s, A_t=a \right]$
- $= \sum_{s',r} p(s',r \mid s,a)\left[r+ \gamma \underset{a'}{\max}q_\*(s',a')\right]$


## Policy Evaluation (Prediction)

First we consider how to compute the state-value function $v_\pi$ for an arbitrary policy $\pi$. This is called policy evaluation in the DP literature. We also refer to it as the prediction problem.


## Policy Improvement

Purpose for computing the value function for a policy
- is to help find better policies


the value function $v_{\pi}$ for an deterministic policy $\pi$

for some state $s$ we would like to know whether or not we should change the policy to choose an action $a \neq \pi(s)$.





# Monte Carlo Methods

We consider our first learning methods for estimating value functions and discovering optimal policies. Unlike the previous chapter, here we do not assume complete knowledge of the environment.

Monte Carlo methods require only experience---sample sequences of states, actions, and rewards from actual or simulated interaction with an environment.

- Learning from actual experience is striking because it requires no prior knowledge of the environment's dynamics, yet can still attain optimal behavior.
- Learning from simulated experience is also powerful.
- Although a model is required, the model need only generate sample transitions, not the complete probability distributions of all possible transitions that is required for dynamic programming (DP).
- In surprisingly many cases it is easy to generate experience sampled according to the desired probability distributions, but infeasible to obtain the distributions in explicit form.


# Temporal-Difference Learning

If one had to identify one idea as central and novel to reinforcement learning, it would undoubtedly be temporal-difference (TD) learning. TD learning is a combination of Monte Carlo ideas and dynamic programming (DP) ideas. Like Monte Carlo methods, TD methods can learn directly from raw experience without a model of the environment's dynamics. Like DP, TD methods update estimates based in part on other learned estimates, without waiting for a final outcome (they bootstrap).



# Eligibility Traces

Eligibility traces are one of the basic mechanisms of reinforcement learning. For example, in the popular $TD(\lambda)$ algorithm, the $\lambda$ refers to the use of an eligibility trace. Almost any temporal-difference (TD) method, such as Q-learning or Sarsa, can be combined with eligibility traces to obtain a more general method that may learn more efficiently.

Eligibility traces unify and generalize TD and Monte Carlo methods. When TD methods are augmented with eligibility traces, they produce a family of methods spanning a spectrum that has Monte Carlo methods at one end ($\lambda=1)$ and one-step TD methods at the other ($\lambda=0$).

## implementation issues

it might at first appear that tabular methods using eligibility traces are much more complex than one-step methods. A naive implementation would require every state(or state-action pair) to update both its value estimate and its eligibility trace on every time step.

This would not be a problem for implementations on single-instruction, multiple-data, parallel computers or in plausible artificial neural network (ANN) implementations, but it is a problem for implementations on conventional serial computer. Fortunately, for typical values of $\lambda$ and $\gamma$ the eligibility traces of almost all states are almost always nearly zero; only those states that have recently been visited will have traces significantly greater than zero and only these few states need to be updated to closely approximate these algorithms.