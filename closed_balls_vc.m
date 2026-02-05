.TL
The VC-dimension of the set of all closed balls

.PP
d <= n+2

.PP
Tool:

Theorem: The VC dimension of the class of nonhomogenous halfspaces in R^d is d+1. (for homogenous: d)

(Schwartz & David 9.3)

.PP
Def Halfspace

Linear predictors is a family of hypothesis classes. Halfspaces is a hypothesis class that belongs to this family. Other members from the family: linear regression predictors, logistic regression predictors.

See the definition of the class of affine functions. Denoted as Ld.

All linear predictors use Ld as the basic building block. In binary classification: we add the sign function on top of it. For regression, we add the identity function on top of it.

To absorb b, w' = (b, w1, ...), x' = (1, x1, ...). See (Schwartz & David 9.1)

The hypothesis class of halfspaces is simply putting the sign function upon Ld. (Schwartz & David 9.1)

That is: x -> sign(<w,x>+b)

In the case of d=2, each halfspace is a hyperplane. The hyperplane is perpendicular to the normal vector w.

The instances above the hyperplane: acute angle with w. (labeled positively)

The instances below the hyperplane: obtuse angle with w.

Given sufficient large sample, we can learn halfspaces (in ERM paradigm).

We need to consider: realizable case and agnostic case. For the realizable case, there are two solutions: linear programming and perceptron.

For the agnostic case: logistic regression.

See (Schwartz & David 9.1) for the concept of linear programs: to maximize a linear function subject to linear inequalities.


Linear programs can be solved efficiently. The key point is how to turn the ERM problem for halfspaces in the realizable case into a linear program.

Constraints: y * <w, x> > 0.

Suppose w* is one such solution that satisfies the constraints. We can find a w by scaling w* such that y * <w, x> >= 1.

y * <w,x> >= 1 can be rewritten as Aw >= v, where v=(1,...,1) and Ai,j = yi * xi,j

Since we just need to find a suitable w, we don't need to optimize over anything. For the realizable case, empirical risk is always 0. We set a "dummy" objective. See (Schwartz & David 9.1.1)

Once we constructed A and v, the LP solver helps us find the w.

.PP
Perceptron for Halfspaces

w is initialized to the zeros vector. At each iteration, updates w with a mislabeled example.

At iteration i, y<w,x> < 0. We then update w' = w + yx. y<w',x> = y<w,x> + |x|^2. The value is increased. Eventually, y<w',x> >0.

But, will it converge? If so, what is the convergence rate?

See (Schwartz & David Theorem 9.1)

Theorem 9.1: the perceptron algorithm stops after at most (RB)^2 iterations. (Stops means all examples are correctly classified. Only for the realizable case)


.PP
Can we translate the balls as halfspaces?

||x - x0|| <= r

||x||^2 - 2<x0, x> + ||x0||^2 - r^2 <= 0

x' = (x, ||x||^2, 1) is n+2

w = (-2x0, 1, b) is n+2


=>  <w, x'> <= 0 is an halfspace.

=> VCdim = d = n + 2

See (Schwartz & David Theorem 9.3)  for the proof  of VC dimension of halfspaces equals to d.

The proof uses the fact that n+1 R^n vectors are linearly dependent.

That is, there exists a linear combination of the n+1 vectors that equals to 0, and at least one of the weights is non-zero.

Then, we separate the weights into positive and negative. (zero weights do not have influence)

Suppose the halfspace (homogenous) shatters n+1 points, then there exists w such that <w, xi> > 0 and <w, xj> < 0, where xi corresponds to the examples with the positive weights.

This will lead to a contradition. (See Schwartz & David Theorem 9.3)

Therefore, halfspaces of n dimension can't shatter n+1 points.

To show that halfspaces of n dimension can shatter n points, we just need to give an example.

e1 = (1, 0, 0, ...)

e2 = (0, 1, 0, ...)

...

w = (y1, y2, y3, ...)

<w, ei> = yi

The halfspace shatters n points. VCdim >= n.