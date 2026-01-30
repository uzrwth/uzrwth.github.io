.TL
Affine combinations

.PP
What properties do lines have in 2-space and planes have in 3-space that would be useful in higher dimensions?

The hyperplanes will be important for understanding the multidimensional nature of the linear programming problems.

What would be the analogue of a polyhedron "look like" in more than three dimensions?

A partial answer is provided by two-dimensional projections of the four dimensional object, created in a manner analogous to two dimensional projections of a three-dimensional object.

Given vectors v1,v2,v3, ...

[[affine.png]]

affine hull

[[affine_hull.png]]

convex combination and convex hull:

[[convex_hull.png]]

The affine hull of distinct points v1 and v2 is the line

[[affine_line.png]]

y-v1 is a linear combination:

[[affine_line2.png]]


The convex hull is the line segment.

[[convex_segment.png]]

Affine set:

[[affine_set1.png]]

[[affine_set2.png]]


[[hyperplane_and_flat.png]]


.SH
affine-invariant property

.PP
Self-concordance is an affine-invariant property, i.e., if we apply a linear transformation of variables to a self-concordant function, we obtain a self-concordant function. (Therefore the complexity estimate that we obtain for Newton's method applied to a self-concordant function is independent of affine changes of coordinates.)

What about convexity? If we apply a linear transformation of variables to a convex function, do we obtain a convex function?


.SH
operations that preserve convexity

.PP

.DS
1. intersection

2. affine functions
.DE

[[affine_preserve_convex.png]]

[[affine_preserve_convex2.png]]


[[affine_preserve_convex3.png]]

