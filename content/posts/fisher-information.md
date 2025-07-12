---
title: "Fisher Information"
date: 2025-07-08T16:04:08+02:00
draft: false
---


In many statistical applications that concern mathematical psychologists, the concept of Fisher Information plays an important role.

In this tutorial we clarify the concept of Fisher information as it manifests itself across three different statistical paradigms.

First, in the frequentist paradigm, Fisher information is used to construct hypothesis tests and confidence intervals using maximum likelihood estimators; second, in the Bayesian paradigm, Fisher information is used to define a default prior; lastly, in the minimum description length paradigm, Fisher information is used to measure model complexity.

# The role of Fisher Information in Frequentist Statistics


# The role of Fisher Information in Bayesian Statistics


# The role of Fisher Information in Minimum Description Length



# Generalization to Vector-Valued Parameters: The Fisher Information Matrix



# Frequentist Statistics based on Asymptotic Normality


# arg min

$min\ f(x)$ 表示函数$f(x)的最小值（一个数值）。

$arg\ min\ f(x)$ 表示使得 $f(x)$ 取得最小值的$x$的取值

![](/images/fisher.png)


This shows that the natural policy gradient, up to a constant factor, is the solution to a least-squares regression problem.

The idea is: we want to find a weight vector such that the inner product between the policy gradient and the weight vector approximates the advantage $Q^{\pi}(s,a)-b(s)$.


# $Q^{\pi}(s,a)-b(s)$

This is a fundamental concept in reinforcement learning, particularly in policy gradient methods and advantage estimation.

$Q^{\pi}(s,a)$: State-Action value function

The expected cumulative future reward (return) when taking action $a$ in state $s$ and therafter following policy $\pi$.

$Q^{\pi}(s,a)$ tells how good action $a$ is at state $s$.


$b(s)$: baseline function

A function that depends only on the state $s$ (not the action $a$), used to reduce variance in gradient estimates.

$b(s)$ is a baseline to reduce noise.

$Q^{\pi}(s,a)-b(s)$ gives the advantage of action $a$ over the expected value of the policy.

This helps the learning algorithm focus on actions that perform better than average.

# $\pi_{\theta}(\cdot \mid s)$

This is a parameterized policy: given a state $s$, it returns a probability distribution over actions.

$a \sim \pi_{\theta}(\cdot \mid s)$ means the action $a$ is sampled according to the policy $\pi_{\theta}$ at state $s$.


# $d_{\lambda}^{{\pi}_{\theta}}$ 

This is a discounted state distribution under the policy $\pi_{\theta}$


Take an expectation of a function
- state $s$ sampled from the discounted distribution
- action $a$ sampled from the policy $\pi_{\theta}(a \mid s)$



# At a high level

Reinforcement learning is learning a policy --- a function that maps states $s$ to actions $a$ --- to maximize expected cumulative reward over time.

## policy: $\pi_{\theta}(a \mid s)$

- A probability distribution over actions given a state.
- Parameterized by $\theta$, often using a neural network.
- **Learning goal**: adjust $\theta$ so that the agent chooses better actions more often.


- $\pi_{\theta}(\cdot \mid s)$ 表示动作的整体分布
- $\pi_{\theta}(a \mid s)$  表示在状态 $s$ 下选择具体动作 $a$ 的概率值
- 动作 $a$ 是你从策略输出的概率分布中采样出来的结果
- 如果你把策略当成一个函数: 意思是：  输入一个状态 $s$, 输出一个在动作空间 $\mathcal{A}$ 上的概率分布
- $\pi_{\theta} : \mathcal{S} \rightarrow \mathcal{P}(\mathcal{A})$
- 状态 $s$ 是策略函数的自变量
- 参数$\theta$是控制策略的参数（你训练中要更新的东西）
- 动作 $a$是你从策略输出的概率分布中采样出来的结果
- 参数可以看作是自变量，并且我们正是对它们进行梯度计算。

## value functions

These are estimates of how good it is to be in a state or take an action.

- $V^{\pi}(s)$: expected return from state $s$
- $Q^{\pi}(s,a)$: expected return from state $s$, taking action $a$
- **Learning goal**: learn accurate value estimates to inform the policy



# What is the score function

In statistics and machine learning, especially in maximum likelihood estimation (MLE) and reinforcement learning, the score function is defined as:

$Score(\theta) = \nabla_\theta\ log\ p(x\mid\theta)$

This is the gradient of the log-likelihood function with respect to the model parameters $\theta$.

The score tells you: In which direction should I move $\theta$ to increase the likelihood of the observed data?

It is both. (both a function and a vector).


In reinforcement learning, the score function appears in the policy gradient theorem.

$Score(\theta) = \nabla_\theta\ log\ \pi_\theta(a \mid s)$

It tells us how changing the policy parameters $\theta$ would affect the probability of taking action $a$ in state $s$


Fisher information matrix: it is the **expected outer product** of the score vector with itself.

This matrix captures:
- How much each parameter affects each other in terms of the likelihood's curvature
- The second-order sensitivity of the model to its parameters --- like a "generalized variance"


Main uses of the outer product of the score

- FIM: measures how much information the data carries about the parameters
- Natural gradient descent: uses the inverse of this matrix to scale gradients efficiently
- Variance of MLE: the inverse Fisher Information gives the Cramer-Rao lower bound


This matrix is symmetric and positive semi-definite. It represents the Fisher Information at that point.

## Summary

The outer product of the score function gives a matrix that captures parameter sensitivity and interaction, and its expectation over the data is the Fisher Information Matrix.



# Natural policy gradient

Natural policy gradient is an optimization technique used in reinforcement learning to update the parameters of a policy in a way that accounts for the underlying geometry of the parameter space.


Unlike the standard policy gradient, which follows the steepest descent direction in the Euclidean space, the natural policy gradient follows the steepest descent direction with respect to the Fisher information metric, leading to more stable and efficient updates.


In RL, the goal is to maximize the expected return $J(\theta)$, where $\theta$ represents the parameters of a policy $\pi_\theta$.

The standard policy gradient update is: (SPG)

$\theta_{k+1} = \theta_{k} + \alpha\nabla_\theta\ J(\theta_{k})$.

Where $\alpha$ is the learning rate.



# Policy gradient theorem

The policy gradient theorem can be generalized to include a comparison of the action value to an arbitrary baseline $b(s)$



This exercise is about natural policy gradient and connects it with least-squares projection.

The possibility of using natural gradients in online learning was first appreciated in [75]. As shown above, the crucial property of the natural gradient is that it takes into account the structure of the manifold over which the cost function is defined, locally characterized by the Riemannian metric tensor.


# Euclidean space 

Euclidean space is the fundamental mathematical framework for classical geometry, where distances and angles are defined in a "flat" (non-curved) manner. It generalizes the intuitive notions of 2D planes and 3D space to any finite dimension $n$.


A manifold is a mathematical concept that generalizes the idea of a smooth, curved space to higher dimensions. Intuitively, it is a topological space that locally resembles Euclidean space (e.g., a flat plane) but may have a more complicated global structure.


Manifold's Key intuitions:
- "Locally Euclidean": Near every point, a small patch of the manifold looks like $\mathbb{R}^n$
- Globally Curved: The overall shape can be more complex (e.g., a sphere, torus, or hyperbolic space).


How good is natural gradient learning compared to conventional gradient learning?
The asymptotic behavior of online natural gradient learning is studied for this purpose.

Training examples can be used only once in online learning when they appear. Therefore, the asymptotic performance of online learning cannot be better than the optimal batch procedure where all the examples can be reused again and again. However, we prove that natural gradient online learning gives the Fisher-efficient estimator in the sense of asymptotic statistics when the loss function is differentiable, so that it is asymptotically equivalent to the optimal batch procedure.

Asymptotic（渐近）

 函数的渐近行为


Consider first just the parameterized stochastic policy $\pi_\theta(x,u)$ at a single state $x$; a probability distribution over the actions $u$. This policy is a point on a manifold of such probability distributions, found at coordinates $\theta$. For a manifold of distributions, the Riemannian tensor is the so-called Fisher information matrix.

# Riemannian Geometry

## Riemannian Metrics

A Riemannian metric (or Riemannian structure) on a differentiable manifold $M$ is a correspondence which associates to each point $p$ of $M$ an inner product $\langle , \rangle_{p}$ (that is, a symmetric, bilinear, positive-definite form) on the tangent space $T_{p}M$, which varies differentiably in the following sense:



It is clear this definition does not depend on the choice of coordinate system.



# information geometry

Information geometry is a method of exploring the world of information by means of modern geometry. Theories of information have so far been studied mostly by using algebraic, logical, analytical, and probabilistic methods. Since geometry studies mutual relations between elements such as distance and curvature, it should provide the information sciences with powerful tools.


Information geometry has emerged from studies of invariant geometrical structure involved in statistical inference. It defines a **Riemannian metric** together with dually coupled affine connections in **a manifold of probability distributions**. These structures play important roles not only in statistical inference but also in wider areas of information sciences, such as machine learning, signal processing, optimization, and even neuroscience, not to mention mathematics and physics.


The text was "Information Theory and Statistics" by S. Kullback, and a professor suggested to me that the Fisher information might be regarded as a Riemannian metric. I calculated the Riemannian metric and curvature of the manifold of Gaussian distributions and found that it is a manifold of constant curvature, which is no different from the famous Poincare half-plane in non-Euclidean geometry. I was enchanted by its beauty. I believed that a beautiful structure must have important practical significance, but I was not able to pursue its consequences further.

Fifteen years later, I was stimulated by a paper by Prof. B. Efron and accompanying discussions by Prof. A.P. Dawid, and restarted my investigation into information geometry. Later, I found that Prof. N.N. Chentsov had developed a theory along similar lines. I was lucky that Sir D. Cox noticed my approach and organized an international workshop on information geometry in 1984, in which many active statisticians participated. This was a good start for information geometry.


This is the ordinary gradient descent method. The natural gradient method would work better, if we had its computational algorithm.




## natural gradient learning and its dynamics in singular regions

Learning takes place in a parameter space, which is not Euclidean in general but Riemannian. Therefore, we need to take the Riemannian structure into account when designing a learning method. The natural gradient method, which is a version of stochastic descent learning, is proposed for this purpose, using the Riemannian gradient. It is a Fisher efficient on-line method of estimation. Its performance is excellent in general and it has been used in various types of learning problems such as neural learning, policy gradient in reinforcement learning, optimization by means of stochastic relaxation, independent component analysis, Monte Carlo Markov Chain in a Riemannian manifold and others.

Some statistical models are singular, implying that its parameter space includes singular regions. The multilayer perceptron (MLP) is a typical singular model. Since supervised learning of MLP is involved in deep learning, it is important to study the dynamical behavior of learning in singular regions, in which learning is very slow. This is known as plateau phenomena. The natural gradient method overcomes this difficulty.






# $\nabla_\theta\ log\ \pi_\theta(a \mid s)$ feature


The gradient of the log-policy, is called a feature because it behaves like a feature vector in function approximation or regression.

In policy gradient methods, we try to approximate or regress something like:

$Q^{\pi_\theta}(s, a) - b(s) \approx \omega^{\top} \nabla_\theta\ log\ \pi_\theta (a \mid s)$

This is exactly like linear function approximation, where:
- $\omega$ is a parameter vector
- $\nabla_\theta\ log\ \pi_\theta(a\mid s)$ is playing the role of a feature vector


It encodes information about the effect of the parameters $\theta$ on the policy's probability distribution --- essentially describing how the policy responds to parameter changes at a specific $(s,a)$.


In linear regression: $y \approx \phi(x)^{\top}w$, where $\phi(x)$ is the feature vector for input $x$, and $w$ is the weight vector.


# BartoSutton


## preface 1

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


## preface 2

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


## Chapter 1


### Early history of RL

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


RL：Sutton & Barto《Reinforcement Learning: An Introduction》

ML：周志华《机器学习》或《Pattern Recognition and Machine Learning》

AI：《Artificial Intelligence: A Modern Approach》

## Policy gradient methods

### The policy gradient theorem

In addition to the practical advantages of policy parameterization over $\varepsilon$-greedy action selection, there is also an important theorectical advantage. With continuous policy parameterization the action probabilities change smoothly as a function of the learned parameter, whereas in $\varepsilon$-greedy selection the action probabilities may change dramatically for an arbitrary small change in the estimated action values, if that change results in a different action having the maximal value.

### Policy parameterization for continuous actions

Policy-based methods offer practical ways of dealing with large actions spaces, even continuous spaces with an infinite number of actions. Instead of computing learned probabilities for each of the many actions, we instead learn statistics of the probability distribution. For example, the action set might be the real numbers, with actions chosen from a normal distribution.

In general, one can take the integral under $p(x)$ for any range of $x$ values to get the probability of $x$ falling within that range.


To produce a policy parameterization, the policy can be defined as the normal probability density over a real-valued scalar action, with mean and standard deviation given by parametric function approximators that depend on the state.


## REINFORCE with Baseline

The policy gradient theorem can be generalized to include a comparison of the action value to an arbitrary baseline $b(s)$



The idea that we learn by interacting with our environment is probably the first to occur to us when we think about the nature of learning. When an infant plays, waves its arms, or looks about, it has no explicit teacher, but it does have a direct sensorimotor connection to its environment. Exercising this connection produces a wealth of information about the cause and effect, about the consequences of actions, and about what to do in order to achieve goals. Throughout our lives, such interactions are undoubtedly a major source of knowledge about our environment and ourselves. Whether we are learning to drive a car or hold a conversation, we are acutely aware of how our environment responds to what we do, and we seek to influence what happens through our behavior. Learning from interaction is a foundational idea underlying nearly all theories of learning and intelligence.

In this book we explore a computational approach to learning from interaction. Rather than directly theorizing about how people or animals learn, we primarily explore idealized learning situations and evaluate the effectiveness of various learning methods. That is, we adopt the perspective of an artificial intelligence researcher or engineer. We explore designs for machines that are effective in solving learning problems of scientific or economic interest, evaluating the designs through mathematical analysis or computational experiments. The approach we explore, called reinforcement learning, is much more focused on goal-directed learning from interaction than are other approaches to machine learning.


We formalize the problem of reinforcement learning using ideas from dynamical systems theory, specifically, as the optimal control of incompletely-known Markov decision processes. The details of this formalization must wait until Chapter 3, but the basic idea is simply to capture the most important aspects of the real problem facing a learning agent interacting over time with its environment to achieve a goal.



Approximate Solution Methods

## On-policy prediction with Approximation

ToC:
- Value-function approximation
- The prediction objective
- Stochastic-gradient and Semi-gradient methods
- Linear methods
- Feature construction for linear methods
- Selecting Step-Size parameters manually
- Nonlinear Function Approximation: Artificial Neural Networks
- Least-Squares TD
- Memory-based function approximation
- Kernel-based function approximation

In this chapter, we begin our study of function approximation in reinforcement learning by considering its use in estimating the state-value function from on-policy data, that is, in approximating $v_\pi$ from experience generated using a known policy $\pi$. The novelty in this chapter is that the approximate value function is represented not as a table but as a parameterized functional form with weight vector $\mathbf{w}$.

One of the most important special cases of function approximation is that in which the approximate function, $\hat{v}(\cdot, \mathbf{w})$, is a linear function of the weight vector, $\mathbf{w}$.

For example, $\hat{v}$ might be a linear function in features of the state, with $\mathbf{w}$ the vector of feature weights.

## On-policy control with Approximation

