.TL
Geometry of vector spaces

.SH
Hyperplane

.PP
Hyperplanes play a special role in the geometry of R^n because they divide the space into two disjoint pieces, just as a plane separates R^3 into two parts and a line cuts through R^2.

The key to working with hyperplanes is to use simple implicit descriptions, rather than the explicit or parametric representations of lines and planes used in the earlier work with affine sets.

An implicit equation of a line in R^2 has the form ax + by = d. An implicit equation of a plane in R^3 has the form ax + by + cz = d. Both equations describe the line or plane as the set of all points at which a linear expression (also called a linear functional) has a fixed value, d.

What is a linear functional?

It is a linear transformation from R^n to R.

For each scalar d, the symbol [f:d] denotes the set of all x in R^n at which the value of f is d.

[[ functional.png]]

[[zero_linear_functional.png]]


"Note that this definition of a hyperplane is invariant to non-zero scalar multiplication" <w, x> + b = 0

"Hence, for a hyperplane that does not pass through any sample point, we can scale w and b appropriately such that min |<w,x> + b| = 1."

Why do we want it to be scaled to 1? Because we are solving an optimization problem, and when scaling doesn't matter, we want to simplify the problem so we don't need to worry about scaling during the procedures of solving the problem.


In the terminology of calculus and geometry for R^3, n is called a normal vector to [f:0]. (A "normal" vector in this sense need not have unit length.)

If f is a nonzero functional, then rank A = 1, and dim Nul A = n - 1, by the Rank Theorem. Thus, the subspace [f: 0] has dimension n - 1 and so is a hyperplane.


The set of solutions of Ax=b is obtained by translating the solution set of Ax=0, using any particular solution p of Ax=b.

Suppose the equation Ax=b is consistent for some given b, and let p be a solution. Then the solution set of Ax=b is the set of all vectors of the form w = p + v, where v is any solution of the homogeneous equation Ax=0.

It means, if Ax=b has a solution, then the solution set is obtained by translating the solution set of Ax=0, using any particular solution p of Ax=b for the translation.

To understand this geometrically:

[[ parallel_solution_sets.png ]]


.SH
What is a subspace? What is the Rank Theorem?