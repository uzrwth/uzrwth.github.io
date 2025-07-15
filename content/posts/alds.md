---
title: "Algorithmic foundations of data science"
date: 2025-07-15T15:00:40+02:00
---

# introduction

algorithms
- machine learning algorithms
- curse of high dimensions and dimensionality reduction
- random walks and Markov-Chain-Monte-Carlo method
- algorithms for massively parallel architectures
- algorithms for streaming data

mathematical methods
- linear algebra, discrete mathematics, probability theory
- analysis of algorithms
- complexity theory
- information theory


overview
- ML algorithms for classification and clustering
- foundations of information theory
- statistical learning theory
	- how well can we learn and generalize from finite data set?
- multiplicative weights
	- learning algorithms for data processed online. Exploration vs. Exploitation
- high dimensional data
	- probability and geometry in high dimensions
	- dimensionality reduction and spectral clustering
- Markov Chains and random walks
	- Markov Chain Monte Carlo
	- How can we (use Markov chains to) sample from any distribution?
- algorithms for parallel systems
	- compute clusters, map reduce, and map reduce algorithms
	- How can we implement algorithms on clusters/parallel machines?
- streaming algorithms
	- stream data model, hashing, streaming algorithms
	- how can we process data that arrives as stream and cannot be stored in memory?


textbooks
- foundations of data science A. Blum, J. Hopcroft, R. Kannan.
- mining of massive datasets J. Leskovec, A. Rajaraman, J. Ullman
- understanding machine learning Shalev-Shwartz


# multiplicative weight updates

goals
- basic algorithm and its analysis using suitable potential functions
- adapted to different scenarios

## The MWU algorithm

## Boosting weak learning algorithms


## Bandit learning




# high-dimensional data


2 goals
- advanced mathematical concepts from geometry and linear algebra (eigenvalues and eigenvectors)
- dimensionality reduction



## the strange geometry of high-dimensional spaces

The volume is near the surface


high-dimensional unit balls


volume of the unit ball


concentration near equator


a probabilistic view on the equator
- concentration near the equator
- think of drawing a point uniformly at random

a probabilistic view on the volume




## Dimension Reduction by Random Projections


reduction of dimensions while preserving the distances between all pairs of points

Johnson-Lindenstrauss Lemma


## Background from linear algebra: eigenvalues and eigenvectors


## power iteration



# The Monte Carlo Method

## lemma 8.9

if $\pi_{i}q_{ij} = \pi_{j}q_{ji}$

then $\mathbf{\pi}$ is the stationary distribution of the Markove chain.

proof: summing both sides of the equation

$\sum_{j}^{n}\pi_{i}q_{ij} = \sum_{j}^{n}\pi_{i}q_{ji}$

$\pi_{i}\sum_{j}^{n}q_{ij} = \sum_{j}^{n}\pi_{i}q_{ji}$

$\pi_{i} = \sum_{j}^{n}\pi_{i}q_{ji}$

$\pi_{i} = (\mathbf{\pi}Q)_i$


The above so-called detailed balance condition assumes the Markov chain is reversible, i.e., the probability flow from state $i$ to $j$ is the same as from $j$ to $i$.


However, a stationary distribution may exist and not be of the above form.