---
title: "Algorithmic foundations of data science"
date: 2025-07-15T15:00:40+02:00
---


# high-dimensional data


2 goals
- advanced mathematical concepts from geometry and linear algebra (eigenvalues and eigenvectors)
- dimensionality reduction



## the strange geometry of high-dimensional spaces

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