.TL
Gradient Descent

.PP
The gradient of a function is the vector of partial derivatives of it. (multi-variables function)

Gradient descent is an iterative algorithm. (the computation starts with an initial assumed value)

(See Schwartz & David 14.1)

For an iterative algorithm, the crucial point is the update rule.

.PP
Why do we need gradient descent rather than computing the optimal value mathematically by setting the gradient to the zero vector?

The point with zero gradient might now exist. Even if exists, the amount of computation could be huge.


.PP
Why do we have to learn about gradient descent for machine learning?

Our goal of learning is to minimize the risk function (but we don't know the distribution as well as the gradient, what we only know is the gradient of the empirical risk. How does this work?). Gradient descent is a method for minimizing a function.

The key point is, even though we don't know the gradient of the risk function, we can still find a direction whose expectation matches the gradient of the risk function. (SGD)

(See Schwartz & David 14.3)

.PP
We take it for granted that in this algorithm we will take a step in the direction of the negative of the gradient at the current point, but what is the principle behind such an algorithm?


.PP
When we apply an iterative method, we must know its convergence rate.



.PP
What is the advantage of preconditioned gradient descent over gradient descent?

Gradient descent is a first-order algorithm for finding a local minimum of a differentiable function.

Preconditioning is typically used to accelerate first-order optimization algorithms.


.PP
Def Gradient

whose value at a point p is the "direction and rate of fastest increase" (See wiki)

"at a point p, the direction of the gradient is the direction in which the function increases most quickly from p, and the magnitude of the gradient is the rate of increase in that direction, the greatest absolute directional derivative." (See wiki)

To maximize a function: gradient ascent.

To minimize a function: gradient descent.

The relationship between directional derivative and gradient: The directional derivative is a dot product of the gradient and the unit vector. (See Thomas Calculus: 14)


.PP
Def: directional derivative

(See Thomas Calculus: 14)

measures the rate at which a function changes in a particular direction at a given point. (See wiki)

Notation of the directional derivative: The derivative of f at P in the direction of u.

To talk about a directional derivative, there is a function, a point and a direction vector.

Derivative is a limit. When we choose the direction vector to be a unit vector, the divisor is easy to express. (See Thomas Calculus: 14.5 Directional Derivatives and Gradient Vectors)

Therefore, for the same function f and point P, choosing a different direction vector means a different directional derivative.


Dot product: <u,v> = |u| * |v| * cos(arc<u,v>)

If we choose the direction vector to be the same direction as the gradient, then the directional derivative equals to the dot product of the gradient and the direction vector, cos() = 1. The directional derivative equals the |gradient|.

At point P, f increases most rapidly in the direction of the gradient vector at P. (since the directional derivative measures the rate at which a function changes in a particular direction at a given point).

But, why increases rather than decreases? See the definition of diretional derivative in terms of limitation. lim (f(x0 + su) - f(x0)) / s.

For the proof of the relationship between the directional derivative and the gradient vector, see Thomas Calculus 14.5: Directional derivatives and gradient vectors.

Hence, when we do gradient descent, we take a step in the negative direction of the gradient.


