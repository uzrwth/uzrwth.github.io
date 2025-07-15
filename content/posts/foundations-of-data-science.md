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

# best-fit subspaces and SVD

# random walks and markov chains


# machine learning


# algorithms for massive data problems: streaming, sketching, and sampling


# clustering

# random graphs



# topic models, nonnegative matrix factorization, hidden Markov models, and graphical models


# other topics


# appendix