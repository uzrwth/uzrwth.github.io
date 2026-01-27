.TL
Dual representation

.PP

Many linear models for regression and classification can be reformulated in terms of a dual representation in which the kernel function arises naturally.

The existence of a dual representation based on the Gram matrix is a property of many linear models, including the perceptron.

There is a duality between probabilistic linear models for regression and the technique of Gaussian processes.

Duality plays an important role in support vector machines.

[[jw.png]]

What is a regularized sum-of-squares error function? Why do we need regularization?

Set the gradient of J(w) to 0 with respect to w:

[[gradient_jw.png]]

[[plug_jw.png]]

.SH
Gram matrix

.PP
[[gram_matrix.png]]


We have introduced the kernel function k(x,x')

[[kernel_ja.png]]

[[gradient_ja.png]]

[[prediction.png]]
