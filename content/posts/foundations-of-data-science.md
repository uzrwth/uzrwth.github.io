---
title: "Foundations of Data Science"
date: 2025-07-16T00:59:03+02:00
---

# introduction


Today, a fundamental change is taking place and the focus is more on a wealth of applications.
- it used to focus on: programming languages, compilers, operating systems, finite automata, regular expressions, context-free languages, computability
- in the 1970's, the study of algorithms was added as an important component of theory
- calls for a change in our understanding of data and how to handle it in the modern setting
- not just how to make computers useful on specific well-defined problems
- one of the major changes is an increase in emphasis on probability, statistics, and numerical methods

modern data in diverse fields such as information processing, search, and machine learning is often advantageously represented as vectors with a large number of components
- the two salient aspects of vectors turn out to be relevant and useful
	- geometric (length, dot products, orthogonality)
	- linear algebraic (independence, rank, singular values)
- chapters 2 and 3 lay the foundations of geometry and linear algebra respectively
- our intuition from two or three dimensional space can be surprisingly off the mark when it comes to high dimensions.
- applications of SVD include principal component analysis, a widely used technique to statistical mixtures of probability densities, discrete optimization



Exploring large structures like the web or the space of configurations of a large system with deterministic methods can be prohibitively expensive
- Random walks (also called Markov Chains) turn out often to be more efficient as well as illuminative
- the stationary distributions of such walks are important for applications ranging from web search to the simulation of physical systems


Chapter 5 describes the foundations of machine learning, both algorithms for optimizing over given training examples, as well as the theory for understanding when such optimization can be expected to lead to good performance on new, unseen data
- Vapnik-Chervonenkis dimensino
- Perceptron Algorithm
- stochastic gradient descent
- boosting
- deep learning
- regularization and overfitting


The field of algorithms has traditionally assumed that the input data to a problem is presented in random access memory, which the algorithm can repeatedly access
- this is not feasible for problems involving enormous amounts of data
- in this setting, sampling plays a crucial role and we have to sample on the fly
- In Chapter 6 we study how to draw good samples efficiently and how to estimate statistical and linear algebra quantities, with such samples


A central topic in unsupervised learning is clustering, discussed in Chapter 7.
- k-means algorithm
- newer algorithms and general frameworks


understanding of large structures, like the web and social networks
- Erdös and Renyi, which we study in detail in Chapter 8

Chapter 9 focuses on linear-algebraic problems of making sense from data, in particular topic modeling and non-negative matrix factorization


Chapter 10 discusses ranking and social choice as well as problems of sparse representations such as compressed sensing
- additionally: linear programming, semidefinite programming
- Wavelets, which are an important method for representing signals across a wide range of applications, are discussed in Chapter 11 along with some of their fundamental mathematical properties


# high-dimensional space

## introduction


## The law of large numbers


Markov's inequality

Chebyshev's inequality

law of large numbers

master tail bounds theorem


## The geometry of high dimensions


## properties of the unit ball

volume of the unit ball



volume near the equator


near orthogonality


## generating points uniformly at random from a Ball


## Gaussians in High Dimension

Gaussian Annulus Theorem


## Random projection and Johnson-Lindenstrauss Lemma


## Separating Gaussians


## Fitting a Spherical Gaussian to Data




# best-fit subspaces and SVD

# random walks and markov chains


# machine learning


# algorithms for massive data problems: streaming, sketching, and sampling


# clustering

# random graphs

Large graphs appear in many contexts
- World Wide Web
- social networks
- journal citations


difference between modern and traditional graph theory
- one seeks statistical properties of these very large graphs
- rather than an exact answer to questions on specific graphs
- This is akin to the switch physics made in going from mechanics to statistical mechanics
- the most basic model is the $G(n,p)$ model of a random graph


### The $G(n,p)$ model

- $n$ is the number of vertices of the graph
- $p$ is the edge probability
- For each pair of distinct vertices, $v$ and $w$, $p$ is the probability that the edge $(v,w)$ is present
- Erdös and Renyi
- The presence of each edge is statistically independent of all other edges
- The graph-valued random variable with these parameters is denoted by $G(n,p)$.


The interesting thing about the $G(n,p)$ model is that even though edges are chosen independently with no "collusion", certain global properties of the graph emerge from the independent choices.
- with $p=d/n, d < 1$, each connected component in the graph is small
- for $d>1$, there is a giant component consisting of a constant fraction of the vertices
- in addition, there is a rapid transition at the threshold $d=1$.
- below the threshold, the probability of a giant component is very small, and above the threshold, the probability is almost one


### Phase transitions

### Giant component

Consider $p=\frac{1+\epsilon}{n}$ where $\epsilon$ is a constant greater than zero.

### Cycles and full connectivity

### Phase transitions for increasing properties

### Branching processes

### CNF-SAT

### Nonuiform models of random graphs

### Growth models

### Small world graphs



# topic models, nonnegative matrix factorization, hidden Markov models, and graphical models


# other topics


# appendix
















# algorithmic foundations of data science

understanding machine learning algorithms
- basic ML concepts and terminology
- the nearest neighbour algorithm
- learning decision trees
- background: Euclidean geometry
- linear classifiers
- k-Means Clustering


information and compression
- background from probability theory
- concentration inequalities
- entropy


statistical learning theory
- classification revisited
- risk and empirical risk minimization
- the PAC learning framework
- sample size bounds



multiplicative weight updates
- the MWU algorithm
- boosting weak learning algorithms
- bandit learning


high-dimensional data
-